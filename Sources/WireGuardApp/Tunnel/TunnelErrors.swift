// SPDX-License-Identifier: MIT
// Copyright © 2018-2023 WireGuard LLC. All Rights Reserved.

import NetworkExtension

public enum TunnelsManagerError: WireGuardAppError {
    case tunnelNameEmpty
    case tunnelAlreadyExistsWithThatName
    case systemErrorOnListingTunnels(systemError: Error)
    case systemErrorOnAddTunnel(systemError: Error)
    case systemErrorOnModifyTunnel(systemError: Error)
    case systemErrorOnRemoveTunnel(systemError: Error)

    public var alertText: AlertText {
        switch self {
        case .tunnelNameEmpty:
            return (tr("alertTunnelNameEmptyTitle"), tr("alertTunnelNameEmptyMessage"))
        case .tunnelAlreadyExistsWithThatName:
            return (tr("alertTunnelAlreadyExistsWithThatNameTitle"), tr("alertTunnelAlreadyExistsWithThatNameMessage"))
        case .systemErrorOnListingTunnels(let systemError):
            return (tr("alertSystemErrorOnListingTunnelsTitle"), systemError.localizedUIString)
        case .systemErrorOnAddTunnel(let systemError):
            return (tr("alertSystemErrorOnAddTunnelTitle"), systemError.localizedUIString)
        case .systemErrorOnModifyTunnel(let systemError):
            return (tr("alertSystemErrorOnModifyTunnelTitle"), systemError.localizedUIString)
        case .systemErrorOnRemoveTunnel(let systemError):
            return (tr("alertSystemErrorOnRemoveTunnelTitle"), systemError.localizedUIString)
        }
    }
}

public enum TunnelsManagerActivationAttemptError: WireGuardAppError {
    case tunnelIsNotInactive
    case failedWhileStarting(systemError: Error) // startTunnel() throwed
    case failedWhileSaving(systemError: Error) // save config after re-enabling throwed
    case failedWhileLoading(systemError: Error) // reloading config throwed
    case failedBecauseOfTooManyErrors(lastSystemError: Error) // recursion limit reached

    public var alertText: AlertText {
        switch self {
        case .tunnelIsNotInactive:
            return (tr("alertTunnelActivationErrorTunnelIsNotInactiveTitle"), tr("alertTunnelActivationErrorTunnelIsNotInactiveMessage"))
        case .failedWhileStarting(let systemError),
             .failedWhileSaving(let systemError),
             .failedWhileLoading(let systemError),
             .failedBecauseOfTooManyErrors(let systemError):
            return (tr("alertTunnelActivationSystemErrorTitle"),
                    tr(format: "alertTunnelActivationSystemErrorMessage (%@)", systemError.localizedUIString))
        }
    }
}

public enum TunnelsManagerActivationError: WireGuardAppError {
    case activationFailed(wasOnDemandEnabled: Bool)
    case activationFailedWithExtensionError(title: String, message: String, wasOnDemandEnabled: Bool)

    public var alertText: AlertText {
        switch self {
        case .activationFailed:
            return (tr("alertTunnelActivationFailureTitle"), tr("alertTunnelActivationFailureMessage"))
        case .activationFailedWithExtensionError(let title, let message, _):
            return (title, message)
        }
    }
}

extension PacketTunnelProviderError: WireGuardAppError {
    public var alertText: AlertText {
        switch self {
        case .savedProtocolConfigurationIsInvalid:
            return (tr("alertTunnelActivationFailureTitle"), tr("alertTunnelActivationSavedConfigFailureMessage"))
        case .dnsResolutionFailure:
            return (tr("alertTunnelDNSFailureTitle"), tr("alertTunnelDNSFailureMessage"))
        case .couldNotStartBackend:
            return (tr("alertTunnelActivationFailureTitle"), tr("alertTunnelActivationBackendFailureMessage"))
        case .couldNotDetermineFileDescriptor:
            return (tr("alertTunnelActivationFailureTitle"), tr("alertTunnelActivationFileDescriptorFailureMessage"))
        case .couldNotSetNetworkSettings:
            return (tr("alertTunnelActivationFailureTitle"), tr("alertTunnelActivationSetNetworkSettingsMessage"))
        }
    }
}

public extension Error {
    var localizedUIString: String {
        if let systemError = self as? NEVPNError {
            switch systemError {
            case NEVPNError.configurationInvalid:
                return tr("alertSystemErrorMessageTunnelConfigurationInvalid")
            case NEVPNError.configurationDisabled:
                return tr("alertSystemErrorMessageTunnelConfigurationDisabled")
            case NEVPNError.connectionFailed:
                return tr("alertSystemErrorMessageTunnelConnectionFailed")
            case NEVPNError.configurationStale:
                return tr("alertSystemErrorMessageTunnelConfigurationStale")
            case NEVPNError.configurationReadWriteFailed:
                return tr("alertSystemErrorMessageTunnelConfigurationReadWriteFailed")
            case NEVPNError.configurationUnknown:
                return tr("alertSystemErrorMessageTunnelConfigurationUnknown")
            default:
                return ""
            }
        } else {
            return localizedDescription
        }
    }
}

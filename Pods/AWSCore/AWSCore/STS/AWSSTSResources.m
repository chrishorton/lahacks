//
// Copyright 2010-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSSTSResources.h"
#import <AWSCore/AWSLogging.h>

@interface AWSSTSResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSSTSResources

+ (instancetype)sharedInstance {
    static AWSSTSResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSSTSResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2011-06-15\",\
    \"endpointPrefix\":\"sts\",\
    \"globalEndpoint\":\"sts.amazonaws.com\",\
    \"protocol\":\"query\",\
    \"serviceAbbreviation\":\"AWS STS\",\
    \"serviceFullName\":\"AWS Security Token Service\",\
    \"signatureVersion\":\"v4\",\
    \"xmlNamespace\":\"https://sts.amazonaws.com/doc/2011-06-15/\"\
  },\
  \"operations\":{\
    \"AssumeRole\":{\
      \"name\":\"AssumeRole\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"AssumeRoleRequest\"},\
      \"output\":{\
        \"shape\":\"AssumeRoleResponse\",\
        \"resultWrapper\":\"AssumeRoleResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"PackedPolicyTooLargeException\"},\
        {\"shape\":\"RegionDisabledException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary security credentials (consisting of an access key ID, a secret access key, and a security token) that you can use to access AWS resources that you might not normally have access to. Typically, you use <code>AssumeRole</code> for cross-account access or federation. For a comparison of <code>AssumeRole</code> with the other APIs that produce temporary credentials, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <p> <b>Important:</b> You cannot call <code>AssumeRole</code> by using AWS root account credentials; access is denied. You must use credentials for an IAM user or an IAM role to call <code>AssumeRole</code>. </p> <p>For cross-account access, imagine that you own multiple accounts and need to access resources in each account. You could create long-term credentials in each account to access those resources. However, managing all those credentials and remembering which one can access which account can be time consuming. Instead, you can create one set of long-term credentials in one account and then use temporary security credentials to access all the other accounts by assuming roles in those accounts. For more information about roles, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/roles-toplevel.html\\\">IAM Roles (Delegation and Federation)</a> in the <i>IAM User Guide</i>. </p> <p>For federation, you can, for example, grant single sign-on access to the AWS Management Console. If you already have an identity and authentication system in your corporate network, you don't have to recreate user identities in AWS in order to grant those user identities access to AWS. Instead, after a user has been authenticated, you call <code>AssumeRole</code> (and specify the role with the appropriate permissions) to get temporary security credentials for that user. With those temporary security credentials, you construct a sign-in URL that users can use to access the console. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html#sts-introduction\\\">Common Scenarios for Temporary Credentials</a> in the <i>IAM User Guide</i>.</p> <p>The temporary security credentials are valid for the duration that you specified when calling <code>AssumeRole</code>, which can be from 900 seconds (15 minutes) to a maximum of 3600 seconds (1 hour). The default is 1 hour. </p> <p>The temporary security credentials created by <code>AssumeRole</code> can be used to make API calls to any AWS service with the following exception: you cannot call the STS service's <code>GetFederationToken</code> or <code>GetSessionToken</code> APIs.</p> <p>Optionally, you can pass an IAM access policy to this operation. If you choose not to pass a policy, the temporary security credentials that are returned by the operation have the permissions that are defined in the access policy of the role that is being assumed. If you pass a policy to this operation, the temporary security credentials that are returned by the operation have the permissions that are allowed by both the access policy of the role that is being assumed, <i> <b>and</b> </i> the policy that you pass. This gives you a way to further restrict the permissions for the resulting temporary security credentials. You cannot use the passed policy to grant permissions that are in excess of those allowed by the access policy of the role that is being assumed. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_assumerole.html\\\">Permissions for AssumeRole, AssumeRoleWithSAML, and AssumeRoleWithWebIdentity</a> in the <i>IAM User Guide</i>.</p> <p>To assume a role, your AWS account must be trusted by the role. The trust relationship is defined in the role's trust policy when the role is created. That trust policy states which accounts are allowed to delegate access to this account's role.</p> <p>The user who wants to access the role must also have permissions delegated from the role's administrator. If the user is in a different account than the role, then the user's administrator must attach a policy that allows the user to call AssumeRole on the ARN of the role in the other account. If the user is in the same account as the role, then you can either attach a policy to the user (identical to the previous different account user), or you can add the user as a principal directly in the role's trust policy</p> <p> <b>Using MFA with AssumeRole</b> </p> <p>You can optionally include multi-factor authentication (MFA) information when you call <code>AssumeRole</code>. This is useful for cross-account scenarios in which you want to make sure that the user who is assuming the role has been authenticated using an AWS MFA device. In that scenario, the trust policy of the role being assumed includes a condition that tests for MFA authentication; if the caller does not include valid MFA information, the request to assume the role is denied. The condition in a trust policy that tests for MFA authentication might look like the following example.</p> <p> <code>\\\"Condition\\\": {\\\"Bool\\\": {\\\"aws:MultiFactorAuthPresent\\\": true}}</code> </p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/MFAProtectedAPI.html\\\">Configuring MFA-Protected API Access</a> in the <i>IAM User Guide</i> guide.</p> <p>To use MFA with <code>AssumeRole</code>, you pass values for the <code>SerialNumber</code> and <code>TokenCode</code> parameters. The <code>SerialNumber</code> value identifies the user's hardware or virtual MFA device. The <code>TokenCode</code> is the time-based one-time password (TOTP) that the MFA devices produces. </p>\"\
    },\
    \"AssumeRoleWithSAML\":{\
      \"name\":\"AssumeRoleWithSAML\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"AssumeRoleWithSAMLRequest\"},\
      \"output\":{\
        \"shape\":\"AssumeRoleWithSAMLResponse\",\
        \"resultWrapper\":\"AssumeRoleWithSAMLResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"PackedPolicyTooLargeException\"},\
        {\"shape\":\"IDPRejectedClaimException\"},\
        {\"shape\":\"InvalidIdentityTokenException\"},\
        {\"shape\":\"ExpiredTokenException\"},\
        {\"shape\":\"RegionDisabledException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary security credentials for users who have been authenticated via a SAML authentication response. This operation provides a mechanism for tying an enterprise identity store or directory to role-based AWS access without user-specific credentials or configuration. For a comparison of <code>AssumeRoleWithSAML</code> with the other APIs that produce temporary credentials, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <p>The temporary security credentials returned by this operation consist of an access key ID, a secret access key, and a security token. Applications can use these temporary security credentials to sign calls to AWS services.</p> <p>The temporary security credentials are valid for the duration that you specified when calling <code>AssumeRole</code>, or until the time specified in the SAML authentication response's <code>SessionNotOnOrAfter</code> value, whichever is shorter. The duration can be from 900 seconds (15 minutes) to a maximum of 3600 seconds (1 hour). The default is 1 hour.</p> <p>The temporary security credentials created by <code>AssumeRoleWithSAML</code> can be used to make API calls to any AWS service with the following exception: you cannot call the STS service's <code>GetFederationToken</code> or <code>GetSessionToken</code> APIs.</p> <p>Optionally, you can pass an IAM access policy to this operation. If you choose not to pass a policy, the temporary security credentials that are returned by the operation have the permissions that are defined in the access policy of the role that is being assumed. If you pass a policy to this operation, the temporary security credentials that are returned by the operation have the permissions that are allowed by the intersection of both the access policy of the role that is being assumed, <i> <b>and</b> </i> the policy that you pass. This means that both policies must grant the permission for the action to be allowed. This gives you a way to further restrict the permissions for the resulting temporary security credentials. You cannot use the passed policy to grant permissions that are in excess of those allowed by the access policy of the role that is being assumed. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_assumerole.html\\\">Permissions for AssumeRole, AssumeRoleWithSAML, and AssumeRoleWithWebIdentity</a> in the <i>IAM User Guide</i>.</p> <p>Before your application can call <code>AssumeRoleWithSAML</code>, you must configure your SAML identity provider (IdP) to issue the claims required by AWS. Additionally, you must use AWS Identity and Access Management (IAM) to create a SAML provider entity in your AWS account that represents your identity provider, and create an IAM role that specifies this SAML provider in its trust policy. </p> <p>Calling <code>AssumeRoleWithSAML</code> does not require the use of AWS security credentials. The identity of the caller is validated by using keys in the metadata document that is uploaded for the SAML provider entity for your identity provider. </p> <important> <p>Calling <code>AssumeRoleWithSAML</code> can result in an entry in your AWS CloudTrail logs. The entry includes the value in the <code>NameID</code> element of the SAML assertion. We recommend that you use a NameIDType that is not associated with any personally identifiable information (PII). For example, you could instead use the Persistent Identifier (<code>urn:oasis:names:tc:SAML:2.0:nameid-format:persistent</code>).</p> </important> <p>For more information, see the following resources:</p> <ul> <li> <p> <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_saml.html\\\">About SAML 2.0-based Federation</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml.html\\\">Creating SAML Identity Providers</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml_relying-party.html\\\">Configuring a Relying Party and Claims</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p> <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_saml.html\\\">Creating a Role for SAML 2.0 Federation</a> in the <i>IAM User Guide</i>. </p> </li> </ul>\"\
    },\
    \"AssumeRoleWithWebIdentity\":{\
      \"name\":\"AssumeRoleWithWebIdentity\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"AssumeRoleWithWebIdentityRequest\"},\
      \"output\":{\
        \"shape\":\"AssumeRoleWithWebIdentityResponse\",\
        \"resultWrapper\":\"AssumeRoleWithWebIdentityResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"PackedPolicyTooLargeException\"},\
        {\"shape\":\"IDPRejectedClaimException\"},\
        {\"shape\":\"IDPCommunicationErrorException\"},\
        {\"shape\":\"InvalidIdentityTokenException\"},\
        {\"shape\":\"ExpiredTokenException\"},\
        {\"shape\":\"RegionDisabledException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary security credentials for users who have been authenticated in a mobile or web application with a web identity provider, such as Amazon Cognito, Login with Amazon, Facebook, Google, or any OpenID Connect-compatible identity provider.</p> <note> <p>For mobile applications, we recommend that you use Amazon Cognito. You can use Amazon Cognito with the <a href=\\\"http://aws.amazon.com/sdkforios/\\\">AWS SDK for iOS</a> and the <a href=\\\"http://aws.amazon.com/sdkforandroid/\\\">AWS SDK for Android</a> to uniquely identify a user and supply the user with a consistent identity throughout the lifetime of an application.</p> <p>To learn more about Amazon Cognito, see <a href=\\\"http://docs.aws.amazon.com/mobile/sdkforandroid/developerguide/cognito-auth.html#d0e840\\\">Amazon Cognito Overview</a> in the <i>AWS SDK for Android Developer Guide</i> guide and <a href=\\\"http://docs.aws.amazon.com/mobile/sdkforios/developerguide/cognito-auth.html#d0e664\\\">Amazon Cognito Overview</a> in the <i>AWS SDK for iOS Developer Guide</i>.</p> </note> <p>Calling <code>AssumeRoleWithWebIdentity</code> does not require the use of AWS security credentials. Therefore, you can distribute an application (for example, on mobile devices) that requests temporary security credentials without including long-term AWS credentials in the application, and without deploying server-based proxy services that use long-term AWS credentials. Instead, the identity of the caller is validated by using a token from the web identity provider. For a comparison of <code>AssumeRoleWithWebIdentity</code> with the other APIs that produce temporary credentials, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <p>The temporary security credentials returned by this API consist of an access key ID, a secret access key, and a security token. Applications can use these temporary security credentials to sign calls to AWS service APIs.</p> <p>The credentials are valid for the duration that you specified when calling <code>AssumeRoleWithWebIdentity</code>, which can be from 900 seconds (15 minutes) to a maximum of 3600 seconds (1 hour). The default is 1 hour. </p> <p>The temporary security credentials created by <code>AssumeRoleWithWebIdentity</code> can be used to make API calls to any AWS service with the following exception: you cannot call the STS service's <code>GetFederationToken</code> or <code>GetSessionToken</code> APIs.</p> <p>Optionally, you can pass an IAM access policy to this operation. If you choose not to pass a policy, the temporary security credentials that are returned by the operation have the permissions that are defined in the access policy of the role that is being assumed. If you pass a policy to this operation, the temporary security credentials that are returned by the operation have the permissions that are allowed by both the access policy of the role that is being assumed, <i> <b>and</b> </i> the policy that you pass. This gives you a way to further restrict the permissions for the resulting temporary security credentials. You cannot use the passed policy to grant permissions that are in excess of those allowed by the access policy of the role that is being assumed. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_assumerole.html\\\">Permissions for AssumeRole, AssumeRoleWithSAML, and AssumeRoleWithWebIdentity</a> in the <i>IAM User Guide</i>.</p> <p>Before your application can call <code>AssumeRoleWithWebIdentity</code>, you must have an identity token from a supported identity provider and create a role that the application can assume. The role that your application assumes must trust the identity provider that is associated with the identity token. In other words, the identity provider must be specified in the role's trust policy. </p> <important> <p>Calling <code>AssumeRoleWithWebIdentity</code> can result in an entry in your AWS CloudTrail logs. The entry includes the <a href=\\\"http://openid.net/specs/openid-connect-core-1_0.html#Claims\\\">Subject</a> of the provided Web Identity Token. We recommend that you avoid using any personally identifiable information (PII) in this field. For example, you could instead use a GUID or a pairwise identifier, as <a href=\\\"http://openid.net/specs/openid-connect-core-1_0.html#SubjectIDTypes\\\">suggested in the OIDC specification</a>.</p> </important> <p>For more information about how to use web identity federation and the <code>AssumeRoleWithWebIdentity</code> API, see the following resources: </p> <ul> <li> <p> <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_oidc_manual\\\">Using Web Identity Federation APIs for Mobile Apps</a> and <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_assumerolewithwebidentity\\\">Federation Through a Web-based Identity Provider</a>. </p> </li> <li> <p> <a href=\\\"https://web-identity-federation-playground.s3.amazonaws.com/index.html\\\"> Web Identity Federation Playground</a>. This interactive website lets you walk through the process of authenticating via Login with Amazon, Facebook, or Google, getting temporary security credentials, and then using those credentials to make a request to AWS. </p> </li> <li> <p> <a href=\\\"http://aws.amazon.com/sdkforios/\\\">AWS SDK for iOS</a> and <a href=\\\"http://aws.amazon.com/sdkforandroid/\\\">AWS SDK for Android</a>. These toolkits contain sample apps that show how to invoke the identity providers, and then how to use the information from these providers to get and use temporary security credentials. </p> </li> <li> <p> <a href=\\\"http://aws.amazon.com/articles/4617974389850313\\\">Web Identity Federation with Mobile Applications</a>. This article discusses web identity federation and shows an example of how to use web identity federation to get access to content in Amazon S3. </p> </li> </ul>\"\
    },\
    \"DecodeAuthorizationMessage\":{\
      \"name\":\"DecodeAuthorizationMessage\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DecodeAuthorizationMessageRequest\"},\
      \"output\":{\
        \"shape\":\"DecodeAuthorizationMessageResponse\",\
        \"resultWrapper\":\"DecodeAuthorizationMessageResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"InvalidAuthorizationMessageException\"}\
      ],\
      \"documentation\":\"<p>Decodes additional information about the authorization status of a request from an encoded message returned in response to an AWS request.</p> <p>For example, if a user is not authorized to perform an action that he or she has requested, the request returns a <code>Client.UnauthorizedOperation</code> response (an HTTP 403 response). Some AWS actions additionally return an encoded message that can provide details about this authorization failure. </p> <note> <p>Only certain AWS actions return an encoded authorization message. The documentation for an individual action indicates whether that action returns an encoded message in addition to returning an HTTP code.</p> </note> <p>The message is encoded because the details of the authorization status can constitute privileged information that the user who requested the action should not see. To decode an authorization status message, a user must be granted permissions via an IAM policy to request the <code>DecodeAuthorizationMessage</code> (<code>sts:DecodeAuthorizationMessage</code>) action. </p> <p>The decoded message includes the following type of information:</p> <ul> <li> <p>Whether the request was denied due to an explicit deny or due to the absence of an explicit allow. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_evaluation-logic.html#policy-eval-denyallow\\\">Determining Whether a Request is Allowed or Denied</a> in the <i>IAM User Guide</i>. </p> </li> <li> <p>The principal who made the request.</p> </li> <li> <p>The requested action.</p> </li> <li> <p>The requested resource.</p> </li> <li> <p>The values of condition keys in the context of the user's request.</p> </li> </ul>\"\
    },\
    \"GetCallerIdentity\":{\
      \"name\":\"GetCallerIdentity\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetCallerIdentityRequest\"},\
      \"output\":{\
        \"shape\":\"GetCallerIdentityResponse\",\
        \"resultWrapper\":\"GetCallerIdentityResult\"\
      },\
      \"documentation\":\"<p>Returns details about the IAM identity whose credentials are used to call the API.</p>\"\
    },\
    \"GetFederationToken\":{\
      \"name\":\"GetFederationToken\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetFederationTokenRequest\"},\
      \"output\":{\
        \"shape\":\"GetFederationTokenResponse\",\
        \"resultWrapper\":\"GetFederationTokenResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"PackedPolicyTooLargeException\"},\
        {\"shape\":\"RegionDisabledException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary security credentials (consisting of an access key ID, a secret access key, and a security token) for a federated user. A typical use is in a proxy application that gets temporary security credentials on behalf of distributed applications inside a corporate network. Because you must call the <code>GetFederationToken</code> action using the long-term security credentials of an IAM user, this call is appropriate in contexts where those credentials can be safely stored, usually in a server-based application. For a comparison of <code>GetFederationToken</code> with the other APIs that produce temporary credentials, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <note> <p> If you are creating a mobile-based or browser-based app that can authenticate users using a web identity provider like Login with Amazon, Facebook, Google, or an OpenID Connect-compatible identity provider, we recommend that you use <a href=\\\"http://aws.amazon.com/cognito/\\\">Amazon Cognito</a> or <code>AssumeRoleWithWebIdentity</code>. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_assumerolewithwebidentity\\\">Federation Through a Web-based Identity Provider</a>.</p> </note> <p>The <code>GetFederationToken</code> action must be called by using the long-term AWS security credentials of an IAM user. You can also call <code>GetFederationToken</code> using the security credentials of an AWS root account, but we do not recommended it. Instead, we recommend that you create an IAM user for the purpose of the proxy application and then attach a policy to the IAM user that limits federated users to only the actions and resources that they need access to. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html\\\">IAM Best Practices</a> in the <i>IAM User Guide</i>. </p> <p>The temporary security credentials that are obtained by using the long-term credentials of an IAM user are valid for the specified duration, from 900 seconds (15 minutes) up to a maximium of 129600 seconds (36 hours). The default is 43200 seconds (12 hours). Temporary credentials that are obtained by using AWS root account credentials have a maximum duration of 3600 seconds (1 hour).</p> <p>The temporary security credentials created by <code>GetFederationToken</code> can be used to make API calls to any AWS service with the following exceptions:</p> <ul> <li> <p>You cannot use these credentials to call any IAM APIs.</p> </li> <li> <p>You cannot call any STS APIs.</p> </li> </ul> <p> <b>Permissions</b> </p> <p>The permissions for the temporary security credentials returned by <code>GetFederationToken</code> are determined by a combination of the following: </p> <ul> <li> <p>The policy or policies that are attached to the IAM user whose credentials are used to call <code>GetFederationToken</code>.</p> </li> <li> <p>The policy that is passed as a parameter in the call.</p> </li> </ul> <p>The passed policy is attached to the temporary security credentials that result from the <code>GetFederationToken</code> API call--that is, to the <i>federated user</i>. When the federated user makes an AWS request, AWS evaluates the policy attached to the federated user in combination with the policy or policies attached to the IAM user whose credentials were used to call <code>GetFederationToken</code>. AWS allows the federated user's request only when both the federated user <i> <b>and</b> </i> the IAM user are explicitly allowed to perform the requested action. The passed policy cannot grant more permissions than those that are defined in the IAM user policy.</p> <p>A typical use case is that the permissions of the IAM user whose credentials are used to call <code>GetFederationToken</code> are designed to allow access to all the actions and resources that any federated user will need. Then, for individual users, you pass a policy to the operation that scopes down the permissions to a level that's appropriate to that individual user, using a policy that allows only a subset of permissions that are granted to the IAM user. </p> <p>If you do not pass a policy, the resulting temporary security credentials have no effective permissions. The only exception is when the temporary security credentials are used to access a resource that has a resource-based policy that specifically allows the federated user to access the resource.</p> <p>For more information about how permissions work, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_getfederationtoken.html\\\">Permissions for GetFederationToken</a>. For information about using <code>GetFederationToken</code> to create temporary security credentials, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_getfederationtoken\\\">GetFederationTokenâFederation Through a Custom Identity Broker</a>. </p>\"\
    },\
    \"GetSessionToken\":{\
      \"name\":\"GetSessionToken\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetSessionTokenRequest\"},\
      \"output\":{\
        \"shape\":\"GetSessionTokenResponse\",\
        \"resultWrapper\":\"GetSessionTokenResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"RegionDisabledException\"}\
      ],\
      \"documentation\":\"<p>Returns a set of temporary credentials for an AWS account or IAM user. The credentials consist of an access key ID, a secret access key, and a security token. Typically, you use <code>GetSessionToken</code> if you want to use MFA to protect programmatic calls to specific AWS APIs like Amazon EC2 <code>StopInstances</code>. MFA-enabled IAM users would need to call <code>GetSessionToken</code> and submit an MFA code that is associated with their MFA device. Using the temporary security credentials that are returned from the call, IAM users can then make programmatic calls to APIs that require MFA authentication. If you do not supply a correct MFA code, then the API returns an access denied error. For a comparison of <code>GetSessionToken</code> with the other APIs that produce temporary credentials, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html\\\">Requesting Temporary Security Credentials</a> and <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#stsapi_comparison\\\">Comparing the AWS STS APIs</a> in the <i>IAM User Guide</i>.</p> <p>The <code>GetSessionToken</code> action must be called by using the long-term AWS security credentials of the AWS account or an IAM user. Credentials that are created by IAM users are valid for the duration that you specify, from 900 seconds (15 minutes) up to a maximum of 129600 seconds (36 hours), with a default of 43200 seconds (12 hours); credentials that are created by using account credentials can range from 900 seconds (15 minutes) up to a maximum of 3600 seconds (1 hour), with a default of 1 hour. </p> <p>The temporary security credentials created by <code>GetSessionToken</code> can be used to make API calls to any AWS service with the following exceptions:</p> <ul> <li> <p>You cannot call any IAM APIs unless MFA authentication information is included in the request.</p> </li> <li> <p>You cannot call any STS API <i>except</i> <code>AssumeRole</code>.</p> </li> </ul> <note> <p>We recommend that you do not call <code>GetSessionToken</code> with root account credentials. Instead, follow our <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html#create-iam-users\\\">best practices</a> by creating one or more IAM users, giving them the necessary permissions, and using IAM users for everyday interaction with AWS. </p> </note> <p>The permissions associated with the temporary security credentials returned by <code>GetSessionToken</code> are based on the permissions associated with account or IAM user whose credentials are used to call the action. If <code>GetSessionToken</code> is called using root account credentials, the temporary credentials have root account permissions. Similarly, if <code>GetSessionToken</code> is called using the credentials of an IAM user, the temporary credentials have the same permissions as the IAM user. </p> <p>For more information about using <code>GetSessionToken</code> to create temporary credentials, go to <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_request.html#api_getsessiontoken\\\">Temporary Credentials for Users in Untrusted Environments</a> in the <i>IAM User Guide</i>. </p>\"\
    }\
  },\
  \"shapes\":{\
    \"AssumeRoleRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleArn\",\
        \"RoleSessionName\"\
      ],\
      \"members\":{\
        \"RoleArn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the role to assume.</p>\"\
        },\
        \"RoleSessionName\":{\
          \"shape\":\"roleSessionNameType\",\
          \"documentation\":\"<p>An identifier for the assumed role session.</p> <p>Use the role session name to uniquely identify a session when the same role is assumed by different principals or for different reasons. In cross-account scenarios, the role session name is visible to, and can be logged by the account that owns the role. The role session name is also used in the ARN of the assumed role principal. This means that subsequent cross-account API requests using the temporary security credentials will expose the role session name to the external account in their CloudTrail logs.</p> <p>The format for this parameter, as described by its regex pattern, is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"sessionPolicyDocumentType\",\
          \"documentation\":\"<p>An IAM policy in JSON format.</p> <p>This parameter is optional. If you pass a policy, the temporary security credentials that are returned by the operation have the permissions that are allowed by both (the intersection of) the access policy of the role that is being assumed, <i>and</i> the policy that you pass. This gives you a way to further restrict the permissions for the resulting temporary security credentials. You cannot use the passed policy to grant permissions that are in excess of those allowed by the access policy of the role that is being assumed. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_assumerole.html\\\">Permissions for AssumeRole, AssumeRoleWithSAML, and AssumeRoleWithWebIdentity</a> in the <i>IAM User Guide</i>.</p> <p>The format for this parameter, as described by its regex pattern, is a string of characters up to 2048 characters in length. The characters can be any ASCII character from the space character to the end of the valid character list (\\\\u0020-\\\\u00FF). It can also include the tab (\\\\u0009), linefeed (\\\\u000A), and carriage return (\\\\u000D) characters.</p> <note> <p>The policy plain text must be 2048 bytes or shorter. However, an internal conversion compresses it into a packed binary format with a separate limit. The PackedPolicySize response element indicates by percentage how close to the upper size limit the policy is, with 100% equaling the maximum allowed size.</p> </note>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"roleDurationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, of the role session. The value can range from 900 seconds (15 minutes) to 3600 seconds (1 hour). By default, the value is set to 3600 seconds.</p> <note> <p>This is separate from the duration of a console session that you might request using the returned credentials. The request to the federation endpoint for a console sign-in token takes a <code>SessionDuration</code> parameter that specifies the maximum length of the console session, separately from the <code>DurationSeconds</code> parameter on this API. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html\\\">Creating a URL that Enables Federated Users to Access the AWS Management Console</a> in the <i>IAM User Guide</i>.</p> </note>\"\
        },\
        \"ExternalId\":{\
          \"shape\":\"externalIdType\",\
          \"documentation\":\"<p>A unique identifier that is used by third parties when assuming roles in their customers' accounts. For each role that the third party can assume, they should instruct their customers to ensure the role's trust policy checks for the external ID that the third party generated. Each time the third party assumes the role, they should pass the customer's external ID. The external ID is useful in order to help third parties bind a role to the customer who created it. For more information about the external ID, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html\\\">How to Use an External ID When Granting Access to Your AWS Resources to a Third Party</a> in the <i>IAM User Guide</i>.</p> <p>The format for this parameter, as described by its regex pattern, is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@:\\\\/-</p>\"\
        },\
        \"SerialNumber\":{\
          \"shape\":\"serialNumberType\",\
          \"documentation\":\"<p>The identification number of the MFA device that is associated with the user who is making the <code>AssumeRole</code> call. Specify this value if the trust policy of the role being assumed includes a condition that requires MFA authentication. The value is either the serial number for a hardware device (such as <code>GAHT12345678</code>) or an Amazon Resource Name (ARN) for a virtual device (such as <code>arn:aws:iam::123456789012:mfa/user</code>).</p> <p>The format for this parameter, as described by its regex pattern, is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        },\
        \"TokenCode\":{\
          \"shape\":\"tokenCodeType\",\
          \"documentation\":\"<p>The value provided by the MFA device, if the trust policy of the role being assumed requires MFA (that is, if the policy includes a condition that tests for MFA). If the role being assumed requires MFA and if the <code>TokenCode</code> value is missing or expired, the <code>AssumeRole</code> call returns an \\\"access denied\\\" error.</p> <p>The format for this parameter, as described by its regex pattern, is a sequence of six numeric digits.</p>\"\
        }\
      }\
    },\
    \"AssumeRoleResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <p> <b>Note:</b> The size of the security token that STS APIs return is not fixed. We strongly recommend that you make no assumptions about the maximum size. As of this writing, the typical size is less than 4096 bytes, but that can vary. Also, future updates to AWS might require larger sizes.</p>\"\
        },\
        \"AssumedRoleUser\":{\
          \"shape\":\"AssumedRoleUser\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) and the assumed role ID, which are identifiers that you can use to refer to the resulting temporary security credentials. For example, you can reference these credentials as a principal in a resource-based policy by using the ARN or assumed role ID. The ARN and ID include the <code>RoleSessionName</code> that you specified when you called <code>AssumeRole</code>. </p>\"\
        },\
        \"PackedPolicySize\":{\
          \"shape\":\"nonNegativeIntegerType\",\
          \"documentation\":\"<p>A percentage value that indicates the size of the policy in packed form. The service rejects any policy with a packed size greater than 100 percent, which means the policy exceeded the allowed space.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>AssumeRole</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>\"\
    },\
    \"AssumeRoleWithSAMLRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleArn\",\
        \"PrincipalArn\",\
        \"SAMLAssertion\"\
      ],\
      \"members\":{\
        \"RoleArn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the role that the caller is assuming.</p>\"\
        },\
        \"PrincipalArn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the SAML provider in IAM that describes the IdP.</p>\"\
        },\
        \"SAMLAssertion\":{\
          \"shape\":\"SAMLAssertionType\",\
          \"documentation\":\"<p>The base-64 encoded SAML authentication response provided by the IdP.</p> <p>For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/create-role-saml-IdP-tasks.html\\\">Configuring a Relying Party and Adding Claims</a> in the <i>Using IAM</i> guide. </p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"sessionPolicyDocumentType\",\
          \"documentation\":\"<p>An IAM policy in JSON format.</p> <p>The policy parameter is optional. If you pass a policy, the temporary security credentials that are returned by the operation have the permissions that are allowed by both the access policy of the role that is being assumed, <i> <b>and</b> </i> the policy that you pass. This gives you a way to further restrict the permissions for the resulting temporary security credentials. You cannot use the passed policy to grant permissions that are in excess of those allowed by the access policy of the role that is being assumed. For more information, <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_assumerole.html\\\">Permissions for AssumeRole, AssumeRoleWithSAML, and AssumeRoleWithWebIdentity</a> in the <i>IAM User Guide</i>. </p> <p>The format for this parameter, as described by its regex pattern, is a string of characters up to 2048 characters in length. The characters can be any ASCII character from the space character to the end of the valid character list (\\\\u0020-\\\\u00FF). It can also include the tab (\\\\u0009), linefeed (\\\\u000A), and carriage return (\\\\u000D) characters.</p> <note> <p>The policy plain text must be 2048 bytes or shorter. However, an internal conversion compresses it into a packed binary format with a separate limit. The PackedPolicySize response element indicates by percentage how close to the upper size limit the policy is, with 100% equaling the maximum allowed size.</p> </note>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"roleDurationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, of the role session. The value can range from 900 seconds (15 minutes) to 3600 seconds (1 hour). By default, the value is set to 3600 seconds. An expiration can also be specified in the SAML authentication response's <code>SessionNotOnOrAfter</code> value. The actual expiration time is whichever value is shorter. </p> <note> <p>This is separate from the duration of a console session that you might request using the returned credentials. The request to the federation endpoint for a console sign-in token takes a <code>SessionDuration</code> parameter that specifies the maximum length of the console session, separately from the <code>DurationSeconds</code> parameter on this API. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-saml.html\\\">Enabling SAML 2.0 Federated Users to Access the AWS Management Console</a> in the <i>IAM User Guide</i>.</p> </note>\"\
        }\
      }\
    },\
    \"AssumeRoleWithSAMLResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <p> <b>Note:</b> The size of the security token that STS APIs return is not fixed. We strongly recommend that you make no assumptions about the maximum size. As of this writing, the typical size is less than 4096 bytes, but that can vary. Also, future updates to AWS might require larger sizes.</p>\"\
        },\
        \"AssumedRoleUser\":{\
          \"shape\":\"AssumedRoleUser\",\
          \"documentation\":\"<p>The identifiers for the temporary security credentials that the operation returns.</p>\"\
        },\
        \"PackedPolicySize\":{\
          \"shape\":\"nonNegativeIntegerType\",\
          \"documentation\":\"<p>A percentage value that indicates the size of the policy in packed form. The service rejects any policy with a packed size greater than 100 percent, which means the policy exceeded the allowed space.</p>\"\
        },\
        \"Subject\":{\
          \"shape\":\"Subject\",\
          \"documentation\":\"<p>The value of the <code>NameID</code> element in the <code>Subject</code> element of the SAML assertion.</p>\"\
        },\
        \"SubjectType\":{\
          \"shape\":\"SubjectType\",\
          \"documentation\":\"<p> The format of the name ID, as defined by the <code>Format</code> attribute in the <code>NameID</code> element of the SAML assertion. Typical examples of the format are <code>transient</code> or <code>persistent</code>. </p> <p> If the format includes the prefix <code>urn:oasis:names:tc:SAML:2.0:nameid-format</code>, that prefix is removed. For example, <code>urn:oasis:names:tc:SAML:2.0:nameid-format:transient</code> is returned as <code>transient</code>. If the format includes any other prefix, the format is returned with no modifications.</p>\"\
        },\
        \"Issuer\":{\
          \"shape\":\"Issuer\",\
          \"documentation\":\"<p>The value of the <code>Issuer</code> element of the SAML assertion.</p>\"\
        },\
        \"Audience\":{\
          \"shape\":\"Audience\",\
          \"documentation\":\"<p> The value of the <code>Recipient</code> attribute of the <code>SubjectConfirmationData</code> element of the SAML assertion. </p>\"\
        },\
        \"NameQualifier\":{\
          \"shape\":\"NameQualifier\",\
          \"documentation\":\"<p>A hash value based on the concatenation of the <code>Issuer</code> response value, the AWS account ID, and the friendly name (the last part of the ARN) of the SAML provider in IAM. The combination of <code>NameQualifier</code> and <code>Subject</code> can be used to uniquely identify a federated user. </p> <p>The following pseudocode shows how the hash value is calculated:</p> <p> <code>BASE64 ( SHA1 ( \\\"https://example.com/saml\\\" + \\\"123456789012\\\" + \\\"/MySAMLIdP\\\" ) )</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>AssumeRoleWithSAML</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>\"\
    },\
    \"AssumeRoleWithWebIdentityRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RoleArn\",\
        \"RoleSessionName\",\
        \"WebIdentityToken\"\
      ],\
      \"members\":{\
        \"RoleArn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the role that the caller is assuming.</p>\"\
        },\
        \"RoleSessionName\":{\
          \"shape\":\"roleSessionNameType\",\
          \"documentation\":\"<p>An identifier for the assumed role session. Typically, you pass the name or identifier that is associated with the user who is using your application. That way, the temporary security credentials that your application will use are associated with that user. This session name is included as part of the ARN and assumed role ID in the <code>AssumedRoleUser</code> response element.</p> <p>The format for this parameter, as described by its regex pattern, is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        },\
        \"WebIdentityToken\":{\
          \"shape\":\"clientTokenType\",\
          \"documentation\":\"<p>The OAuth 2.0 access token or OpenID Connect ID token that is provided by the identity provider. Your application must get this token by authenticating the user who is using your application with a web identity provider before the application makes an <code>AssumeRoleWithWebIdentity</code> call. </p>\"\
        },\
        \"ProviderId\":{\
          \"shape\":\"urlType\",\
          \"documentation\":\"<p>The fully qualified host component of the domain name of the identity provider.</p> <p>Specify this value only for OAuth 2.0 access tokens. Currently <code>www.amazon.com</code> and <code>graph.facebook.com</code> are the only supported identity providers for OAuth 2.0 access tokens. Do not include URL schemes and port numbers.</p> <p>Do not specify this value for OpenID Connect ID tokens.</p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"sessionPolicyDocumentType\",\
          \"documentation\":\"<p>An IAM policy in JSON format.</p> <p>The policy parameter is optional. If you pass a policy, the temporary security credentials that are returned by the operation have the permissions that are allowed by both the access policy of the role that is being assumed, <i> <b>and</b> </i> the policy that you pass. This gives you a way to further restrict the permissions for the resulting temporary security credentials. You cannot use the passed policy to grant permissions that are in excess of those allowed by the access policy of the role that is being assumed. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_assumerole.html\\\">Permissions for AssumeRoleWithWebIdentity</a> in the <i>IAM User Guide</i>. </p> <p>The format for this parameter, as described by its regex pattern, is a string of characters up to 2048 characters in length. The characters can be any ASCII character from the space character to the end of the valid character list (\\\\u0020-\\\\u00FF). It can also include the tab (\\\\u0009), linefeed (\\\\u000A), and carriage return (\\\\u000D) characters.</p> <note> <p>The policy plain text must be 2048 bytes or shorter. However, an internal conversion compresses it into a packed binary format with a separate limit. The PackedPolicySize response element indicates by percentage how close to the upper size limit the policy is, with 100% equaling the maximum allowed size.</p> </note>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"roleDurationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, of the role session. The value can range from 900 seconds (15 minutes) to 3600 seconds (1 hour). By default, the value is set to 3600 seconds.</p> <note> <p>This is separate from the duration of a console session that you might request using the returned credentials. The request to the federation endpoint for a console sign-in token takes a <code>SessionDuration</code> parameter that specifies the maximum length of the console session, separately from the <code>DurationSeconds</code> parameter on this API. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html\\\">Creating a URL that Enables Federated Users to Access the AWS Management Console</a> in the <i>IAM User Guide</i>.</p> </note>\"\
        }\
      }\
    },\
    \"AssumeRoleWithWebIdentityResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security token.</p> <p> <b>Note:</b> The size of the security token that STS APIs return is not fixed. We strongly recommend that you make no assumptions about the maximum size. As of this writing, the typical size is less than 4096 bytes, but that can vary. Also, future updates to AWS might require larger sizes.</p>\"\
        },\
        \"SubjectFromWebIdentityToken\":{\
          \"shape\":\"webIdentitySubjectType\",\
          \"documentation\":\"<p>The unique user identifier that is returned by the identity provider. This identifier is associated with the <code>WebIdentityToken</code> that was submitted with the <code>AssumeRoleWithWebIdentity</code> call. The identifier is typically unique to the user and the application that acquired the <code>WebIdentityToken</code> (pairwise identifier). For OpenID Connect ID tokens, this field contains the value returned by the identity provider as the token's <code>sub</code> (Subject) claim. </p>\"\
        },\
        \"AssumedRoleUser\":{\
          \"shape\":\"AssumedRoleUser\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) and the assumed role ID, which are identifiers that you can use to refer to the resulting temporary security credentials. For example, you can reference these credentials as a principal in a resource-based policy by using the ARN or assumed role ID. The ARN and ID include the <code>RoleSessionName</code> that you specified when you called <code>AssumeRole</code>. </p>\"\
        },\
        \"PackedPolicySize\":{\
          \"shape\":\"nonNegativeIntegerType\",\
          \"documentation\":\"<p>A percentage value that indicates the size of the policy in packed form. The service rejects any policy with a packed size greater than 100 percent, which means the policy exceeded the allowed space.</p>\"\
        },\
        \"Provider\":{\
          \"shape\":\"Issuer\",\
          \"documentation\":\"<p> The issuing authority of the web identity token presented. For OpenID Connect ID Tokens this contains the value of the <code>iss</code> field. For OAuth 2.0 access tokens, this contains the value of the <code>ProviderId</code> parameter that was passed in the <code>AssumeRoleWithWebIdentity</code> request.</p>\"\
        },\
        \"Audience\":{\
          \"shape\":\"Audience\",\
          \"documentation\":\"<p>The intended audience (also known as client ID) of the web identity token. This is traditionally the client identifier issued to the application that requested the web identity token.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>AssumeRoleWithWebIdentity</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>\"\
    },\
    \"AssumedRoleUser\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AssumedRoleId\",\
        \"Arn\"\
      ],\
      \"members\":{\
        \"AssumedRoleId\":{\
          \"shape\":\"assumedRoleIdType\",\
          \"documentation\":\"<p>A unique identifier that contains the role ID and the role session name of the role that is being assumed. The role ID is generated by AWS when the role is created.</p>\"\
        },\
        \"Arn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The ARN of the temporary security credentials that are returned from the <a>AssumeRole</a> action. For more information about ARNs and how to use them in policies, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html\\\">IAM Identifiers</a> in <i>Using IAM</i>. </p>\"\
        }\
      },\
      \"documentation\":\"<p>The identifiers for the temporary security credentials that the operation returns.</p>\"\
    },\
    \"Audience\":{\"type\":\"string\"},\
    \"Credentials\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AccessKeyId\",\
        \"SecretAccessKey\",\
        \"SessionToken\",\
        \"Expiration\"\
      ],\
      \"members\":{\
        \"AccessKeyId\":{\
          \"shape\":\"accessKeyIdType\",\
          \"documentation\":\"<p>The access key ID that identifies the temporary security credentials.</p>\"\
        },\
        \"SecretAccessKey\":{\
          \"shape\":\"accessKeySecretType\",\
          \"documentation\":\"<p>The secret access key that can be used to sign requests.</p>\"\
        },\
        \"SessionToken\":{\
          \"shape\":\"tokenType\",\
          \"documentation\":\"<p>The token that users must pass to the service API to use the temporary credentials.</p>\"\
        },\
        \"Expiration\":{\
          \"shape\":\"dateType\",\
          \"documentation\":\"<p>The date on which the current credentials expire.</p>\"\
        }\
      },\
      \"documentation\":\"<p>AWS credentials for API authentication.</p>\"\
    },\
    \"DecodeAuthorizationMessageRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"EncodedMessage\"],\
      \"members\":{\
        \"EncodedMessage\":{\
          \"shape\":\"encodedMessageType\",\
          \"documentation\":\"<p>The encoded message that was returned with the response.</p>\"\
        }\
      }\
    },\
    \"DecodeAuthorizationMessageResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DecodedMessage\":{\
          \"shape\":\"decodedMessageType\",\
          \"documentation\":\"<p>An XML document that contains the decoded message.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A document that contains additional information about the authorization status of a request from an encoded message that is returned in response to an AWS request.</p>\"\
    },\
    \"ExpiredTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"expiredIdentityTokenMessage\"}\
      },\
      \"documentation\":\"<p>The web identity token that was passed is expired or is not valid. Get a new identity token from the identity provider and then retry the request.</p>\",\
      \"error\":{\
        \"code\":\"ExpiredTokenException\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"FederatedUser\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"FederatedUserId\",\
        \"Arn\"\
      ],\
      \"members\":{\
        \"FederatedUserId\":{\
          \"shape\":\"federatedIdType\",\
          \"documentation\":\"<p>The string that identifies the federated user associated with the credentials, similar to the unique ID of an IAM user.</p>\"\
        },\
        \"Arn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The ARN that specifies the federated user that is associated with the credentials. For more information about ARNs and how to use them in policies, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html\\\">IAM Identifiers</a> in <i>Using IAM</i>. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Identifiers for the federated user that is associated with the credentials.</p>\"\
    },\
    \"GetCallerIdentityRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"GetCallerIdentityResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"UserId\":{\
          \"shape\":\"userIdType\",\
          \"documentation\":\"<p>The unique identifier of the calling entity. The exact value depends on the type of entity making the call. The values returned are those listed in the <b>aws:userid</b> column in the <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html#principaltable\\\">Principal table</a> found on the <b>Policy Variables</b> reference page in the <i>IAM User Guide</i>.</p>\"\
        },\
        \"Account\":{\
          \"shape\":\"accountType\",\
          \"documentation\":\"<p>The AWS account ID number of the account that owns or contains the calling entity.</p>\"\
        },\
        \"Arn\":{\
          \"shape\":\"arnType\",\
          \"documentation\":\"<p>The AWS ARN associated with the calling entity.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>GetCallerIdentity</a> request, including information about the entity making the request.</p>\"\
    },\
    \"GetFederationTokenRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"Name\"],\
      \"members\":{\
        \"Name\":{\
          \"shape\":\"userNameType\",\
          \"documentation\":\"<p>The name of the federated user. The name is used as an identifier for the temporary security credentials (such as <code>Bob</code>). For example, you can reference the federated user name in a resource-based policy, such as in an Amazon S3 bucket policy.</p> <p>The format for this parameter, as described by its regex pattern, is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"sessionPolicyDocumentType\",\
          \"documentation\":\"<p>An IAM policy in JSON format that is passed with the <code>GetFederationToken</code> call and evaluated along with the policy or policies that are attached to the IAM user whose credentials are used to call <code>GetFederationToken</code>. The passed policy is used to scope down the permissions that are available to the IAM user, by allowing only a subset of the permissions that are granted to the IAM user. The passed policy cannot grant more permissions than those granted to the IAM user. The final permissions for the federated user are the most restrictive set based on the intersection of the passed policy and the IAM user policy.</p> <p>If you do not pass a policy, the resulting temporary security credentials have no effective permissions. The only exception is when the temporary security credentials are used to access a resource that has a resource-based policy that specifically allows the federated user to access the resource.</p> <p>The format for this parameter, as described by its regex pattern, is a string of characters up to 2048 characters in length. The characters can be any ASCII character from the space character to the end of the valid character list (\\\\u0020-\\\\u00FF). It can also include the tab (\\\\u0009), linefeed (\\\\u000A), and carriage return (\\\\u000D) characters.</p> <note> <p>The policy plain text must be 2048 bytes or shorter. However, an internal conversion compresses it into a packed binary format with a separate limit. The PackedPolicySize response element indicates by percentage how close to the upper size limit the policy is, with 100% equaling the maximum allowed size.</p> </note> <p>For more information about how permissions work, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_control-access_getfederationtoken.html\\\">Permissions for GetFederationToken</a>.</p>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"durationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, that the session should last. Acceptable durations for federation sessions range from 900 seconds (15 minutes) to 129600 seconds (36 hours), with 43200 seconds (12 hours) as the default. Sessions obtained using AWS account (root) credentials are restricted to a maximum of 3600 seconds (one hour). If the specified duration is longer than one hour, the session obtained by using AWS account (root) credentials defaults to one hour.</p>\"\
        }\
      }\
    },\
    \"GetFederationTokenResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <p> <b>Note:</b> The size of the security token that STS APIs return is not fixed. We strongly recommend that you make no assumptions about the maximum size. As of this writing, the typical size is less than 4096 bytes, but that can vary. Also, future updates to AWS might require larger sizes.</p>\"\
        },\
        \"FederatedUser\":{\
          \"shape\":\"FederatedUser\",\
          \"documentation\":\"<p>Identifiers for the federated user associated with the credentials (such as <code>arn:aws:sts::123456789012:federated-user/Bob</code> or <code>123456789012:Bob</code>). You can use the federated user's ARN in your resource-based policies, such as an Amazon S3 bucket policy. </p>\"\
        },\
        \"PackedPolicySize\":{\
          \"shape\":\"nonNegativeIntegerType\",\
          \"documentation\":\"<p>A percentage value indicating the size of the policy in packed form. The service rejects policies for which the packed size is greater than 100 percent of the allowed value.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>GetFederationToken</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>\"\
    },\
    \"GetSessionTokenRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"DurationSeconds\":{\
          \"shape\":\"durationSecondsType\",\
          \"documentation\":\"<p>The duration, in seconds, that the credentials should remain valid. Acceptable durations for IAM user sessions range from 900 seconds (15 minutes) to 129600 seconds (36 hours), with 43200 seconds (12 hours) as the default. Sessions for AWS account owners are restricted to a maximum of 3600 seconds (one hour). If the duration is longer than one hour, the session for AWS account owners defaults to one hour.</p>\"\
        },\
        \"SerialNumber\":{\
          \"shape\":\"serialNumberType\",\
          \"documentation\":\"<p>The identification number of the MFA device that is associated with the IAM user who is making the <code>GetSessionToken</code> call. Specify this value if the IAM user has a policy that requires MFA authentication. The value is either the serial number for a hardware device (such as <code>GAHT12345678</code>) or an Amazon Resource Name (ARN) for a virtual device (such as <code>arn:aws:iam::123456789012:mfa/user</code>). You can find the device for an IAM user by going to the AWS Management Console and viewing the user's security credentials. </p> <p>The format for this parameter, as described by its regex pattern, is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>\"\
        },\
        \"TokenCode\":{\
          \"shape\":\"tokenCodeType\",\
          \"documentation\":\"<p>The value provided by the MFA device, if MFA is required. If any policy requires the IAM user to submit an MFA code, specify this value. If MFA authentication is required, and the user does not provide a code when requesting a set of temporary security credentials, the user will receive an \\\"access denied\\\" response when requesting resources that require MFA authentication.</p> <p>The format for this parameter, as described by its regex pattern, is a sequence of six numeric digits.</p>\"\
        }\
      }\
    },\
    \"GetSessionTokenResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Credentials\":{\
          \"shape\":\"Credentials\",\
          \"documentation\":\"<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <p> <b>Note:</b> The size of the security token that STS APIs return is not fixed. We strongly recommend that you make no assumptions about the maximum size. As of this writing, the typical size is less than 4096 bytes, but that can vary. Also, future updates to AWS might require larger sizes.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the response to a successful <a>GetSessionToken</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>\"\
    },\
    \"IDPCommunicationErrorException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"idpCommunicationErrorMessage\"}\
      },\
      \"documentation\":\"<p>The request could not be fulfilled because the non-AWS identity provider (IDP) that was asked to verify the incoming identity token could not be reached. This is often a transient error caused by network conditions. Retry the request a limited number of times so that you don't exceed the request rate. If the error persists, the non-AWS identity provider might be down or not responding.</p>\",\
      \"error\":{\
        \"code\":\"IDPCommunicationError\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"IDPRejectedClaimException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"idpRejectedClaimMessage\"}\
      },\
      \"documentation\":\"<p>The identity provider (IdP) reported that authentication failed. This might be because the claim is invalid.</p> <p>If this error is returned for the <code>AssumeRoleWithWebIdentity</code> operation, it can also mean that the claim has expired or has been explicitly revoked. </p>\",\
      \"error\":{\
        \"code\":\"IDPRejectedClaim\",\
        \"httpStatusCode\":403,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"InvalidAuthorizationMessageException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"invalidAuthorizationMessage\"}\
      },\
      \"documentation\":\"<p>The error returned if the message passed to <code>DecodeAuthorizationMessage</code> was invalid. This can happen if the token contains invalid characters, such as linebreaks. </p>\",\
      \"error\":{\
        \"code\":\"InvalidAuthorizationMessageException\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"InvalidIdentityTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"invalidIdentityTokenMessage\"}\
      },\
      \"documentation\":\"<p>The web identity token that was passed could not be validated by AWS. Get a new identity token from the identity provider and then retry the request.</p>\",\
      \"error\":{\
        \"code\":\"InvalidIdentityToken\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"Issuer\":{\"type\":\"string\"},\
    \"MalformedPolicyDocumentException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"malformedPolicyDocumentMessage\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the policy document was malformed. The error message describes the specific error.</p>\",\
      \"error\":{\
        \"code\":\"MalformedPolicyDocument\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"NameQualifier\":{\"type\":\"string\"},\
    \"PackedPolicyTooLargeException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"packedPolicyTooLargeMessage\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the policy document was too large. The error message describes how big the policy document is, in packed form, as a percentage of what the API allows.</p>\",\
      \"error\":{\
        \"code\":\"PackedPolicyTooLarge\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"RegionDisabledException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"regionDisabledMessage\"}\
      },\
      \"documentation\":\"<p>STS is not activated in the requested region for the account that is being asked to generate credentials. The account administrator must use the IAM console to activate STS in that region. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html\\\">Activating and Deactivating AWS STS in an AWS Region</a> in the <i>IAM User Guide</i>.</p>\",\
      \"error\":{\
        \"code\":\"RegionDisabledException\",\
        \"httpStatusCode\":403,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"SAMLAssertionType\":{\
      \"type\":\"string\",\
      \"max\":50000,\
      \"min\":4\
    },\
    \"Subject\":{\"type\":\"string\"},\
    \"SubjectType\":{\"type\":\"string\"},\
    \"accessKeyIdType\":{\
      \"type\":\"string\",\
      \"max\":32,\
      \"min\":16,\
      \"pattern\":\"[\\\\w]*\"\
    },\
    \"accessKeySecretType\":{\"type\":\"string\"},\
    \"accountType\":{\"type\":\"string\"},\
    \"arnType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":20,\
      \"pattern\":\"[\\\\u0009\\\\u000A\\\\u000D\\\\u0020-\\\\u007E\\\\u0085\\\\u00A0-\\\\uD7FF\\\\uE000-\\\\uFFFD\\\\u10000-\\\\u10FFFF]+\"\
    },\
    \"assumedRoleIdType\":{\
      \"type\":\"string\",\
      \"max\":96,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@:-]*\"\
    },\
    \"clientTokenType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":4\
    },\
    \"dateType\":{\"type\":\"timestamp\"},\
    \"decodedMessageType\":{\"type\":\"string\"},\
    \"durationSecondsType\":{\
      \"type\":\"integer\",\
      \"max\":129600,\
      \"min\":900\
    },\
    \"encodedMessageType\":{\
      \"type\":\"string\",\
      \"max\":10240,\
      \"min\":1\
    },\
    \"expiredIdentityTokenMessage\":{\"type\":\"string\"},\
    \"externalIdType\":{\
      \"type\":\"string\",\
      \"max\":1224,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@:\\\\/-]*\"\
    },\
    \"federatedIdType\":{\
      \"type\":\"string\",\
      \"max\":96,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@\\\\:-]*\"\
    },\
    \"idpCommunicationErrorMessage\":{\"type\":\"string\"},\
    \"idpRejectedClaimMessage\":{\"type\":\"string\"},\
    \"invalidAuthorizationMessage\":{\"type\":\"string\"},\
    \"invalidIdentityTokenMessage\":{\"type\":\"string\"},\
    \"malformedPolicyDocumentMessage\":{\"type\":\"string\"},\
    \"nonNegativeIntegerType\":{\
      \"type\":\"integer\",\
      \"min\":0\
    },\
    \"packedPolicyTooLargeMessage\":{\"type\":\"string\"},\
    \"regionDisabledMessage\":{\"type\":\"string\"},\
    \"roleDurationSecondsType\":{\
      \"type\":\"integer\",\
      \"max\":3600,\
      \"min\":900\
    },\
    \"roleSessionNameType\":{\
      \"type\":\"string\",\
      \"max\":64,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@-]*\"\
    },\
    \"serialNumberType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":9,\
      \"pattern\":\"[\\\\w+=/:,.@-]*\"\
    },\
    \"sessionPolicyDocumentType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":1,\
      \"pattern\":\"[\\\\u0009\\\\u000A\\\\u000D\\\\u0020-\\\\u00FF]+\"\
    },\
    \"tokenCodeType\":{\
      \"type\":\"string\",\
      \"max\":6,\
      \"min\":6,\
      \"pattern\":\"[\\\\d]*\"\
    },\
    \"tokenType\":{\"type\":\"string\"},\
    \"urlType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":4\
    },\
    \"userIdType\":{\"type\":\"string\"},\
    \"userNameType\":{\
      \"type\":\"string\",\
      \"max\":32,\
      \"min\":2,\
      \"pattern\":\"[\\\\w+=,.@-]*\"\
    },\
    \"webIdentitySubjectType\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":6\
    }\
  },\
  \"documentation\":\"<fullname>AWS Security Token Service</fullname> <p>The AWS Security Token Service (STS) is a web service that enables you to request temporary, limited-privilege credentials for AWS Identity and Access Management (IAM) users or for users that you authenticate (federated users). This guide provides descriptions of the STS API. For more detailed information about using this service, go to <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html\\\">Temporary Security Credentials</a>. </p> <note> <p> As an alternative to using the API, you can use one of the AWS SDKs, which consist of libraries and sample code for various programming languages and platforms (Java, Ruby, .NET, iOS, Android, etc.). The SDKs provide a convenient way to create programmatic access to STS. For example, the SDKs take care of cryptographically signing requests, managing errors, and retrying requests automatically. For information about the AWS SDKs, including how to download and install them, see the <a href=\\\"http://aws.amazon.com/tools/\\\">Tools for Amazon Web Services page</a>. </p> </note> <p>For information about setting up signatures and authorization through the API, go to <a href=\\\"http://docs.aws.amazon.com/general/latest/gr/signing_aws_api_requests.html\\\">Signing AWS API Requests</a> in the <i>AWS General Reference</i>. For general information about the Query API, go to <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/IAM_UsingQueryAPI.html\\\">Making Query Requests</a> in <i>Using IAM</i>. For information about using security tokens with other AWS products, go to <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html\\\">AWS Services That Work with IAM</a> in the <i>IAM User Guide</i>. </p> <p>If you're new to AWS and need additional technical information about a specific AWS product, you can find the product's technical documentation at <a href=\\\"http://aws.amazon.com/documentation/\\\">http://aws.amazon.com/documentation/</a>. </p> <p> <b>Endpoints</b> </p> <p>The AWS Security Token Service (STS) has a default endpoint of https://sts.amazonaws.com that maps to the US East (N. Virginia) region. Additional regions are available and are activated by default. For more information, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html\\\">Activating and Deactivating AWS STS in an AWS Region</a> in the <i>IAM User Guide</i>.</p> <p>For information about STS endpoints, see <a href=\\\"http://docs.aws.amazon.com/general/latest/gr/rande.html#sts_region\\\">Regions and Endpoints</a> in the <i>AWS General Reference</i>.</p> <p> <b>Recording API requests</b> </p> <p>STS supports AWS CloudTrail, which is a service that records AWS calls for your AWS account and delivers log files to an Amazon S3 bucket. By using information collected by CloudTrail, you can determine what requests were successfully made to STS, who made the request, when it was made, and so on. To learn more about CloudTrail, including how to turn it on and find your log files, see the <a href=\\\"http://docs.aws.amazon.com/awscloudtrail/latest/userguide/what_is_cloud_trail_top_level.html\\\">AWS CloudTrail User Guide</a>.</p>\"\
}";
}

@end

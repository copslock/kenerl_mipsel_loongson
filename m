Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2018 18:24:43 +0200 (CEST)
Received: from mail-by2nam05on0709.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::709]:12736
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994002AbeHBQYjkN14z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Aug 2018 18:24:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP3LoNx24H4O93LEK6SIjAOefq/wpi6QAzmuL1eK024=;
 b=KDqil2cTZq7XAy37h9dQdExGe5qpkEThDJjzziGppil2pL5E/bFz+/sHS1N4Fro0aV5WUaMXTWj9v3CWdm8AJwgzX6HUbRZjQsKaZGHhFaJQwpSrBBH/So0wkwoNmi+49pNnZRCT73XGwieKR3AkeKeFURReOxb7tYDdTOhI4Eg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4930.namprd08.prod.outlook.com (2603:10b6:408:28::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Thu, 2 Aug 2018 16:23:54 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: generic: Remove input symbols from defconfig
Date:   Thu,  2 Aug 2018 09:23:30 -0700
Message-Id: <20180802162330.31266-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To BN7PR08MB4930.namprd08.prod.outlook.com
 (2603:10b6:408:28::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 707139c9-01ba-4df3-e5a7-08d5f8945746
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;3:BO9+BZ541MqvO1lgxxud+Q1qTzgo9OeQqcdd8Ga9j64A3OQKwYef5Ss5t4u9P/nOPbyKbGGKZWRpgZuj6amORUkUbvoM82mmtlvEdi3ep/zTKfiuwkNQzOSvlknm7mku334L9mdivncbi5wlLbFGDt3jxZrP77CtAVVEsWcOpf/fPUyMS3amLDGr//rp0pdTwM5TqKvB7k0OM5Rl8UnZMPKYVBwfXYWLN8n1PliqUjlHfXaFMQzN9hir3z4Ch0kd;25:sb6h/68cE/vA/PYtzX1cn9KsZXY7Lli196QI6tMzr6ToINT2OmnFCJ+X3oEAosJNATpgMqtAkkCNfXXMYnwgpOzBIAIy7jYHpvqcuZDOiinbJrfM6mKHLeNve4g6wYimJWhUQ+C2ybY2qLLUDs0VWYT7j1JzD3dJvAAbFv3UY9qZjqcivwm+nlrYOUMUxsj5kw+y4c1oXa1cDPtHI/SkxUKoFKp6VAlR4OijjV1h6FFhOZ+xmk7Ve2lJJYPpkylawsCizm2PWkUvVRSec0Q1xHpNbNE2t1q50WgmRhCsQrpAG4S586zOci0u4YvHjICdAlUkuGcIcyZDULlTotMFzw==;31:io3LcCcnPa7sq1VORhNYXFhgtXm/L1oCQm8pHTo/9eczmEDGrnHZnaypuEM/RlJyUmMOLmGFW9V+4n3j+/pgGwA03X/RorfLciVtwJUywd821ClrULMrVg2YBxJIP10CSGpAQ0QJJbhR1rW7gDHFF7GSsFp2JHlA7HbtKjoYe/KRXcSt0JmsaW7dOtYoESrekQFfpVfghw831h9PAQY1dD2WQF3t62pQuzAkeyYAdPs=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4930:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;20:6EsIfWZ7CJ3+IMM3ztDa2Bcx5ljx95t1+M0uAJPFtNcEVQ3ao2l8uUfnig4JhHunbJWSRF0zyF3VhWmUvYfUVuwcqN2EBJWjjSgR+JGDzVNFAUhFT2k0OsCNl0n+IBF2obEDB18XubedPDNqWeOpHNBEK4+pbqPYyKmZ8EAMc/GSRk395r/vf4Yvk7NBpRBp1a2ArloX5ri3+krIfVAo50AQjJYfdxokyX7SsTI1ZAlugU2/QyXW7cVzv5dz36XI;4:ddb4o4lWJOD6bhME5jM7xs5jbsij7+H9Mza9YTyxK/BDQlSj8KirtWEun+qAIhs9iAAZPcnzqTdm0sE+1Bsv9eeDg1LuspIIKF1a+WdVIUd0zfqO4FCaareSgW3pPtD5Omi0B5OIoFOgvdcOBE9LNbNb5SKfY9xhM2w0R+Hkr0U6JAjN2mYAc+ITlHF9AzHkNbzjSnMKV9wvIlUMNoJj9KUPn/mtWEafaOwJqSPmdZMIRzV60A/iVGhyP0ZHfcushYS7ugI1hg/MFLpOZMLntw==
X-Microsoft-Antispam-PRVS: <BN7PR08MB493041877397D80DB7C94DF7C12C0@BN7PR08MB4930.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4930;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4930;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(366004)(376002)(396003)(346002)(189003)(199004)(8936002)(66066001)(36756003)(25786009)(48376002)(69596002)(50466002)(4326008)(42882007)(305945005)(68736007)(5660300001)(478600001)(53416004)(97736004)(47776003)(53936002)(81166006)(14444005)(2361001)(7736002)(81156014)(8676002)(2351001)(105586002)(50226002)(1857600001)(52116002)(54906003)(106356001)(575784001)(6916009)(476003)(956004)(6506007)(6116002)(6666003)(16526019)(2616005)(44832011)(486006)(316002)(16586007)(3846002)(6486002)(186003)(51416003)(6512007)(2906002)(1076002)(386003)(26005)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4930;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4930;23:QwerUHtbdS5pQC1JH63NP/WEPcufNYXVjsTsbkjsw?=
 =?us-ascii?Q?fuy9cKL5IoPSympw+ftIVE+9EaACHWFOY1HPHpAkS5EDcMq/ckkt645FJ8qH?=
 =?us-ascii?Q?6qf5jc8bTbvadHg/uiP56ZLK2EnjtxkNEh7RKSerLNXNqULdWtoATqJEDnV4?=
 =?us-ascii?Q?3JHiz1LpYOPDAPkVqt9x56LiyiNt0EvUM8LInY7NXCXNjCd0m34hUepj4MMf?=
 =?us-ascii?Q?oG4/8BqIcOiIrASbj8fuMZOoTh9VsBBwI/EmxP2YMb4IeO+LFU0KEDOu0qYE?=
 =?us-ascii?Q?v4uUwbVD0sOSfqTaiSLauGf+x6M7sm/zoaa1zCKx9ex1MwPkglJXlXqn2rl/?=
 =?us-ascii?Q?pqOa0AdT3/secXiJtvJk45OIEqh79YA90aEtg7t2cOtj4SnXri2L0zKtJ0S9?=
 =?us-ascii?Q?iz5PaAOyA1DzX8QSc5lj4TgIWzY+WOq8/0twCgfYfpYYb4WlPw13m7WeZI2t?=
 =?us-ascii?Q?vWDHt1q+JmrPV4/K+ZRdaEC88/rA58qL6pLWeQ7iU7BQB06Dn1nnBrKDHhKT?=
 =?us-ascii?Q?+D6RxvQ7W1HBBKaO7jPrNnLN9PxB8TdWdF/pWkIbq9UrZDhQi7ULPtPUUoFh?=
 =?us-ascii?Q?LPR/u/nGh5kwVbcL+KKaMZL6majjjtjQdAA7ufNV38Nu/w4ZaMWsbURrYLg3?=
 =?us-ascii?Q?1Lg5uCnKYWoGTTYXOJlsKQR1kLJlFQVAsTbf+UZg4p8t6lbMcgqaXWhdNsyZ?=
 =?us-ascii?Q?gWcGlaBzYN9GJeDYCS1l0upq9r5tlF9Olcn0LnLBk7i48eVXXxOTJrbPcvK5?=
 =?us-ascii?Q?jmHVv3PVFU5xgBrrRnwiAOriRxBagxOMgBFrnWNOOxPECWK503seGMesu3Fe?=
 =?us-ascii?Q?B3DlqD5tB6gC4qAEn8WwSMMF9jHVBu+JLQnve/9cUxVsUCEqVVrWEHkD62sn?=
 =?us-ascii?Q?qOEnf+ZaWVRf2QKpRc9icsxgtrNotYx3gqUOn1/T8CorsTt/sGPWrq+oGmNK?=
 =?us-ascii?Q?XBGNrS7zO97BCzE/zhJuVlbvjQa8fw07gzYRqR42oeD3PtYkIH0jQ3GL/7sD?=
 =?us-ascii?Q?6KEGHQPkJdaOYI0XdV8oiov9AUfGUNidZjSric0cJKv/dXAFpoJDyxpGPJRL?=
 =?us-ascii?Q?HS9g1mB0W84aPWmCGaqapp1UPnIe7r89F2mZVrYRWEHVHiNGQt6ct43K9zuN?=
 =?us-ascii?Q?fpWriWCgdPs0HqD3XfkNtOqZcX6sfcQX4RfgYAEG1gSlwge5BydMvqOSsS2n?=
 =?us-ascii?Q?pQ7DXm1kmQMEZ9RY8Mo/2dL2KyKFr/SlUdCHHI4d7PGJlr0rpi0f4x4NjBal?=
 =?us-ascii?Q?X6hFXJlJp0EUrrhhTh6JvTGB5IY5w3042obU6uvba1UJ7JwFH3QK00wqy6Eo?=
 =?us-ascii?Q?RjlQ/tXoXcsmImlcCdrjmPnTEQNP+n+DVlYGu+MBNqE?=
X-Microsoft-Antispam-Message-Info: eMnX8mD3oWei5WGVGmuei6NB8z1AC1BXhl+uYa/4Fe2PlO3VOCfCtbE/yMAmz2aU0p5ig6vP0isFC4/190BAltzGD8kfgpa7jskIaqRpSem8lamlRejdMWw58vJJzqjT9SSUM9mww1m72wfD64NdgrWUUw0t+eeTujL7FCmVfwe5v8G7wKrqJ1OgIfujEMQuSjKRnVQF31Y8k6H6iGIaxy0EBx/gopWfnfbZvB+7NG/X5OXJd3ah4XxCb3/+ritWwWqayk7ct7coVY7nwzxeXmyIM1GGoGoaFAPKwd0IefI0KW4j+TP0mrIijCYIoS+/lqoT4zOZhtVAEyv3LxhwWj/oDAZ955RsLYo56O5vYd8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;6:RLOWU1UP37ihMr+JsWCRJ/pCP+KAd3FC1/W8FW/gf4Ew0AVM3CmpdQYsXU1XZY5NAchrNFGDsD14STjcDiW7XNh+uGae0PwE6HqQGI1j9cl2465i0LCwEP2cvibxNZcLRdAz46XHmeha4m6Z6nYOZRZko/leyGmBnH4WpwV0PzrURzUYxJIONncC9Uxp108hhtLXyo52BYgrXytieaBs2qZMPhFzUZzuuCOv5rS4SKFlLiadHIU/SkOKqL2eV5mMTsoLBpn77kV4Y4PUB86AY+VW/CUN0PhhgZn3PxGweLahFBhDyhAoaXP/hSdxMqymcS2F2z+MGf3oPuGAfkmG/g7B2Y/7BZzD1jXYUdQ4JbrC5QHrjhwdrn9DoCyTOb1q/UHvG6uxKhNbR/mMyXtOiG4Nd8sope8rVZrow51qM65wEnaFeyrPeUimbkomiR26X5KkqDunz4I9WAyX2tvErQ==;5:jfT/d/TKYrk19jDsQ/HpYusG1KqOlniJkmuRw/iYVM2AneMb1XdN/LQbfi0EAaip7Wkxx7nnk4USSYoSdhLSiahbCL2obHV80JumLD6ZZAqoDMH5OIYufjaP6N788unIR8uE/+R5FWbIm7HTKUnp4exn8PXHgobW8fk/tns/+1c=;7:/f+mjaP1MYQZXUk319iMFP8QtQ0lT1UoVLNBax3sWWsr13pki7GxlB65ErcG6b3zQ32CfIjaVnJpBM4KBJKsrr+W0olbo219eBDlPzu/5ngODZwt0Ls7rrEICScfEZNuIlHesMpCD53p7S5Y9OHBWgbO9x7xz0l6gy3RfLqnH00aa9PJtYBvg6wfC2WSlWrTN4Ophe3pUWVRjxPYBt9fCWb1lUpT27eNZqK2y7mGIMtVVRy2SZ2goI2hFXKhtB5j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 16:23:54.2182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 707139c9-01ba-4df3-e5a7-08d5f8945746
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4930
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

generic_defconfig explicitly disables CONFIG_INPUT_MOUSEDEV,
CONFIG_INPUT_KEYBOARD & CONFIG_INPUT_MOUSE which results in warnings
when merging board config fragments if any of them require these
options. This is the case for the ranchu board, which means we've had
the following warning when configuring for generic platform targets
since commit f2d0b0d5c171 ("MIPS: ranchu: Add Ranchu as a new
generic-based board"):

  $ make ARCH=mips 32r2el_defconfig
  Using ./arch/mips/configs/generic_defconfig as base
  Merging arch/mips/configs/generic/32r2.config
  Merging arch/mips/configs/generic/el.config
  Merging ./arch/mips/configs/generic/board-sead-3.config
  Merging ./arch/mips/configs/generic/board-ranchu.config
  Value of CONFIG_INPUT_KEYBOARD is redefined by fragment ./arch/mips/configs/generic/board-ranchu.config:
  Previous value: # CONFIG_INPUT_KEYBOARD is not set
  New value: CONFIG_INPUT_KEYBOARD=y

  Merging ./arch/mips/configs/generic/board-ni169445.config
  Merging ./arch/mips/configs/generic/board-boston.config
  Merging ./arch/mips/configs/generic/board-ocelot.config
  Merging ./arch/mips/configs/generic/board-xilfpga.config
  scripts/kconfig/conf  --olddefconfig Kconfig
  #
  # configuration written to .config
  #

Resolve this by removing mention of the CONFIG_INPUT_* Kconfig symbols
from generic_defconfig, allowing them to take their default values &
allowing board config fragments to enable them without warnings.

This may be problematic if CONFIG_ARCH_MIGHT_HAVE_PC_SERIO is ever
enabled for CONFIG_MIPS_GENERIC=y configurations, but for now that isn't
the case so we can worry about that if & when it happens.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/configs/generic_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index 26b1cd5ffbf5..684c9dcba126 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -43,9 +43,6 @@ CONFIG_NETFILTER=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_SCSI=y
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_HW_RANDOM=y
 # CONFIG_HWMON is not set
-- 
2.18.0

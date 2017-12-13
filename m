Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 01:49:16 +0100 (CET)
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:30945
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992866AbdLMAtJRKwPl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Dec 2017 01:49:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vLP6vmNU1efyrnrdAg+kzZpSE+te5GJVvLAOOQAGqdE=;
 b=LQxw0U73NILDrDOeYSCuFQHxQybaYmstmMUlAwn9mvyBkdfCXBpRdR5MOriAoAJs7PzG7O8hvTSr2rXcyBgIY6TD28t4mJ5YxAEqofS5MTw+wUqUrIGN1lV0miwQKKqd3RvKlyCGTc/eP+izsDviP4SvrnnxBIQToDipLf+qgHw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.302.9; Wed, 13 Dec 2017 00:48:57 +0000
From:   David Daney <david.daney@cavium.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v7 0/4] Prerequisites for Cavium OCTEON-III network driver.
Date:   Tue, 12 Dec 2017 16:48:44 -0800
Message-Id: <20171213004848.15086-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0037.namprd07.prod.outlook.com (10.168.109.23) To
 CY4PR07MB3495.namprd07.prod.outlook.com (10.171.252.152)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c3127ac-693f-4dff-b0c9-08d541c34b38
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307);SRVR:CY4PR07MB3495;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;3:UuX1qwhyacRj3BnxM8KmbK+mBH8X7Ge1nOd5k90uilwqlWtuCSPyZvtNx7xexDs5Jo5Biao8CUxOv6DlBOuJzIdBqTjq5cQdAjmjICoImkBufa21I6zg8+mbyscwoliJ3ZMQ6Xwq0/dlsRTVabuWBxkojS1LdpREF8UagPxAqlk5QkCVQbbQ8m24HSQugLBzJJbCfigIldWR5kJ/po1VDyEDV26UTzbF8RVL19X9e9D6n+ZQCvWM07rLWUbSOdVH;25:aogw4EKy4E5gOuEICGMLCv/FKB048ncPQTl5kWRoBLWEb6vOZGqkP9mRMhuSwVRNlwn5FqmOYhKudkdRoVCb66nOBwmJJVMbDpNQ8KO45gAYXx6ogW3iVHr5MxRk4KDXbS1pADCMfcK6VcgRqfKnb3fYQpplM4SstO+FVxfVazA30WMah+o3NtPuzFM5UahcowOWnWVBMPdgxqgyEzCXEMF0azW4UKkuYw35ZNxuraZY9A7UKHPy+visoDTvyb4kAQz3ZvUUDLPU3txexqlktrwEK7bBCLbhYN6WBjNo7/SsXdzE3G2s8sW+5PCpu8ZxqqImRCp51H29EtuAgmEvAH9weiP+gApql0IHchtchSI=;31:uijZacy6rv8FrA99f1iT9f2RWQqxOBEaxcMRSf3ChYg6TRL4u4Cmtx8doZeEAAFQc8TkXcIhPYxJobuguTgwZDHqqfxOdQSzOReoNy2syhocwmerpKINiMp7fTNZ4lL/jtxFXhrGaXSTfRiHOKp8hTOmsN/SgFcb3ww0XghChwb++bFuJcZjyKHLjYYOzTfTiclkYIKZUC2BSDnM80WCwXw+tW7qyELEogb0RtXK0TY=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3495:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;20:C8EDP0YwmlVvGvT7u+Q4XtRGImfaRP78msE98U3amYETR4Aw5KSLxMegVT3dHX4L9+e/dhkzjtdlEKLLUo7Zkr4TW49zqtKlkmRZ/Dhyz4BOZPh7hoLQHUtDmLwteapbYkhtkb0VfPTm3HW5pak+RDzXXAYRadly/gREsr9EbFFO2WIAj4gLGIFuDkYRQLlOyxFl7p4FFFFB41RBBHUvfwH4X/Jf+ihvcOHwaQ3AC02y77SfEj340I9WXdjwoSuIJCKSAjsqJe8ZgzGbx58grjwJz3Ar+rfCGM3e7nMjguUpBETKrUYCR53OZ1k9Mt+AZcHdOHsa5cida4zSgGfy+/e2Z1NT0DFothXgRRSbTjQ//nbaYdCKf+nbyP1IMW5uCqsdKztQvHgVbk2oG4aFSB29I9lxzF0YsRqvC7obEC4WDqfr4O5WPN+0zCJQIs4z3zpOqXy87wEh5Ne3A+6OfFLLGwfhEhaoraIZmHyET+/jB4ZNyKuf8kk8SNnnQd0R;4:xyf4VEXodh/9vL5BoEr53S05WJ9L0Ek3tSlpJE6bb3zlO8j5Kr/BmVW2GlQRvSlwWrmZBSHbD0Cdr4Sg63+jcEpdFBjLuBDoE6Nb7J6C9NOPZ1ayMO1mrmbHkGMTOQ8mhWslzAm8ue8SE5/zOoGNO2cqyZlMfJ++kR8TTa7lBy/s1sEm08HmPnHZ/MH5mZ1wVfHcU9oyNp8aTvHxuLSlO18GPaR7OdDe3x/CPvxxepPFbx/w5UjRftDhqPLoZdm+ofL163ONembdLk2w8pNqFQ==
X-Microsoft-Antispam-PRVS: <CY4PR07MB34954A915F255D3B07D833DD97350@CY4PR07MB3495.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(3002001)(3231023)(93006095)(93001095)(10201501046)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123562025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB3495;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4PR07MB3495;
X-Forefront-PRVS: 052017CAF1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(199004)(189003)(106356001)(52116002)(105586002)(53416004)(16526018)(6512007)(16586007)(107886003)(1076002)(4326008)(53936002)(47776003)(25786009)(6506007)(386003)(54906003)(3846002)(2906002)(6486002)(316002)(66066001)(6116002)(59450400001)(69596002)(68736007)(81166006)(5660300001)(6666003)(72206003)(50226002)(36756003)(305945005)(7736002)(8936002)(6916009)(51416003)(81156014)(8676002)(97736004)(86362001)(48376002)(478600001)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3495;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3495;23:F9hyvVsmxDTE51J0ChvNOBajLZMtqz2fSXM9JOme5?=
 =?us-ascii?Q?RSqjOE/e8dWeUS5TRoZGAeAY8Iw2Pr10anvmEfXqvGw6/6NMpI6jcgTAIr3p?=
 =?us-ascii?Q?2tvVzIGBDeWx8vyiXwZL4CCiu6Lmt2mfM23IhukkWXao+ceiBjUuVvWO8+PZ?=
 =?us-ascii?Q?VMhu5NBPTbkC1nVHjeCh6YxoVDMeW29ZIju4TrUp/MjmngebsyMXOLFvkskw?=
 =?us-ascii?Q?yBoC/E1jLbuBZcKTikM2PrqtbrfuPcXYTQ0gy8+8jvUleGtp7DN28NxFBMwo?=
 =?us-ascii?Q?YZJJGu44FOQt2I6uZgbDsKR5yODpEu7XZB2xET+NkY9/gXOjivcUWK8bKlts?=
 =?us-ascii?Q?KJl55dgF8XIhiclZlKo1TdIHuIFS39J744nEs3v02TMaJDg6ZYX+EOxwH6yw?=
 =?us-ascii?Q?/MBAIu9MJZCQPsLdUycDl5SWqvtnmey6JuL0hsCe7bhISnpSbyquyUS9WUHo?=
 =?us-ascii?Q?ZU37wysrJmTroKXIPkK8/2/YQxu+fi53SqyJA7LZgYSHMcXxH4gqJDujNTFF?=
 =?us-ascii?Q?aAE/JhkGIreNffDuo4iMHYjnK10+JFUagNc311umswC5Sc72wIcqOJ8EROAn?=
 =?us-ascii?Q?UXw9Dg4rIWtU5g65vzkMPiZFq6YNHPRVJDaqyZShyXPfFQmi8x1sexq5MK9j?=
 =?us-ascii?Q?Xz/0tnexbS3T4U+XKIMAFoy5kKUzFyn3PyKnVbnOtOI6s7NLLIdNzIlO3c/K?=
 =?us-ascii?Q?x5pT7ZFt86HbyrRLaeZo6MO1cufoRcbv0Dadt8OxZp2QBJTCEY4rAcTWCH7B?=
 =?us-ascii?Q?DHKzdH9+cONnOSOwHPd3KYIWR9yMwulxY58XEp5MXJ8lE2A29E9NJGKStsZz?=
 =?us-ascii?Q?oAJDVFOjPTfDO79uGg4MtZFLiw8z8whOrMNfmm1ST1gAyQVAV1gHU/e53lRr?=
 =?us-ascii?Q?1VETY4525UT1y1FLnL8rHMIgyJ+u77zBFhKKp65yT7f42XKfBRsT7a2+u4TW?=
 =?us-ascii?Q?yJS5QXy92wuaCPOvwC94uWd1Ejj6e2foZDALPfNZBKxnkLK51s27z9WxxgsM?=
 =?us-ascii?Q?xfeVx6aoNZr4mKr1cWmZcIFnLgvzo1N0NgRcr1rnKfWJr7PDbZ2DMlcw9g9e?=
 =?us-ascii?Q?Cf3jYc3DHaADgt0smaUw23cbVRsi0fisUqg6OOxjW+QY8EKFg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3495;6:dDfExjZ95x/oJdXY/9yZ3+pGdKbzo9qSuxojwjZONHtsvQtvStM5jumhMUvgKkqFqusVpkZenJTmoXGgCBj02os4+bTlUU5VAmtXDqiqRlBwE1SbvXKB007c79V0N9T8girb5OzLvYltfXusOT5tGWYrNdgN8wAKYlg/B1HihELeutA0JEIl6EGCrqxZJr2TCFABKO1TUdEMJZiH8alwsLFAgQCIewoCm7/L3GPcxJAL+xjSaO4qj0dY3QF9lwassMdMQfM2z1n30E6C1xdspt1hLLX5MYnet1PxnvsgllT9oTHPy0bdzB2+1GM4bLdOMVCoKc+VTJVWMYasmZVp+j/CQYDjrOWHleJsfZp1F6o=;5:az/U39c/grYlZx41gzdI2Xm1V2MotZug7iAUUdzZbCxv4K5RpG8Z1JImxgcJ/9VDQTMCiQLLO3ayXhaQKjigPIl43EN2X++Tdf59+cMA+DuEA9uZM1GDKk6SzftTMLP1GT7MEf/sxf3a+o5dbdNlaIuA4/BcMbWjfjGMe21lXIY=;24:WnPSAohSOE06Bza+twBzMKfgWqATF9TngXcri1bSR+NEH+upFwn6qV2bWl3PdpFd0l/f2B3AwTSGBo20TiVnjzjlFKgDCw+imKlFfOmTCZM=;7:MunlMVIum65kGzV/tgfJ6ZHkJDb6hNY5xAxx4GvOHtbOTktQq8cti/d3W6Iu6TH4ZghtzDDOyBTthIbSGMDbBNJbWCbFp3xb+j1TmZv3U5+8s+P++ZKGIDMOxAxlzcYLf+vLDQHtrbjSsOFOhMvr/aSV/kAPKn821h/BkVqy114ME1zOUCDgICKgLbeROP+XVQ8ff9s2k84TYBlRAIrkfB/eMd9ILstnb+Hg44UDAMDyPrKN33sPoX32Tfr6gP2p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2017 00:48:57.2977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3127ac-693f-4dff-b0c9-08d541c34b38
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3495
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

We want to add the Cavium OCTEON-III network driver.  But since
interacting with the input and output queues is done via special CPU
local memory, we also need to add support to the MIPS/Octeon
architecture code.  Aren't SoCs nice in this way?  These are the
prerequisite patches that are needed before the network driver can be
merged.

Changes in v7:

o Splitting of the patch set only.  These 4 mips patches are unchanged
  from the previous posting.

Changes in v6:

o Added back cleanup patch for previous generation SoC "staging"
  driver, as Greg K-H acked it.

o Moved FPA driver to drivers/net/ethernet/cavium/octeon as it is
  currently only used by the octeon3-ethernet driver.

o Many code formatting fixes as noted by davem.

Changes in v5:

o Removed cleanup patch for previous generation SoC "staging" driver,
  as it will be sent as a follow-on.

o Fixed kernel doc formatting in all patches.

o Removed redundant licensing text boilerplate.

o Reviewed-by: header added to 2/7.

o Rewrote locking code in 3/7 to eliminate inline asm.

Changes in v4:

o Use phy_print_status() instead of open coding the equivalent.

o Print warning on phy mode mismatch.

o Improve dt-bindings and add Acked-by.

Changes in v3:

o Fix PKI (RX path) initialization to work with little endian kernel.

Changes in v2:

o Cleanup and use of standard bindings in the device tree bindings
  document.

o Added (hopefully) clarifying comments about several OCTEON
  architectural peculiarities.

o Removed unused testing code from the driver.

o Removed some module parameters that already default to the proper
  values.

o KConfig cleanup, including testing on x86_64, arm64 and mips.

o Fixed breakage to the driver for previous generation of OCTEON SoCs (in
  the staging directory still).

o Verified bisectability of the patch set.

Carlos Munoz (2):
  MIPS: Octeon: Enable LMTDMA/LMTST operations.
  MIPS: Octeon: Add a global resource manager.

David Daney (2):
  MIPS: Octeon: Automatically provision CVMSEG space.
  staging: octeon: Remove USE_ASYNC_IOBDMA macro.

 arch/mips/cavium-octeon/Kconfig                    |  27 +-
 arch/mips/cavium-octeon/Makefile                   |   1 +
 arch/mips/cavium-octeon/resource-mgr.c             | 351 +++++++++++++++++++++
 arch/mips/cavium-octeon/setup.c                    |  22 +-
 .../asm/mach-cavium-octeon/kernel-entry-init.h     |  20 +-
 arch/mips/include/asm/mipsregs.h                   |   2 +
 arch/mips/include/asm/octeon/octeon.h              |  32 +-
 arch/mips/include/asm/processor.h                  |   2 +-
 arch/mips/kernel/octeon_switch.S                   |   2 -
 arch/mips/mm/tlbex.c                               |  29 +-
 drivers/staging/octeon/ethernet-defines.h          |   6 -
 drivers/staging/octeon/ethernet-rx.c               |  25 +-
 drivers/staging/octeon/ethernet-tx.c               |  85 ++---
 13 files changed, 472 insertions(+), 132 deletions(-)
 create mode 100644 arch/mips/cavium-octeon/resource-mgr.c

-- 
2.14.3

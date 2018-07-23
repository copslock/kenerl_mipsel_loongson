Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2018 16:49:31 +0200 (CEST)
Received: from mail-eopbgr700104.outbound.protection.outlook.com ([40.107.70.104]:55469
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993941AbeGWOsp1AK2n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Jul 2018 16:48:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AofAngyJJ1MYD9JoMWmQUWNkFGbgI0zJl4kZ6oDi7ok=;
 b=MBHEGRAmr5mkM8dT4PjIih9Xwk6O08FPAZ65hAW2BmBAnhHL8Df166k/TSxB7zDVD//oeOvLbIDuT7Uhyj79c/rUD+qznOyn1Z/oa1A4CGhsymaSQxXaa4l5Ew1H5w2MyZ2kxzv64TiZR+q32MyP1QftJiEEkufWwAqE0U2GDsQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 CY1PR0801MB2155.namprd08.prod.outlook.com (2a01:111:e400:c611::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 14:48:34 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, rachel.mozes@intel.com,
        Dengcheng Zhu <dzhu@wavecomp.com>
Subject: [PATCH v3 5/6] MIPS: kexec: Relax memory restriction
Date:   Mon, 23 Jul 2018 07:48:18 -0700
Message-Id: <1532357299-8063-6-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
References: <1532357299-8063-1-git-send-email-dzhu@wavecomp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BYAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::34) To CY1PR0801MB2155.namprd08.prod.outlook.com
 (2a01:111:e400:c611::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a27074e-2141-4fd8-1875-08d5f0ab5de2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0801MB2155;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;3:/dH4RZkRhIBRuYhgJVA/qW7M041c+ZYFRsHdct6f8g6kvH5U+snHlWknmLZdrN5xcAXDGHeqE10lB/G2ExJaohcSHul6etZ+v5FYKESU9WYm2VWTvy8u76qvli6kH6kIU+EBG0BN53FIe/UFD2bpMVMtwxOfQW0tyTePibgq7LcoV1J9K/GuANN6GW4cH0WNioFqZbIQP6jiBZgPGyTg6wdKhCKUIbeGGEfqBnnc7Xax3ckL22MlQ9x1iNr7yzWq;25:Cmi8E9S+2rOmFg6uR7OIN3cFF9btRHTfSrgy9nJiAopO+DxLvI3sCkX/aNDOzl323+VzwsM3BPlVAyLO94FuJMss4pgAamHxAdOkrZ6qxPdyB8r/HVlX5njQFA0L0/iUC9DgSxVOE35mqQfxr2v2vbLed/xE26LE+axGDf5T98uhpZT8DpzLi6YAJU7ZCAINow6p98ckYkTv97tQ5AICHUL+/K+yCOZLfjiU4puRkrcdBkRPM33qyyutecBE1XdVG7GUL93pNtK9jkQ3TJoD4aDBWROyAeGVRtkLYH/bOftBu2gFt4wh9ccv+ZkCxvnY0s46fVNWmyf1gxSfPyKqiQ==;31:LKO9oy9Xu4oJCeHbrEfebkRdIGzaWYX+IKo1bBCo/uz8yz9/gA8jQrH+O5pbIwE2cKdMs11kxY1kq3jqZDkqyTdssiXfcPdSygeobR7L4ZGjvugiwN2a3e36sq3b1gcp/CazjKmc0pf9onwP4Rh5C9mEk4L0J75kVlhFYDl/fZVfYLscfTnupWndDPRnadT3q/4fwEwoR2WLt3jPpAyUFTRBbAdcYJr2cd9jECgOGc4=
X-MS-TrafficTypeDiagnostic: CY1PR0801MB2155:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;20:KtdHIKHSOUGooHqHSa4H4SdCmqyEvtHPdXAf6e/x0KC/yvlxpp9va3OA3+/t1TTyZk4/+dlKehW9egUkMw195kNFjaDav9Oz6PLj4YH4T/5CliCFUA5564YHNTJ0VadYhCPy4TqpkqTEzsIL1ZG5vhn2BqNgG1ixfclhLI/Zjh8y2tsJHNjP4+mGccwaVSYFZi74N9E0xKLu/PZQJ590T5Y/zphGkX0cSH8ZGu7x0newZAsFcn2K1AY7we0R3YM+;4:FMeEaL2S6onq9LVI9rEc8cdLTl49PiXlwy5DsOXKt3T4H9buZxHhln2SNoQLFALImUvbbbVl/ossiYmRfq4y2rRvv8s9rjA8HPJB4xozUQ8PF4BV6fww+xFsz7imEVaZyLUmKCH21rYr/oPHicqqwr9U30Yh/ppQ+z8QTTnjRSQ4ptLfk/D45UVPDS+KzQuhyQzFBwiuijJhYyCv1gfm3aA3ORNK3+VIW9iSv74BgQxEGOVlXVSc8jmZttVeDw0fAUaN2xdFLPAZQTPh1aox8BuE1/TKPaFXgisPBZHamFhtiN75gABUFIscxJWcm8Ao
X-Microsoft-Antispam-PRVS: <CY1PR0801MB2155EEA18214B8043DDD993FA2560@CY1PR0801MB2155.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:CY1PR0801MB2155;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0801MB2155;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(189003)(199004)(66066001)(86362001)(97736004)(8676002)(105586002)(81156014)(8936002)(47776003)(3846002)(6116002)(316002)(16586007)(106356001)(81166006)(14444005)(478600001)(5660300001)(6512007)(36756003)(6666003)(51416003)(305945005)(37156001)(69596002)(48376002)(68736007)(52116002)(50466002)(7736002)(25786009)(76176011)(107886003)(4326008)(446003)(11346002)(386003)(53936002)(16526019)(53416004)(2906002)(476003)(2616005)(50226002)(956004)(6486002)(486006)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0801MB2155;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0801MB2155;23:hw6vyvP6Vump8Z/QBXB9qH/3sep9dxCKCcrKpys?=
 =?us-ascii?Q?I1VKd0yARHjTV6vpccQIevOF9EtHty1XMu9hFd/rS8xt/9EplyAm4XCgSCzh?=
 =?us-ascii?Q?JoAUJ5uhT7j22MKu03TVjTwOVsUA1dQg9zEcdA4jFL+4dfU0qGq5SApfuLQJ?=
 =?us-ascii?Q?8XAfK8A8rcRahGqmqCQ4uoDMReUCmq+BDlobpJGnlfi1u6ytYutSb9t0Wk6O?=
 =?us-ascii?Q?2qVgMyKkKTY3F3xflmbyOF3KG+juH6WeWur9fB0tfUotd1WEJBeSO/nwS5rk?=
 =?us-ascii?Q?v+mNLBIA93+NYabMuIEhMGl33cHL9MC1jswlRF6s/yJSvCa4L2ziqprKtRMo?=
 =?us-ascii?Q?UrgFt2jTzWcFMnBJbYwURn5bRo/Z6g0L/NpOcApeZvg4qfBk4Y/8smk/0Yrv?=
 =?us-ascii?Q?cGlPapMMD61j9hbuXuDrrcY5zMXCbo9zuzVQVJ8MMsMZxYSJwCqliJMV4gbr?=
 =?us-ascii?Q?z3fgBQKbI7TFRo3NZ6uu8AStJSvyqWQOsRIjxUfCDXFCOkoEIIqXtmeymaLP?=
 =?us-ascii?Q?KoeLTEwoV36Au99WuqP+/oK2s5PTQ4vbyLFw7iPl1Ahr0rRkq1ufnIaDvsIe?=
 =?us-ascii?Q?XnNG2RyFW621hu5Ty95Nv4dr2W9fcwtq75KYGmJ7NtpLiSOft+Tog7xw76T0?=
 =?us-ascii?Q?DcXQZn8unt9xHVMakBo1Xh1knu3He7tDkINZ805mrGLIN/XDXCt9V4I5Pktg?=
 =?us-ascii?Q?seWovwa771aSPghRlBiPk+69KwT/PPry7E8xTbCmuVJyhxhgRKVN2bLnrPRN?=
 =?us-ascii?Q?hsHJjdyEfqKOcxnhGdo1uLdeQsZek8pv3T/AwK7EvJtw5wmRD0Prq2totLuE?=
 =?us-ascii?Q?8oogfrhVVAGxASfxkCjR+LGt1/BvYDEnJh8rBFH3dXRX3ievyw1TuQLZtAjN?=
 =?us-ascii?Q?jx8p9VTOGXSp+t29RXyy9W5G5OmoEQUq7i9eIwof2ZUnHq9uX+cFLLxX6beW?=
 =?us-ascii?Q?LhV9tYwWfk3v4PKKs7mIsYcJxd0qZsz2kg+PzdpqeRhZnWqCBgQWkv4pA33C?=
 =?us-ascii?Q?XRkeJeL/lvZ3DHmpfUTKdtvug6qnaZZWT4MMWEUCdgpCpoLzaDYnF+8j+Oro?=
 =?us-ascii?Q?gtVsziPAR1BIEFogmQy35EO/MIIEhYFg+oNAbWGTFfstK1NDkPf4+ha47EqA?=
 =?us-ascii?Q?cKsknOwpefXf012L7GE5CTJHk+iavsl4WCNPCrYdHJcOfj2h5wfp6rwcmHoi?=
 =?us-ascii?Q?Vnvk00aHxKkcyXLCYBxv1cydV5enVaavUbR0MNw4iKrZN1YcLI001EMhtlA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: vgL8eMhiX6UmnFrt+CDnSx/flEchHZ0e8PNdTIlMHBLr4k/ZW5uzVb5s/yTpeDHKDtSZnvD8M6T8iYnA3GeV1w7rh0oTQBtrvv8FxD7yzN1TQPmkQJ66nEavmP8AFLmFAEkmW4PbT/IgEIBbo4E4k0zoiCn2d3tX/VdLNCRoznKK4LSCoIKt77nuQczIbzEZdw7imxo7A4l0NYHay2+wCa2pz4nIsaWFKuM6nT5Xey4tQJd6qQWXfKZzQMTdSd5vNcPekpAIsh02JQRqkTaB6Ubg780a+Dm+/RjDuzIuX1ADQbDZw6DW9vKhVCz04ciBYobRoKvTMKOcOHQs4ZGyaTcOtgA9Gk06N/7jnTuJINk=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0801MB2155;6:jrCaM0VMHXJ6CJ3/KKRghP/P5ySTxFBn0onj9SnmMxjIJ40FcpFYe0VGQPW35zO7gU78WRHGDpQKOoCQb6oBzY57GM5GQiRaY0RoTMtS9acEaUQPHhpCxDXFq3VaKVguweMpbBHnzG2hAH2i2P33dQbmvTCV5ITTBajLPUC+JWm+0T/+5jUaz2Y/MnHVXr2WrXIlhU1hMl9jnDTc9nG8GTwHnPTsxvXtgxPv2cqT9nhJ6ekAsRHhnv3OqeqdZoH8gpdJMrT8PPbt2I8I7V9TQH2xgRb9VzY916o+mbdaeNWELvQlrgtyzRwt/gBUmONvEMTqZadEkf3+A3SBJ1sTOY7bSWcwPLw8DX26ovX7qKGFxrDky4BT0te1f7VOWchLtH1ayYGbhCkNrT3CxLvZ8P86cRNGibU3pctpfTTPWJ9gv1WJX6ptEi9UBlQ8g2uUo4bg6E5Yl/Gz+d7/9DeUiQ==;5:gGxNpnZUmT4g70mJpdJ3iCYh8OOvIwAuM+PWwjwlECMzmzVN+NHADJ83JJ4cyY+X0zocZr+f/bNljtZDX1tbpfWD7QkEeDF3/Lv0Y9S172pgExQSAYcE3V/u0pwM7WF/Jrx5cfj9PGWEJp3FcW7dJCDi3KouYo85zUd0h5u76w8=;7:xxyPKhs9K0jJ54I/IVK3BV5MXOpu1mkImczBi+PndS7dOImqjlu+3yulMsujU+YcqstiGJueQtZEEpy+7x19DlQPDVThbFwmF4fT0YFhXNo4AFYOpIEvCRJ8lUvroF52eWkbMa0fvu1g27qTuPagJrPPeSiWjgJA7roKD0QiuSnpeV2yC9DvZEVsmY2sXF5wu+h/PW336DcQ2uj/gP/s6O6u/Bq48v0R4VLacGlok02aOOmLLvF78T0UbzE2cEO6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 14:48:34.5465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a27074e-2141-4fd8-1875-08d5f0ab5de2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2155
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dzhu@wavecomp.com
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

We can rely on the system kernel and the dump capture kernel themselves in
memory usage.

Being restrictive with 512MB limit may cause kexec tool failure on some
platforms.

Tested-by: Rachel Mozes <rachel.mozes@intel.com>
Reported-by: Rachel Mozes <rachel.mozes@intel.com>
Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
---
 arch/mips/include/asm/kexec.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
index 33f31a8..2583e6a 100644
--- a/arch/mips/include/asm/kexec.h
+++ b/arch/mips/include/asm/kexec.h
@@ -12,11 +12,11 @@
 #include <asm/stacktrace.h>
 
 /* Maximum physical address we can use pages from */
-#define KEXEC_SOURCE_MEMORY_LIMIT (0x20000000)
+#define KEXEC_SOURCE_MEMORY_LIMIT (-1UL)
 /* Maximum address we can reach in physical address mode */
-#define KEXEC_DESTINATION_MEMORY_LIMIT (0x20000000)
+#define KEXEC_DESTINATION_MEMORY_LIMIT (-1UL)
  /* Maximum address we can use for the control code buffer */
-#define KEXEC_CONTROL_MEMORY_LIMIT (0x20000000)
+#define KEXEC_CONTROL_MEMORY_LIMIT (-1UL)
 /* Reserve 3*4096 bytes for board-specific info */
 #define KEXEC_CONTROL_PAGE_SIZE (4096 + 3*4096)
 
-- 
2.7.4

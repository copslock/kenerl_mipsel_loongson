Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 19:25:58 +0200 (CEST)
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:65317
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993552AbdEaRZuASuGI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 May 2017 19:25:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZFJhv1xe3+MI0E7K0ZDM+tlMBQMvUVhFAkXvj6T+jzo=;
 b=SM3/oz5JdhZNfuYWXf27TF1bEvc2n2c3y5inpL7XMHj2RS7UH7qA50zp6HkxjpTAErSYToJVP+yHoi2ZZUQI54CRqOCkWFjqjdad+mwvnpu1G4HOWhVkG2vb5Aa33RAuWBLwbXNPXAO/QT1LxChMn3HQ581xDfb0AlQSh+TPpYI=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from black.inter.net (173.18.42.219) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1124.9; Wed, 31 May 2017 17:25:42 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Octeon: Fix broken EDAC driver.
Date:   Wed, 31 May 2017 12:20:47 -0500
Message-Id: <1496251247-27123-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: MWHPR07CA0033.namprd07.prod.outlook.com (10.169.230.19) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR07MB3206:
X-MS-Office365-Filtering-Correlation-Id: fcd11c7b-fdbe-4926-1fdb-08d4a84a10ff
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:4V28EsEJFO1Ze+UxHfBt0GOASHxTgdH3FMbgyn3kSY4gZvU2cOqAaTI2lNOvHXWkdhrk7ZGLcbqEhQ6za8KUCPN4EnHzr5/eugVQrkHjNCcAl1akBP7nWsuMELzO7APw2xlMVwrKFpsESMDAWIeo+JUYozN9mFbMKyW7GUkvPMoo3oNLRxDxOytTguKOmwO2Gx9k0+ALiwMnhRr4JB9or/ETO7luMimyuKWZKDn6QkT6sGF8aBPYE2giUwQaAQKOOMHHg/D3elnIlFhMn26Tw2epOvNoaWv9Y3Gb/Jd9qDo2s/9C4oHeHRajczGJab5+iRAIgjP8D0CGPH3HEbEGng==;25:Qwctq7sPWCzWYb0XnCg6Is+SE087q1ke8oe2SYcB7MaR0sYP4Av/kNFz055voIJZJ1ehW2sVcRyqG721e3rLDiLCE8ruuNq/lhCRrO5FVycqz7KbP9IwRAddEa8xwibWyzjbqTJeiCURWIcw2qxdV0DcOg2sKTDNnHOL44WQspyEV21BI0aZFLAhfR9U6elGjr50vXNmtGpkEKFGf9rvS82VAtGhJXLsXhY5ZJS7Jefi7c3OFf1KALP0EZ7btvFVwcZESV6nalOTVFUjil9AgYmn0Y4vZ/9L9Kg5EKuRv4u5GUYykuuNbsPwZli2g00krQsjInS7FwEPTYEr5YMYy81uzRH8QhHSszQlcKx5dRlgC7X6ah52WVimA1xa1QKaI3HiNO7chyszkvTVPZA24NtK8TxsTgDV/MvuypNA6OlBD1msj7nDl09/yE/piN7mKty2M3pu6z5GYA5jrrTdCipxUSxnPSfv3Y3HFrxyaI8=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:EaihLtiQN0GxlmMRxZw8sLqJkkVcG+zZq7Xrm1bDv9pXxulbBeNqfbdKJkWN8+HXXVXabjdRZQFFdneGra/q+4xYzOWPtXxxtK0PVaFGYq7gvCGz+m+0zaBhe8+jQOqJUxzYS7721DQhw1EnChCAuJ0ERA8ZWd1P4KAOf1mc+g0ZC2CgmNhNiCesxE7KaW3lAY9Icp6uqmPryEqqbUdsztzdg5shEWzKwzuFKVN/StTT0soolfdwJMk3R2fW898N;20:w/wqfUsDL7F2Tjbjw9ngnEJ9CBXocd+7WuxcubPdFFRogox/akExeon/IDUzKMM51j0J6+i6KkzAS1OmXD+KKmFGFH3XAfhNi/PbxMYFGp3xIphu13+0ytiVpCmR6VHfalpiF4k8PErarxaY61kMbHOFMSpK6po0EmY2saHQxpFxCt3BBJf2ky1ALOxS074/MaL3Zri9Y0EnSxpgIxhHaQkkJPGTXE+X9N8rYip7eEcA8PiUDvy4YREALUseLn6HQ1OLp2lns12yV2R2iRZ3oZuu9VbGRycGKR7/njx6KVS0EBeS30n7VI+K5CDxvOX10PKHslEqF3684zCwnV59aBslcTJE0Runz7+uTcrKjaNbKV4qP8sRB3NwUed801rg+8zp0FgcuujR5mQSIPcz5eLykD56lNOxoN0irGJ8mN/NYipyZskn6je6QhQKW/r3ctwObNRwjwAU6Q3GDXI1AYY1+vhbELAvVxh5gOOZ+7MC8evHDU2D68moVrhOLZAA
X-Microsoft-Antispam-PRVS: <CY4PR07MB320617552C49774B819A921980F10@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(22074186197030);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700073)(100105000095)(100000701073)(100105300095)(100000702073)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(100000703073)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6041248)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123558100)(20161123562025)(6072148)(100000704073)(100105200095)(100000705073)(100105500095);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:(100000800073)(100110000095)(100000801073)(100110300095)(100000802073)(100110100095)(100000803073)(100110400095)(100000804073)(100110200095)(100000805073)(100110500095);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3206;4:2w5ksOn/Shc8vgvewNb82u4qR32sqJUfdICSZwkOmP?=
 =?us-ascii?Q?jd0kLl5aViXNbeqx4cLeSGJ8eBKu7mjjYrsF4M7cWg3U327KlYhy7b/uPrCq?=
 =?us-ascii?Q?b7SxOv6fhLBKj5cviTQgK6RG4rgwSsYvLQqQvBehy129GJpOoHS8rPTegOvP?=
 =?us-ascii?Q?XKR5fGSMg0tfg8PeQ3Y68zC08CCyyk5Uz0AftQ/29GvldOWwDf2YSu0l45Yt?=
 =?us-ascii?Q?MVDkbhsKODfJxE8FCJp6wEb+gSr3XCiApMWZqiKJwFAmTQJxy5MNJaprKo96?=
 =?us-ascii?Q?Fcd0fYohhPVSDbT/Z13l/8dT8RKtL7Dx8DPL/NR0kNxjhodKIx473Tm1n+9J?=
 =?us-ascii?Q?+Q7C7OD55cRG3gTy6X1YDep6cyYZOjRuaiyHnPGNu8ZMGk5ktIW8dW+EMBiI?=
 =?us-ascii?Q?Wwgjs+rQhZ9EyEBx1FQkyC+eE+HgUi2eTZLnOrI4X2e4vc2gnnrPCvLvuPed?=
 =?us-ascii?Q?yQTuW8NXERJe36kp7mIHxs/xlT8td2kaCtSfY5AU0JACmpoykm+zNsnq//6e?=
 =?us-ascii?Q?+lHRJNHUrvu+Ufj3ke1S3eLbQ/avyeongEC7lNd8NgD2qBIi3Q6aDH8+Hofc?=
 =?us-ascii?Q?v7suffH7zug9JaM5FQ72LUvUVGDPSWPbmFq8eNW8AR4ao/y8ZujjpB6WO3Aw?=
 =?us-ascii?Q?RVipYvmfBJE3N8Fg3GbPx7QM3pNBpoE7gV1RmPVk4ZqiSU3RTesDUxhGsSTI?=
 =?us-ascii?Q?f3xAoHsb6V5TSlJDUois84Jc1saNMeyK/nnEjGMc243lZnaHNdFh/u2Y6lZa?=
 =?us-ascii?Q?4MAqnIcLyLoENG2Ic4XTrakbn5p/7cvq3NYe3ysgI5PSD11K4s5HPm3YSwE5?=
 =?us-ascii?Q?W+vR+X2zTBO0Yn2K9pQYyrNdInaVGppWiqax+WxIf3rit3Kcm7D8GUVn0v8X?=
 =?us-ascii?Q?FHng+Yyyvb0pNynnjuX8f31qeS60AI9g0ZdJFb7FzH4fM9aC+M64V/e93F1D?=
 =?us-ascii?Q?zSZ1xw0VRzetDROYU7h18QbFlMZnZfk/Q7wGnJ7aDyq6y9VHpQ5hcPFC/r0h?=
 =?us-ascii?Q?uB4Q1hSQpfP36ZHlNSMiszjI/d/6b4t+pPrpwyEWZO7exaCEYSzTp5qILuHY?=
 =?us-ascii?Q?m01FC2kKzd3RMYyj0IEfBSMFg438fd8NOpf1E42GmRf+lPdedyOeERZ8l56y?=
 =?us-ascii?Q?DgOvju9LJmQGMIJxD69CtErGcGTXY1w/opwKH3aYBc7DnkLtESsWjjtFvfnE?=
 =?us-ascii?Q?A3bU8sJFAhJaAJNqjZLQxGmSgtd6BnuxL55wCbK6zsKKfDi+qQY9rinQ=3D?=
 =?us-ascii?Q?=3D?=
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39400400002)(39410400002)(39840400002)(39450400003)(478600001)(72206003)(5003940100001)(50226002)(81166006)(966005)(8676002)(66066001)(450100002)(36756003)(47776003)(6306002)(50466002)(4326008)(6512007)(48376002)(33646002)(3846002)(5660300001)(2351001)(7736002)(2361001)(42186005)(6506006)(110136004)(6116002)(50986999)(38730400002)(575784001)(6486002)(53416004)(189998001)(86362001)(53936002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:black.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3206;23:hjr1SQ7bDKPyhqeOpbFHswFBxQttVn4brFeC0qS5I?=
 =?us-ascii?Q?zDej2y8zIOSICueqwYhahW4POKK6zaLSvR8hhoX/98gYtG3qwcbF18NK5lCP?=
 =?us-ascii?Q?4X/VadLBhl3rWCm0dztV6ydHW3pYRA3Z77DIvXSPSeHEdzm3TVOX3imnIJu3?=
 =?us-ascii?Q?wTDLoQa/uKXhyPM5EThTjhhd4c15I1p+40kPFG7J4VrxvhVARg5LVKCx5OJd?=
 =?us-ascii?Q?E4baOxEN0Dp3L2BezlzFNfMInCSL/4QLs/3m8sWxBFHcrQdh1az38Fa1leT8?=
 =?us-ascii?Q?oXttMSvCIIEpZemFjW23V9B/yaY31T2/gyS2LzpPMX0l23sZvcM/kkN7bcXt?=
 =?us-ascii?Q?v/sYhaZFYOuFpSWdyGxRlc2FdW40H4n56VkSBbNRbs91letXsfaamMG0Fh3O?=
 =?us-ascii?Q?u14LIGpGSqZ8PkXbTm3FUKUmKKU1WhoD1KPFMT0p8WXB+OkBCdU2bqQbDsYY?=
 =?us-ascii?Q?yGA91p+jBigrC3DxxjBTh5HdD6znXLTrfrfEhCjCFhqm44AtD5yVeGy9ABDt?=
 =?us-ascii?Q?Novd707fQ6Brt6Y9BrIAUXYlu8qs3hmZcy2Xl3ameZ3cN5MpiV6iEqhtSK7R?=
 =?us-ascii?Q?wWrqKgW4vJnLAXJegUZ4pwnew4ABwpf+Y5oA2V+aZvmoCuPDA48mBMMpiq3M?=
 =?us-ascii?Q?LNIRxBpM5SKXLETjVU+Az0jq478Evq671oRowKre0F8P6nD+BqYTJk2rdL6Z?=
 =?us-ascii?Q?WxWZsXDO8j8RaQuCwvuKECYbwzdtXopFhgGMNVfbfVsxzC/2SpDRzHa1thLl?=
 =?us-ascii?Q?AKRz68kRTu/0RLQpVLEwAHQYSCNi1Se1NTryyQ1cNoaUIfXjKYr6Xpkw2GMX?=
 =?us-ascii?Q?QoAaGJXDUqb6ydvI9Voc3NzpRwyPM7e3jPnoayIzwD++vpUNz1UpOaRMIFAj?=
 =?us-ascii?Q?e4QDOHCc+buB1P0TTee4UcsdnirCMw0/dX3BEzjP292SE74xEhgClT4zRCkU?=
 =?us-ascii?Q?dr5o1kTmQgHpqlT2AHmK2dTd0RzLPOdIT+8DS0mfS9zRE3Ww/CjwpYmuVBsy?=
 =?us-ascii?Q?8A5wZizf94xjQUHKHnNbc9umqiDFKgnIySMc2IXpeGXEw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:q/YJqiRTaIdNl6rltOk9VskBrQdRsfKjXxIKfS8nlQEC+ylGhdC2VyTmurnLEcLECFPLH+7lZG6m/1xnkG7UiNyV2olooTP4/Z7MwI75rsAedhHoTlG3fm9Uj4TVFUoxvaqqOov5hEMVrcAeYdn0OcKEsmS+hauYBMiHxbjssee5ggytgGQ2vpRa0GyT3CHZpkWpAA5vATAE6mB6spwSUhZsdB15BcyBguuvjTHaOPQlIkTTRRlDh0vCr9RX8z0d9U4GeySKfXSaCUwpOoPKc7g64BI2FDD4LFQt/sgmeqIKOxLIRw1zm904juwHPE5eZuIVkeZjfSobXbsbAQcw7WChPBUos1Bim5hyLN9Dzyy4myb64C2X+rwpYufIWrBV3fLWRbwkemWHyfN+utFhvoOIs1288SmHLVVc0QH8sJBaEhmn1jVKdmn7zxfcA0o8bx+q/VRS7KhUouZBLD8xruqDXE+vqpnb6J3gtJcGbS6K81YYIX0hX3V/qDby4YpySE89QvopsDn6XMrxfq6DBg==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;5:Dc4KXLQt8r4x68Y0y9B5F6eiuYAOJ/ULvakXdNYBd9gdH37fvGyJP1nuCxEq/5+76n3TDiORGeO0qnb3S/lFTDn8GTdKtnuMOdougApH+/QAADCeOLNHefhdu8zTbQx+LtrvhchX4yumTepRMjenJkx/Lbs4SLILAg30hRrDzLBcfdlHAZIpCBCSsLjP5RH6KhgiRHiflYjGwnklVj9IBNGQrmQ7F7T7nlkFMmfmG6u4v0PiiGR2VqcAjV4YN5J20oOMcWhf/LDICMKfFY+9cnXfNVYcca9wpZSvnx/V99+PZKHLoQWVfuvb5eB+zbOoJtnGpfLlJtrmCNj4Ids3v2KUV6YuEyI+PGDPBGGPiheEqBkMdEvssCTV5GVzrmEKDdyhzA4dI6zO6ped3m6TxjV7i+P7Rff119LltZ4NkiHfvUgndmawj5ZKJheoQ0bUuDRq5kRugvt2JEVAlk+PijU9Hbn5CHzWAD+6cj8ZpY3L7ySNb0kgwI+ORd+jJokn;24:0E2/FoYu1sSe2Qwicdz1oTHg5fYsLIToWcIzSG7+bJ0XaS5lPYQK+ymKlBDQYS8BaT+oOQpi6V5CMwcMC0w1Zwpp9UCZU5ePvetnYrE1eBM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:iOC6nOWPPRSfyCmb/wJPXaHsfJanDS64s4P3S7fuPHwgl011V0OuEsg2/dGgBC3XFfRkHYVgLNmXrWE2igK1qm2KGs0zAeE5lYXUpkfaU59seo440U71zLWZQN1n1QxxF3SWIhWdy5jf8SG1Nm2IwWiTpQg/HNoLT4irdA59nrGnONvEBael39FbPK4wdDSIlU39fJIxF0N2wQGsLBuwIklSR3b7bqqPF3ufkarjGhco9yK43I7SI9BZzCW/rRG/+7Kw92CUWCZOU0Yyn5aB4fE/q6+tFg03nDhyd1LQ8dI51zbekKK8+BC4tcf7nkgZGYcqoFYX3k4JdEoadLsFAQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2017 17:25:42.8551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steven.hill@cavium.com
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

From: "Steven J. Hill" <Steven.Hill@cavium.com>

Commit 15f6847 "MIPS: Octeon: Remove unused L2C types and macros."
broke the EDAC driver. Bring back 'cvmx-l2d-defs.h' file and the
missing types for L2C.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-l2c-defs.h | 37 ++++++++++++++++-
 arch/mips/include/asm/octeon/cvmx-l2d-defs.h | 60 ++++++++++++++++++++++++++++
 arch/mips/include/asm/octeon/cvmx.h          |  1 +
 3 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/octeon/cvmx-l2d-defs.h

diff --git a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
index d045973..3ea84ac 100644
--- a/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-l2c-defs.h
@@ -33,6 +33,10 @@
 #define CVMX_L2C_DBG (CVMX_ADD_IO_SEG(0x0001180080000030ull))
 #define CVMX_L2C_CFG (CVMX_ADD_IO_SEG(0x0001180080000000ull))
 #define CVMX_L2C_CTL (CVMX_ADD_IO_SEG(0x0001180080800000ull))
+#define CVMX_L2C_ERR_TDTX(block_id)					       \
+	(CVMX_ADD_IO_SEG(0x0001180080A007E0ull) + ((block_id) & 3) * 0x40000ull)
+#define CVMX_L2C_ERR_TTGX(block_id)					       \
+	(CVMX_ADD_IO_SEG(0x0001180080A007E8ull) + ((block_id) & 3) * 0x40000ull)
 #define CVMX_L2C_LCKBASE (CVMX_ADD_IO_SEG(0x0001180080000058ull))
 #define CVMX_L2C_LCKOFF (CVMX_ADD_IO_SEG(0x0001180080000060ull))
 #define CVMX_L2C_PFCTL (CVMX_ADD_IO_SEG(0x0001180080000090ull))
@@ -66,9 +70,40 @@
 		((offset) & 1) * 8)
 #define CVMX_L2C_WPAR_PPX(offset) (CVMX_ADD_IO_SEG(0x0001180080840000ull)    + \
 		((offset) & 31) * 8)
-#define CVMX_L2D_FUS3 (CVMX_ADD_IO_SEG(0x00011800800007B8ull))
 
 
+union cvmx_l2c_err_tdtx {
+	uint64_t u64;
+	struct cvmx_l2c_err_tdtx_s {
+		__BITFIELD_FIELD(uint64_t dbe:1,
+		__BITFIELD_FIELD(uint64_t sbe:1,
+		__BITFIELD_FIELD(uint64_t vdbe:1,
+		__BITFIELD_FIELD(uint64_t vsbe:1,
+		__BITFIELD_FIELD(uint64_t syn:10,
+		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
+		__BITFIELD_FIELD(uint64_t wayidx:18,
+		__BITFIELD_FIELD(uint64_t reserved_2_3:2,
+		__BITFIELD_FIELD(uint64_t type:2,
+		;)))))))))
+	} s;
+};
+
+union cvmx_l2c_err_ttgx {
+	uint64_t u64;
+	struct cvmx_l2c_err_ttgx_s {
+		__BITFIELD_FIELD(uint64_t dbe:1,
+		__BITFIELD_FIELD(uint64_t sbe:1,
+		__BITFIELD_FIELD(uint64_t noway:1,
+		__BITFIELD_FIELD(uint64_t reserved_56_60:5,
+		__BITFIELD_FIELD(uint64_t syn:6,
+		__BITFIELD_FIELD(uint64_t reserved_22_49:28,
+		__BITFIELD_FIELD(uint64_t wayidx:15,
+		__BITFIELD_FIELD(uint64_t reserved_2_6:5,
+		__BITFIELD_FIELD(uint64_t type:2,
+		;)))))))))
+	} s;
+};
+
 union cvmx_l2c_cfg {
 	uint64_t u64;
 	struct cvmx_l2c_cfg_s {
diff --git a/arch/mips/include/asm/octeon/cvmx-l2d-defs.h b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
new file mode 100644
index 0000000..a951ad5
--- /dev/null
+++ b/arch/mips/include/asm/octeon/cvmx-l2d-defs.h
@@ -0,0 +1,60 @@
+/***********************license start***************
+ * Author: Cavium Networks
+ *
+ * Contact: support@caviumnetworks.com
+ * This file is part of the OCTEON SDK
+ *
+ * Copyright (c) 2003-2017 Cavium, Inc.
+ *
+ * This file is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, Version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This file is distributed in the hope that it will be useful, but
+ * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
+ * NONINFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this file; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ * or visit http://www.gnu.org/licenses/.
+ *
+ * This file may also be available under a different license from Cavium.
+ * Contact Cavium Networks for more information
+ ***********************license end**************************************/
+
+#ifndef __CVMX_L2D_DEFS_H__
+#define __CVMX_L2D_DEFS_H__
+
+#define CVMX_L2D_ERR	(CVMX_ADD_IO_SEG(0x0001180080000010ull))
+#define CVMX_L2D_FUS3	(CVMX_ADD_IO_SEG(0x00011800800007B8ull))
+
+
+union cvmx_l2d_err {
+	uint64_t u64;
+	struct cvmx_l2d_err_s {
+		__BITFIELD_FIELD(uint64_t reserved_6_63:58,
+		__BITFIELD_FIELD(uint64_t bmhclsel:1,
+		__BITFIELD_FIELD(uint64_t ded_err:1,
+		__BITFIELD_FIELD(uint64_t sec_err:1,
+		__BITFIELD_FIELD(uint64_t ded_intena:1,
+		__BITFIELD_FIELD(uint64_t sec_intena:1,
+		__BITFIELD_FIELD(uint64_t ecc_ena:1,
+		;)))))))
+	} s;
+};
+
+union cvmx_l2d_fus3 {
+	uint64_t u64;
+	struct cvmx_l2d_fus3_s {
+		__BITFIELD_FIELD(uint64_t reserved_40_63:24,
+		__BITFIELD_FIELD(uint64_t ema_ctl:3,
+		__BITFIELD_FIELD(uint64_t reserved_34_36:3,
+		__BITFIELD_FIELD(uint64_t q3fus:34,
+		;))))
+	} s;
+};
+
+#endif
diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 9742202..e638735 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -62,6 +62,7 @@ enum cvmx_mips_space {
 #include <asm/octeon/cvmx-iob-defs.h>
 #include <asm/octeon/cvmx-ipd-defs.h>
 #include <asm/octeon/cvmx-l2c-defs.h>
+#include <asm/octeon/cvmx-l2d-defs.h>
 #include <asm/octeon/cvmx-l2t-defs.h>
 #include <asm/octeon/cvmx-led-defs.h>
 #include <asm/octeon/cvmx-mio-defs.h>
-- 
2.1.4

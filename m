Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 20:46:09 +0200 (CEST)
Received: from mail-by2nam03on0086.outbound.protection.outlook.com ([104.47.42.86]:64592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993916AbdDXSoacAKIm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Apr 2017 20:44:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ud1DU+OqeR8KUqRecdERiJs/QlpIUGo43VsnkEMlgEc=;
 b=VE1gnmyyFXWhhoMeSk4vX2n5f1RmHbEZpGARUCsb0q43w51g/Il8EV38kC1ADr6ZpXijc0rxfzL1NmI9MUEDqKLrruIIIINwzhzEOsS9cPoLi2OOVtlbST+481Y+YqBIKpHW2kSh4V0n5Zps6n/ReVRWeQgknFvoI2mUBye+teM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=cavium.com;
Received: from black.inter.net (50.82.184.123) by
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1047.13; Mon, 24 Apr 2017 18:44:19 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>, linux-mmc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] MIPS: Octeon: cavium_octeon_defconfig: Enable Octeon MMC
Date:   Mon, 24 Apr 2017 13:41:58 -0500
Message-Id: <1493059318-767-5-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.82.184.123]
X-ClientProxiedBy: BY2PR07CA044.namprd07.prod.outlook.com (10.141.251.19) To
 CY4PR07MB3206.namprd07.prod.outlook.com (10.172.115.148)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 608f4028-03e8-45b3-68b0-08d48b41eb2d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;3:jzviWQCkrWBDX0yzHL7kRX2pUic6Bbzypwcgo1pPkwWbz2CMlFqBjyTMSkXOVTO3v/UquqRAsgmOkG+RNYmrrWq4Z5vakpQ85hh4tA2q/zhg/D5D6k8E8xnQ2lmvRUb6L+biKubNeMnvodA6Mtzxra75WNCEKumS04BVv5VW0+cN7p44/7CRXc0P2PPd4U+s+hT8wb0EWOGaW/wsrDwbPEFtcd+9rlGFSS2O8sqofqk2BgrW3zYFd2SYgteeadIKc0pY/8ds8oDGAexnr9MzYDHKddVsmIWjShxPswP1x37kaAqnRPI77B+G4OGjHAdhFS77+KjvvSnjb6v2BMozHw==;25:HqUJvvOaW5WBeuKBULGosiB++FG0ToxnImkKYnPoEovIRuZoJLA1QJgUp8Si9oelPwAOIKbUeyWhi5isSWYR26GVBIDJm56RI39g8rjgjKNq/rQPoLPtHmZWmYiOdAfbcHnTMOC+hGu6EcoXbRDpLTnWN/dWPTrYbcdZ4PxeWOcyAfdCtRttN6OOzEA4/H1YQQuhT0ugXu6i3+Xg/FMSRFkqgQpODPfVgC5xC3iOz2ZGB0ObJNHlrISD5E1Ey6pYjw6Th6VzzOoyNcmlokzZ0QNUj/WXNdJ9VFNf0tNK/N7XTKXdyFpf45thyMXedLbVTOtY8MpnYX1m9kchOVcnbInEQZA0bMuFTmS/WEKKLO9WBSFygWfVwT6/yh1u9SfQC8U4XcS/9DO1dN507HDACl2dlL1Vg9XmywsvSynmnGWQpPZU3ZIO/OmQTV+c1meJfgP8AZz6y2samL24A3YZmw==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;31:bl0OJFWnxqwQJGfx7YXqmNx/aOB8gPMpaCj7VhT/1dYR6ZlvfoTi7szGB1d10O8ZdtaEcKf6gZMzMDAe0SU+D+u2iRZ4iOMk49BbnLsX3rE4XfqtH+nyWrc+FwpgcRXiE9yoT2LBGENdNIu/yqB7Sv1MYWMaUcJarSl1HshZ9/v/8lyeX7xVrHbhw8J81JwnsEof3pEzFD32uvPLiq3TTMPajtCPNTHqlSkfG1t7GTg=;20:0x861At66Pdg2buiVWyT5SjhY+DpJvVjpiMlgfOLxb/3OJhT50YnZIiD506AVbma83PQMGYay00pUDYoDLBOM9joiTAkwKFly80OjyDuWO88sUggSO8pghIPQKqndBDDJtZhKXam2SzSYrou425gUYlsK2rsRJoxCZWab/3TGlJYhiSYAwtW2dDRUBEao0F8osTtq7qgbZgCsKTicbWQqeYqOTsRajkkFukVql9Cv4i9rBo/e2NNQu/1U8ZSKwPneTUEZVQ7W+SDBQrACOxo6nJAplal0xb67Uih7HPvcjdZXvOfp29ESWJyufYQTVJfKXlxfjZWOkcc+Q7RoHHahERGZpjIMks3HxPm9z2TkSbhn/HWYNdjR8YTjNm+8DvRJd6zWrNveUxvzYrhxhe2aXTCfl1KnsFST/UI6lS6XQFWhGnTnKNjsOoXmLi6u67Zj+wDbI/rCAYeSQOW7TbgZq1tI9jGQ0GML8jM7qlCqTQtAHSzG9xNf6rBAbKtTeMu
X-Microsoft-Antispam-PRVS: <CY4PR07MB3206840B8DD85D608C0CD625801F0@CY4PR07MB3206.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(20161123560025)(20161123555025)(20161123564025)(6072148);SRVR:CY4PR07MB3206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3206;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;4:/WZLVz8fhnBYHOh7pPmsgoUuvzZKP88FnVZDZBe9cXoRndDNZW2N7allw3QKj+2egW2gwcn/vMnMsOtpBSY/Bmco2whYuAmGO1js/lIzftI2sPJz/qF572YhBi3isbC6pfixlip0g/kRK2Oy0hKcRzPkBkTNKQaZwj1lmilJJDgDguoTkpIZzJb+iSYAqGRpJx/7oZFycB9aCjEHTSbH+tZeRqnPG0nAQyE5UZf46ja2IEC29S2QKAbO94/Xcx9XIutRC46TrByWaXpt6ZE+6LSnOdA6pUGUtgjozWoI8x/isbfUO+PJZvjmgC640zFp40lfQAHjEbd/qaT1MESlqHxYkZ/GseRhwCU2AXMaA2erpRhvoIb6aRmD+kddbZqdw5qIBA2G2D75gdvxyyiUh4DAEj1gxevtXKGNqXXM5F85qHMGuxFqBjS8qqg8Yq4FSEw6da52nZ699wo72GHPPOHs5PtfggJXFdOEX8hr/HJwMGmtdBI9XWQXWrhcolUR2RvTnwSV9qhvQNrl6QE2UYQ7dYN9Co25/sz7OHbf0MFG0Tf/rW894YGyTtUls+vjPgZKbGALQzVQfAUjcPv295Rl2yYiTfFW44hCgZnviPZnktidKsnkU1IYSxYM9Tl3wIRPTvx2A0VDvLfvB/YvN2VSNz0uhV1ayAyhGI2FAyccXV5CPocKSf+oYlIzAsaIn/rZYIPUJ0Iqx8EKLiS37lzbo2X/xoALpGRJZbYRbl8=
X-Forefront-PRVS: 0287BBA78D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39850400002)(39410400002)(39450400003)(39840400002)(39400400002)(4326008)(110136004)(6116002)(54906002)(2906002)(50986999)(3846002)(6486002)(6506006)(76176999)(189998001)(53416004)(50466002)(66066001)(47776003)(38730400002)(48376002)(42186005)(25786009)(305945005)(5003940100001)(50226002)(7736002)(81166006)(8676002)(5660300001)(6916009)(86362001)(36756003)(53936002)(6512007)(6666003)(33646002)(2950100002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3206;H:black.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3206;23:lu2qHXYpael/n80iI5O+nINDGZVncTKlni8ODHMo0?=
 =?us-ascii?Q?t7AFguo30I6EVdGZwzLpD1pbbqvKf6VcegVMUS1G/aeunQmZU7WMJsxIk12k?=
 =?us-ascii?Q?qfPCWfTlwJLmPT/41Fqc9Lj6uUiO37EDwD+epBi5nZJ5d9mbv7PT8Kulxp56?=
 =?us-ascii?Q?p4cMWLtLPxkAublLxkjQHTYCDCEaCzIZIcms8XWlFkBDTp9K8ZCjgpO+pyWZ?=
 =?us-ascii?Q?jjlgCRomaTDvrbaHWLObhXnvOCZLRIRtuL7Z+VCGrb6KBPTiR95/NW0Vz1hJ?=
 =?us-ascii?Q?pTBjR3SDqbg64xPFeu/qICNmUe4fHmCIjZj8aoltkcn5Y6GfPvvNeNa7BtN0?=
 =?us-ascii?Q?xKE5Md1qTo/5wB4GulrJFrf9UMG3dY0T1sWU1+abhzd1/Rd7apGeevgcFynl?=
 =?us-ascii?Q?2k6M2/RIlUO6uecVJooV4yEW1XCFBQzlH9JFhw7Ard6bnzXyMruFwMbbEeC6?=
 =?us-ascii?Q?+4e23JrfJFiWGgwAwvhkdxZkW4ZDfkCtne5O+zpATjdFld5ZfpZDS+mrk1Vs?=
 =?us-ascii?Q?wV8UBWbvykfX+QSeKyWIffuppBHWKXXCTkFgkEXsiPrSxbABEfp6u9hbOBX3?=
 =?us-ascii?Q?kBEmgSgqWLJCsBiKQL07jP9lDG46S8ZjGxyHfgaBw0QUvXaOt+yCMk1DKl4q?=
 =?us-ascii?Q?drE5fsKKM27yu9TLtFQAS14939Npohp9FJD2VnLPOP0bClZ7SyWDrR2x8QV7?=
 =?us-ascii?Q?rwIMN2bxOhONbMR5AbZ4t0lEW2eeH9hPKFY8+mwFaL8uZXbHb1YHY6M3rC8X?=
 =?us-ascii?Q?yLYzYCIbe5xJhgyy3luemxT5GftykoBoCna2SboodpJJvF7QnTJXVspAOPTV?=
 =?us-ascii?Q?DpXXd+p6mhFhS1w7ZiTU+v4cZ8nxEkBPed3F2Nt4B23xeyUxiWdsIGTqpbma?=
 =?us-ascii?Q?MfXf58848NRkRCPSRM2jrDP9IYuCTWzDPFUvUBmaKFqQHJwLS7Z6G5BqF5cq?=
 =?us-ascii?Q?Ku0Q292tNYg8Ibo9u5IHwoWMz2D3XwSlCq0G/8kXcV0XxoNtgDzCQPNRFBcG?=
 =?us-ascii?Q?cDkV8d9IXPggOjitG+hApRAUUgOXvvlYZ7FJVxFgyaDpnkR4Rr7FcbN45aSY?=
 =?us-ascii?Q?UVdFqI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;6:UuPCRsNkRf2q1t72fqgGMHnO+/9SH1qCde+v6FJbyfZFE1UJnkpQDL43hMugE/Yoao8aLcUIcOKN9DfCKo08nfKFFVZ8bxnQOHWZcGR53+jHJ+ksK/HoLU+U1jiSxE+8c8tcFwN4Ot94BYiou5Gd71eaHPXlq52kF2u49sFiep0nPcAvybfjHroFh+X5lBJguKUdvPl7Qitu/FQlNk0trVrXHRint8blKlon1nKT1zO4wL8mG8+EJpw3aYwEZoPQQ6t4Wi/wj0DZuSNFGeMEoicjSkCiVh19sCU1mElkBM4vp0n7MD+JOR0LenbRhGOWjpwmFvC48PNyPjg0FUFP+HObJSLHIOFNis0BYD8QwoWgPMk9hfF90v9k1Ia8P837I+cqutCl15T/SrAWuMsZeQC5tMp9SOvZwM8faNz3IXqXvgHo2nEBLFMYUsmkPmUbRZvRDiFuLUNF/Fu76A4zUwj7DBaU3DqYZQdvbv2exGQirfeNAWeIn5ZyrZpo/9aBbh26r0FXoR3zMf/D7MBd9Q==;5:nuXHH9PX2rKPVoSrdKY3rgH0LxwRib01ObJKaGBesKwIsqOUttLFkeN8oThlVp1iElLMGapcGzcSuA1iHScp1xWdAt6Tr09n4nAzMVniWUJLUb/EIa/Ji/DaMRRfzNfandwR/7iQ3XxMFSOIiKcNkZj5m+w/3c6xMUydkVTEsXY=;24:eyyTYHUnYugJfyIOSewoYbo4aGHQPWuwoRcMQSSU4PK3ovFikXDJZ31C4fSX5h08XHwiPisfaOcXu7zRlNrSgp5ON7X/dgMFIhbS3QnWemI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3206;7:+2HKlmMtP8WdYEZTXLI5d8qL9/WErJc53hQWCaG0dBe1w00q3vBop/Dv+t2PiPHI+Ng/AUoy1zQQlE+l6tWfnlwAHBTwmXuf66cJcesbF3OvpjmjHqR/K7PxuGjNSMaCVXYJRWDmGkFO0sy5+Nf0YgO4vj+qXzYPAk5YlWd8JcjY8/Us8LzoI46CIGhiSBpUwmPrTy94SLvu9+ISs+t64HsBrAutKt9aEbO3QgC7LXCcLg4NEqBpLWqzTWIORRgOsy+wuYizE457vOLeLDRy2uXlZq26xWA8HLoADg79w6wE6UOp9FLvHrxocottVURiTzHocwOGKigLdv7nNJhW0g==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2017 18:44:19.2742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3206
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57775
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

Enable the Octeon MMC driver in the defconfig.

Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
---
 arch/mips/configs/cavium_octeon_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 31e3c4d..d4fda41 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -127,6 +127,11 @@ CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_EHCI_HCD_PLATFORM=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_OHCI_HCD_PLATFORM=m
+CONFIG_MMC=y
+# CONFIG_PWRSEQ_EMMC is not set
+# CONFIG_PWRSEQ_SIMPLE is not set
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+CONFIG_MMC_CAVIUM_OCTEON=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_STAGING=y
-- 
2.1.4

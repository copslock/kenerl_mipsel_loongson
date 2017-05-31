Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 19:19:03 +0200 (CEST)
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com ([104.47.38.70]:5760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993419AbdEaRS4RnNvF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 May 2017 19:18:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ey34LGrr/rRVjMjOLKzRAeD5iNa1oe/qQLdSbAxIX4Y=;
 b=LFOMGsU/DZA+JKRxX7pHgWoytO72pBlZVrv/niZebqh4zd4rz6OBuJPkv0qj+EvRbpA5SKT0vJYAcR+E9ac9WZ6jT283UimFsUft3c2aRts6fEvaGcDCVB9IfZJDLrVqTDa6xUSWRv8//t22HH+bcX0LrW55TZ7I9N5LEciEch8=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=cavium.com;
Received: from black.inter.net (173.18.42.219) by
 CY4PR07MB3207.namprd07.prod.outlook.com (10.172.115.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1124.9; Wed, 31 May 2017 17:18:49 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: OCTEON: Fix USB platform code breakage.
Date:   Wed, 31 May 2017 12:13:50 -0500
Message-Id: <1496250830-26716-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0011.namprd07.prod.outlook.com (10.162.96.21) To
 CY4PR07MB3207.namprd07.prod.outlook.com (10.172.115.149)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR07MB3207:
X-MS-Office365-Filtering-Correlation-Id: c973807a-1369-45e4-765d-08d4a8491a6c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3207;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;3:lEkZLqEzalyqPtoyJfP4Uy1lejwFUZ1CJ3u4/paLF1CbUfBi1MuW6r8i0hQC+sTPic97Ha9UWTpg22MXsc9peJVrCfvXsk8W6u09+aF/8mu6AdbJlhmyvbolDbcKEHN0nnotatPsy7LrH830PVBqZQECAFc9ogGw9NvpHzLQUSxG7z7dknYJVeOqJ9RkcxvQPOIhgfcP7qph/Wczp+Zds9vdPHnsw63HXS4711wQ0V7Nia6LrKtkhKKc2kqiUj6w3OGaKnJLvmEQGe1dtsRE/UJ9c55+Yg6IspBpPtPzVZCvqPKew4kDx7eb/CJZgT+2K31vYvkVf8vZGKrXWap3eQ==;25:nmjQkYvBHWM31EeLn6UKaw+BzH7EjkVGlzYp/etKXis2PdErbKrZCAasWti7Ao98ZUa4di70QKurAHiOLi0s/IrOFCJPKUXlTqmqaS8WD8yALDkPrEMd0A6T2/Od4sGbzbxeRfawjeeUwnBAo7zpAlHp5MS6XBgjxvpQllYdeDTwHVqMUgqgbW+rjNhg4ifPFtw+X00GpQ10+vDjqycLrztq/2EbJS7+OYixjQMogajhGHpnjw9APZfsvebDusIQmRpThUjrUgYF84s0A1kAF7aniX0SKMzl4Sv9zrm6a017znMScEOlc2xFT2+Td1VV5/3ONi5T8x0v2PKNaiFtXP9qxFTsGURTFsR/gFdwfHEiJiM3N+tzaJWcytX9lhymnKPvRZmEw7WVpHSFqkVn0ujPJWipt8YqkKYc1K0L93bNJ8AnsmKieNpZoP2G++eeRPY5rE6AsHnO/w6A2UpmqqpUuqiYTJpA7SU0FIX66n4=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;31:j4T97C4K+CF5PTKB6zn0eLI/Kjk4Gr3G/vsYnCF5fBTff3dveWh5vSYGKUhGO1VKMYQV6OWPce7e0r91x4p1L/ap5D0p7DGYP/Wq6n1IPqv4mCaktnfe0V0TiOrWESM6NG9mba1RLOs6PR8MPCwrMcKQ8B7OSdXQl/MckcLbyRoaHwQGlaIbnW1V5QXehaSsPoYpQ117ZXK5LG3zmPOVuR0ct++7pdAauVQC0qG9jbW3YMx9+F/ulixqyrj6T5h0LaHX6nFd/JmaiH+pgSaaYw==;20:RISyL/vBLI/BfFVdQbcMzUOTAZAaOfjZoRcLkiT6eUiH4Q+f8lz45GsmNokm7s/4k8BAXyUd5MOP1Ve7/mDc1NscpvCZh1H2VltpfqGayKZ2ciL+bVJm4b2VYNYGs7iW5kXudIH+6UnX5EfN0HXm2Qkeh5//B02EBjNVL/zrBVz/PdPzXhZLhJvsMeIn/aNT9+1vIw7F/QtKOTGPmPACSz4RO2BlVLcxvZFwLefCSVr/5lbM4XkRsf/V2mHsfhkOTA56TfOJhHhccWljtZDWIbFs67Tp0LynfS8w00ViAbvpGoNqNI9LVGwD8Cm8bZTagPbu5Gd2NAM3phNPeuZhMniGWtLH6h/rU5wB/ZEXJbkptDJzkYEYaVVVLgnlu+w2keIxb8RAlMrun/IWdKZAKEYQbXoYikn86jdlo86VG6iL4GUoKh5iUmX/SDxYwqg33Gmd7YWAyISnW9pNR0Z3rxz+aObCyY34F46fyD4ojBaNJcdpM/jvH/kw+yt+O43O
X-Microsoft-Antispam-PRVS: <CY4PR07MB32078B6F5C627FDA9334D91A80F10@CY4PR07MB3207.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700073)(100105000095)(100000701073)(100105300095)(100000702073)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703073)(100105400095)(3002001)(10201501046)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123560025)(20161123564025)(20161123562025)(6072148)(100000704073)(100105200095)(100000705073)(100105500095);SRVR:CY4PR07MB3207;BCL:0;PCL:0;RULEID:(100000800073)(100110000095)(100000801073)(100110300095)(100000802073)(100110100095)(100000803073)(100110400095)(100000804073)(100110200095)(100000805073)(100110500095);SRVR:CY4PR07MB3207;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3207;4:dRYEFuVAKkdnEy9qxbFAHEip2bju8FrrK0DIo4zyLh?=
 =?us-ascii?Q?qvZazdkQmd4WV10wGYEYgyShUTDQBsvgY+iuXL+v5W1E/tR8aVXKSrHi0hYe?=
 =?us-ascii?Q?3aHGUzTHk3mNFr5XJBsm4Zgmc5T+/Pf3vX6wksfii64oqoVO9FLuKJfegIfc?=
 =?us-ascii?Q?JF2/9FPY4nh8PiBskeihX31Km+OJN91oBGgUGZQjtNqNzjqmrnwJfKi/WXjq?=
 =?us-ascii?Q?CIXiPqwTHnuVamHS8CJiSxkCOh51fiJKU4n84xtznSpQL6As/83orbt2qN6Y?=
 =?us-ascii?Q?3ddcPtlrrH5TNgJQ2177n6agu6nMubr23RVWUEV2VD/28nDPkh7adD7O8VRq?=
 =?us-ascii?Q?Q1uGRNGfTkREqBAR9acPqm3vOlwKhoG6Lg+Cv4VpEgkcFSdT13RMmVCAqGlX?=
 =?us-ascii?Q?DTmpXys5V9AQvKkxCBqPTaAUFaa5gsSSiogc1HGLfQMQmhWqozbNqjqH+ywY?=
 =?us-ascii?Q?qGhl/0FVSM6wMEmp303OZKAJWn1wFJbIcaksYQySKYxG54qhhK4fJR1gZiBt?=
 =?us-ascii?Q?6MNTlCPKOu+ZjkNYCns+N1claiukE2t7hgmuu6JVsRgIBIVd7m6BT9e+2SQ7?=
 =?us-ascii?Q?e5Wo9ZC1iNtkVKuCF2oIQ5ljFXgziIPZ+fe4I7n8wdvyupPeJl27FU7OAp1Q?=
 =?us-ascii?Q?z2/cv7b8kYgccLKb3Smjgjc1OrcUP5Df9aIpJBzBSq7CL/SAzno2pBMuQhkL?=
 =?us-ascii?Q?fCeXbCziJ4w8fO+vK6OVrNsXv5QjBPAelRmzgrcp88oJmfzxhTJNP1p4t5ii?=
 =?us-ascii?Q?umdRdMTrarU7M8EfBtJ2aNVKo9IGWMBfQtt4Vndd6GQADTRQV/35FPMobgyg?=
 =?us-ascii?Q?//1a1LR/7Cipw1sxNcMOkcjeFRyHMBRi//zU74+lUWucib8/vP2sHnbfG7/Q?=
 =?us-ascii?Q?UlLFBxTYDDGhRyMTa16LFGmnsQ6uWHzwP6ospmuRwvOluk5ge15Bssg4+wxx?=
 =?us-ascii?Q?HCI5SUOUNKvwL8EXb8cv4z6mUEqNt4eoFIRzIHe0HhG9eLX1Wvsf35dlPISl?=
 =?us-ascii?Q?6cwtmOmpXby2tto255yUnruXbhp0WaGXHTvp3gVxB3jhikl67UArozZzVqo+?=
 =?us-ascii?Q?44J8wCH/JMui7IEzR3e/7+V3yJgDrID7njORxJ9DReENLoTlde+pxwrlsQw2?=
 =?us-ascii?Q?bbyneD+c9XzOikMfhh9adS6XoKn4O/?=
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39400400002)(39450400003)(39840400002)(3846002)(5003940100001)(81166006)(450100002)(48376002)(38730400002)(4326008)(50466002)(6512007)(110136004)(8676002)(50986999)(50226002)(5660300001)(7736002)(36756003)(53936002)(6506006)(6666003)(6116002)(6486002)(305945005)(72206003)(47776003)(66066001)(2351001)(2361001)(189998001)(53416004)(42186005)(86362001)(478600001)(33646002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3207;H:black.inter.net;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3207;23:hAeQmdyxHlw20cRzgQYn6GUWV+6O30KjQ+5eo+7Cu?=
 =?us-ascii?Q?mKZctZ6TrKU4a8SHoqKwHEi+d5fL1RHomVv/Gh92Lo+yBMeislCLbEDTdsbH?=
 =?us-ascii?Q?16a7QRajoVviKuxcme1AHXi9lCzD5k3pgIT8Xl8iKpGO6+tuEei0rnpbkHRo?=
 =?us-ascii?Q?GALeQxWR89qmBxuQtINO/QCFPuyv4p7mTkYE5rs/7yho8H9tLC5Ipt5e+DaC?=
 =?us-ascii?Q?yvuw6nNajn64cT5XKUHVsaqrRpp22aiHlNIHGArOcP/D0TtfBP1Ur5PS+oqI?=
 =?us-ascii?Q?mKU98T/cnbzUn057NfJrcfZEMm20/lvB9+Eb7809Hvt2r2dVK2cV2tYz4qDh?=
 =?us-ascii?Q?6W2En5k3xqbN2Z5RbrRwv84XEJN381qA5SBnqwJSmQXZGUNZy2EJlb0sa8dd?=
 =?us-ascii?Q?ObUD29tD4347TUqfZblfaxB7sFbpgkUJmntK082kKeG+TckdJPU/FpNpKloj?=
 =?us-ascii?Q?KwMaeNenipWZVAO3zqnn4b107PkWuhKvf4/Ox08zqFjSL34eoqT62WNSeGUT?=
 =?us-ascii?Q?2dAwIDBccY0D64OFJJ95fprE8kZ/WewqM4iEjmWwdeo7jz4Y20qEWJm9ZmlR?=
 =?us-ascii?Q?M+2k+tsvOfMeddfxz1qhGjuzC7ZPzfxBdL5wV8NQLbJl2DtdllBX/S4WQd72?=
 =?us-ascii?Q?Oy3pZ8A5HsyFNg7Mg/Dkm+5wVORD9oCBcc5rInKLx/Ie3re8xsJDF4mYCxEH?=
 =?us-ascii?Q?ucNDLEtqdGv3T4hsJi+SbrUYRh3mWDnzf6NwEV7RH0+hiRL/NQBSmU1cDcRc?=
 =?us-ascii?Q?iBDsnol5o9XVkP81JmW41xxUAgvjP2xB0QwqT9Fhcrvw1kZH8h95stekbWnR?=
 =?us-ascii?Q?fgyui/Z7M7fgmjlSmwGgSmRM/eH8V6p0S2Mp9eZ4JH44qsNCuVYqeNmHWwjz?=
 =?us-ascii?Q?1wUNeReKdw5PG7m+JWN+aMSWbmyqwR2DV74vZBuIeoJZtCU8D1/l9ipniAW0?=
 =?us-ascii?Q?Oq7l0c8EnaAhAct6jwLSG5pdy9tXvuurvb+cfsrg51dM0I+LGxG7cFiGtGWg?=
 =?us-ascii?Q?Tk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;6:e5f3274lLpti8F89xYFJt1bSPBaMGFLLT6u7UQxfsyG4WlWV47qaREgUWCuVdBYqlc0+HpXafCyxYVbPIWcEH1iGXcOu9tJiOrh9FMa1Vy7JbVLPchicw2awUs7Nr5n+M4HfKaaaHlnZThtXdl0Di7eeLcLEjCcncKOhx9OwuUy+uTmWks2QAd1AqG2T3b7ipULHJoXSzIDtmzVxeyPxPMJTKdfJcZhlQ7qvQxyekOj4GPxNv0iHU79LgAi+cwWAloYhXAMxBPwIci/wBDqaUSPsyYT4GqHnF/TaFCrwFRe6nOs9k5yRckHNWTEv20rW+n2OnCFyUgTcpmtEkCeSXHZix7v/fMxeRtBgxlp2NPgyhDMyOo8S0ZDvmZk1U20JMNty2HjAvQOEk4ihXyaPdMOr03FNHI3n4VlH57Cb/TIWWspLzlT2VsDQXTkVx5hPgOHRG1KoiNwq5SQ+1eFxqzHy5EtjynUaIl7W/3wGnYw4F0wNPBbTEWO968iE7GXiZVZRlfRpyhRbgvl5/3npvQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;5:l4U0r+UutiHBQqsUVV/fiG74g7ECGaj2EkrmIWRgQ8ZAwth4pjB11RXVQY+5qr417qLjon1f1X4ZakcJonHrrg+lFtt/JV7xIUhINgCLQr3J7KB0sJSjL1gSe/dM3cjwyeclmdCNLAqHFbPTnXzjZtNTUQUZS7aGhoVfGz5y4wZ3/aW5GcdDN5VinQjSj/bdnfDNTex2FvCax/iceDkFU79g+qK8/TjwBOsrBJsCpQJSt8WTw0QeL7KNnXlKo0ie6JABkkCur9IPVF0d+lNAUjSPqbkrawYOAgJvs6pFHJ5E9/7iEr5xuoXDqj1Qh5uUS9lGZPLt4O+6MVyudRGviDs23UiOBvaDfMpvByRSCuuCCDXDDDGeetM6zJxSf8FskxKjsG6Y/yiTochnPMHQUSSa96nkxuoqCbbFrLu1EyjgKTYXAhSxJg3hdoXQcZIjUAPT8/Jak+jskbm8IctfC90yHNIjRcZjRE+xl/ejlDnos9Nay0f+dxk1oL5iZZjH;24:LbigiLsDsa0+/rn+qotwMykOoJ4UCb0fWi3oWL77gI0EICm8eoQwlQuR2goHa77/E/o6n7p0nnRKZ/SYxu7aMXYoMFMzceCJWUDlDO3fFq8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3207;7:47qowHy1C2aLsobtqckDWaT5VQvt6PKzDRJSJyCp8FrHGDnE+VA1v6b39u0w/KrMMongasr9iqgKxsEOMSFtKJNHQ1Zp9gZKVeA/sWuDihXyz4vBZd8GB97DT/+StIW3uVfYh5bIIi25Wi9ph84kCoWbnp2ZidfWFkiEPQt8uVVT5b9ZaMeefIb/vkGHtpGFTlwIigrCgy8tC5m5ZvLivHgmxVvwCVV+S2ciST8Zd3seqH0F9QFIiIJiIuyRc5tUGwhFCUvBOfJ0PXKU+FFLNJ/kX+jeQtarESxw2BRKmCYqrlR6KVZzgfx5zA6Pwc4DE0guN+wOInUNvHKQPTqqaQ==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2017 17:18:49.2039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3207
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58099
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

Fix build error which appears in latest 4.12 series. Also remove
redundant header include.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/cavium-octeon/octeon-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index 542be1c..bfdfaf3 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -13,9 +13,9 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/of_platform.h>
+#include <linux/io.h>
 
 #include <asm/octeon/octeon.h>
-#include <asm/octeon/cvmx-gpio-defs.h>
 
 /* USB Control Register */
 union cvm_usbdrd_uctl_ctl {
-- 
2.1.4

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 20:10:40 +0200 (CEST)
Received: from mail-eopbgr690105.outbound.protection.outlook.com ([40.107.69.105]:56576
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994541AbeGXSKhXWZaM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 20:10:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok/Ff1dK2RgVvzzg4EXISW0ck/N7C82cfeDI5SgBMQY=;
 b=E1mJmkDKRLHdNR5Kh0Rq75IjLeGvFvpHFGkg+Cpg91a8VBJfxjWlJzVxoVsVgRuoR0J7FcUzB4FgyjBB0xtMEaLYW7xSxAd4SekwafUjILPAQD6r7EJIpPyR4KAqFZ6MiFhU6X0sRE6jYyZo+zi6yHzZRd9g3/45klzdZ6Vw7X8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from pburton-laptop.mipstec.com (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 24 Jul 2018 18:10:25 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Jon Loeliger <jdl@jdl.com>
Cc:     Paul Burton <paul.burton@mips.com>, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        linux-mips@linux-mips.org
Subject: [PATCH] checks: Detect cascoda,ca8210 extclock-gpio false-positive
Date:   Tue, 24 Jul 2018 11:09:40 -0700
Message-Id: <20180724180940.20249-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724000647.okbjmghv4w66bl7u@pburton-laptop>
References: <20180724000647.okbjmghv4w66bl7u@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR1101CA0020.namprd11.prod.outlook.com
 (2603:10b6:910:15::30) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b0cb673-0164-44b2-93e8-08d5f190bb40
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:vE55J76olbUIPA30mMimSEQt5wJ4kjnFLa7o1RvU5LUhwOUTw2TX6/pObetCtdB50D7U7R+yJQhSVApIx5f+aKqjLRIRQpql9ZUVS/8NTAW2KUWwH01VIoHoPD/kF886mg3Lkn2c5jRhQh/f5uCZPXOs3KbGFLgmT0KzKUvlosWLdJKoToIGpY+8+Dmftae+AAp6HhEggLd3HVDetUADSskzV1F/+PdCO9sB1hOGgFnbeG1E4mnKzLBS3aR5bo3c;25:fznF0LlwvvCZ1LvvWGswndPV7Vw22ZQihEW2DkmU2Qj3ZFmH4A2sBtCSBW/oiGWGghKS3KGLrCpl+0rPRNPFGE1/gdBxQR3LRUzYDED1aomA0kZ8PXwNusvo7tXoTz6tzCVbV//FoiX2qme312EB+d8P0+bdJartY2vPixuELcYC5OOH6tdIsRTsakuEEFA+PFZYE8lL688iLbNgIYNB9Km11WudrUf3lEfNuGV72YNwzUKSCBNY0rj9zP/4G9OG9dsVPAK6Ly8yGBWqcVYCbsRJ8fTeVkpcZUoVbER6wpRPHSGDdajSnFJpPVZJ+W2MVdr48c5mvMUaNmKGnXB9aw==;31:jiuOCi3OSpyYxx1BEjgND36zI+VJ/+9qlx5J7mKQLSVAIvXYEfkR+mpt/f8HLIU4TqvojUR/q8tCtPBshryAh5jv4L9N8jzKctt+HjoZ5N+5Ijigg9cNx1S5TxVSttVTIOIFNeEAy8VH+jOWAIRJQjzvOXY9hS/4J++o8rQA7qS7PbTjsvRVQODVP+ne41Y73tt6FPiZ4OZHRUmfu1H9uFgZ1z8KmN+3V1VzIQwg88A=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:bu6n+CTa/rMvfdyXrzfLNoe57veAhiu7wHqxDga62wG7TblZysKDVBifl6hJqdmdXyam1g8xUbgN3TMkXPRw3rEbqBrlkVZLYGDbjC76m7fKd/ufvRqTSkSgqJhF1ijE1P4vFYE4rWyupgfQrDUGakJ4t9gQ9OJvEZa3i0SBC1VYsDiGJec2qpi8s+5vVAacJmvrBlacb/upDG3PMmD9Q5Va8K9GYlIBPIFi+AnOCSIE8gI/UK2EbEkWX+/i7k8Z;4:3LumymVk+5fC0KZ2kaunFi1eAHnGA2h/bqSi4EnO/XCR1LkmhmmJeZRbORFWXuICR5LTc/WLqzDN140kwpe8zWpAB/8SslO8ejsVGIRANxpKLWDl9mweir3b03pSHbgBuesP9GBhmh05MJ5RkMdLDhFGT3Tgwf2rMSYYmDkEtMTNYfZrQWz7n8UR6LOa4QYfbtIZFhnHUSvOBWifHcrhvXRw/FduFiXWnFxqcaobjU1V4T6qf8JcbQ757dquAPiEnA7vJoQUuRThQ4jaqRuFWtfG4ZG7wRK6f8SpdyjHY87lQBTjlJNUZSbMeLOZWdWE
X-Microsoft-Antispam-PRVS: <BN7PR08MB4932E63B6024A82DE0EE9DEEC1550@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(376002)(366004)(136003)(346002)(189003)(199004)(68736007)(69596002)(97736004)(6666003)(6512007)(6116002)(1076002)(50226002)(3846002)(2870700001)(4326008)(8936002)(2906002)(486006)(44832011)(6486002)(11346002)(1857600001)(42882007)(2616005)(5660300001)(476003)(956004)(14444005)(446003)(52116002)(305945005)(316002)(81166006)(478600001)(110136005)(54906003)(6506007)(386003)(47776003)(26005)(76176011)(66066001)(50466002)(23676004)(105586002)(7736002)(53416004)(25786009)(106356001)(36756003)(16526019)(186003)(53936002)(8676002)(81156014)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:pburton-laptop.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjA4TUI0OTMyOzIzOitxZ0F5aFpFUTZKWWc0cHo3bXJLVVR0WXFN?=
 =?utf-8?B?WWwzNjBkSzlmd001QU9BMzhtUGVGdFdWVWJETEpmVUNoY2VZL0M3N3NSb0p6?=
 =?utf-8?B?SUo1MjNZOTF0SHd0Mmhma0huTkRwaDJLek4rNGxNRXlyTG5naTlwSmJ1L3lD?=
 =?utf-8?B?YSs5aERmYlo4ZTR0VkVMbmVQQWFMeE1FZThmdXZtUTg1WDVCZXo4QmRBYWZI?=
 =?utf-8?B?V1VpdmRpTlB6cGdEWExYQjdUZE5meUVUb2tEYUM1cllEM1ZoWHY5WmM5RG5Z?=
 =?utf-8?B?N29RY2tEanRpeWZMb3hmSmVNM0cvSXNJaEdzNTNtVU9lcmczMmVxMzlxTHNa?=
 =?utf-8?B?UHdSSEdZNDJFN0xVSjRReDFwRFB4UHc5Nng5aCswdGVtWDI2dkJ0aVJuTjNB?=
 =?utf-8?B?dXlwUHY5ZE10TU5PMVN0bkFZUDNoNnRvY1A3ZGQwSWR6WndLaUh0NFk5RXow?=
 =?utf-8?B?TnNVaEVPVDNmMlFJWlJBK2IyUXRwYTZVL01pS1JqUzlmbm1lTEFrSkNVTGJw?=
 =?utf-8?B?aWxSMVVOaXkwTmYzOWtuYUZNQU9ZVERHV2tIeHoyM1RwQlRocU0wTHdDcDU5?=
 =?utf-8?B?WVF2alA4TjJUVllaM3NFQUd5aFBOVDRjUWJRdDA4SW5YNHVPMWNPdXNTVVgy?=
 =?utf-8?B?bTdSNTRCWjM1ZHFJRUJFTlBPZUx4dUU0Y2pmeDFsNE1JOVdiYnMrcVRhRk9W?=
 =?utf-8?B?RnorUEZDMExJKzNxSTQ2SGhlR2VrRWpVTXNQbFVFNlNOem1aS09JU3M5bEFk?=
 =?utf-8?B?YndPL0lIdFYxLy9ObGRqQXczenNFODlwL2ZrYVhJeUF2Mkp0ZUFlYU1FOHJH?=
 =?utf-8?B?MDRPVHVGMVZ2aEhVK3E0Vmxua3ptc08xNUMzeCtmRGh2bGxxLzc0SVFPNGY1?=
 =?utf-8?B?N2NTVkpBRDIxTGFLNmxrVUpWbFRwT05YL1hhb3pueWFNV21BVDB5Y3dJYVJr?=
 =?utf-8?B?TnFnZHdJTGdDMDYvYm14WG5aZG95OTZTUFFkNFNkWnIvSFk0emQvcUhGVXBn?=
 =?utf-8?B?WGdpSGpWSkhiSnNOdFlNaXRFVjMzVUttdlgrVVN5UUNHMndmWnFsMGpFK2ZK?=
 =?utf-8?B?cFcrdFFETlJUK1JaUnV4VGhRdWczQTJ1VkhWejc5WTRnSEpzNXp1Rk8vRXV1?=
 =?utf-8?B?S1lvWm4wUCsyT2xRc1ZrT3NHZGxHbnNpM0pZYVFwekJVdE5FS0JxMjRzZGVs?=
 =?utf-8?B?NlcvN3BIS3VDaG5xM2svQnJIdlZSRGJsS2hkdGlVQVNMUWJIaWVEd2VtV2ZH?=
 =?utf-8?B?WTZsS2JGcXdmVlNUTlgxNW43RjFYcUc4MGNHUzNQSGJORDkrblBBemQ5c2Fu?=
 =?utf-8?B?QlNWUDllU2VNMWdIZXVXZlVZVXdYRXJwNlM2UTZnak1HbEN1OTRRRzJBRitD?=
 =?utf-8?B?MThNTVdzMDUwM1VWRmtXaHRHekR0RUdSL3V4WTczeVF2YlZua2dhYzE1UHpk?=
 =?utf-8?B?UlB3QUZ1MWFzTlhyYktHODIwTVNSWXovM2hzOFFHUFpUc2RsTUdnSHozSXFW?=
 =?utf-8?B?cHFudU5lVEVMSWszYURHazNyMTFCbGVxSkxTVHo2UjQ5eHFKMkgwYzkrNGQw?=
 =?utf-8?B?QlV4cERKTXVqdVhpcU8yRGM4NjhJeHdtbGgwdzdKT2tJREVtOTBoOGpVamNX?=
 =?utf-8?B?U1BJSTk4R3dSUUdoRXV2c0JEZnJIbkVKMzZ6TlJVdFhtR1RLUWFydmZ2bWt3?=
 =?utf-8?B?QjRMZGpjWno0YlZhZmxPMUNuM3E2czM2QVlsUUdTUGdhQzBzQ1loVVNuUlF0?=
 =?utf-8?Q?KnYAk8mklbrwvaw7XT03Gf/a1XuA/OmCENa4g=3D?=
X-Microsoft-Antispam-Message-Info: ++rBMxfh/wsa/u4RKx7yiKu92MhfeQEzFeesD4Z+lW9LbtGIOi0KBjnb/opf8IG50YxHBQBdL+GpodcfUYp+ysOAr2FCrbTqNJOxQ2cjg7Ms2CEv2SXXL+gA1a+N948RwL5OEm13CsJlvGTi5PXNbpykj/S9DKzqnprAsEc4WbUwzRviMAkJIpas3ZejuqJaDgOVh3KYbG7ogxqOZgJ8WZYHiTsIe6/ft6vs8U04CQc2ePN2V76Jrz+xA08KOqAYdUZ7DColJsXcl8AHpVJkjOGtX8uZQc7cueRx3WfBOvLKqBAemOuXxJgXXr+L3Hl9t8BLk9cKmqjCzqVSVt2DxuDfWtQXpWam7xc9k9xOpOY=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:Y0pKQuarMHjvPB2Can4N1E7wDwPMrBg1C+XOTDULOVvX6Kf1VG7ElSMplxxTvgg/oFVF7dUdMY4e9lr9oztGzvstGAeSfryVnoMrZFakZfv0i4j5CXGzXVwuLd9Se3pKgqFHY11pGNyt47QjCg92+uX/iEjxLAblAzlTwl/kxGAZxiq/iAqwCVU4zgfZqaohuDyIxPq5OgE45wFXusr2ThmEbIT0Q406t1xoiEdbgpUoXE35x2OKsx8HPH85kThkMfBmVcNgnOtklRB4q0EGYRSaD+2CxjyodqV09cqEznoHnhdS1sGhFg7ohb07WppDe5zHcSNXnB3njYslZqOC6JwJGSZr7zSgUroz9x8mhH1HXOMGaemtCl7SUEFwBovIcre/9FUL6xtueqa345yKCx3sA6Xj4hid/himfAoruh+fOe1hl9SjRNPuNin4Ii5L1uxEfwyhGGhWqbCI0lUeSg==;5:u6pvcUxZCf34bpGxoKkMcwfp6iWC7pQJTDaRBujg8DD0YpSetUvrXYO6FciL4d46MF+9gAHrAG82c6kb1btFCtmJl2WShsg1OAtg24G29+hn4HY4wNCoX++C290fNNZPyxFSjyfOgKjUqYudXob2rMsXhTNxvx8xMQsG7iDnaxY=;7:ySABl7itfANS+YSwB785YMK26vxk0efY65CTNTFlzZH+wmNynYtB77gVPlCj64lSvEgZmK6o1CE1fbUfsPIho1krGVCOpSoCCN7gIadkQZJ+MG9zlHqVGF3GOuC7NynXw+gAQt/gFaP3iY5fKh0qybiAL9rT3f1g/286z2rQZenI3dE1HH6TWXofexoZr2+KwXOdkC+FV4CV1Oa1FB4ZWSh1LOWVqb+CCm4LxbCWfD9uT9eytDaMtVIdhHRr5G6/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 18:10:25.4924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0cb673-0164-44b2-93e8-08d5f190bb40
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65090
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

The binding for the cascoda,ca8210 IEEE 802.15.4 (6LoWPAN) device
includes an extclock-gpio property which does not contain a gpio-list,
but is instead an integer representing a pin of the device itself. This
falls foul of the gpios_property check, for example:

    DTC     arch/mips/boot/dts/img/pistachio_marduk.dtb
  arch/mips/boot/dts/img/pistachio_marduk.dtb: Warning (gpios_property):
    /spi@18100f00/sixlowpan@4: Missing property '#gpio-cells' in node
    /clk@18144000 or bad phandle (referred from extclock-gpio[0])

Extend the checking for false-positives in prop_is_gpio() to detect this
case in addition to the existing nr-gpio case. The false-positive cases
are described by an array including a compatible string & property name.
A NULL compatible string indicates that the property may be present in
any node, otherwise the property is only allowed in a node compatible
with the given string. This allows us to whitelist the extclock-gpio
property for the cascoda,ca8210 device without allowing it anywhere
else.

Since checks for false-positives now have a little higher cost, they are
moved to after the detection of the gpio(s) substring, which the vast
majority of property names will fail avoiding needless checks against
the false_positives array.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Jon Loeliger <jdl@jdl.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Andreas Färber <afaerber@suse.de>
Cc: devicetree-compiler@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 checks.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/checks.c b/checks.c
index a2cc103..c76e312 100644
--- a/checks.c
+++ b/checks.c
@@ -1254,16 +1254,17 @@ WARNING_PROPERTY_PHANDLE_CELLS(resets, "resets", "#reset-cells");
 WARNING_PROPERTY_PHANDLE_CELLS(sound_dai, "sound-dai", "#sound-dai-cells");
 WARNING_PROPERTY_PHANDLE_CELLS(thermal_sensors, "thermal-sensors", "#thermal-sensor-cells");
 
-static bool prop_is_gpio(struct property *prop)
+static bool prop_is_gpio(struct node *node, struct property *prop)
 {
+	const struct {
+		char *compat;
+		char *prop;
+	} false_positives[] = {
+		{ NULL, "nr-gpio" },
+		{ "cascoda,ca8210", "extclock-gpio" },
+	};
 	char *str;
-
-	/*
-	 * *-gpios and *-gpio can appear in property names,
-	 * so skip over any false matches (only one known ATM)
-	 */
-	if (strstr(prop->name, "nr-gpio"))
-		return false;
+	int i;
 
 	str = strrchr(prop->name, '-');
 	if (str)
@@ -1273,6 +1274,21 @@ static bool prop_is_gpio(struct property *prop)
 	if (!(streq(str, "gpios") || streq(str, "gpio")))
 		return false;
 
+	/*
+	 * *-gpios and *-gpio can appear in property names,
+	 * so skip over any false matches.
+	 */
+	for (i = 0; i < ARRAY_SIZE(false_positives); i++) {
+		if (strstr(prop->name, false_positives[i].prop))
+			return false;
+
+		if (!false_positives[i].compat)
+			return false;
+
+		if (node_is_compatible(node, false_positives[i].compat))
+			return false;
+	}
+
 	return true;
 }
 
@@ -1289,7 +1305,7 @@ static void check_gpios_property(struct check *c,
 	for_each_property(node, prop) {
 		struct provider provider;
 
-		if (!prop_is_gpio(prop))
+		if (!prop_is_gpio(node, prop))
 			continue;
 
 		provider.prop_name = prop->name;
@@ -1310,7 +1326,7 @@ static void check_deprecated_gpio_property(struct check *c,
 	for_each_property(node, prop) {
 		char *str;
 
-		if (!prop_is_gpio(prop))
+		if (!prop_is_gpio(node, prop))
 			continue;
 
 		str = strstr(prop->name, "gpio");
-- 
2.18.0

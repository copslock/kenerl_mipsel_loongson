Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:36:17 +0200 (CEST)
Received: from mail-co1nam03on0062.outbound.protection.outlook.com ([104.47.40.62]:11616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992533AbdIOReDtoxdM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:34:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=30Jdfaebi/iXenPtSDaBdNNvdTHoa3osSNDKaHeEClw=;
 b=mY2s3W/au7vbjpoDAEwRzaMyrj4Df4NFdaREY3oTzAswtPpi9PCVOnq3Hzg8ws+jY+o6Q/viqLYs8fpKquMzeZQfTYY+DSXJLZdbY6ko0TiQY+mCxavc0BQZmh8XSiWxwjDMy7FSsIgg6JEhQ4q2m+7HgPUI/+miEYZkRVl4uC8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 DM5PR0701MB3800.namprd07.prod.outlook.com (2603:10b6:4:7f::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 17:33:55 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 06/11] MIPS: Octeon: Add Octeon III platforms for console output.
Date:   Fri, 15 Sep 2017 12:30:08 -0500
Message-Id: <1505496613-27879-7-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
References: <1505496613-27879-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: SN1PR0701CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:5173::41) To DM5PR0701MB3800.namprd07.prod.outlook.com
 (2603:10b6:4:7f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e836484-c2c2-4620-2df9-08d4fc5ff0b3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:DM5PR0701MB3800;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;3:xuiY3xHK0eQQ0BAxlrFMgmUi5clJFTueMSzMaCq+udQ0acaGVk/5u+OWJOmklqPHuKjBefQmAdFXiKaJOVBK8N0JuwZk/o7/fvaA0qAIbPxcEwsQqAfAV2rzL9RKbkk8dEm/hc++bPOzXgGUuhpHRdVaEIo96ItHmmH3GZzx8InOt6Sq5KTCXSXn1MlQqw4pJXezEz93srrHQMo1U10jdb9BM8kAJjHrsPrLd44nQtOdF6DMCCoYhldPW1LIx3De;25:mSjCNfvJ0V/BxJN5YpJlc5LL2yPyj34VdlcEHBzm8bCACYkp+6bJJdsosemMeS6b9BsC2XqRJUU529weYMdLddtS/8gLFg6ga5qp1EGFVjSzKoBMnVILZSzU/w/wWbqsD95sRg1uAQKT/gXNmJyoZ2TbPirMct3xTOz1bMA1fntTRHoAQ4xSF/37VT84//MnXwJAr8kyq4EO9/8ibtqzHiMbrd5RNlGBwCyMbIbkhKQ5zezpYE7x17+D6xqZ1so+l6WWDQQleArfiwExcBlFvZZUxnHzqCTWTuOGXIxlKCsb7lHMAbzbd9dMQuZElvpu1YES2jwEOn+3MefmXVGo9Q==;31:f3N/FBJTqY8BcSetAZQIVLutJqnmp9BJSgh4zFSM4q20ApKH44VWFrzTiBBI7UMddVBknU4cs6LyVdc4a7lNR+9J6XXjsiiA+qztLx5pU8XZKwzu5TC4PbxFbecwe5jXtWs5xxuqNiZOe9pFD3sArFTg44jbI/mAGQMlcibZwp6Uiqi6oS1jaLzO3+u7suxwKpHyiEAFGsvet1mbaZgAlvGpY4+MewiB85h99sfZiOw=
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3800:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;20:ra9cCB66n1uIZLwjiLtOh0ZxZxiy0K48FS5D5fAfCKl1RntEq1fOeFqVI3z8oym5KGqJgrTHVCmB+XZj26OIjYHvyC4yTq5EV+TnJ/wWSBRlem/SbV9MpCuqdN8LPSdQHnnhFIHsvHl5ZtAzJgMJDd3M0OoEE5863Y9LRT3+VvM5aYUF9P0JPpk+sd4kK7rppn1Q0wfldcOFGRPnYzm62SRK1qmmE+FPuvDcHIN0aXvO8/0c0fOHBRuI/Rjk9o++Gb38B9+lrocPv5UHpLzdSK5vE5Ss5tj4R5TmIAKVFLPvEUjYmjxqe23r7CLWaUDtu1lUsquueohgaO+emZnh/8Zb3Prb1pz6G16n2cxOzhdPa5w560cNU4XW04s91cWk++W4izSN60XhoiggYACZJZTg7+sqB9VL9rbQlePtQ+Z+2eRddXwTySDHud28TczhuQVGT8DK8v79SGngP+eImQr9/sMxE6R3Y5U8dZWbMAARj9rfzaLWxe2Mx2YTL9ea;4:MpWRGJZ/rW4r9OVsQURkBg1hnjf5l1vJ4cJF7g69RyPrKFHmWTk/11ytltfWLbI9hGbonQ1nXKwte7Hz2lZ+sKVKg0dUYbKQPMOCpN+gVLci0javaedNUpnwuE1lpQqtk8M20L9Q0q+miktJaPhmVfLX68dczpPZ54jZ3SVGcY1KWeL9BAiExo4w0YpJ74DGsvGncoCEvaUjXb2cOg7Z0e7Qxao5Sk1gomueNCiyG2KJV1L+jLa9+HZf8aC3vwmn
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3800DF4C87E8B3DBB3D95772806C0@DM5PR0701MB3800.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(10201501046)(93006095)(93001095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123564025)(20161123560025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR0701MB3800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR0701MB3800;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(199003)(189002)(2950100002)(33646002)(50986999)(68736007)(53416004)(47776003)(76176999)(106356001)(2361001)(105586002)(2351001)(66066001)(48376002)(6666003)(50466002)(6506006)(6916009)(36756003)(7736002)(69596002)(2906002)(5660300001)(101416001)(8676002)(6486002)(305945005)(4326008)(53936002)(450100002)(25786009)(189998001)(97736004)(86362001)(8936002)(110136004)(50226002)(3846002)(6116002)(5003940100001)(81156014)(81166006)(72206003)(316002)(16526017)(16586007)(6512007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0701MB3800;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0701MB3800;23:9Uu1yyGbQGShuZ6PVGQkMopg5DKzNtag7uZxpMQ?=
 =?us-ascii?Q?Q6opamtw9xUtiCLLWsoBi/K2QI9zWBDuOEEr+bTnxOK1SAybJ/X1QEO9FXhu?=
 =?us-ascii?Q?t2tUDFGAtcDryAtUxhj76ccs0pXy/6i2FhhG4hctWEABnoo0oB9PCnJyHYnv?=
 =?us-ascii?Q?Zm6qKHnEJICQou/xhV1Wi4Ws5poCUs1voLetDi5gRV/2Uj3xxtx6VHW0TImM?=
 =?us-ascii?Q?dX3x8I7pkUVR+VyS9fP4bqYwwSs4SXD0Vgc6JAKQsOH0DcQosfNJLScV/Ig6?=
 =?us-ascii?Q?+bxTgUONYUdi7OpyQPr+HikileW73lb43oKMBOW1Ya8UCxqH60thqsHkEGUE?=
 =?us-ascii?Q?sUs5XXaWJMkrYZTRbPlc8ob59OwWycqZuwvqr2X7WDl22HkGmAbhyI4lo1Gf?=
 =?us-ascii?Q?2PN3FDZVtVI9ZzOo3+iWaTEzUIx4rKpUW09olzd9YiChPO4s/mDMHlr0BW5L?=
 =?us-ascii?Q?BKZGkiEusXXH/DvtN4WV+mLYcevmbEJC6oY5ruPWv101hDyXSKPj0bwq9nXi?=
 =?us-ascii?Q?dVnITbChihXhB6WA7FM7LoLRJjIDgUsVQnXlpq8aL0KIuc+nz+nSlMl7VpMZ?=
 =?us-ascii?Q?sGKmvP+3zGUACUwWXgH/ZMFyuX4dOLwVDY3i//2DMD/0BLJ8uW7pfK04G5us?=
 =?us-ascii?Q?dmUaNGMRY8i3KpPcJcXFQEhttGliL1NsGgjNmtwjYZCLSpMQM5TgA8De9kyt?=
 =?us-ascii?Q?lrnni16g2g+DFQ94WN6tKiXybwUPi1IpZMn5GesKA5Gmd7SC59DzO0C1T7X6?=
 =?us-ascii?Q?f6SGFdATxIvka0OvZMMsowFF1TfUeU25vgpOvv7vkb1fvACAdlF8UUIz12c3?=
 =?us-ascii?Q?xLxvWPbw0gwUZjtPp99M5xAFxncKqlByBRTwDc0+XBYNAUBwLDNstI2y0COK?=
 =?us-ascii?Q?1zxGocRujDT6pNW2SNXzfyDHyN+4Or38BEjS5XA6uWyQVeY60SQc8Mhgzt7g?=
 =?us-ascii?Q?2pYi8W0K7JDXXaL1X1iRqDZJ97+et3APST6T4gMcSZflMSsabkkPvFSwUnxH?=
 =?us-ascii?Q?UE24haWTANkJcc8yIavBVu8A9OK/d0MGDzhtwsUuIwc7YgZ3xDNVHl6/QT69?=
 =?us-ascii?Q?GUZghTjX2Uxt7qZONf02frMALind07SK21lUMNTMzC0bEI0xvQL5qTPUm2UT?=
 =?us-ascii?Q?WLiE8H9v6L8MWbAoBgrWiFgTkljwbkHoaC26gNV27pIbHtUb9FdTJnMrdkdK?=
 =?us-ascii?Q?NAoT4nmXEloB8mkUGln9i0ArmEweJqJqU65p7?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0701MB3800;6:H6Z5s66IK4uAJSCeRYw2trY1ZigKw1dAQGwDyj3QQGqguS/ytY+Cd2WppIimMGkvi86fCRO/PmPfnifQzxFf20PvgzF64ooYRiHxRBv1U14mfqvMt3TGFJeAW4F7wiC3AC04+/3rDVGgdYegqbsyusFGuo7FWoAUF+dgV3kiZJLwv0WGyEA4ZG5nD9VQkoleUkMrAuF/9WyMKOGMkZs2POlrZVvKpq8cWNp43Qw2JYwPPf3+i39AVOMLagzDSAzpTXD70O4WU6IPb2nvtIHiqpWVaIwYPUEILqxWUGJflZEY6xd2weSEklr2VlZ11Xq4biZFDQJ+NAgiOFGBRh/9Dg==;5:bIY+Pg/xLpK0AOvHh16hZHN9Y02E/Dtln6ooC2/WFdoc8KZGIFVnLcOnJOgDWZrRQlIAm7LboShbfmB7pH3XykqiT7gZnGIxawM0+bQByDtYjw+KkxNaNkkiVbP74jsmID+AICmvMk2D0XoL6np6Ig==;24:QpSMN8Biauv/8gKh3pAC8cn6GVm+LeSx3bz+g/s/O/zAxOwpCKLFYcWEnBVt+JzRIjeNS/cR+p8v5UKrh3Glb9to1IQhA/79lRrsXYUXz8Q=;7:qEUZ5UDsmJcpC+TSwdvSkHsWEnogsRt7AnzQn8Ck2dyOke/pmT86JtYrUF+8LNUuPM0LW0UQhg0y/4OvY0eww4XNI0iM2S+qIPDltj2DYBZk7H5LHXsHhJnDiviu+Trb4iDOB76lzzdhAq5uhX7jSXeRIF6nxiktI07mVyOV5BBVy4WaEuW7ClveK2mqwU+c4XFxG5qCh/k4TKqfREp2YwSCITyR6VQ2cUTo3X6Qqj4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:33:55.3168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3800
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60018
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

Support Octeon III platforms when printing out the model and
SoC information during boot.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/executive/octeon-model.c | 53 ++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/octeon-model.c b/arch/mips/cavium-octeon/executive/octeon-model.c
index 3410523..069a996 100644
--- a/arch/mips/cavium-octeon/executive/octeon-model.c
+++ b/arch/mips/cavium-octeon/executive/octeon-model.c
@@ -67,7 +67,7 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	union cvmx_mio_fus_dat2 fus_dat2;
 	union cvmx_mio_fus_dat3 fus_dat3;
 	char fuse_model[10];
-	uint32_t fuse_data = 0;
+	uint64_t fuse_data = 0;
 	uint64_t l2d_fus3 = 0;
 
 	if (OCTEON_IS_MODEL(OCTEON_CN3XXX) || OCTEON_IS_MODEL(OCTEON_CN5XXX))
@@ -453,11 +453,13 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 	}
 
 	clock_mhz = octeon_get_clock_rate() / 1000000;
-	if (family[0] != '3') {
+	if (family[0] != '3')
+		goto out;
+
+	if (OCTEON_IS_OCTEON1PLUS() || OCTEON_IS_OCTEON2()) {
 		int fuse_base = 384 / 8;
 		if (family[0] == '6')
 			fuse_base = 832 / 8;
-
 		/* Check for model in fuses, overrides normal decode */
 		/* This is _not_ valid for Octeon CN3XXX models */
 		fuse_data |= cvmx_fuse_read_byte(fuse_base + 3);
@@ -486,7 +488,52 @@ static const char *__init octeon_model_get_string_buffer(uint32_t chip_id,
 				family = fuse_model;
 			}
 		}
+	} else {
+		/* Format for Octeon 3. */
+		fuse_data = cvmx_read_csr(CVMX_MIO_FUS_PDF);
+		if (fuse_data & ((1ULL << 48) - 1)) {
+			char suffix_str[4] = {0};
+			char fuse_suffix[4] = {0};
+			int i;
+			int model = fuse_data & ((1ULL << 17) - 1);
+			int suf_bits = (fuse_data >> 17) & ((1ULL << 15) - 1);
+			for (i = 0; i < 3; i++) {
+				/* A-Z are encoded 1-26, 27-31 are
+				   reserved values. */
+				if ((suf_bits & 0x1f) && (suf_bits & 0x1f) <= 26)
+					suffix_str[i] = 'A' + (suf_bits & 0x1f) - 1;
+				suf_bits = suf_bits >> 5;
+			}
+			if (strlen(suffix_str) && model) {      /* Have both number and suffix in fuses, so both */
+				sprintf(fuse_model, "%d%s", model, suffix_str);
+				core_model = "";
+				family = fuse_model;
+			} else if (strlen(suffix_str) && !model) {      /* Only have suffix, so add suffix to 'normal' model number */
+				sprintf(fuse_model, "%s%s", core_model, suffix_str);
+				core_model = fuse_model;
+			} else if (model) {    /* Don't have suffix, so just use model from fuses */
+				sprintf(fuse_model, "%d", model);
+				core_model = "";
+				family = fuse_model;
+			}
+			/* in case of invalid model suffix bits
+			   only set, we do nothing. */
+
+			/* Check to see if we have a custom type
+			   suffix. */
+			suf_bits = (fuse_data >> 33) & ((1ULL << 15) - 1);
+			for (i = 0; i < 3; i++) {
+				/* A-Z are encoded 1-26, 27-31 are
+				   reserved values. */
+				if ((suf_bits & 0x1f) && (suf_bits & 0x1f) <= 26)
+					fuse_suffix[i] = 'A' + (suf_bits & 0x1f) - 1;
+				suf_bits = suf_bits >> 5;
+			}
+			if (strlen(fuse_suffix))
+				suffix = fuse_suffix;
+		}
 	}
+out:
 	sprintf(buffer, "CN%s%sp%s-%d-%s", family, core_model, pass, clock_mhz, suffix);
 	return buffer;
 }
-- 
2.1.4

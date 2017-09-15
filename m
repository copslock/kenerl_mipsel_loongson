Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 19:06:53 +0200 (CEST)
Received: from mail-sn1nam02on0061.outbound.protection.outlook.com ([104.47.36.61]:3407
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991438AbdIORGpFiQuH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Sep 2017 19:06:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oNhB4/w/ogjiXjLo0NuhbAkpVmQXsiZ/us1AOidBZA4=;
 b=l4jGo01s61JwvGJuWrAvceZATknrJNiWrr7ZyruoDmv4SA7aCR/B+py0NNEeTb6huJO90pUJ//TQzAIJqQdJvt7UrW6/6j07SxZglGPNzz56qeUNMdW0mcx2QgImKkJQR1Fe5wmGwjkL2HWhIk/JBqVdecZyRL9zpOt9p3cIJQw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.9; Fri, 15 Sep
 2017 17:06:33 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Remove unused variable 'lastpfn'
Date:   Fri, 15 Sep 2017 12:02:55 -0500
Message-Id: <1505494975-22887-1-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0092.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::45) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bbb2862-131c-4503-310d-08d4fc5c1e7d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(300000502095)(300135100095)(22001)(2017030254152)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:5MgDRShBhXAeuZjd821d8U6kjX0X/3zOPVK6bkC6Cdy9bK61rUfHvPbhC5kcTQPN0LbFzrMt2xb1dQ4DH67I2S4dNyNl+QKJQnwaYlyumEv6/X9AL49IZ0Sqm/RPqfP1a32ZwoPq5zLVzvCBSluSpuyXWjhAEYmVDN+4rd+Nfs+MgGErQO14CDd7vea9QkojqjTFer1qCsPRKVNQZPlImZfuJTHwCAvSF1UzWC9GL3/OwnMEcDpfFK2nnn3yxUvl;25:XXpvMpP4hKBbeh6Gs3s0o69aorR0aMM/Z47pnNTlfBT9wwIUKd47CJ3aejcops7p7MbREP94evuFq9oPI6KJREUkporvXSoCHt5xgME6ZvMt4HhmkvRd5r1nz3OyJxyfqhFRqvOnYOfX6isuMt26EVejiZ/oga5YK3NRoi2IaUOKtgPuetogreQUHcfDmUU16mIurJ4GxyC0PVOMkA5P4FQXF+pricXErgiWlimvwx+dP00cLUrtjHZvapK30VrUsORqMK8iymkxoHfzVH8ydl9d+G/ffWlIk0OW7EbuRF215pevhgej572tNqN3SL3oaToaRKJfDE1wj/1tZUS0RA==;31:UWPtvumjU/OX6Ml0LhG4iIgDT2J4+D8+ksmQOvwolUdBywsK5kzHKcFnSQluckCkpFU0MMpMw540u2WXD4w7OF6LjBd7TT6dMsG0xc9E72pPK0M+NVwgOmpvX23xDOfR4b7C544UX/5UZ6TAztVDIWqx9/ddHaNoqUA96Beo1jBHwmdvLzz189c+WD8HF57pwHUtoPVzue57YsebjzBO4dLHvyqr+49Ja25rf3j1iNo=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:Vrwf1Og2ap37wv3eerS+jaOX9puqXRHayBtastm/azd7i0cHxkmXGhpCwyXMkvy7+iZFvctqv3CpvwpjzPzAltzOMF0aDSYBOw3Fys3rYQuNJGuLQ9X0dM9gpkVww6BFQ+TpHeB0UDzC3mbWG+V2SXMo2R/ZF5lI6Uut3d5mQPr+Ni0OO42EJOWpHC6A8QgfmB6Xx3MviE8EKlq6461knz/9TnTC8A9XJZwEZSV8qK1FPkvinPFm/BYOGNL8PMv2c1zkPPkwATmxIJJQUnv+ZkEfgBAlXOv5GSzm4XDF0lDfQXoYhhIX4hilTUyDAQ+ihDNRxJLwun5+qCU3mohTBrckU4g6VOYvf6ArcA/pl85YUeq9UvIjcHP18q1Cwl3oaQrmtPVaNCTYQqqJSQyRVUt9MOr3Ya7NFk37Fv9erqhdjf4BPbZjM7BIdOP1maxmDshEcR9WpfCUhPvbTOc7kGud/cGrqHo3LcjajmLR3JscsBcSkyMCJOckKxGWrckD;4:eZnqpH8WjqWuno32AR8ph80RwZ0L3jAWFtUJhceGJFBmmmXTWk9/VtH3t6eDKJLnifPYgMorNrh4Qw3TIWAZReUAQJ8WqcLUaEMQxRVovWiLH/lnCjEZJ0fGqp2qQ5Qq7xXYGo0IM3Vli0/veBhiLXQ/BNfi5npu2MjLI1prPXaZr9lTsYWpR+Yzrki6QH47gAuYlhFR1MApESgiIiEcAkwI1Km/G63SbZHkojgRMAPLQGF2z+YrrwUF7iSNEimv
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB38031D11735C39C75D0E1082806C0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(100000703101)(100105400095)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123564025)(20161123560025)(20161123558100)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(199003)(47776003)(50986999)(2906002)(5003940100001)(189998001)(68736007)(101416001)(66066001)(48376002)(2351001)(50226002)(50466002)(106356001)(2361001)(105586002)(33646002)(53416004)(305945005)(8936002)(4326008)(7736002)(8676002)(81156014)(81166006)(72206003)(110136004)(36756003)(69596002)(450100002)(86362001)(6916009)(6666003)(478600001)(25786009)(16526017)(16586007)(6486002)(5660300001)(53936002)(6506006)(97736004)(6116002)(3846002)(316002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:SbDgi5fRlB19jLhWyFrs7Y5g3WbAc085dGDc9pU?=
 =?us-ascii?Q?wQCsDtVpye2HchDK3v5HML1Ct8Vwj2ClmH1NlGu9fzb3IO2OhR/MdEX4ciNW?=
 =?us-ascii?Q?kN7yDu0kegT90qnkZeUi3E8tNLF8hlSBqkTHsme+Kq2epf8ml2mLZpJoL5U7?=
 =?us-ascii?Q?SCGlDuAkaoIUoksJYxrE0VLElRMywWeV19VbYrKIRLp5ayiKTGneqAyIiwHJ?=
 =?us-ascii?Q?g4/eD3ERp5uiS0KzCOcQmwt0Tdim7/svGoj6lGqv4vSkZQe8OtG8xQKBk6WV?=
 =?us-ascii?Q?vG+0+Z+dOAGYA3iQx5yaEoY+nX8HuRc7tPcRk+/vrJHLKnA8+WJqPIe+JuAM?=
 =?us-ascii?Q?1KWi94iTYgKtexZgUnQ2UhOSZVnn23yMzzFEAg8t53U5ijAAA7GyYihBgoZx?=
 =?us-ascii?Q?mRCBeF7bw4rd4hl9fambYYaek6Q4/fIyN/x1+/GE3yuuv8xxH9FRL0s7I1Qo?=
 =?us-ascii?Q?1ZYq6bPf12hmasnNJZn3IFNLnsM2snAsJF1dapyjx+nzvHKYy9+zhql0YK0J?=
 =?us-ascii?Q?xmWGdc7srElxB00i7sMqEGBw6M729qqWqnx9UzlEvC4i+DNDpJh3SXRzms3u?=
 =?us-ascii?Q?KGNtbuSebPeAFQqOpyvXKi2KOJmLm3qLXgrqscsiKW/TkmfO2s6usImyWzki?=
 =?us-ascii?Q?MVn1tPSStdJLnFf50NUUt6Z0jz+FN3Teq+MZibdOSoS9TAkqOeCGDCj81cbP?=
 =?us-ascii?Q?ILTD8chxYHdGDhGSOyblH91shkxzVmdYAjdo5fn+Xf/d3dyF160TYjcTwP/a?=
 =?us-ascii?Q?3HbH+fjJQFRRfJj+JSJHwuvD17+Fp3xNOG400J+vmHx0l50janvCDGdcqeCa?=
 =?us-ascii?Q?jd6laQst2L5ISo1tlREbi6grdWxz798EJPqdvrelr6uZVVlW06B65CmfgpAj?=
 =?us-ascii?Q?6aU2fN9eJDq/t+dcR+unb5Ln3RegS6jqO7EKfi5eMTD3wEbzckDIjxB10YEe?=
 =?us-ascii?Q?ataUFDvJ8Bl+k1F8XxmI14HxHpBbsQcZPEhfOSompUR5Sl4nmagxMzPIfqGG?=
 =?us-ascii?Q?ib7lc9kGBPEGQCEonqOmJPRgi7IMLdvobsqkSSaltA8Kf1VeAlqmoJxbjAL3?=
 =?us-ascii?Q?htwx+BvqVZGhXeiz2++Q6SDqmiwx9xO41Vszds+q+cbOvRep5Q5Ssv0X0QWc?=
 =?us-ascii?Q?o3gyiiSDq1XCwW+ZR4GTm1ryhTB/iq/XwKKGwwq9KJNl4Zob7HnTMag=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:cH07BVclWpLPs6sxZZtsvZAy/F096bhVx7F+J5pv2OmJSnAxfjNgM+jT/OXK5TBvGgFb6WAitORZJx+0jFO7KqoSFdZnSrM+RkTLxhIdSDfs542NPVeyn74ZpToXQzXUw4Ofa6T8JGtntg/pQIX7fWRaM5064s2hp4xvARhmledBuR+rKd9UUqM5TzNtV4o2x2MtGWIhNv1eQXDzfL6zCLyNF4Ne5II4zRJXTtQ0hk70x3YF4dI/RTUBDN7augQlxdNsxH+2+9snSGdWyN5SmIBnUImVcGNSuAcEpNbrOkyYOeZX9XRXg9F+dwXpIXyEAVAU9lcHCmx9m2UMbZjPgA==;5:6+PUAQDDPfowwaTkQ6FMWQQgrMkO8er6ycEr4L3VVJOhaCsZbtQUmafDZ5j0oqMKZC3/WKnDBfXBwCQBDz8G3tjTNnTAsvF+WeN86AHuhkqcp/VPGNs3ViHlf+iTM5VW1cTMvsxBuh8uS7lUg7NGhg==;24:15MFY4kL0uHYwsJdAqSqvNKcOkgyvgle+Kx7QWvOfTb6F4cjvxPMWOJAtKMpxdh9WygsWYNM21QRAW+GC8I9l5fjKqNMU9Vulhbtt8wUppQ=;7:kxeRcykhwZYL8uWotb7WAOUYDES5JdfueMaAN9PFtOd3Sx/RZdP+H/CbzyANP3H/mWmOOPLdZ8oH/dwslg09JzltU5wX+ZtURvFk8tEW9irulIQlj0fg58zWLhw2qJTClnDUO/Ggb4Y0QjzqcGKQ/+qr0FECAawrbPbfqEgIybh1Lh45oX61RTbCYFapICc3VhtEj9tvdvc49AvzglTv//MRbHbBuVGfV1uwGXjWhIo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2017 17:06:33.6669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60012
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

'lastpfn' is never used for anything. Remove it.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/mm/init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 8ce2983..99863af 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -401,7 +401,6 @@ int page_is_ram(unsigned long pagenr)
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	unsigned long lastpfn __maybe_unused;
 
 	pagetable_init();
 
@@ -415,17 +414,14 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
-	lastpfn = max_low_pfn;
 #ifdef CONFIG_HIGHMEM
 	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
-	lastpfn = highend_pfn;
 
 	if (cpu_has_dc_aliases && max_low_pfn != highend_pfn) {
 		printk(KERN_WARNING "This processor doesn't support highmem."
 		       " %ldk highmem ignored\n",
 		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
-		lastpfn = max_low_pfn;
 	}
 #endif
 
-- 
2.1.4

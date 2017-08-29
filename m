Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 17:44:41 +0200 (CEST)
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:51904
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23995035AbdH2PnQOlR51 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Aug 2017 17:43:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MSNhRv368a9YMLhCj0EpNaGRk3urGlolYLPXJwE8DpY=;
 b=EdIJbFXow0294Fo5a3ZXreVDJ4uXLRsfvH5lbALJngo6x1i9143Ox4cv4trUOfBTDdhlzH2zhD9rotSXs/YcZux/8p+t6RIhJS5oMkmhDR4KdJtWeKQ0dejxIQnVyrbnpM6ZyvX6lWfr0LTqt1MYQgcholpApvSpf/XwP1eirZ8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from black.inter.net (173.18.42.219) by
 MWHPR0701MB3803.namprd07.prod.outlook.com (2603:10b6:301:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1385.9; Tue, 29
 Aug 2017 15:42:56 +0000
From:   "Steven J. Hill" <steven.hill@cavium.com>
To:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: [PATCH 3/8] MIPS: Octeon: Watchdog registers for 70xx, 73xx, 78xx, F75xx.
Date:   Tue, 29 Aug 2017 10:40:33 -0500
Message-Id: <1504021238-3184-4-git-send-email-steven.hill@cavium.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [173.18.42.219]
X-ClientProxiedBy: BY2PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::26) To MWHPR0701MB3803.namprd07.prod.outlook.com
 (2603:10b6:301:7f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea543401-7ae6-4cf8-c8cf-08d4eef49f08
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR0701MB3803;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;3:7ObJK0lwUoOZKMWjvLWWQOWfGXnHOigfxD38jeQZ0+fwcl39hN3oyN4zlps8FwO4vujUey2DVzaiYFAxl7izBqAr6nZ01kwNjxQD/Mf0zqkSGATfkgrFNMnK50lNEI7shDLFuOZDaxw8kFJSPEL8vOLSxTV8yDMcexouZb531Z+OmVOp8ebTjj57z+C2nw91vDJEk+0oMh00VY6EqNk9npsYx73bsE8+6kbHgYWT7PNMECtluMNKhshqZuGjfHwk;25:iO5vNRV+DoP2VNRm4rdJCdBLDz+YMe8holC5MHUCo2h0C/wrJRwtxXypCud9ZfLZ1MK4oWzqAB7y8FZx/rLwEnIEYTIROAYhy3+27vGYfCG3akisOSLO4ZeHGXZ9ljbYpETxiRHwrEAjMVXS0bbQocaqH/0tclJrq/eLFyflEpS9Q0FJgqSea/pjzN1c7+/RydtShsidYUmncJXXIFsMZve2Iv6URzlRnKATZnnEW0Khh4Bsm88wwSGONCQztSUNLz27O3eCO25o2Fnyx2IHi8LINzqcXVZ3iJ29Bus6SdjTjFdB5gL2QrLM3gWV2hv+rOFjlVOl6wIZRhtBj7S8mA==;31:FyX6FaHUCGXhloKJy+xcaIgp47bWcmLyojdKTVqw4XWHxO+Nkv3wy/joxEcGIq+56l6ngZC9fjBdwMzBnXYVtxQTWV+ysLtXVV/gwpkyCeu866bHh5vOTBxpNkzl6UO78VkrOLfMml0B66mUYfBc8jyOZlJGo9ybEJl7brDqNErE9vLrMkizmIYhCuO5r3paK9bjaArTiDs/6AHAOPNYtpVmKCWgqgwRS0eyoBdj5Ls=
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3803:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;20:TzohUCJpS609v/+BXTpHrjLCJZTg5Gb+us67FJunbLzeN7MtDg3TvPIoCSO9bDEqrPm6mrjlALAlOpeAMTQmJIlq+cbfHnYNtxkMJQ7RW0DzmZprgHG03fcdfq2JPU7oRRahj7isiyVCRfBNNGxoJptn08C4hXte+Hn9EpmfZw8f5WGqvXXGbcVdav62uzHPCly80PODQq++iiddSdI6eoiE5mKIntDX0KEHNRJX8FbEYiJYZzVucvj8SaRr/j/rRjImyq/TG20b4V9jXUqkmPruz+Za6z1pxXoFB1tVey7TeIj6TE+IKfYqIvcV78EHXdmfoTyySaMBNSZf1sufGt6WiULtujkdiD3Ua/03HVuXen3QmkYDTIgw31U8L4gKYeR2cF5TJGs4WIx7COckqZe2ffJF2//ULLsxFq3QWaTvvs2rgjBN6yf4LLcKQNDoq8zVZo9Q3+uTogh0+5NV7cuGweNTRghz5lz6jmam02mWdyX6EZ58KmrnuxibPDck;4:AGli5YLpidzUV9QMx9CxSl2SQQN1ymXtJBkjdhuUUMMEsTr9tTi+RZWeIiAlmGJYTkYuDbz+NpbLq0W+gq6Um3qTU7qNGcX21fYKaX7BwGJtnghhBNHSvSUUpMTTYmvty/qovzQku4lTYK+uvZuTEADRN0VqG5rmV7tGRmapJyTKVqPkgMO/OvrbVJxItFMjbP1nzCpdvAC8XYnGQe8t9AzigXGIg8GLWVz5zNl2YC5uSqZcO11pkHjLB2qghDvk
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR0701MB3803E85DA61E6A9753B7C1D9809F0@MWHPR0701MB3803.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR0701MB3803;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR0701MB3803;
X-Forefront-PRVS: 0414DF926F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7370300001)(4630300001)(6009001)(189002)(199003)(189998001)(7736002)(72206003)(97736004)(36756003)(305945005)(5003940100001)(69596002)(33646002)(50226002)(8676002)(81166006)(7350300001)(50466002)(81156014)(68736007)(3846002)(6116002)(48376002)(6506006)(66066001)(86362001)(575784001)(47776003)(53936002)(110136004)(50986999)(76176999)(5660300001)(6666003)(6486002)(2906002)(2950100002)(25786009)(42186005)(53416004)(6512007)(106356001)(101416001)(478600001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3803;H:black.inter.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3803;23:bUCC48d3yvw3LMnRj4li3SNc73A87uWuU3lExUi?=
 =?us-ascii?Q?e2T5fm7Dj0+orAFEFFksoH53GNmJ9lRbj2BP6+ypFL5WKf1b6AOD8pnNst3v?=
 =?us-ascii?Q?/THfwi7s7L/pwcaABDn7H27xjHrEcYbbUKm9fDj7F498jnzy6wWBH7V/r+P4?=
 =?us-ascii?Q?K2HzXDuLOAAICLqZslczuO7/26amGdTx/l6Cxb8INhOoruCV2D8R/4QR1kqP?=
 =?us-ascii?Q?Vxdz21jW4L00rT1Hl3AoAl9Cv1M6ALqISSJbciB4vHjvhYbb/28FjYbz3mYb?=
 =?us-ascii?Q?PsBHndnowa7NbkNlws8L4DM65fbD/Kj9bNmAQe8mqXJ9guMcCroldsrIBCnx?=
 =?us-ascii?Q?f3KC7gPelueOcTnJWcoZs7H/Lj7B6RRr+5jvYrYZIgIG2WBtDHqR0D6eAMLp?=
 =?us-ascii?Q?aI9Z0Z7HfVWAZ+J8+TEBiiG6Rkhw6wP0ILSJSMhBT8Zo1JmLb+pW1/bKt7XS?=
 =?us-ascii?Q?8Y54OL1eZWluTcDD3+Dp2SuPdk6MUMt4GFcq9ztlmsQLm5yOolEdiToNMz/C?=
 =?us-ascii?Q?2QPomUREVoEoVWI4v6Zf5X6HCPJkdG8zkdRbyx9UrmSZUSoamEUvsWsd1Iea?=
 =?us-ascii?Q?+LdyK5imy1DKjrsMX77PaMYPiP0MtXXW6tXcm6sBzQNhd+9WZb7durRaYLN7?=
 =?us-ascii?Q?zno2SWttuW0cM0TCE6OetbyGtIb4uqDJGSptx1v2ums1OLl4Rg4LBTpQBr30?=
 =?us-ascii?Q?xjb/Yvg4IUfmszkLqMzSmHDHK2d0Tjoj9jQzf86rozEXYq4HnMAsqcHwnYr5?=
 =?us-ascii?Q?XAod41OEwxb8mE7hPFVFG4o2pgc+0Fdezb9tFr7osB0H6K6cpsC6m5o7q0m9?=
 =?us-ascii?Q?Y1PUXGW2by7kKwOnd//z8/09aoDqA4LTz+Cvbbi0Jfn6jW2J0u7Nsm1fLRwd?=
 =?us-ascii?Q?BQELo/mVuKUbUATrdRkQ3TsyMaeZTBoROOnMam/ufXxS6WEv9u6YCmXSdIQu?=
 =?us-ascii?Q?NeubaC5NkcrVoQIP9XQB8KpmOFijRQOAIR8kd0fHV48LPnDnOq80rwb8Wlma?=
 =?us-ascii?Q?OyUxLL9v7umIaDM7EsoOE02eFYr0afEm9P+9vI3kWTWgvPgyUXuxJU9DtW2d?=
 =?us-ascii?Q?tjGWMOhHucH+0q1+xem0fDZf5nSz5JK7nHtw8uy255oxWH/UrgjOCjNZCi7R?=
 =?us-ascii?Q?VCfBf+1klcVToeE/FPAoKLxSyWemTXCk2?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3803;6:WDJVuEmZwVXe+ESJaU03byHsZ7Qi4nikfNymzm/VBCOyQOGdJOgcT/gwRf3cQJh190/tZGBxTSaV6wspM8sAPhzfn/AKhZWP+isZ5h5xa/VCyJOvq7WEiIF8BTv3SHnUXo2Jg0E2ZhgItXFzF9OJKoszZqQ7/3ojeDI4OnFEXTX0OLnwtb4YTS12seVnsrbDSt5LTViaK6rtWIbKaew9PBv2vwALW2h8AydNoyJV0ncJyVx4YDeN6KPywpcqrZJawXyLzFa9w4k4bNolUXPHRC5dd3iMNh4eZbwnecDwjYboUybXr6YUFhKYZpiMdNLihg9CMs97bebaTKQ1KR2Q8Q==;5:PBPmKqjDfohjswwu7H49wJKbd25FX+OhaAcnkkDLpUO9YTrxRrmxV5lsc7rI18gvrSpHsGbhjXPLo96jm5+BCYOPZRdAtFzkzolBtkruU+BL4JRMeE4xyhxFJDR+ggMd5K2Vbd+PhNs4QSlAx2OvPw==;24:ETY3eTXRMBWXAo61WPx2M3FxxkEqT/T+yVz/biVHW6dK2e1Nn7uoLmYbOc696POnWxXLzXV9r6nAbvMbOvTaKw9TmJ2XqcDujwEBjNnIgJw=;7:EGP+ZSA57V0kK5uC9LlrEMd/PpJJrO5zcJf8HyxcVUhEOAEwKRMZiSciMaTYGU8DKk3qqmQs/fQ+S4hmJFuhwdhVGSPxU1uNDjt8VKPyJv6bqrgwr+r8egGC1fJQZdw/WuDKHVkXQ5NzDt111LtNITOoO3Hwd2adQJ+1sFXmtg/q5u0lXPcEymozbnsscmK6byOmw6wsipwqYRUTgtBAKVKwCoS88n6BQMV92mgW+3Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2017 15:42:56.8666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3803
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59870
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

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/octeon/cvmx-ciu-defs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
index 0dd0e40..6e61792 100644
--- a/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
+++ b/arch/mips/include/asm/octeon/cvmx-ciu-defs.h
@@ -128,6 +128,7 @@ static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
@@ -143,6 +144,10 @@ static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
 		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
+	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001010000030000ull) + (offset) * 8;
 	}
 	return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
 }
@@ -180,6 +185,7 @@ static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
 	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
@@ -195,6 +201,10 @@ static inline uint64_t CVMX_CIU_WDOGX(unsigned long offset)
 		return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
 		return CVMX_ADD_IO_SEG(0x0001070100100000ull) + (offset) * 8;
+	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
+	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
+		return CVMX_ADD_IO_SEG(0x0001010000020000ull) + (offset) * 8;
 	}
 	return CVMX_ADD_IO_SEG(0x0001070000000500ull) + (offset) * 8;
 }
-- 
2.1.4

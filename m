Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:57:18 +0200 (CEST)
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:57056
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992514AbeFYR5Iw-a9e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:57:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9Cy+tl6EjvGzkCzWbBZwaBSKYSmE8kJ1C2cV15UI9E=;
 b=p8DiTH8t0wrgEasSYg4Is0kXY2YeMJ2Tfb/Ro/zqVvJyimS4JMGq6l+rmfGHHKz2w0g4tY4/GkwDnn2X2+fRIRH1bpWtlFbwqACrKF3pK95MaqjXBMa26tIMeVTW8PIk65DBJ5iQs7IRuxZQLY0UuiO5sKvitHtFlwvtQbWtn60=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dzhu@wavecomp.com; 
Received: from box.mipstec.com (4.16.204.77) by
 BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.23; Mon, 25 Jun
 2018 17:56:57 +0000
From:   Dengcheng Zhu <dzhu@wavecomp.com>
To:     pburton@wavecomp.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Dengcheng Zhu <dzhu@wavecomp.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH] mips: rseq: Use new interface required to avoid SIGSEGV infinite recursion
Date:   Mon, 25 Jun 2018 10:56:19 -0700
Message-Id: <1529949379-5363-1-git-send-email-dzhu@wavecomp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40)
 To BN3PR0801MB2145.namprd08.prod.outlook.com (2a01:111:e400:7bb5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 434421ff-78f7-45f4-9a60-08d5dac50ba4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN3PR0801MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;3:p3lyHnEScQjsPQH830HDEPnu/VX9xJKFIfeDESBcq0balqHtuWV40Xdk23L0fg90vqIJp5IL9uPlRafjravZi/dT75DVjuni7AKeE5+tkEZbe2MJ6dQ5d9NNMptN1sfjVN++FmwwAQm08K3Pxz6zPvj16ezAPXVZV+kLzRdmt3CUFFiyiVpWJmQzTG4c0V7LzaacsTrLA9Jvh58K24heGQExYYUDpK/H8jD7rm0Izi2GTXn+EIX8aN9OnKpKxJ5m;25:3oadMTmciQMGQd9/munALKPbVS9a4/VTfO+PnVpCiD1fST4yXUTBItck2xMUe0Q89HDbwONU8Q+pyp0Ggrb6psarI9E0AVvBeo05ABB4eEM9x/afN6VmsEJNl4nq2T0hGs1Xv7Um2n06/kB+FC137rTTOvOow1Ru/5yTgLbroyWDZF/9wDlzWP9F2A9cWlM9Vx+JNIowuzO+Gvf7kvtiAfFC5dF+6tVHyk/HJvJVpR06RnZRLcsKXPs+jKFzI83bSeWpCR2NwrHi2AEhf31xh5tmkEGJtFGRGDGtcpuKyGxElU3VjYSGRzXsaIZ2DrRqwSTn//2zvlBaMPPCyXR+Gg==;31:o2D02N19PIzNpu5xKov0JoMnTc0CJYCRS8XjqZi+UUsBKKSMmCAF/8H5/AvRQEznHRr/qUVjGQVfEk49abqQMpg47Xg09BIyIWDLsWh0z8C8zF62quu6VwDPMI1fIwB2fNKfecpDTizyHR9hMn8Z19ErsfzVw+0YrRHCe+fNWk1MlS1OclKuS2a9uMGQE1MMJAXtfJ400+1Zu3tsNluZn/ZQVx2ePoP0n4VU9Hvajag=
X-MS-TrafficTypeDiagnostic: BN3PR0801MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;20:j81JfGPyp+pI+fzU0C8GI3vO+G8EXdrncUVBhHe6QCEkXD0ywZ3fRwn2HYRUDFXueh8LPlnyHqClcedkNNNGW3TyE4iwjRLpQHbgt9PC38A0LyHVEGS+O9aV3PiTJAkk7Jvigkngd7EQwUwcJeQ1m/wZDGkmQG5w5Fe9hLaoG1PxYAYlLpdKWartgI6KVIBNd3UBr4zC8l9MC0s/WCr25IfaSzuFHLH3SqesiOOtyIj6uooKK3n0vcW7VDVdEB82;4:xQzxWKGhU4Z5ifzJ3bSjNZdp+zsHqN4yHyAFT6oNnc3D0kHgJEVSDHx1k/SuOpIUW9pWt6NfjCrPxOPjsUJjYx22Co/fX+zPAitkMcxYMJF0Tex2uY70ri3cDOgzpJs1u5o+6gXOTXHJ7Ht5fx/8ULy1nKR4w3q5OjGt/TPTLbPZ2pAvkgLIgLtQNCZAwiVC2DmvBdXR1mGqQI13tTKDp+XHS1pGx5OiPJ3lzEog1sghpmdu0hMGR9jchAroLAYyltky94yIflUoGkTuVmXejvMmPhL1k2xHbsFKKiffgOUadmavC/2Q+1ZQSeuMeuUd
X-Microsoft-Antispam-PRVS: <BN3PR0801MB21450818C6A4E77BF6887379A24A0@BN3PR0801MB2145.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN3PR0801MB2145;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0801MB2145;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39840400004)(376002)(346002)(136003)(199004)(189003)(305945005)(81156014)(53416004)(8936002)(97736004)(6116002)(3846002)(7736002)(476003)(956004)(2616005)(486006)(6506007)(50466002)(386003)(2906002)(51416003)(8676002)(36756003)(52116002)(478600001)(81166006)(105586002)(6666003)(47776003)(6512007)(50226002)(54906003)(16526019)(106356001)(48376002)(6486002)(68736007)(5660300001)(25786009)(26005)(66066001)(86362001)(37156001)(316002)(69596002)(4326008)(16586007)(53936002)(1857600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0801MB2145;H:box.mipstec.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0801MB2145;23:ZujCQU/ZjHZwrqnJp+w9sj+zjAl602AX93oow+r?=
 =?us-ascii?Q?dRmL8THgrqVB8AEDfkQnd2oLtpq8T4/IRnsjx17rW7vP+LZjAw+qSQUFbOOf?=
 =?us-ascii?Q?iFV2qh4vh8FlUTSfcJykSFu9m/Y4tGpmxgQjD7eA+0uCJPFFdA86U6najaVj?=
 =?us-ascii?Q?e75YkglAk68bMpMGK2hLRA4UMZ7/jPIElO88x4HnSMsEI5IO6q3S3u3MNz6w?=
 =?us-ascii?Q?MA0rSM5MzpPCR+LThNZw0hMhJOqyCe5a+FrZYDVhcUDT9hSNOtjyyXhgt5mk?=
 =?us-ascii?Q?gzzJSv2fWrPbnOdTeKGd4WEzl5yP30ErNWhVvIEmjMKFidopmAwiDzDW20RV?=
 =?us-ascii?Q?y4iRGTY3tL0z0oVeE9MROe0zVIGEGd5CdE/+uemAU/xErxzdKaruzYz+DIM/?=
 =?us-ascii?Q?kvyO2yoQfz1cdItFrlIc5Cb53xM083AQSBZZCFVjoj2FJmzvVIndRW7yYtE6?=
 =?us-ascii?Q?gKESzRNRvZgSVIerNRk/yslAVLmtxddDtsa0KGfkIprrioEXngGYqMiQMNSE?=
 =?us-ascii?Q?wbbiNMBAZlPeszEGoONphOXVuRg0qfaX/xjKtR8IE9lP/LS27kScEjdOZrz6?=
 =?us-ascii?Q?lOskPN8fTtCHdr91KEMshNoCJBoNY/S5gbENWZVALiAB8/RP7KjQN40S8UMx?=
 =?us-ascii?Q?akuhym1kZtb37Zgwr6oxNS43o4StohwzGtEu7UMSXhI1sOhJzg7+xrxcuiKO?=
 =?us-ascii?Q?WTEsBA5PiZ5jBL2H8NUWt2ZCaKjSnVrwyaLiFxKWhZCTmr8Lh12PTMz3QLcs?=
 =?us-ascii?Q?KLSO1/cMgSQcupM5BwWvTselCUzEhymRQ4/hWouTecA0xUjQWihE1egjD79L?=
 =?us-ascii?Q?tJI5PzZSWKZivEzV1nUoR5BB35TpHsaP/kX8TaRjH0kdc8Ur2aqY1BlDRIOF?=
 =?us-ascii?Q?4/AUXo5DpQuHc+1z7rZopZ9ln2bKi4jVL2V9uQTSNl+rOzC6HKcgV7AlZwjt?=
 =?us-ascii?Q?0cikIyFR8ynCNV6NJHfMb3bu93YRwSsySUT3EMfNN77QgDDwLaN2tTqsBaPj?=
 =?us-ascii?Q?G/h2XhfjRErxN42gzMLQAkSTn8JwypBZ08wqZbWYW3bARd3deb+cJ+HzXPsP?=
 =?us-ascii?Q?zQI2xDXuJap8p2SISH8/tpmGFnESIXfYINYAajNlFgLf9W+rucFdP8sZnbtH?=
 =?us-ascii?Q?sU3a5ny7LLc2cpBGn0iiCA6OMwQanczfArVBTP2gDksJ+yslV+1uYUluHtY5?=
 =?us-ascii?Q?yuJssSidRqqJTEGQ=3D?=
X-Microsoft-Antispam-Message-Info: N76RC6HvuodQcem5NWhuNSjWlB6LtI7zLU00okSWyZez2sYLndyHfWzdSFhTonqXnKDX3pAUNDyPhbO2BR95KiqGpWozVLX13xLV9jM9/MDIJjhXxWZe1dsR1GmSwvQFk/eltn0FWuNbAj88gef9z8NNPzzE3mLYG+MDtiT/IsZ48HAp4KWuKxeHE/F8yKJSs9Kdqohjwb0jY9X22XnwJC4POE1B/NWvdyJDxmaV/BdhDC3V6zhF3A4ejONAJvqYC/uGbOnpDKk2tfd0+PkbZdAcyI3SLiM07JV0ZilwXX2ApbgmL6M4Ri1vkhqg1ZD4kaK5HmMLNxl3amwJan/BqJJM1l0Pzl3RyGqdjHBC0GI=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;6:bu8nJtx2bxAvZZjuuELkWlRqWLvTeu9ZZXqgZKJhhSClryWwWAkXaZVbcM4EOA7VrDIzQ1xUQ/bhWocWyCCXCPAdg0wwdfpDnrGZzN0hKXXybjx3s48I+SjZcvZpEi0D1HN7FpjUWuLDBv380J3cwNPEr+LnGLe2rrWUHiML35JjTeQfAqP/q8FnpIXuKJ8dqG1LPjezyROeycuauTYrfbBlPQOdQ6QU1kS252ANIyuHkkvtC9ZK99PJbaBGLB1raSEFuY7P5iJ18a2rLWBI+x5o6fGGe56Lli5l6cYirESsp4dpMZaU/RYI/JqGmFnizUDkq2es7dwzMMRINJV8TuX8Zy0iZ9HUNq6v72q2HUiXp6x7UaI0/pxZ7LsXeY1IV+ZwnUsNVENTpDEPWOtAz3yrEde1BKEWRjPVi4gLy8J49pwmmAT6LSAXwczkw6S5lISoMTQmTS/cXPtunxWenw==;5:o8KXRCqRYrkhzbShgW2QG2eKs0nGV9zYQ8xyjN+y68LwUwCfifEkq/NcG8RFQGDD1DTxinnAG8jB0TimTKf00VP8MN6bieb+fiNNmYvHzHrjnrioF2xxyGXdzxvOUjjZHFLlEYyUxvrBBT6MhuFgBuajB96eQoeCA+HhnZMIFww=;24:ug3GmSdI1QaVbFP7/S76DYa7X78FWsALoP2B9nmlz6C2LVrE7BL4wlpEECWtvUa4DDtWxAbE9w2sT8q7/dVhUo5Mg5oRPb060cCpAKLUxd4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0801MB2145;7:2voVYS60feG+XNnCHzuk6QcsHNRIc9mp1MzbPZYB25bh4K32yf2MUKb/j35lUeNdUCgW+06HnQJTuzpPqkH0IWrG2t5RwyeIrxuGmhuEpjgq/Tka9rkVvNfeylgnzMT8IMWkxvFZRimH3vs5pYp79xctSkCv00RYEE0D+REdLGZ/HQOUDzl69xM02El94tofbUm1MLH2E8jWQMrTzHXCYHnXbBN2YcSZXmfP6Avb2nTh54dikyOXkxhfJBfkehEy
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 17:56:57.4823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434421ff-78f7-45f4-9a60-08d5dac50ba4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0801MB2145
Return-Path: <dzhu@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64455
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

The new interface was introduced in 784e0300fe (rseq: Avoid infinite
recursion when delivering SIGSEGV).

This patch makes the change for mips.

Signed-off-by: Dengcheng Zhu <dzhu@wavecomp.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/mips/kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 00f2535..0a9cfe7 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -801,7 +801,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		regs->regs[0] = 0;		/* Don't deal with this again.	*/
 	}
 
-	rseq_signal_deliver(regs);
+	rseq_signal_deliver(ksig, regs);
 
 	if (sig_uses_siginfo(&ksig->ka, abi))
 		ret = abi->setup_rt_frame(vdso + abi->vdso->off_rt_sigreturn,
@@ -870,7 +870,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, void *unused,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
-		rseq_handle_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 
 	user_enter();
-- 
2.7.4

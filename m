Return-Path: <SRS0=3MQT=PA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31EDC43387
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 22:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68E3217D7
	for <linux-mips@archiver.kernel.org>; Sun, 23 Dec 2018 22:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeLWWw6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 23 Dec 2018 17:52:58 -0500
Received: from mx1.mailbox.org ([80.241.60.212]:47642 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbeLWWw6 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 23 Dec 2018 17:52:58 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 2242E4B2F5;
        Sun, 23 Dec 2018 23:52:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id WhPV-dI2iD12; Sun, 23 Dec 2018 23:52:53 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     paul.burton@mips.com
Cc:     linux-mips@vger.kernel.org, ldir@darbyshire-bryant.me.uk,
        jonas.gorski@gmail.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: Add CPU option reporting to /proc/cpuinfo
Date:   Sun, 23 Dec 2018 23:52:24 +0100
Message-Id: <20181223225224.23042-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Many MIPS CPUs have optional CPU features which are not activates for
all CPU cores. Print the CPU options which are implemented in the core
in /proc/cpuinfo. This makes it possible to see what features are
supported and which are not supported. This should cover all standard
MIPS extensions, before it only printed information about the main MIPS
ASEs.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/kernel/proc.c | 116 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index b2de408a259e..f89d52aebe09 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -130,6 +130,122 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		seq_printf(m, "micromips kernel\t: %s\n",
 		      (read_c0_config3() & MIPS_CONF3_ISA_OE) ?  "yes" : "no");
 	}
+
+	seq_printf(m, "Options implemented\t:");
+	if (cpu_has_tlb)
+		seq_printf(m, "%s", " tlb");
+	if (cpu_has_ftlb)
+		seq_printf(m, "%s", " ftlb");
+	if (cpu_has_tlbinv)
+		seq_printf(m, "%s", " tlbinv");
+	if (cpu_has_segments)
+		seq_printf(m, "%s", " segments");
+	if (cpu_has_rixiex)
+		seq_printf(m, "%s", " rixiex");
+	if (cpu_has_ldpte)
+		seq_printf(m, "%s", " ldpte");
+	if (cpu_has_maar)
+		seq_printf(m, "%s", " maar");
+	if (cpu_has_rw_llb)
+		seq_printf(m, "%s", " rw_llb");
+	if (cpu_has_4kex)
+		seq_printf(m, "%s", " 4kex");
+	if (cpu_has_3k_cache)
+		seq_printf(m, "%s", " 3k_cache");
+	if (cpu_has_4k_cache)
+		seq_printf(m, "%s", " 4k_cache");
+	if (cpu_has_6k_cache)
+		seq_printf(m, "%s", " 6k_cache");
+	if (cpu_has_8k_cache)
+		seq_printf(m, "%s", " 8k_cache");
+	if (cpu_has_tx39_cache)
+		seq_printf(m, "%s", " tx39_cache");
+	if (cpu_has_octeon_cache)
+		seq_printf(m, "%s", " octeon_cache");
+	if (cpu_has_fpu)
+		seq_printf(m, "%s", " fpu");
+	if (cpu_has_32fpr)
+		seq_printf(m, "%s", " 32fpr");
+	if (cpu_has_cache_cdex_p)
+		seq_printf(m, "%s", " cache_cdex_p");
+	if (cpu_has_cache_cdex_s)
+		seq_printf(m, "%s", " cache_cdex_s");
+	if (cpu_has_prefetch)
+		seq_printf(m, "%s", " prefetch");
+	if (cpu_has_mcheck)
+		seq_printf(m, "%s", " mcheck");
+	if (cpu_has_ejtag)
+		seq_printf(m, "%s", " ejtag");
+	if (cpu_has_llsc)
+		seq_printf(m, "%s", " llsc");
+	if (cpu_has_bp_ghist)
+		seq_printf(m, "%s", " bp_ghist");
+	if (cpu_has_guestctl0ext)
+		seq_printf(m, "%s", " guestctl0ext");
+	if (cpu_has_guestctl1)
+		seq_printf(m, "%s", " guestctl1");
+	if (cpu_has_guestctl2)
+		seq_printf(m, "%s", " guestctl2");
+	if (cpu_has_guestid)
+		seq_printf(m, "%s", " guestid");
+	if (cpu_has_drg)
+		seq_printf(m, "%s", " drg");
+	if (cpu_has_rixi)
+		seq_printf(m, "%s", " rixi");
+	if (cpu_has_lpa)
+		seq_printf(m, "%s", " lpa");
+	if (cpu_has_mvh)
+		seq_printf(m, "%s", " mvh");
+	if (cpu_has_vtag_icache)
+		seq_printf(m, "%s", " vtag_icache");
+	if (cpu_has_dc_aliases)
+		seq_printf(m, "%s", " dc_aliases");
+	if (cpu_has_ic_fills_f_dc)
+		seq_printf(m, "%s", " ic_fills_f_dc");
+	if (cpu_has_pindexed_dcache)
+		seq_printf(m, "%s", " pindexed_dcache");
+	if (cpu_has_userlocal)
+		seq_printf(m, "%s", " userlocal");
+	if (cpu_has_nofpuex)
+		seq_printf(m, "%s", " nofpuex");
+	if (cpu_has_vint)
+		seq_printf(m, "%s", " vint");
+	if (cpu_has_veic)
+		seq_printf(m, "%s", " veic");
+	if (cpu_has_inclusive_pcaches)
+		seq_printf(m, "%s", " inclusive_pcaches");
+	if (cpu_has_perf_cntr_intr_bit)
+		seq_printf(m, "%s", " perf_cntr_intr_bit");
+	if (cpu_has_ufr)
+		seq_printf(m, "%s", " ufr");
+	if (cpu_has_fre)
+		seq_printf(m, "%s", " fre");
+	if (cpu_has_cdmm)
+		seq_printf(m, "%s", " cdmm");
+	if (cpu_has_small_pages)
+		seq_printf(m, "%s", " small_pages");
+	if (cpu_has_nan_legacy)
+		seq_printf(m, "%s", " nan_legacy");
+	if (cpu_has_nan_2008)
+		seq_printf(m, "%s", " nan_2008");
+	if (cpu_has_ebase_wg)
+		seq_printf(m, "%s", " ebase_wg");
+	if (cpu_has_badinstr)
+		seq_printf(m, "%s", " badinstr");
+	if (cpu_has_badinstrp)
+		seq_printf(m, "%s", " badinstrp");
+	if (cpu_has_contextconfig)
+		seq_printf(m, "%s", " contextconfig");
+	if (cpu_has_perf)
+		seq_printf(m, "%s", " perf");
+	if (cpu_has_shared_ftlb_ram)
+		seq_printf(m, "%s", " shared_ftlb_ram");
+	if (cpu_has_shared_ftlb_entries)
+		seq_printf(m, "%s", " shared_ftlb_entries");
+	if (cpu_has_mipsmt_pertccounters)
+		seq_printf(m, "%s", " mipsmt_pertccounters");
+	seq_printf(m, "\n");
+
 	seq_printf(m, "shadow register sets\t: %d\n",
 		      cpu_data[n].srsets);
 	seq_printf(m, "kscratch registers\t: %d\n",
-- 
2.19.2


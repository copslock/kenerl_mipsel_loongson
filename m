Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:19:00 +0100 (CET)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:40747
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeA0DSxL62BB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:18:53 +0100
Received: by mail-pl0-x241.google.com with SMTP id g18so163492plo.7;
        Fri, 26 Jan 2018 19:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CKmy+73KSUBc3MbGk8jLLAKPYfURmA3+1yJc5Fi7oSI=;
        b=OgYbNyN8FjRMyY3DyETthK0BzJtrBFLcwjzUFtmRqa4ySxq6coPQvjuiWwnELeBAnX
         XsDhARbsAwUMn6IqH59JWqMaPuhe+oUfugiNOg5vubahyYYnJ6C0sk+pg4b0hHIlGS5V
         4iT3LLn/QHB+w16biDiNR8EN2tRr+oXcBeiv2Wa/I9c7F6FbG8kHUM9Et+nubH1e36KP
         Q9dziqg2t6ppgDMS5hmu5V2pSK3HvegxmdOv1uGj33a5vmzuP3HjaUDEHMOQf2UaMEPI
         dalgOdtZgkz1VeH10ei4lEBm5P3607p7vJ6at3vNkTYr6wHV9i5xCvDzIMG1oGq9RRqD
         ar2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=CKmy+73KSUBc3MbGk8jLLAKPYfURmA3+1yJc5Fi7oSI=;
        b=b/pLAK8S6Uv5FaNmwJ+taV/glIIkb0QF5sXFs2K9OPEScbq9Ja8TGvuvoxZl23WbHU
         pmkY8FCem6FTjDrPEcBxYHNYf4Z2LcP3wg3qVEclE7J/RzbpU4Rnpr5v5EZefiSt1k3+
         yTdQIZYrw8WMLEbs5gbI6lKjHumjIquTlOqfSmv8zgr97erAM1Em/BzshghZoxGvFj36
         5n5qwln848Ua77knd0UmSuwWPp4iRlvanz5FvNeeNVbiKBTOp8yl2t32O+1NlCkaQzFA
         OgKiuYjFLF49n1TXfB2qB3h1R4ptQeRclY1VY8K/sWKyKpFi1+jYWZfoSe3y36NlSlWo
         YYhQ==
X-Gm-Message-State: AKwxyte449+2MD+HXn2dYKR/Y+XtEa+FTxC1YHsd5JQL5VgglMjDfb9q
        cnK7Hb1KxALG3/ZTxvQW6AMyqA==
X-Google-Smtp-Source: AH8x224FwygxM9mPaZJ1gyYt5xxRBtrqN7SBbc+XpBS/YLC7VXuF4kPi0MJXNwTSsjqGNX16b3LJ3Q==
X-Received: by 2002:a17:902:481:: with SMTP id e1-v6mr13863364ple.228.1517023124829;
        Fri, 26 Jan 2018 19:18:44 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id 184sm17833607pfg.87.2018.01.26.19.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:18:44 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 15+" <stable@vger.kernel.org>
Subject: [PATCH V2 04/12] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
Date:   Sat, 27 Jan 2018 11:19:05 +0800
Message-Id: <1517023145-14293-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

For multi-node Loongson-3 (NUMA configuration), r4k_blast_scache() can
only flush Node-0's scache. So we add r4k_blast_scache_node() by using
(CAC_BASE | (node_id << NODE_ADDRSPACE_SHIFT)) instead of CKSEG0 as the
start address.

Cc: <stable@vger.kernel.org> # 3.15+
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/r4kcache.h | 34 ++++++++++++++++++++++++++++++++
 arch/mips/mm/c-r4k.c             | 42 +++++++++++++++++++++++++++++++++-------
 2 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index 7f12d7e..c1f2806 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -747,4 +747,38 @@ __BUILD_BLAST_CACHE_RANGE(s, scache, Hit_Writeback_Inv_SD, , )
 __BUILD_BLAST_CACHE_RANGE(inv_d, dcache, Hit_Invalidate_D, , )
 __BUILD_BLAST_CACHE_RANGE(inv_s, scache, Hit_Invalidate_SD, , )
 
+#ifndef pa_to_nid
+#define pa_to_nid(addr) 0
+#endif
+
+#ifndef NODE_ADDRSPACE_SHIFT
+#define nid_to_addrbase(nid) 0
+#else
+#define nid_to_addrbase(nid) (nid << NODE_ADDRSPACE_SHIFT)
+#endif
+
+#define __BUILD_BLAST_CACHE_NODE(pfx, desc, indexop, hitop, lsize)	\
+static inline void blast_##pfx##cache##lsize##_node(long node)		\
+{									\
+	unsigned long start = CAC_BASE | nid_to_addrbase(node);		\
+	unsigned long end = start + current_cpu_data.desc.waysize;	\
+	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
+	unsigned long ws_end = current_cpu_data.desc.ways <<		\
+			       current_cpu_data.desc.waybit;		\
+	unsigned long ws, addr;						\
+									\
+	__##pfx##flush_prologue						\
+									\
+	for (ws = 0; ws < ws_end; ws += ws_inc)				\
+		for (addr = start; addr < end; addr += lsize * 32)	\
+			cache##lsize##_unroll32(addr|ws, indexop);	\
+									\
+	__##pfx##flush_epilogue						\
+}
+
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 16)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 32)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
+__BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 128)
+
 #endif /* _ASM_R4KCACHE_H */
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 6f534b20..155f5f5 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -459,11 +459,28 @@ static void r4k_blast_scache_setup(void)
 		r4k_blast_scache = blast_scache128;
 }
 
+static void (*r4k_blast_scache_node)(long node);
+
+static void r4k_blast_scache_node_setup(void)
+{
+	unsigned long sc_lsize = cpu_scache_line_size();
+
+	if (current_cpu_type() != CPU_LOONGSON3)
+		r4k_blast_scache_node = (void *)cache_noop;
+	else if (sc_lsize == 16)
+		r4k_blast_scache_node = blast_scache16_node;
+	else if (sc_lsize == 32)
+		r4k_blast_scache_node = blast_scache32_node;
+	else if (sc_lsize == 64)
+		r4k_blast_scache_node = blast_scache64_node;
+	else if (sc_lsize == 128)
+		r4k_blast_scache_node = blast_scache128_node;
+}
+
 static inline void local_r4k___flush_cache_all(void * args)
 {
 	switch (current_cpu_type()) {
 	case CPU_LOONGSON2:
-	case CPU_LOONGSON3:
 	case CPU_R4000SC:
 	case CPU_R4000MC:
 	case CPU_R4400SC:
@@ -480,6 +497,10 @@ static inline void local_r4k___flush_cache_all(void * args)
 		r4k_blast_scache();
 		break;
 
+	case CPU_LOONGSON3:
+		r4k_blast_scache_node(get_ebase_cpunum() >> 2);
+		break;
+
 	case CPU_BMIPS5000:
 		r4k_blast_scache();
 		__sync();
@@ -839,9 +860,12 @@ static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
-		if (size >= scache_size)
-			r4k_blast_scache();
-		else
+		if (size >= scache_size) {
+			if (current_cpu_type() != CPU_LOONGSON3)
+				r4k_blast_scache();
+			else
+				r4k_blast_scache_node(pa_to_nid(addr));
+		} else
 			blast_scache_range(addr, addr + size);
 		preempt_enable();
 		__sync();
@@ -872,9 +896,12 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 
 	preempt_disable();
 	if (cpu_has_inclusive_pcaches) {
-		if (size >= scache_size)
-			r4k_blast_scache();
-		else {
+		if (size >= scache_size) {
+			if (current_cpu_type() != CPU_LOONGSON3)
+				r4k_blast_scache();
+			else
+				r4k_blast_scache_node(pa_to_nid(addr));
+		} else {
 			/*
 			 * There is no clearly documented alignment requirement
 			 * for the cache instruction on MIPS processors and
@@ -1905,6 +1932,7 @@ void r4k_cache_init(void)
 	r4k_blast_scache_page_setup();
 	r4k_blast_scache_page_indexed_setup();
 	r4k_blast_scache_setup();
+	r4k_blast_scache_node_setup();
 #ifdef CONFIG_EVA
 	r4k_blast_dcache_user_page_setup();
 	r4k_blast_icache_user_page_setup();
-- 
2.7.0

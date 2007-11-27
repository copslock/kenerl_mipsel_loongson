Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2007 16:22:03 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.235]:46228 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S28574616AbXK0QVz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Nov 2007 16:21:55 +0000
Received: by wr-out-0506.google.com with SMTP id 67so899348wri
        for <linux-mips@linux-mips.org>; Tue, 27 Nov 2007 08:20:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=CdycuaAbgXJ5/oT9NmYhxmho5acTRPCi6sIY3C67xrA=;
        b=bKC0mrtQj78+ML0QvoC5U79kzf88KusKynLlPOk6jjBQDpmX9fysiucjEqd/6/eMWZKGW6qMi2y1R6qPJZP0EPuCM7spxDTVbQcTsBuYnhiRmWVYkBZr6DztD4jebHZK898q4NRW69fC/Wg9SmWj1x9SnjXuXyAwveB7dGOf2P0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=xs+IFdMm5RFQ787228/AtjEOksROTksEqLuPstOGWD/6uL4waHeIL3HEEEww9ADiJfFiDja67jEzY0+FCQye+t3NYp1OYNtfwSdCNUU9Zmx+JjzrlbVDrAHw1yQ/qjniSXVow0t7OW0ocSJtp8gdar86+HiZlH/MPtU617RbtrQ=
Received: by 10.143.162.8 with SMTP id p8mr1013696wfo.1196180447972;
        Tue, 27 Nov 2007 08:20:47 -0800 (PST)
Received: by 10.142.214.9 with HTTP; Tue, 27 Nov 2007 08:20:47 -0800 (PST)
Message-ID: <73cd086a0711270820r92dc164heaa453e94cf1a8c6@mail.gmail.com>
Date:	Tue, 27 Nov 2007 19:20:47 +0300
From:	"Pavel Kiryukhin" <vksavl@gmail.com>
To:	linux-mips@linux-mips.org
Subject: BUG: using smp_processor_id() in preemptible code
Cc:	vksavl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <vksavl@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vksavl@gmail.com
Precedence: bulk
X-list: linux-mips

I get the following bug running 2.6.18 on malta34Kc .

Freeing prom memory: 956kb freed
Freeing firmware memory: 978944k freed
Freeing unused kernel memory: 180k freed
BUG: using smp_processor_id() in preemptible [00000000] code: swapper/1
caller is r4k_dma_cache_wback_inv+0x144/0x2a0
Call Trace:
 [<80117af8>] r4k_dma_cache_wback_inv+0x144/0x2a0
 [<802e4b84>] debug_smp_processor_id+0xd4/0xf0
 [<802e4b7c>] debug_smp_processor_id+0xcc/0xf0
...
CONFIG_DEBUG_PREEMPT is enabled.
--
Bug cause is blast_dcache_range() in preemptible code [in
r4k_dma_cache_wback_inv()].
blast_dcache_range() is constructed via __BUILD_BLAST_CACHE_RANGE that
uses cpu_dcache_line_size(). It uses current_cpu_data that use
smp_processor_id() in turn. In case of CONFIG_DEBUG_PREEMPT
smp_processor_id emits BUG if we are executing with preemption
enabled.

Cpu options of cpu0 are assumed to be the superset of all processors.

Can I make the same assumptions for cache line size  and fix this
issue the following way:

Index: linux-2.6.18/include/asm-mips/cpu-features.h
===================================================================
--- linux-2.6.18.orig/include/asm-mips/cpu-features.h
+++ linux-2.6.18/include/asm-mips/cpu-features.h
@@ -200,10 +200,10 @@
 #endif

 #ifndef cpu_dcache_line_size
-#define cpu_dcache_line_size() current_cpu_data.dcache.linesz
+#define cpu_dcache_line_size() cpu_data[0].dcache.linesz
 #endif
 #ifndef cpu_icache_line_size
-#define cpu_icache_line_size() current_cpu_data.icache.linesz
+#define cpu_icache_line_size() cpu_data[0].icache.linesz
 #endif
 #ifndef cpu_scache_line_size
 #define cpu_scache_line_size() current_cpu_data.scache.linesz

Any suggestions would be greatly appreciated.
---
Thanks,
Pavel

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Nov 2004 06:11:56 +0000 (GMT)
Received: from webmail.ict.ac.cn ([IPv6:::ffff:159.226.39.7]:47529 "HELO
	ict.ac.cn") by linux-mips.org with SMTP id <S8224771AbUKPGLu>;
	Tue, 16 Nov 2004 06:11:50 +0000
Received: (qmail 7493 invoked by uid 507); 16 Nov 2004 05:41:22 -0000
Received: from unknown (HELO ict.ac.cn) (fxzhang@159.226.40.187)
  by ict.ac.cn with SMTP; 16 Nov 2004 05:41:22 -0000
Message-ID: <419999B5.3070901@ict.ac.cn>
Date: Tue, 16 Nov 2004 14:09:57 +0800
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: emblinux@macrohat.com
CC: linux-cvs <linux-cvs@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: 
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Probably because -O3 automatically make short functions inline so
local_sb1___flush_cache_all disappears

asm("sb1___flush_cache_all_ipi = local_sb1___flush_cache_all");
^^^^^^^^^I don't know whether this trick is safe for auto-inlining.

as for the problem of adding prefetch to memcpy, I am not famliar with SB1250,
but as of version 2.4.22, arch/mips/lib/memcpy.S already support using MIPS IV 
prefetch


macrohat wrote:

>Dear Fuxin Zhang:
>
>Thinks for your help!
>
>Now i have another question, I use mips-linux-gcc which is ported from gcc-3.2.3 by Broadcom to compile linux kernel,when I use "-O2" or "-Os" option, it can complete successfully, but if i use "-O3" option, it can not complete.Enclosed is the err log and souce code.
>Any help would be really appreciated.
>
>err log:
>
>arch/mips64/mm/mm.o: In function `sb1___flush_cache_all':
>arch/mips64/mm/mm.o(.text+0x1930): undefined reference to `local_sb1___flush_cac
>he_all'
>arch/mips64/mm/mm.o(.text+0x1934): undefined reference to `local_sb1___flush_cac
>he_all'
>make: *** [vmlinux] Error 1
>
>source code:
>
>static void local_sb1___flush_cache_all(void)
>{
>	TRACE_RECORD(TRC_CACHEOP_BASE+5, 0, 0,
>		     read_c0_count());
>
>	__sb1_writeback_inv_dcache_all();
>	__sb1_flush_icache_all();
>}
>
>extern void sb1___flush_cache_all_ipi(void *ignored);
>asm("sb1___flush_cache_all_ipi = local_sb1___flush_cache_all");
>
>static void sb1___flush_cache_all(void)
>{
>	smp_call_function(sb1___flush_cache_all_ipi, 0, 1, 1);
>	local_sb1___flush_cache_all();
>}
>
>	
>Regards!
>
>　　　　　　　　macrohat
>　　　　　　　　emblinux@macrohat.com
>　　　　　　　　　　2004-11-14
>  
>

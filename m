Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2008 05:51:06 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:46061 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23920604AbYKZFu6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Nov 2008 05:50:58 +0000
Received: (qmail 12862 invoked by uid 1000); 26 Nov 2008 06:50:53 +0100
Date:	Wed, 26 Nov 2008 06:50:53 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	LMO <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] Alchemy: cpu feature override constants.
Message-ID: <20081126055053.GA12831@roarinelk.homelinux.net>
References: <20081125231230.GA10366@roarinelk.homelinux.net> <492C8904.5040202@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492C8904.5040202@caviumnetworks.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi David,

On Tue, Nov 25, 2008 at 03:23:48PM -0800, David Daney wrote:
> Manuel Lauss wrote:
> [...]
>> +#define cpu_has_tlb		1
>> +#define cpu_has_4kex		1
>> +#define cpu_has_3k_cache	0
>> +#define cpu_has_4k_cache	1
>> +#define cpu_has_tx39_cache	0
>> +#define cpu_has_fpu		0
>> +#define cpu_has_32fpr		0
>> +#define cpu_has_counter		1
>> +#define cpu_has_watch		1
>> +#define cpu_has_divec		1
>> +#define cpu_has_vce		0
>> +#define cpu_has_cache_cdex_p	0
>> +#define cpu_has_cache_cdex_s	0
>> +#define cpu_has_mcheck		1
>> +#define cpu_has_ejtag		1
>> +#define cpu_has_llsc		1
>> +#define cpu_has_mips16		0
>> +#define cpu_has_mdmx		0
>> +#define cpu_has_mips3d		0
>> +#define cpu_has_smartmips	0
>> +#define cpu_has_vtag_icache	0
>> +#define cpu_has_dc_aliases	0
>> +#define cpu_has_ic_fills_f_dc	1
>> +#define cpu_has_pindexed_cache	0
>> +#define cpu_has_mips32r1	1
>> +#define cpu_has_mips32r2	0
>> +#define cpu_has_mips64r1	0
>> +#define cpu_has_mips64r2	0
>> +#define cpu_has_dsp		0
>> +#define cpu_has_mipsmt		0
>> +#define cpu_has_userlocal	0
>> +#define cpu_has_nofpuex		0
>> +#define cpu_has_64bits		0
>> +#define cpu_has_64bit_zero_reg	0
>> +#define cpu_has_vint		0
>> +#define cpu_has_veic		0
>> +#define cpu_has_inclusive_pcaches 0
>> +
>> +#define cpu_dcache_line_size()	32
>> +#define cpu_icache_line_size()  32
>
> The probe routines in cpu-probe.c should get at least some of that correct. 
>  How about just overriding the things that cpu-probe.c doesn't get right?

CPU detection gets them all right, it's just that somehow GCC does not use
the information correctly;  i.e. in the __fls() case it blindly falls back
on the C version instead of using the asm macro with clz in it.  I scanned
a few callsites of __fls() and there's not 'clz' to be found anywhere.  With
this addition the clz is used and the binary is a _lot_ smaller.

I believe this is a gcc thing, but this seemed to be the obvious quick
remedy.

Thanks!
	Manuel Lauss

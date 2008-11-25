Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 23:24:46 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:39175 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23915281AbYKYXYh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Nov 2008 23:24:37 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492c89060000>; Tue, 25 Nov 2008 18:23:50 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 15:23:48 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 15:23:48 -0800
Message-ID: <492C8904.5040202@caviumnetworks.com>
Date:	Tue, 25 Nov 2008 15:23:48 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	LMO <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] Alchemy: cpu feature override constants.
References: <20081125231230.GA10366@roarinelk.homelinux.net>
In-Reply-To: <20081125231230.GA10366@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2008 23:23:48.0701 (UTC) FILETIME=[DE9650D0:01C94F54]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
[...]
> +#define cpu_has_tlb		1
> +#define cpu_has_4kex		1
> +#define cpu_has_3k_cache	0
> +#define cpu_has_4k_cache	1
> +#define cpu_has_tx39_cache	0
> +#define cpu_has_fpu		0
> +#define cpu_has_32fpr		0
> +#define cpu_has_counter		1
> +#define cpu_has_watch		1
> +#define cpu_has_divec		1
> +#define cpu_has_vce		0
> +#define cpu_has_cache_cdex_p	0
> +#define cpu_has_cache_cdex_s	0
> +#define cpu_has_mcheck		1
> +#define cpu_has_ejtag		1
> +#define cpu_has_llsc		1
> +#define cpu_has_mips16		0
> +#define cpu_has_mdmx		0
> +#define cpu_has_mips3d		0
> +#define cpu_has_smartmips	0
> +#define cpu_has_vtag_icache	0
> +#define cpu_has_dc_aliases	0
> +#define cpu_has_ic_fills_f_dc	1
> +#define cpu_has_pindexed_cache	0
> +#define cpu_has_mips32r1	1
> +#define cpu_has_mips32r2	0
> +#define cpu_has_mips64r1	0
> +#define cpu_has_mips64r2	0
> +#define cpu_has_dsp		0
> +#define cpu_has_mipsmt		0
> +#define cpu_has_userlocal	0
> +#define cpu_has_nofpuex		0
> +#define cpu_has_64bits		0
> +#define cpu_has_64bit_zero_reg	0
> +#define cpu_has_vint		0
> +#define cpu_has_veic		0
> +#define cpu_has_inclusive_pcaches 0
> +
> +#define cpu_dcache_line_size()	32
> +#define cpu_icache_line_size()  32

The probe routines in cpu-probe.c should get at least some of that 
correct.  How about just overriding the things that cpu-probe.c doesn't 
get right?

David Daney

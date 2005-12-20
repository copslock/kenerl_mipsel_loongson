Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2005 11:47:00 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:44811 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3457893AbVLTLqk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Dec 2005 11:46:40 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 49609F59F9;
	Tue, 20 Dec 2005 12:47:40 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14133-06; Tue, 20 Dec 2005 12:47:40 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 0215EF59F7;
	Tue, 20 Dec 2005 12:47:40 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id jBKBlXh2014236;
	Tue, 20 Dec 2005 12:47:33 +0100
Date:	Tue, 20 Dec 2005 11:47:42 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel freezes in r4k_flush_icache_range() with CONFIG_CPU_MIPS32_R2
In-Reply-To: <1135047438.9874.74.camel@sakura.staff.proxad.net>
Message-ID: <Pine.LNX.4.64N.0512201120010.25567@blysk.ds.pg.gda.pl>
References: <1135047438.9874.74.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1213/Mon Dec 19 15:48:34 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 20 Dec 2005, Maxime Bizon wrote:

>     272c:       8c43000c        lw      v1,12(v0)
>     2730:       0060f809        jalr    v1
>     2734:       00000000        nop
>     2738:       3c020000        lui     v0,0x0
>     273c:       2442277c        addiu   v0,v0,10108   <----------
>     2740:       00400408        jr.hb   v0
>     2744:       00000000        nop
>     2748:       8fbf0028        lw      ra,40(sp)
>     274c:       8fb30024        lw      s3,36(sp)
>     2750:       8fb20020        lw      s2,32(sp)
>     2754:       8fb1001c        lw      s1,28(sp)
>     2758:       8fb00018        lw      s0,24(sp)
>     275c:       03e00008        jr      ra
>     2760:       27bd0030        addiu   sp,sp,48
>     2764:       3c020000        lui     v0,0x0
>     2768:       8c430018        lw      v1,24(v0)
>     276c:       0060f809        jalr    v1
>     2770:       00000000        nop
>     2774:       0800099c        j       2670 <r4k_flush_icache_range+0x4c>
>     2778:       3c030000        lui     v1,0x0
> 
> 0000277c <r4k_dma_cache_inv>:
> [...]
> 
> At offset 0x26ac and 0x273c, we can see that instruction_hazard() got
> duplicated due to inlining, and that the jr.hb is going to send us to
> 10108 (0x277C), outside the function...

 FYI, GCC 3.4.4 produces the following code which is clearly wrong:

	.align	2
	.align	3
	.ent	r4k_flush_icache_range
	.type	r4k_flush_icache_range, @function
r4k_flush_icache_range:
	.set	nomips16
	.frame	$sp,56,$31		# vars= 16, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
[...]
	lui	$2,%hi($L506)	 # 239	movsi_internal/2	[length = 4]
	addiu	$2,$2,%lo($L506)	 # 240	*lowsi	[length = 4]
#APP
		jr.hb	$2					

#NO_APP
	lw	$31,48($sp)	 # 304	movsi_internal/4	[length = 4]
	lw	$19,44($sp)	 # 305	movsi_internal/4	[length = 4]
	lw	$18,40($sp)	 # 306	movsi_internal/4	[length = 4]
	lw	$17,36($sp)	 # 307	movsi_internal/4	[length = 4]
	lw	$16,32($sp)	 # 308	movsi_internal/4	[length = 4]
	.set	noreorder
	.set	nomacro
	j	$31	 # 310	return_internal	[length = 4]
	addiu	$sp,$sp,56	 # 309	addsi3_internal/2	[length = 4]
	.set	macro
	.set	reorder

$L510:
	lui	$2,%hi(r4k_blast_icache)	 # 181	movsi_internal/2	[length = 4]
	lw	$3,%lo(r4k_blast_icache)($2)	 # 182	movsi_internal/4	[length = 4]
	jal	$3	 # 183	call_internal/1	[length = 8]
	lui	$2,%hi($L506)	 # 313	movsi_internal/2	[length = 4]
	addiu	$2,$2,%lo($L506)	 # 314	*lowsi	[length = 4]
#APP
		jr.hb	$2					

#NO_APP
	lw	$31,48($sp)	 # 316	movsi_internal/4	[length = 4]
	lw	$19,44($sp)	 # 317	movsi_internal/4	[length = 4]
	lw	$18,40($sp)	 # 318	movsi_internal/4	[length = 4]
	lw	$17,36($sp)	 # 319	movsi_internal/4	[length = 4]
	lw	$16,32($sp)	 # 320	movsi_internal/4	[length = 4]
	.set	noreorder
	.set	nomacro
	j	$31	 # 322	return_internal	[length = 4]
	addiu	$sp,$sp,56	 # 321	addsi3_internal/2	[length = 4]
	.set	macro
	.set	reorder

$L508:
	lui	$2,%hi(r4k_blast_dcache)	 # 67	movsi_internal/2	[length = 4]
	lw	$3,%lo(r4k_blast_dcache)($2)	 # 68	movsi_internal/4	[length = 4]
	jal	$3	 # 69	call_internal/1	[length = 8]
	.set	noreorder
	.set	nomacro
	b	$L512	 # 334	jump	[length = 4]
	lui	$3,%hi(icache_size)	 # 170	movsi_internal/2	[length = 4]
	.set	macro
	.set	reorder

$L506:
	.end	r4k_flush_icache_range

Please file a bug report at: "http://gcc.gnu.org/bugzilla/".

  Maciej

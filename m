Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5T0PfB21286
	for linux-mips-outgoing; Thu, 28 Jun 2001 17:25:41 -0700
Received: from dsic.co.kr ([210.221.126.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5T0PZV21283
	for <linux-mips@oss.sgi.com>; Thu, 28 Jun 2001 17:25:38 -0700
Received: from astonlinux.com [192.168.2.173] by dsic.co.kr [210.221.126.1]
	with SMTP (MDaemon.v3.5.6.R)
	for <linux-mips@oss.sgi.com>; Fri, 29 Jun 2001 09:24:02 +0900
Message-ID: <3B3C8288.51AD1CCB@astonlinux.com>
Date: Fri, 29 Jun 2001 09:28:40 -0400
From: =?EUC-KR?B?sK29xbHU?= <cosmos@astonlinux.com>
Organization: astonlinux
X-Mailer: Mozilla 4.75 [ko] (X11; U; Linux 2.2.16-21hl i686)
X-Accept-Language: ko
MIME-Version: 1.0
To: Ralph Metzler <rjkm@convergence.de>
CC: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: Help me.
References: <3B3B9C29.6898DC59@astonlinux.com> <15163.24240.316758.268911@valen.metzler>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 192.168.2.173
X-Return-Path: cosmos@astonlinux.com
X-MDaemon-Deliver-To: linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Ralph Metzler wrote:

> Hi,
>
> =?EUC-KR?B?sK29xbHU?= writes:
>  > I am trying to port a linux 2.4 to R3000 based system (LSI LOGIC
>  > SC2000).
>  > SC2000 have caches. one is Two-way set associative or direct mapped
>  > Instruction cache (16K) and another is Direct-mapped data cache(8K).
>
> I also spent one or two weeks with Linux on an SC2000 a while ago
> but had to stop due to other more important projects. I also ran
> into problems with the caching. Without caching I got it to boot
> via NFS. Anyway, at least one mistake is in this part:
>
>  > ---------------lsi-cache.S--------------------------------
>  >
>  > /* void flush_icache(void) */
>  > LEAF(flush_icache)
>  >         .set    noreorder
>  >
>  >         la      a3, icache_size     # 8Kbyte
>  >         lw      t4, 0(a3)
>  >
>  >         mfc0    t7, CP0_STATUS          # save SR
>  >         nop
>  >         nop
>  >
>  >         and     t0, t7, ~ST0_IEC        # disable interrupts
>  >         mtc0    t0, CP0_STATUS
>  >         nop
>  >         nop
>  >
>  >         li      t3, CBSYS             # BBCC configuration register
>  >         lw      t8, 0(t3)               # save config. register
>  >         nop
>  >
>  >         li      t0, KSEG0
>  >         or      t4, t4, t0              # end of I-cache
>  >
>  >         move    t5, t0
>  >
>  > 2:        la      t0, 3f                  # switch to Kseg1
>  >         or      t0, KSEG1
>  >         jr      t0
>  >         nop
>  >
>  > #
>  > # flush I-cache set 0
>  > #
>  > 3:
>  >         li      t0, (CFG_DCEN | CFG_ICEN)
>  >         or      t0, CFG_CMODE_ITEST     # I-cache set1 enable
>  >                                         # D-cache enable, I-cache set0
>  > enable
>  >                                         # I-cache software test
>  >         sw      t0, 0(t3)
>  >         lw      zero, 0(t3)
>  >         addi    zero, zero, 1
>  >
>  >         move    t0, t5
>  > 4:      sw      zero, (t0)
>  >         nop
>  >         lw      zero, (t0)
>  >         addu    t0, t6
>  >         bltu    t0, t4, 4b
>  >         nop
>
> Where does t6 get set?
> This bug already is in the LSI sample code.
> I think they just copied the loop code from the cache invalidation
> functions (where they actually do determine t6 from the cache
> line size) and forgot to adjust it.
>
> Best regards,
> Ralph
>
> --
> /--------------------------------------------------------------------\
> | Dr. Ralph J.K. Metzler         | Convergence integrated media      |
> |--------------------------------|-----------------------------------|
> | rjkm@convergence.de            | http://www.convergence.de/        |
> \--------------------------------------------------------------------/

Thank you.

I changed 't6' into '0x4'. but the problem is same.

Regards,
Shinkyu.

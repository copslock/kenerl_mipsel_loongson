Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 16:06:39 +0100 (BST)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.196]:58718 "EHLO
	mproxy.gmail.com") by linux-mips.org with ESMTP id <S8224929AbUHRPGe>;
	Wed, 18 Aug 2004 16:06:34 +0100
Received: by mproxy.gmail.com with SMTP id 76so182196rnk
        for <linux-mips@linux-mips.org>; Wed, 18 Aug 2004 08:06:27 -0700 (PDT)
Received: by 10.38.13.31 with SMTP id 31mr481878rnm;
        Wed, 18 Aug 2004 08:06:27 -0700 (PDT)
Message-ID: <e2eac65704081808061f27cb5a@mail.gmail.com>
Date: Wed, 18 Aug 2004 11:06:27 -0400
From: Tim Lai <tinglai@gmail.com>
Reply-To: Tim Lai <tinglai@gmail.com>
To: Eric DeVolder <eric.devolder@amd.com>, linux-mips@linux-mips.org
Subject: Re: problem with prefetch in user space
In-Reply-To: <41235841.6090105@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <e2eac65704081716345c78b7c6@mail.gmail.com> <41235841.6090105@amd.com>
Return-Path: <tinglai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tinglai@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks for the suggestion.
I tried it, and still got the same error:

/tmp/cc73TRSF.s:5521: Error: illegal operands `pref'


On Wed, 18 Aug 2004 08:23:13 -0500, Eric DeVolder <eric.devolder@amd.com> wrote:
> try ".set mips32" instead of ".set mips4"
> 
> 
> 
> Tim Lai wrote:
> 
> >I am trying to use prefetch in user space. I am using mips_fp_be-gcc
> >version 3.2.1,
> >and the kernel is MontaVista 2.4 kernel.
> >
> >I have a C program with the fellowing function:
> >
> >inline void mips_prefetch(void *addr)
> >{
> >    __asm__ __volatile__(
> >                         ".set push                  \n"
> >                         ".set noreorder             \n"
> >                         ".set noat                  \n"
> >                         ".set mips4                 \n"
> >
> >                         "     pref       4 ,  0(%0)  \n"
> >
> >                         ".set pop                   \n");
> >    return;
> >}
> >
> >When I compile with gcc,
> >/tmp/ccMHaOOf.s: Assembler messages:
> >/tmp/ccMHaOOf.s:5479: Error: illegal operands `pref'
> >make: *** [foo.o] Error 1
> >
> >I tried add -mips4 option in gcc, it got even worst,
> >
> >/tmp/ccN6Xs81.s: Assembler messages:
> >/tmp/ccN6Xs81.s:54: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:55: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:128: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:129: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:171: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:223: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:224: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:420: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:421: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:698: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:776: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:801: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:815: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:857: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:858: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:913: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:1308: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:1377: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:1402: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:1424: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:1462: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:1497: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:1498: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:1953: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:1954: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:2023: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2092: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2145: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2275: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2313: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:2314: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:2360: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:2361: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:2395: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:2396: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:2480: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:2481: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:2565: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2575: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2609: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2686: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2692: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2714: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2741: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2745: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2793: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2818: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2824: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2849: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2858: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2883: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:2948: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:2949: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:3036: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:3037: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:3109: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3260: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3388: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3393: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3446: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3458: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3469: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3486: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3543: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3631: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3677: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3695: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3715: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3739: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3805: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3829: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3840: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3858: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3935: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3941: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3963: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3982: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:3994: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4012: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4086: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4101: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4142: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:4143: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:4196: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4210: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4236: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4264: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4285: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4311: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4330: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4386: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:4387: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:4673: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4714: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4882: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:4948: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5014: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5067: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5179: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5282: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5366: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5382: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5441: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5585: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:5586: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:5685: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5690: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5705: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5782: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:5783: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:5808: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5816: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5880: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:5915: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:5916: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:5925: Error: illegal operands `pref'
> >/tmp/ccN6Xs81.s:5926: Error: illegal operands `pref'
> >/tmp/ccN6Xs81.s:5927: Error: illegal operands `pref'
> >/tmp/ccN6Xs81.s:5928: Error: illegal operands `pref'
> >/tmp/ccN6Xs81.s:5929: Error: illegal operands `pref'
> >/tmp/ccN6Xs81.s:5930: Error: illegal operands `pref'
> >/tmp/ccN6Xs81.s:5931: Error: illegal operands `pref'
> >/tmp/ccN6Xs81.s:5962: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:5963: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:6008: Error: illegal operands `lui'
> >/tmp/ccN6Xs81.s:6009: Error: illegal operands `addiu'
> >/tmp/ccN6Xs81.s:6024: Warning: No .cprestore pseudo-op used in PIC code
> >/tmp/ccN6Xs81.s:6035: Warning: No .cprestore pseudo-op used in PIC code
> >
> >Can anyone shine some light on this?
> >Is prefetch not mean for user program at all?
> >Have anyone got this to work?
> >
> >Thanks.
> >
> >Tim Lai
> >
> >
> >
> >
> 
>

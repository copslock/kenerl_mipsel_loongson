Received:  by oss.sgi.com id <S553750AbRCOH6R>;
	Wed, 14 Mar 2001 23:58:17 -0800
Received: from mx2.mips.com ([206.31.31.227]:16036 "EHLO mx2.mips.com")
	by oss.sgi.com with ESMTP id <S553746AbRCOH54>;
	Wed, 14 Mar 2001 23:57:56 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id XAA25932;
	Wed, 14 Mar 2001 23:57:54 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id XAA14104;
	Wed, 14 Mar 2001 23:57:49 -0800 (PST)
Message-ID: <001701c0ad26$31a91160$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Pete Popov" <ppopov@mvista.com>
Cc:     <linux-mips@oss.sgi.com>
References: <20010314084633.A25674@nevyn.them.org> <20010314195919.A1911@bacchus.dhis.org> <20010314140529.A29525@nevyn.them.org> <20010314202058.B1911@bacchus.dhis.org> <00fc01c0acd3$c881ca80$0deca8c0@Ulysses> <011001c0acd8$c27a9220$0deca8c0@Ulysses> <3AB01FCE.CDFA99C9@mvista.com>
Subject: Re: Can't build a CONFIG_CPU_NEVADA kernel
Date:   Thu, 15 Mar 2001 09:01:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> > Meanwhile, try piping objdump of a "-mmad" kernel
> > through "grep -i mad".  I'd be stunned if a single MADD
> > turned up.  If it gains nothing, but breaks builds, then
> > for heaven's sake banish -mmad from the kernel
> > makefiles!
> 
> I managed to compile a 2.4.2 kernel with our bleeding edge toolchain. I
> had to get rid of the -mmad from the Makefile though. The kernel boots
> and runs and I ran Bonnie over NFS as well as on an IDE hard disk. I
> tried some other tests as well, and they all passed.  
> 
> Without the -mmad flag, I see the following mad instructions below. No
> "madd" though, just madd.s, madd16, mad, etc. So, can we get rid of this
> flag in the Makefile?

"MAD" is a synonym for "MADD", but it looks as if this was
a grep of the output of "objdump --diassemble-all".  There
can't possibly be that many usefull floating point MADDs
in the kernel, and the actual bytes of the instructions look
suspiciously like ASCII strings.  Likewise, "MADD16" and
"DMADD16" are R4100 instructions with a different opcode
and semantics from the Nevada/MIPS32 MADD.  And of
course instructions like "mad $zero,$zero" aren't likely to
be real code.  It's pretty obvious from context, but you
should really confirm that address 0x802c07f4 is data
before we confirm that *no* MAD/MADDS are being
generated in the kernel.

It is certainly conceivable that MADDs in some form
could be used in the kernel.  Specifically, it would not
surprise me in the least to see them used in a software
modem on a VrLinux platform.  But those modules can
and should be handled seperately (and are probably
written in assembler anyway).  There's not need for
-mmad in the general set of flags.

            Kevin K.

> 
> 0000000080132690 <sys_madvise>:
>     801326dc:   1080fffc        beqz    $a0,801326d0 <sys_madvise+40>
>     801326e4:   04810004        bgez    $a0,801326f8 <sys_madvise+68>
>     801326f8:   5440002e        bnezl   $v0,801327b4 <sys_madvise+124>
>     80132714:   54400027        bnezl   $v0,801327b4 <sys_madvise+124>
>     8013271c:   12510024        beq     $s2,$s1,801327b0
> <sys_madvise+120>
>     80132734:   1200001e        beqz    $s0,801327b0 <sys_madvise+120>
>     80132744:   10400003        beqz    $v0,80132754 <sys_madvise+c4>
>     80132758:   1440000c        bnez    $v0,8013278c <sys_madvise+fc>
>     80132764:   10400007        beqz    $v0,80132784 <sys_madvise+f4>
>     80132770:   0c04c988        jal     80132620 <madvise_vma>
>     8013277c:   5660000d        bnezl   $s3,801327b4 <sys_madvise+124>
>     80132784:   0804c9ec        j       801327b0 <sys_madvise+120>
>     80132790:   0c04c988        jal     80132620 <madvise_vma>
>     8013279c:   56600005        bnezl   $s3,801327b4 <sys_madvise+124>
>     801327a8:   0804c9cd        j       80132734 <sys_madvise+a4>
>     801327c8:   1080fffc        beqz    $a0,801327bc <sys_madvise+12c>
>     801327d0:   1c800004        bgtz    $a0,801327e4 <sys_madvise+154>
>     80250590:   4d4d2030        nmadd.s $f0,$f10,$f4,$f13
>     80250a84:   4f4e2820        madd.s  $f0,$f26,$f5,$f14
>     802517bc:   00000029        dmadd16 $zero,$zero
>     80253c94:   00000029        dmadd16 $zero,$zero
>     802555a4:   00000029        dmadd16 $zero,$zero
>     80256178:   00000029        dmadd16 $zero,$zero
>     80259804:   4d445b20        madd.s  $f12,$f10,$f11,$f4
>     80259810:   4d445b20        madd.s  $f12,$f10,$f11,$f4
>     8025981c:   4d445b20        madd.s  $f12,$f10,$f11,$f4
>     8025aa34:   00000029        dmadd16 $zero,$zero
>     8025bbf0:   4c257830        nmadd.s $f0,$f1,$f15,$f5
>     802618a8:   4f2f4920        madd.s  $f4,$f25,$f9,$f15
>     80262018:   4e203a70        nmadd.s $f9,$f17,$f7,$f0
>     802625c4:   4c554e20        madd.s  $f24,$f2,$f9,$f21
>     80262700:   4c554e20        madd.s  $f24,$f2,$f9,$f21
>     80264d5c:   4c545220        madd.s  $f8,$f2,$f10,$f20
>     80264d64:   00000029        dmadd16 $zero,$zero
>     80265148:   4e203d21        madd.d  $f20,$f17,$f7,$f0
>     80265194:   4e203d21        madd.d  $f20,$f17,$f7,$f0
>     8026534c:   00000029        dmadd16 $zero,$zero
>     80265b50:   4f495020        madd.s  $f0,$f26,$f10,$f9
>     80265f70:   4c554e20        madd.s  $f24,$f2,$f9,$f21
>     80266294:   4e554c20        madd.s  $f16,$f18,$f9,$f21
>     802670bc:   4c4c4120        madd.s  $f4,$f2,$f8,$f12
>     80267690:   4d207361        madd.d  $f13,$f9,$f14,$f0
>     80267f5c:   00000029        dmadd16 $zero,$zero
>     80268314:   00000029        dmadd16 $zero,$zero
>     80268abc:   00000029        dmadd16 $zero,$zero
>     80269cd4:   4d435020        madd.s  $f0,$f10,$f10,$f3
>     8026a504:   00000029        dmadd16 $zero,$zero
>     8026df88:   4c4c5020        madd.s  $f0,$f2,$f10,$f12
>     8026e01c:   4c502070        nmadd.s $f1,$f2,$f4,$f16
>     8026f6bc:   4c622020        madd.s  $f0,$f3,$f4,$f2
>     8026f71c:   4e622020        madd.s  $f0,$f19,$f4,$f2
>     8026f944:   4c622020        madd.s  $f0,$f3,$f4,$f2
>     8026f9f0:   4d772020        madd.s  $f0,$f11,$f4,$f23
>     802702f8:   4d203231        nmadd.d $f8,$f9,$f6,$f0
>     80273830:   00000029        dmadd16 $zero,$zero
>     80276a24:   4f6d7361        madd.d  $f13,$f27,$f14,$f13
>     80277498:   4e203d21        madd.d  $f20,$f17,$f7,$f0
>     80279c10:   4d202020        madd.s  $f0,$f9,$f4,$f0
>     80279ea4:   4d434920        madd.s  $f4,$f10,$f9,$f3
>     8027c588:   4f494520        madd.s  $f20,$f26,$f8,$f9
>     80280048:   4d642520        madd.s  $f20,$f11,$f4,$f4
>     802802c8:   4d4f5220        madd.s  $f8,$f10,$f10,$f15
>     802a0e00:   4e414d20        madd.s  $f20,$f18,$f9,$f1
>     802a2988:   4c4f5720        madd.s  $f28,$f2,$f10,$f15
>     802a2a30:   00000029        dmadd16 $zero,$zero
>     802a2c14:   4f2f4920        madd.s  $f4,$f25,$f9,$f15
>     802a336c:   4f2f4920        madd.s  $f4,$f25,$f9,$f15
>     802a39e4:   00000029        dmadd16 $zero,$zero
>     802a3a00:   00000029        dmadd16 $zero,$zero
>     802a3a1c:   00000029        dmadd16 $zero,$zero
>     802a3a70:   00000029        dmadd16 $zero,$zero
>     802a3ac8:   00000029        dmadd16 $zero,$zero
>     802a3ad0:   4d353531        nmadd.d $f20,$f9,$f6,$f21
>     802a3b3c:   00000029        dmadd16 $zero,$zero
>     802a427c:   4f2f4920        madd.s  $f4,$f25,$f9,$f15
>     802a50bc:   4d4f4320        madd.s  $f12,$f10,$f8,$f15
>     802a5504:   4e414c20        madd.s  $f16,$f18,$f9,$f1
>     802a57ec:   4c2e6920        madd.s  $f4,$f1,$f13,$f14
>     802a5f18:   4f2f4920        madd.s  $f4,$f25,$f9,$f15
>     802a6378:   4d544120        madd.s  $f4,$f10,$f8,$f20
>     802a63b4:   4d207161        madd.d  $f5,$f9,$f14,$f0
>     802a6d5c:   00000029        dmadd16 $zero,$zero
>     802a6ea8:   4f2f4920        madd.s  $f4,$f25,$f9,$f15
>     802a6ebc:   4f2f4920        madd.s  $f4,$f25,$f9,$f15
>     802a73c0:   4e414c20        madd.s  $f16,$f18,$f9,$f1
>     802a74cc:   4e414c20        madd.s  $f16,$f18,$f9,$f1
>     802a75a0:   4f505420        madd.s  $f16,$f26,$f10,$f16
>     802a7994:   4d502031        nmadd.d $f0,$f10,$f4,$f16
>     802a7ac0:   4e414c20        madd.s  $f16,$f18,$f9,$f1
>     802a7b54:   4e206870        nmadd.s $f1,$f17,$f13,$f0
>     802a7e8c:   4d502820        madd.s  $f0,$f10,$f5,$f16
>     802a7f84:   4e5b2061        madd.d  $f1,$f18,$f4,$f27
>     802a7f90:   4e5b2061        madd.d  $f1,$f18,$f4,$f27
>     802a7f9c:   4e5b2061        madd.d  $f1,$f18,$f4,$f27
>     802a7fa8:   4e5b2061        madd.d  $f1,$f18,$f4,$f27
>     802a8068:   00000029        dmadd16 $zero,$zero
>     802a8290:   4d5b2030        nmadd.s $f0,$f10,$f4,$f27
>     802a8c94:   4f525020        madd.s  $f0,$f26,$f10,$f18
>     802a9088:   4e207370        nmadd.s $f13,$f17,$f14,$f0
>     802a94ec:   4d544120        madd.s  $f4,$f10,$f8,$f20
>     802a962c:   4d544120        madd.s  $f4,$f10,$f8,$f20
>     802a9c10:   00000029        dmadd16 $zero,$zero
>     802a9d64:   00000029        dmadd16 $zero,$zero
>     802a9d80:   00000029        dmadd16 $zero,$zero
>     802a9e2c:   00000029        dmadd16 $zero,$zero
>     802ab81c:   00000029        dmadd16 $zero,$zero
>     802ac17c:   00000029        dmadd16 $zero,$zero
>     802ac65c:   4d207861        madd.d  $f1,$f9,$f15,$f0
>     802ac740:   4d207861        madd.d  $f1,$f9,$f15,$f0
>     802ac79c:   4c525320        madd.s  $f12,$f2,$f10,$f18
>     802ad3e4:   4e206c61        madd.d  $f17,$f17,$f13,$f0
>     802ad954:   4d202d20        madd.s  $f20,$f9,$f5,$f0
>     802ae994:   4f2f4920        madd.s  $f4,$f25,$f9,$f15
>     802af200:   4e415720        madd.s  $f28,$f18,$f10,$f1
>     802b10cc:   4e414320        madd.s  $f12,$f18,$f8,$f1
>     802b167c:   4e454420        madd.s  $f16,$f18,$f8,$f5
>     802b1690:   4c554d20        madd.s  $f20,$f2,$f9,$f21
>     802b1d88:   4d4f4320        madd.s  $f12,$f10,$f8,$f15
>     802b1df0:   00000029        dmadd16 $zero,$zero
>     802b2428:   00000029        dmadd16 $zero,$zero
>     802b2458:   4d206e61        madd.d  $f25,$f9,$f13,$f0
>     802b30e0:   00000029        dmadd16 $zero,$zero
>     802b3140:   00000029        dmadd16 $zero,$zero
>     802b3c68:   00000029        dmadd16 $zero,$zero
>     802b3ff8:   4f525020        madd.s  $f0,$f26,$f10,$f18
>     802b4010:   4f525020        madd.s  $f0,$f26,$f10,$f18
>     802b4120:   4d472030        nmadd.s $f0,$f10,$f4,$f7
>     802b453c:   4f2f4920        madd.s  $f4,$f25,$f9,$f15
>     802b5d80:   00000029        dmadd16 $zero,$zero
>     802b6e38:   00000028        madd16  $zero,$zero
>     802b6e40:   00000029        dmadd16 $zero,$zero
>     802b7350:   00000028        madd16  $zero,$zero
>     802b80a8:   00000028        madd16  $zero,$zero
>     802b80b0:   00000029        dmadd16 $zero,$zero
>     802b81d8:   00000028        madd16  $zero,$zero
>     802b81e0:   00000029        dmadd16 $zero,$zero
>     802bdda4:   00000028        madd16  $zero,$zero
>     802bddd8:   00000028        madd16  $zero,$zero
>     802bde7c:   00000029        dmadd16 $zero,$zero
>     802bdeac:   00000028        madd16  $zero,$zero
>     802bdeb8:   00000028        madd16  $zero,$zero
>     802bdf14:   00000028        madd16  $zero,$zero
>     802be6d8:   00000028        madd16  $zero,$zero
>     802be764:   00000028        madd16  $zero,$zero
>     802c0578:   70000000        mad     $zero,$zero
>     802c07f4:   72070000        mad     $s0,$a3
>     802c1490:   00000028        madd16  $zero,$zero
>     802c957c:   00000029        dmadd16 $zero,$zero
>     802c96b0:   00000028        madd16  $zero,$zero
>     802ccdcc:   00000028        madd16  $zero,$zero
>     802cddb0:   00290028        madd16  $at,$t1
>     802cdfb0:   00290028        madd16  $at,$t1
>     802ce1b0:   00290028        madd16  $at,$t1
>     802ce6b8:   00290028        madd16  $at,$t1
>     802d4150:   4e534331        nmadd.d $f12,$f18,$f8,$f19
>     802d667c:   00000028        madd16  $zero,$zero
>     802d7614:   00290028        madd16  $at,$t1
>     802d9770:   00000028        madd16  $zero,$zero
>     802d9820:   00000029        dmadd16 $zero,$zero

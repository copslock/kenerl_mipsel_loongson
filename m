Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 12:26:31 +0100 (BST)
Received: from deliver-1.mx.triera.net ([IPv6:::ffff:213.161.0.31]:15532 "HELO
	deliver-1.mx.triera.net") by linux-mips.org with SMTP
	id <S8225072AbVIHL0P>; Thu, 8 Sep 2005 12:26:15 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id B6349BFF9;
	Thu,  8 Sep 2005 13:33:12 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id BBCE11BC086;
	Thu,  8 Sep 2005 13:33:15 +0200 (CEST)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 5C2F11A18A7;
	Thu,  8 Sep 2005 13:33:15 +0200 (CEST)
Subject: Re: MIPS SF toolchain
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	David Daney <ddaney@avtrex.com>
Cc:	crossgcc@sources.redhat.com, linux-mips@linux-mips.org
In-Reply-To: <1126168866.25388.11.camel@orionlinux.starfleet.com>
References: <1126098584.12696.19.camel@localhost.localdomain>
	 <431F0850.8090804@avtrex.com>
	 <1126168866.25388.11.camel@orionlinux.starfleet.com>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Thu, 08 Sep 2005 13:33:19 +0200
Message-Id: <1126179199.25389.20.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> Now I am trying with the:
> GCC: 4.1.0
> GLIBC: 2.3.5
> BINUTILS: 2.16.1
> Linux Headers: 2.6.11

Here are the results:
ligcc.a does not have any sf instructions.
busybox built as dynamic binary does not have any sf ins.
libc.so.6 has this:

-------------------------------------------------------------
0002fe80 <__longjmp>:
   2fe80:       c4940038        lwc1    $f20,56(a0)
   2fe84:       c495003c        lwc1    $f21,60(a0)
   2fe88:       c4960040        lwc1    $f22,64(a0)
   2fe8c:       c4970044        lwc1    $f23,68(a0)
   2fe90:       c4980048        lwc1    $f24,72(a0)
   2fe94:       c499004c        lwc1    $f25,76(a0)
   2fe98:       c49a0050        lwc1    $f26,80(a0)
   2fe9c:       c49b0054        lwc1    $f27,84(a0)
   2fea0:       c49c0058        lwc1    $f28,88(a0)
   2fea4:       c49d005c        lwc1    $f29,92(a0)
   2fea8:       c49e0060        lwc1    $f30,96(a0)
   2feac:       c49f0064        lwc1    $f31,100(a0)
   2feb0:       8c820030        lw      v0,48(a0)
   2feb4:       00000000        nop
   2feb8:       44c2f800        ctc1    v0,$31
   2febc:       8c9c002c        lw      gp,44(a0)
   2fec0:       8c900008        lw      s0,8(a0)
   2fec4:       8c91000c        lw      s1,12(a0)
   2fec8:       8c920010        lw      s2,16(a0)
   2fecc:       8c930014        lw      s3,20(a0)
   2fed0:       8c940018        lw      s4,24(a0)
   2fed4:       8c95001c        lw      s5,28(a0)
   2fed8:       8c960020        lw      s6,32(a0)
   2fedc:       8c970024        lw      s7,36(a0)
   2fee0:       8c990000        lw      t9,0(a0)
   2fee4:       8c9d0004        lw      sp,4(a0)
   2fee8:       8c9e0028        lw      s8,40(a0)
   2feec:       14a00005        bnez    a1,2ff04 <__longjmp+0x84>
   2fef0:       00000000        nop
   2fef4:       03200008        jr      t9
   2fef8:       24020001        li      v0,1
   2fefc:       1000ffff        b       2fefc <__longjmp+0x7c>
   2ff00:       00000000        nop
   2ff04:       03200008        jr      t9
   2ff08:       00a01021        move    v0,a1
   2ff0c:       1000fffb        b       2fefc <__longjmp+0x7c>
   2ff10:       00000000        nop
-------------------------------------------------------------
and
-------------------------------------------------------------
0002ff70 <__sigsetjmp_aux>:
   2ff70:       3c1c0017        lui     gp,0x17
   2ff74:       279cce40        addiu   gp,gp,-12736
   2ff78:       0399e021        addu    gp,gp,t9
   2ff7c:       00801021        move    v0,a0
   2ff80:       e4940038        swc1    $f20,56(a0)
   2ff84:       e495003c        swc1    $f21,60(a0)
   2ff88:       e4960040        swc1    $f22,64(a0)
   2ff8c:       e4970044        swc1    $f23,68(a0)
   2ff90:       e4980048        swc1    $f24,72(a0)
   2ff94:       e499004c        swc1    $f25,76(a0)
   2ff98:       e49a0050        swc1    $f26,80(a0)
   2ff9c:       e49b0054        swc1    $f27,84(a0)
   2ffa0:       e49c0058        swc1    $f28,88(a0)
   2ffa4:       e49d005c        swc1    $f29,92(a0)
   2ffa8:       e49e0060        swc1    $f30,96(a0)
   2ffac:       e49f0064        swc1    $f31,100(a0)
   2ffb0:       ac9f0000        sw      ra,0(a0)
   2ffb4:       ac860004        sw      a2,4(a0)
   2ffb8:       ac870028        sw      a3,40(a0)
   2ffbc:       ac9c002c        sw      gp,44(a0)
   2ffc0:       ac900008        sw      s0,8(a0)
   2ffc4:       ac91000c        sw      s1,12(a0)
   2ffc8:       ac920010        sw      s2,16(a0)
   2ffcc:       ac930014        sw      s3,20(a0)
   2ffd0:       ac940018        sw      s4,24(a0)
   2ffd4:       ac95001c        sw      s5,28(a0)
   2ffd8:       ac960020        sw      s6,32(a0)
   2ffdc:       ac970024        sw      s7,36(a0)
   2ffe0:       8f9982a8        lw      t9,-32088(gp)
   2ffe4:       4443f800        cfc1    v1,$31
   2ffe8:       03200008        jr      t9
   2ffec:       ac430030        sw      v1,48(v0)
-------------------------------------------------------------

I did:
mipsel-linux-objdump -S libc.so.6 | less 
and then searching for $f (floating point registers)

If I link busybox static, I get those two functions linked in.

How to solve this?

One more thing.
I can compile strace only with gcc-3.3.4. With any other version
I get:
syscall.c:449: error: 'SYS_read' undeclared (first use in this function)

I applayed the patch for this, but it doesn't seem to help.

BR,
Matej

Received:  by oss.sgi.com id <S42259AbQGRW36>;
	Tue, 18 Jul 2000 15:29:58 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:11566 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42235AbQGRW3Z>; Tue, 18 Jul 2000 15:29:25 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA08309; Tue, 18 Jul 2000 15:34:42 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA61923;
	Tue, 18 Jul 2000 15:28:44 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: by calypso.engr.sgi.com (Postfix, from userid 37984)
	id B71C1A7875; Tue, 18 Jul 2000 15:27:23 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14708.55755.682163.57386@calypso.engr.sgi.com>
Date:   Tue, 18 Jul 2000 15:27:23 -0700 (PDT)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     wrasman@cs.utk.edu, linux-mips@oss.sgi.com
Subject: Re: Okay, lost
In-Reply-To: <20000718052309.B12440@bacchus.dhis.org>
References: <20000717205303.A14220@enchanted.net>
	<20000718052309.B12440@bacchus.dhis.org>
X-Mailer: VM 6.75 under Emacs 20.5.1
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

 > > Okay, I can't seem to get any of the pre-compiled linux kernels  after the 2.2.14 one on oss.sgi.com to boot on my Indy.
 > > 
 > > I get this type of error:
 > > Exception: <vector=Normal>
 > > Status register: 0x10044803<CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
 > > Cause register: 0x8034<CE=0,IP8,EXC=TRAP>
 > > Exception PC: 0x88240004, Exception RA: 0x8816d610
 > > Processor Trap exception at address 0xffffffff
 > > Local I/O interrupt register 1: 0x80 <VR/GIO2>
 > > 	Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
 > > 	arg: a8740000 28 8847ff80 a
 > > 	tmp: a8740000 8480 88002000 8480 881932a0 1 fffffffc 47dfa8
 > > 	sve: a8740000 0 0 0 0 0 0 0
 > > 	t8 a8740000 t9 0 at 0 v0 0 v1 0 k1 88002000
 > > 	gp a8740000 fp 0 sp 0 ra 0
 > > 
 > > PANIC: unexpected exception
 > 
 > Now that looks like a kernel compiled by somebody who doesn't read
 > documentation, see http://oss.sgi.com/mips/mips-howto.html.  In short:
 > remove the -N linker flag from arch/mips/Makefile.

I had the same problem on one of my machines.  The -N linker flag was
not the solution.  Note that the kernels ran on other machines.  I
only got this for the 2.4, not 2.2.

Ulf

Received:  by oss.sgi.com id <S42235AbQGRBxx>;
	Mon, 17 Jul 2000 18:53:53 -0700
Received: from m3bhNs1n20.midsouth.rr.com ([24.24.110.20]:17414 "EHLO
        GroundZero.enchanted.net") by oss.sgi.com with ESMTP
	id <S42227AbQGRBxj>; Mon, 17 Jul 2000 18:53:39 -0700
Received: from talisman.enchanted.net (root@talisman.enchanted.net [10.20.30.50])
	by GroundZero.enchanted.net (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id UAA21506
	for <linux-mips@oss.sgi.com>; Mon, 17 Jul 2000 20:53:06 -0500
Received: (from awrasman@localhost)
	by talisman.enchanted.net (8.11.0.Beta1/8.11.0.Beta1/Debian 8.11.0-1) id e6I1r5s14234
	for linux-mips@oss.sgi.com; Mon, 17 Jul 2000 20:53:05 -0500
From:   "A. Wrasman" <awrasman@enchanted.net>
Date:   Mon, 17 Jul 2000 20:53:03 -0500
To:     linux-mips@oss.sgi.com
Subject: Okay, lost
Message-ID: <20000717205303.A14220@enchanted.net>
Reply-To: wrasman@cs.utk.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Url:  http://www.cs.utk.edu/~wrasman
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Okay, I can't seem to get any of the pre-compiled linux kernels  after the 2.2.14 one on oss.sgi.com to boot on my Indy.

I get this type of error:
Exception: <vector=Normal>
Status register: 0x10044803<CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x8034<CE=0,IP8,EXC=TRAP>
Exception PC: 0x88240004, Exception RA: 0x8816d610
Processor Trap exception at address 0xffffffff
Local I/O interrupt register 1: 0x80 <VR/GIO2>
	Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
	arg: a8740000 28 8847ff80 a
	tmp: a8740000 8480 88002000 8480 881932a0 1 fffffffc 47dfa8
	sve: a8740000 0 0 0 0 0 0 0
	t8 a8740000 t9 0 at 0 v0 0 v1 0 k1 88002000
	gp a8740000 fp 0 sp 0 ra 0

PANIC: unexpected exception


Or something similar.

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Sep 2004 08:04:58 +0100 (BST)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:37789 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8224829AbUIHHEy>; Wed, 8 Sep 2004 08:04:54 +0100
Received: by the-doors.enix.org (Postfix, from userid 1105)
	id 936711EF6D; Wed,  8 Sep 2004 09:04:48 +0200 (CEST)
Date: Wed, 8 Sep 2004 09:04:48 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: linux-mips@linux-mips.org
Cc: dank@kegel.com
Subject: Re: Missing include/asm-mips/reg.h ?
Message-ID: <20040908070448.GS32393@enix.org>
References: <20040907164903.GB32393@enix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907164903.GB32393@enix.org>
User-Agent: Mutt/1.5.4i
Return-Path: <thomas@the-doors.enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

Hello,

On Tue, Sep 07, 2004 at 06:49:03PM +0200, Thomas Petazzoni wrote :
> While trying to compile uClibc, I get an error concerning Linux kernel
> headers. The file include/asm-mips/user.h includes the file asm/reg.h,
> but the file include/asm-mips/reg.h doesn't exist. So the EF_SIZE symbol
> required by the definition of the user structure is not declared.
> 
> I checked the linux-mips CVS but couldn't find this file.

I exchanged a couple of mails with Thiemo Seufer who tried to help solve
this problem. It appears that include/asm-mips/reg.h is automatically
generated at compile time, by the arch/mips/Makefile (prepare target).
(I use a 2.6.x kernel).

In fact, I'm trying to generate a cross-compilation chain for MIPS
(using Dan Kegel's crosstools). So, I need the kernel headers, but I'm
not able to compile the kernel since I'm generating the cross-compiler
itself.

When I try to generate the 'prepare' target in the main directory of
the kernel source tree, it starts compiling files in scripts/ using the
MIPS compiler (which isn't available at this time).

How can I generate this include/asm-mips/reg.h file (and possibly other
automatically generated includes) without starting kernel compilation ?
Of course, I provide a .config file to the kernel.

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org 
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

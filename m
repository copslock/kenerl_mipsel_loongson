Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 04:44:43 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:45003 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225200AbTDDDom>;
	Fri, 4 Apr 2003 04:44:42 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP id C38773700
	for <linux-mips@linux-mips.org>; Thu,  3 Apr 2003 21:44:32 -0600 (CST)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h343iW6D045171
	for <linux-mips@linux-mips.org>; Thu, 3 Apr 2003 21:44:32 -0600 (CST)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h343iV7N045170
	for linux-mips@linux-mips.org; Fri, 4 Apr 2003 03:44:31 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from tc1-41.lindstrom.cornernet.com (tc1-41.lindstrom.cornernet.com [207.195.212.115]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Fri,  4 Apr 2003 03:44:31 +0000
Message-ID: <1049427871.3e8cff9f9c50e@my.visi.com>
Date: Fri,  4 Apr 2003 03:44:31 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: linux-mips@linux-mips.org
Subject: Unknown ARCS message/hang
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 207.195.212.115
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips



Hello all;

I'm working on getting mips-linux up and running on my Octane, which may be an
impossible task.  I am new to the MIPS architecture, and I'm absorbing a lot of
information rapidly from MIPS Inc. manuals, See MIPS Run, et. al., but I have
been banging my head against the wall for a couple days trying to get a simple
problem fixed.

First, my Octane works just fine with Irix 6.5.17.  Configuration is a R12K
CPU/300 mhz, 256MB RAM, 1 18G disk, ethernet connection.  I boot using bootp. 
I've used the network to boot fx, a copy of the irix kernel, etc.

I get the following messages when I try to boot the (very slightly) modified
linux kernel I am working with:

--start messages

Obtaining /vmlinux.64 from server
1813568+1150976+172144 entry: 0xa8000000211c4000

*** PROM write error on cacheline 0x1fcd3b00 at PC=0x211c4018 RA=0xffffffff9fc5ace4

--end messages

The PC address is the first instruction in head.S (mips64) that touches the
control register.  I've tried multiple fixes, including initializing the whole
TLB before the error occurs.  Same error.

Can anyone tell me:

1) What does this error text mean exactly? 

2) What is "RA"?  The address is a location in the PROM text/stack section.

3) Am I missing something simple?  An initialization, a rule I'm not following?

objdump of the head.S I am using is below.

Thanks for any clues you can provide.  I'm excited to get working on this
machine if I can just learn MIPS =\

Erik

Disassembly of section .text.init:

a8000000211c4000 <kernel_entry>:
a8000000211c4000:       37bd000f        ori     sp,sp,0xf
a8000000211c4004:       3bbd000f        xori    sp,sp,0xf
a8000000211c4008:       3c0c211c        lui     t0,0x211c
a8000000211c400c:       258c4018        addiu   t0,t0,16408
a8000000211c4010:       01800008        jr      t0
a8000000211c4014:       00000000        nop
a8000000211c4018:       400c6000        mfc0    t0,$12
a8000000211c401c:       3c0d1000        lui     t1,0x1000
a8000000211c4020:       35ad001f        ori     t1,t1,0x1f
a8000000211c4024:       018d6025        or      t0,t0,t1
a8000000211c4028:       398c001f        xori    t0,t0,0x1f
a8000000211c402c:       408c6000        mtc0    t0,$12
a8000000211c4030:       3c1c211c        lui     gp,0x211c
a8000000211c4034:       279c0000        addiu   gp,gp,0
a8000000211c4038:       679d3fe0        daddiu  sp,gp,16352
a8000000211c403c:       8f8c0060        lw      t0,96(gp)



-- 
Erik J. Green
erik@greendragon.org

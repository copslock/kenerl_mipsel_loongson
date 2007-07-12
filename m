Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 18:07:05 +0100 (BST)
Received: from mra01.ch.as12513.net ([82.153.254.69]:37327 "EHLO
	mra01.ch.as12513.net") by ftp.linux-mips.org with ESMTP
	id S20022611AbXGLRHD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 18:07:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by mra01.ch.as12513.net (Postfix) with ESMTP id 84B8128C427
	for <linux-mips@linux-mips.org>; Thu, 12 Jul 2007 18:06:27 +0100 (BST)
Received: from mra01.ch.as12513.net ([127.0.0.1])
 by localhost (mra01.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 07912-01-7 for <linux-mips@linux-mips.org>;
 Thu, 12 Jul 2007 18:06:26 +0100 (BST)
Received: from mcrowe.com (deneb.mcrowe.com [82.152.148.4])
	by mra01.ch.as12513.net (Postfix) with ESMTP id 4424728C370
	for <linux-mips@linux-mips.org>; Thu, 12 Jul 2007 18:06:26 +0100 (BST)
Received: from mac by mcrowe.com with local (Exim 4.63)
	(envelope-from <mac@mcrowe.com>)
	id 1I927U-0008KG-PK
	for linux-mips@linux-mips.org; Thu, 12 Jul 2007 18:06:24 +0100
Date:	Thu, 12 Jul 2007 18:06:24 +0100
From:	Mike Crowe <mac@mcrowe.com>
To:	linux-mips@linux-mips.org
Subject: Strange gp corruption problem
Message-ID: <20070712170624.GA31776@mcrowe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-url:	http://www.mcrowe.com/
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <mac@mcrowe.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mac@mcrowe.com
Precedence: bulk
X-list: linux-mips

I'm seeing a rather strange problem on an NXP PNX8550 board we're
using (the PNX8550 is a SoC with a MIPS PR4450 core) and I'm wondering
if anyone here has ever seen anything similar or have any particular
advice as to how it can be investigated. I've searched the list
archives, googled, diffed with 2.6.22 etc. but not found anything
revealing. :(

We're using gcc 4.0.0 (from ELDK-4.0) on a 2.6.19 kernel with
glibc/LinuxThreads 2.3.5. I realise that this version of gcc is quite
old but it's the version used by the chip vendor for this platform.

The problem is easy to reproduce with a particular build of our
software but goes away very easily if code is changed, particularly
changes that affect the GOT or move code around. Even adding a single
"nop" instruction to the offending function "fixes the problem" This
is making it hard to debug.

We have a function that does some string manipulation (not
particularly dangerous manipulation and I've been through it
carefully) and then calls atol. As expected the prologue of this
function calculates the value of the gp register by applying an offset
to the t9 register which contains the address of the start of the
function like this:

 47995c:       3c1c0fba        lui     gp,0xfba
 479960:       279c1fe4        addiu   gp,gp,8164
 479964:       0399e021        addu    gp,gp,t9
 479968:       27bdff80        addiu   sp,sp,-128
 47996c:       afbf007c        sw      ra,124(sp)
 479970:       afbe0078        sw      s8,120(sp)
 479974:       03a0f021        move    s8,sp
 479978:       afbc0010        sw      gp,16(sp)
 47997c:       afc40080        sw      a0,128(s8)
 479980:       afc50084        sw      a1,132(s8)

The function then doesn't go near the t9 or gp registers until it it
needs to read the address of the atol function from the GOT and it
does so like this:

 479a98:       8f99a7c4        lw      t9,-22588(gp)
 479a9c:       00402021        move    a0,v0
 479aa0:       0320f809        jalr    t9
 479aa4:       00000000        nop

At this point it segfaults because gp has an invalid value of
0x10497280.  t9 still has the correct value of 0x47995c. 16(sp) (see
479978 above) also has the incorrect value of gp of 0x10497280.

The correct value for gp in this binary is 0x1001b940.

Interestingly the bad and good gp values are related in the following
way:

 0x1001b940 (correct value of gp)
+  0x47995c (address of this function == t9)
+    0x1fe4 (second part of gp fixup (8164 in decimal) from 479960 above)
=0x10497280 (bad value of gp)

This implies that upon execution of the instruction at 0x479960 gp
contained the "good" gp value of 0x1001b940 rather than the 0x0fba0000
it should have contained according to the previous instruction.

The only user-space reason I can come up with for this happening is if
the caller jumped into this function one instruction late. This seems
unlikely because t9 contains the correct value and the stack looks
fine. By instrumenting the kernel I determined that no signals are
being delivered around this time but instrumenting all context
switches looked rather hard.

TIA. Any advice gratefully received.

Mike.

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2003 04:20:12 +0000 (GMT)
Received: from web21327.mail.yahoo.com ([IPv6:::ffff:216.136.175.216]:33980
	"HELO web21327.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225310AbTLWEUL>; Tue, 23 Dec 2003 04:20:11 +0000
Message-ID: <20031223041929.33936.qmail@web21327.mail.yahoo.com>
Received: from [12.33.17.145] by web21327.mail.yahoo.com via HTTP; Mon, 22 Dec 2003 20:19:29 PST
Date: Mon, 22 Dec 2003 20:19:29 -0800 (PST)
From: Vince Jameson <vjv0vjv@yahoo.com>
Subject: SCO heads-up
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <vjv0vjv@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vjv0vjv@yahoo.com
Precedence: bulk
X-list: linux-mips

I don't mean to bring up an unpleasant subject, but as
part of their latest antics, those wacky SCO folks are
claiming a list of 65 header files that were
supposedly copied verbatim into Linux from their
proprietary Unix codebase.  Among these files are
eight that are specific to the MIPS platform: 
include/asm-mips/errno.h, include/asm-mips64/errno.h,
include/asm-mips/signal.h,
include/asm-mips64/signal.h, include/asm-mips/ioctl.h,
include/asm-mips64/ioctl.h,
include/asm-mips64/ioctls.h, and
arch/mips/boot/ecoff.h.  

No, I am not making this up.  I swear.  They're really
claiming this.  Groklaw has a lively discussion going
about the whole topic, of course.  

In the near future, there are probably going to be
lawyers and other random people in suits wanting to
know precisely where these headers came from and how
they came to be, so I figured I should drop a heads-up
to the list.  

Vince

__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/

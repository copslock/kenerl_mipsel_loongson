Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 10:22:28 +0000 (GMT)
Received: from netlx050.vf.utwente.nl ([IPv6:::ffff:192.87.17.19]:62160 "EHLO
	netlx050.vf.utwente.nl") by linux-mips.org with ESMTP
	id <S8225550AbUA2KW2>; Thu, 29 Jan 2004 10:22:28 +0000
Received: from ringbreak.dnd.utwente.nl (ringbreak.dnd.utwente.nl [130.89.175.240])
          by netlx050.vf.utwente.nl (8.11.7/HKD) with ESMTP id i0TAMF001087
          for <linux-mips@linux-mips.org>; Thu, 29 Jan 2004 11:22:15 +0100
Received: from jorik by ringbreak.dnd.utwente.nl with local (Exim 3.35 #1 (Debian))
	id 1Am9JP-0004h8-00
	for <linux-mips@linux-mips.org>; Thu, 29 Jan 2004 11:22:15 +0100
Date: Thu, 29 Jan 2004 11:22:15 +0100
From: Jorik Jonker <linux-mips@boeventronie.net>
To: linux-mips@linux-mips.org
Subject: linux 2.4 and Indy
Message-ID: <20040129102215.GC17760@ballina>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-UTwente-MailScanner-Information: Scanned by MailScanner. Contact helpdesk@ITBE.utwente.nl for more information.
X-UTwente-MailScanner: Found to be clean
Return-Path: <jorik@dnd.utwente.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@boeventronie.net
Precedence: bulk
X-list: linux-mips

Hi,

I'm having big trouble getting linux 2.4.* to work on my SGI Indy. I want to
use my indycam, and thus compile a kernel with support for that. The problem
is that all the kernels I built do boot, but freeze some moments after
starting the init process. The only kernels that do not have this problem are 
2.4.16 and 2.4.17, but they do not have proper VINO support (they lack the
i2c algo-sgi part).
Is there some patch flying around to fix this, or do I just have bad luck?

/proc/cpuinfo:
system type             : SGI Indy
processor               : 0
cpu model               : R4600 V1.0  FPU V0.0
BogoMIPS                : 99.73
byteorder               : big endian
wait instruction        : yes
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available

cheers,
-- 
Jorik Jonker
http://boeventronie.net/

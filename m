Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 00:09:39 +0100 (BST)
Received: from parcelfarce.linux.theplanet.co.uk ([IPv6:::ffff:195.92.249.252]:41364
	"EHLO www.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225523AbTJUXJg>; Wed, 22 Oct 2003 00:09:36 +0100
Received: from willy by www.linux.org.uk with local (Exim 4.22)
	id 1AC5d6-0007t7-2Q; Wed, 22 Oct 2003 00:09:32 +0100
Date: Wed, 22 Oct 2003 00:09:32 +0100
From: Matthew Wilcox <willy@debian.org>
To: Ralf Baechle <ralf@linux-mips.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Jeff Dike <jdike@karaya.com>
Cc: linux-mips@linux-mips.org,
	user-mode-linux-devel@lists.sourceforge.net
Subject: asm/smplock.h is dead
Message-ID: <20031021230932.GM18370@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <willy@www.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@debian.org
Precedence: bulk
X-list: linux-mips


asm/smplock.h is dead, you're the only three arches that still have it.
Can you delete next time you merge?  Thanks.

$ find -type f |xargs grep smplock.h      
./arch/mips/sibyte/sb1250/bcm1250_tbprof.c:#include <asm/smplock.h>
./include/asm-h8300/smplock.h: * <asm/smplock.h>
./include/asm-um/smplock.h:#include "asm/arch/smplock.h"
$ find -name smplock.h
./include/asm-h8300/smplock.h
./include/asm-mips/smplock.h
./include/asm-um/smplock.h

(the sibyte driver can just lose this line.  it doesn't do any SMP locking)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk

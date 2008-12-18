Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 00:14:21 +0000 (GMT)
Received: from mail.codesourcery.com ([65.74.133.4]:15782 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S24208015AbYLRAOQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Dec 2008 00:14:16 +0000
Received: (qmail 2614 invoked from network); 18 Dec 2008 00:14:13 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 18 Dec 2008 00:14:13 -0000
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.68)
	(envelope-from <joseph@codesourcery.com>)
	id 1LD6Wq-0008Tu-Lf
	for linux-mips@linux-mips.org; Thu, 18 Dec 2008 00:14:12 +0000
Date:	Thu, 18 Dec 2008 00:14:12 +0000 (UTC)
From:	"Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:	linux-mips@linux-mips.org
Subject: N32 fallocate syscall
Message-ID: <Pine.LNX.4.64.0812180009000.31179@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

The N32 syscall table uses sys_fallocate instead of sys32_fallocate.  
However, glibc expects to be using the syscall version with 32-bit 
arguments on N32, which should work with sys32_fallocate but not 
sys_fallocate.

What should the N32 interface for this syscall be?  My inclination is that 
glibc is right not to do anything special and different from other 32-bit 
ABIs here, and so sys32_fallocate should be used.

(glibc is also expecting the 32-bit version for N64, but that's a clear 
bug in glibc that I'll be fixing.)

-- 
Joseph S. Myers
joseph@codesourcery.com

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 11:31:03 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:2971 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133495AbWAYLaS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 11:30:18 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id 076E831C1AC; Wed, 25 Jan 2006 20:34:41 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Wed, 25 Jan 2006 11:34:40 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id E25C3420196; Wed, 25 Jan 2006 20:34:46 +0900 (JST)
Date:	Wed, 25 Jan 2006 20:34:46 +0900
To:	linux-kernel@vger.kernel.org
Cc:	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: [PATCH 5/6] fix warning on test_ti_thread_flag()
Message-ID: <20060125113446.GF18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125112625.GA18584@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From:	mita@miraclelinux.com (Akinobu Mita)
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

If the arechitecture is
- BITS_PER_LONG == 64
- struct thread_info.flag 32 is bits
- second argument of test_bit() was void *

Then compiler print error message on test_ti_thread_flags()
in include/linux/thread_info.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
---
 thread_info.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-git/include/linux/thread_info.h
===================================================================
--- 2.6-git.orig/include/linux/thread_info.h	2006-01-25 19:07:12.000000000 +0900
+++ 2.6-git/include/linux/thread_info.h	2006-01-25 19:14:26.000000000 +0900
@@ -49,7 +49,7 @@
 
 static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 {
-	return test_bit(flag,&ti->flags);
+	return test_bit(flag, (void *)&ti->flags);
 }
 
 #define set_thread_flag(flag) \

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 01:23:46 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:29255 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133427AbWBCBW0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 01:22:26 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id 2D14031C2DA; Fri,  3 Feb 2006 10:27:37 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Fri, 03 Feb 2006 01:27:37 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 34BC54201E0; Fri,  3 Feb 2006 10:27:35 +0900 (JST)
Date:	Fri, 3 Feb 2006 10:27:35 +0900
To:	Rune Torgersen <runet@innovsys.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	linux-m68k@lists.linux-m68k.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, Andi Kleen <ak@suse.de>,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>,
	parisc-linux@parisc-linux.org, akpm@osdl.org,
	Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] fix generic_fls64()
Message-ID: <20060203012735.GA21567@miraclelinux.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859547@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859547@ismail.innsys.innovsys.com>
User-Agent: Mutt/1.5.9i
From:	mita@miraclelinux.com (Akinobu Mita)
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

Noticed by Rune Torgersen.

fix generic_fls64().
tcp_cubic is using fls64().

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/bitops.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-git/include/linux/bitops.h
===================================================================
--- 2.6-git.orig/include/linux/bitops.h
+++ 2.6-git/include/linux/bitops.h
@@ -81,7 +81,7 @@ static inline int generic_fls64(__u64 x)
 {
 	__u32 h = x >> 32;
 	if (h)
-		return fls(x) + 32;
+		return fls(h) + 32;
 	return fls(x);
 }
 

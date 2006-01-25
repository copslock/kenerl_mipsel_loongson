Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 11:22:19 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:49817 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S8133456AbWAYLWC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 11:22:02 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id EAF4831C180; Wed, 25 Jan 2006 20:26:19 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Wed, 25 Jan 2006 11:26:19 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id F2B29420196; Wed, 25 Jan 2006 20:26:25 +0900 (JST)
Date:	Wed, 25 Jan 2006 20:26:25 +0900
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
Subject: [PATCH 0/6] RFC: use include/asm-generic/bitops.h
Message-ID: <20060125112625.GA18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	mita@miraclelinux.com (Akinobu Mita)
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

Large number of boilerplate bit operations written in C-language
are scattered around include/asm-*/bitops.h.
These patch series gather them into include/asm-generic/bitops.h. And

- kill duplicated code and comment (about 4000lines)
- use better C-language equivalents
- help porting new architecture (now include/asm-generic/bitops.h is not
  referenced from anywhere)

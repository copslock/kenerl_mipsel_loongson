Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2008 23:30:31 +0100 (BST)
Received: from hall2.aurel32.net ([91.121.138.14]:5517 "EHLO hall2.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20036868AbYDTWa3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 20 Apr 2008 23:30:29 +0100
Received: from aurel32 by hall2.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1Jni3I-0002Xh-1c; Mon, 21 Apr 2008 00:30:28 +0200
Date:	Mon, 21 Apr 2008 00:30:28 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/4] MIPS BCM47xx patches (resend)
Message-ID: <20080420223028.GA9282@hall2.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The following 4 patches have been sent 2 months ago, but they haven't
been been merged yet and I haven't received any comment. I am resending 
them again, in the hope to see them merged for 2.6.26.

The first patch is really important to make PCI working again on this
platform (broken since 2.6.24).

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

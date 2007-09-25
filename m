Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 14:42:03 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:33950 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20023089AbXIYNmB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2007 14:42:01 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1IaAch-0003ij-6s; Tue, 25 Sep 2007 15:38:47 +0200
Date:	Tue, 25 Sep 2007 15:38:47 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/4] Rename BCM947XX into BCM47XX
Message-ID: <20070925133847.GA14227@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The following 4 patches are replacing 4 already merged patches in order
to rename BCM947XX into BCM47XX. I have been explained that the '9' in
the name mean "development board", while the code refers to the CPU.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

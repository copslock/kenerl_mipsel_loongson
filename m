Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2007 07:57:21 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:37305 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20022132AbXIEG5K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2007 07:57:10 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1ISooy-0004R6-Mz
	for linux-mips@linux-mips.org; Wed, 05 Sep 2007 08:57:04 +0200
Date:	Wed, 5 Sep 2007 08:57:04 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH 0/2][MIPS] Move platform independent firmware code into arch/mips/fw
Message-ID: <20070905065704.GA16802@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The two following patches move platform independent firmware code, ie 
CFE and ARC, into arch/mips/fw.  This way they can be used on other 
platforms.

The patches look big but that's just because some files are moved, they
are actually almost trivial.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

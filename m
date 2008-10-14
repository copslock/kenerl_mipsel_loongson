Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 10:40:47 +0100 (BST)
Received: from hall.aurel32.net ([88.191.82.174]:20103 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S21457223AbYJNJkp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 10:40:45 +0100
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1KpgOS-0007hW-EC; Tue, 14 Oct 2008 11:40:44 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1KpgOR-00070J-Su; Tue, 14 Oct 2008 11:40:43 +0200
Date:	Tue, 14 Oct 2008 11:40:43 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/5] BCM47xx patches for 2.6.28
Message-ID: <20081014094043.GA26560@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The following patches are a resent of patches sent earlier in order to
support the BCM47xx chips: 

      [MIPS] WGT634U: Add machine detection message
      [MIPS] Remove references to BCM947XX
      [MIPS] BCM47xx: Use the new SSB GPIO API
      [MIPS] Add WGT634U reset button support
      [MIPS] Scan PCI busses when they are registered

Compared to the previous version, one patch has been merged, and the
second patch has been updated to reflect the new location of this file.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

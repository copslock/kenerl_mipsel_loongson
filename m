Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2008 20:18:50 +0100 (BST)
Received: from hall.aurel32.net ([91.121.138.14]:30696 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S29061837AbYIXTSn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2008 20:18:43 +0100
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZsn-0003g9-Rk; Wed, 24 Sep 2008 21:18:42 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZsm-00056s-Kq; Wed, 24 Sep 2008 21:18:40 +0200
Date:	Wed, 24 Sep 2008 21:18:40 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 0/6] BCM47xx patches
Message-ID: <20080924191840.GA18700@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The following patches are a resent of patches sent early this year in
order to support the BCM47xx chips: 

      [MIPS] BCM47xx: Add platform specific PCI code
      [MIPS] WGT634U: Add machine detection message
      [MIPS] Remove references to BCM947XX
      [MIPS] BCM47xx: Use the new SSB GPIO API
      [MIPS] Add WGT634U reset button support
      [MIPS] Scan PCI busses when they are registered

The first one fixes a build failure of the BCM47xx sub-architecture that
has been introduced sometimes ago. IMHO it should really be in 2.6.27.

Patches 2 and 3 are very simple patches that IMHO may be merged in
2.6.27 without too much risks.

For the following patches, it may be better to wait for 2.6.28 as they
are a little more complex. The last patch of the series also fixes
something important, that is the detection of PCI busses (and hence PCI 
devices) on the BCM47xx SOC.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

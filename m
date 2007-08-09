Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 01:09:04 +0100 (BST)
Received: from mail.onstor.com ([66.201.51.107]:65343 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20021404AbXHIAI4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2007 01:08:56 +0100
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 8 Aug 2007 17:08:48 -0700
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 8 Aug 2007 17:08:48 -0700
Date:	Wed, 8 Aug 2007 17:08:46 -0700
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	linux-mips@linux-mips.org
Subject: kexec - not happening on mipsel?
Message-ID: <20070808170846.7d395891@ripper.onstor.net>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Aug 2007 00:08:48.0599 (UTC) FILETIME=[75A2CE70:01C7DA19]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips

We could sure make use of kexec for quick reboots (it bloody takes
forever for the PROM to set up ECC memory).  The config option is in
Kconfig; I haven't checked the kernel source.  But the userspace package
kexec-tools barfs on the mipsel arch in configure.

Is anybody using this on MIPS?  Do the kernel portions work for anyone?

Cheers,

a


kexec-tools-1.101-kdump10$ dpkg-buildpackage -us -uc -nc -b -d -rfakeroot
dpkg-buildpackage: source package is kexec-tools
dpkg-buildpackage: source version is 1.101-kdump10-2
dpkg-buildpackage: source changed by Khalid Aziz <khalid@debian.org>
dpkg-buildpackage: host architecture mipsel
dpkg-buildpackage: source version without epoch 1.101-kdump10-2
 debian/rules build
dh_testdir
# Add here commands to configure the package.
(cd kexec-tools-1.101; ./configure --prefix=/usr --sbindir=/sbin --mandir=/usr/share/man --datadir=/usr/share)
checking build system type... mipsel-unknown-linux-gnu
checking host system type... mipsel-unknown-linux-gnu
configure: error:  unsupported architecture mipsel
make: *** [configure-stamp] Error 1

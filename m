Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 21:35:16 +0100 (MET)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:5853 "EHLO
	mx2.mips.com") by ralf.linux-mips.org with ESMTP id <S869542AbSK1UfC>;
	Thu, 28 Nov 2002 21:35:02 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gASKapNf026683
	for <linux-mips@linux-mips.org>; Thu, 28 Nov 2002 12:36:51 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA00473
	for <linux-mips@linux-mips.org>; Thu, 28 Nov 2002 12:36:53 -0800 (PST)
Received: from coplin09.mips.com (IDENT:root@coplin09 [192.168.205.79])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gASKaqb21980
	for <linux-mips@linux-mips.org>; Thu, 28 Nov 2002 21:36:53 +0100 (MET)
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id gASKaqD24646
	for linux-mips@linux-mips.org; Thu, 28 Nov 2002 21:36:52 +0100
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200211282036.gASKaqD24646@coplin09.mips.com>
Subject: New 7.3 installation kit for MIPS dev boards
To: linux-mips@linux-mips.org
Date: Thu, 28 Nov 2002 21:36:52 +0100 (CET)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvige@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvige@mips.com
Precedence: bulk
X-list: linux-mips

On our FTP site, you will now be able to find a MIPS RedHat 7.3 
installation kit (for Malta boards) which contains all of the latest
RPM's from both H.J.'s 7.3 port as well as some extras. The kernel
is 2.4.18++. The complete kit is provided in both LE and BE versions.

It also includes the new SDE/Linux compiler provided by MIPS, both 
as a native toolchain, as well as a x86 cross version which has been
used for generating the kernels (kernels provided both as precompiled
binaries and complete source tree).

>From ftp.mips.com:

ftp> pwd
257 "/pub/linux/mips/installation/redhat7.3/01.00" is current directory.
ftp> dir
227 Entering Passive Mode (206,31,31,227,157,169)
150 Opening ASCII mode data connection for /bin/ls.
total 985416
-rw-r--r--   1 9618     40          15352 Nov 27 02:31 INSTALL
-rw-r--r--   1 9618     40       535359488 Nov 26 09:17 MIPS_RedHat7.3_Release-01.00.iso
-rw-r--r--   1 9618     40       473165864 Nov 26 06:42 MIPS_RedHat7.3_Release-01.00.tar.gz
-rw-r--r--   1 9618     40            589 Nov 27 02:31 README
226 Transfer complete.

Get the .tar file for an NFS install, and the .iso file for a CDROM install
directly on the Malta. It's all explained in the README and INSTALL files.

/Hartvig

-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556

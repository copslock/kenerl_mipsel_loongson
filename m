Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2009 08:38:22 +0200 (CEST)
Received: from hall.aurel32.net ([88.191.82.174]:39514 "EHLO hall.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492561AbZFXGiP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jun 2009 08:38:15 +0200
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall.aurel32.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1MJM4L-0003ff-Uc
	for linux-mips@linux-mips.org; Wed, 24 Jun 2009 08:34:54 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1MJM4L-0004wc-3Q
	for linux-mips@linux-mips.org; Wed, 24 Jun 2009 08:34:53 +0200
Date:	Wed, 24 Jun 2009 08:34:53 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Subject: Broadcom Swarm support
Message-ID: <20090624063453.GA16846@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi all,

I am still trying to get a Broadcom Swarm boot on a recent kernel. I
have made some progress, but I am now stuck on another problem.

I am using a lmo 2.6.30 kernel, using the defconfig configuration, with
minor tweaks to get the IDE and EXT3 support working.

The boot process works correctly until it reaches userland:

| hda: max request size: 128KiB
| hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63
| hda: cache flushes not supported
|  hda: hda1 hda2
| eth0 (sb1250-mac): not using net_device_ops yet
| sb1250-mac.0: registered as eth0
| eth0: enabling TCP rcv checksum
| eth0: SiByte Ethernet at 0x10064000, address: 00:02:4c:fe:51:e0
| eth1 (sb1250-mac): not using net_device_ops yet
| sb1250-mac.1: registered as eth1
| eth1: enabling TCP rcv checksum
| eth1: SiByte Ethernet at 0x10065000, address: 00:02:4c:fe:51:e1
| usbmon: debugfs is not available
| ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
| TCP cubic registered
| NET: Registered protocol family 17
| NET: Registered protocol family 15
| RPC: Registered udp transport module.
| RPC: Registered tcp transport module.
| kjournald starting.  Commit interval 5 seconds
| EXT3-fs: mounted filesystem with writeback data mode.
| VFS: Mounted root (ext3 filesystem) readonly on device 3:2.
| Freeing unused kernel memory: 184k freed
| Kernel panic - not syncing: Attempted to kill init!
| Rebooting in 5 seconds..Passing control back to CFE...

This is with /sbin/init, but I get the exact same problem with /bin/sh.
Also the file is found, as otherwise the message is different. The same
partition when used with an older kernel (2.6.18) works perfectly.

I have the problem with both big and little endian, and with and without
SMP support.

Does anyone is able to run a recent kernel on such a board ? If yes,
could you please share the configuration file? Thanks in advance.

Best regards,
Aurelien

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net

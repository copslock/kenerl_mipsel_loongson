Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 01:31:01 +0100 (BST)
Received: from mailout05.sul.t-online.com ([IPv6:::ffff:194.25.134.82]:7365
	"EHLO mailout05.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8225072AbTDIAbA>; Wed, 9 Apr 2003 01:31:00 +0100
Received: from fwd01.sul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1933UK-0005gn-00; Wed, 09 Apr 2003 02:30:52 +0200
Received: from denx.de (320026445996-0001@[217.235.226.164]) by fmrl01.sul.t-online.com
	with esmtp id 1933UF-1cvDt2C; Wed, 9 Apr 2003 02:30:47 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 7FFAC43139; Wed,  9 Apr 2003 02:30:46 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id 347ABC5877; Wed,  9 Apr 2003 02:30:45 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id 2F9F6C56C7; Wed,  9 Apr 2003 02:30:45 +0200 (MEST)
To: linuxppc-embedded@lists.linuxppc.org,
	linuxppc-dev@lists.linuxppc.org
Cc: linux-mips@linux-mips.org
From: Wolfgang Denk <wd@denx.de>
Subject: [ANN] U-Boot-0.3.0 released
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
Date: Wed, 09 Apr 2003 02:30:40 +0200
Message-Id: <20030409003045.347ABC5877@atlas.denx.de>
X-Sender: 320026445996-0001@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

A new version of the Universal Bootloader "U-Boot" has been released.
It is named U-Boot-0.3.0 and tagged  as  "U-Boot-0_3_0"  on  the  CVS
server.

A tarball is available at

ftp://ftp.denx.de/pub/u-boot/u-boot-0.3.0.tar.bz2


Major news:

* Support for new processors: MIPS 4Kc, MIPS 5Kc, MPC555/556
* Support for new RTOS: RTEMS
* Support for new boards: INCA-IP, Innokom, TOP860, MPC8266ADS,
  VCMA9, ELPT860, CPC45, PM825, SC8xx, AT91RM9200DK, cmi_mpc5xx,
  Purple
* other highlights: PCI support for MPC8250, JFFS2 cleanup

See the project page at http://sourceforge.net/projects/u-boot
for further information.


Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Man is the best computer we can put aboard a spacecraft ...  and  the
only one that can be mass produced with unskilled labor.
                                                  - Wernher von Braun

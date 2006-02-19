Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2006 21:08:53 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:16908 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133559AbWBSVIp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Feb 2006 21:08:45 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 318AF64D3D; Sun, 19 Feb 2006 21:15:36 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 75AC78D5D; Sun, 19 Feb 2006 21:15:27 +0000 (GMT)
Date:	Sun, 19 Feb 2006 21:15:27 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Stanislaw Skowronek <skylark@linux-mips.org>
Subject: Merging Skylark's IOC3 patch
Message-ID: <20060219211527.GA12848@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Ralf,

Can you please review and/or merge Skylark's IOC3 patch from
ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/linux-mips-2.6.14-ioc3-r26.patch.bz2

From my basic understanding I believe that this patch needs to be split up
and submitted to different sub-system maintainers.  However, it would be
nice if the MIPS part could get in first because the other parts depend on
this.  I'll start splitting stuff out in the meantime.

 arch/mips/Kconfig                        |    8
 arch/mips/pci/Makefile                   |    2
 arch/mips/pci/ioc3.c                     |  801 +++++++++++++++++++++++++++++++
 arch/mips/sgi-ip27/ip27-console.c        |    2
 drivers/input/serio/Kconfig              |    7
 drivers/input/serio/Makefile             |    1
 drivers/input/serio/ioc3kbd.c            |  172 ++++++
 drivers/net/Kconfig                      |    2
 drivers/net/ioc3-eth.c                   |  458 ++---------------
 drivers/serial/8250.c                    |   17
 drivers/serial/Kconfig                   |    7
 drivers/serial/Makefile                  |    1
 drivers/serial/ioc3uart.c                |  135 +++++
 drivers/serial/serial_core.c             |   12
 include/asm-mips/mach-ip27/mangle-port.h |    2
 include/linux/ioc3.h                     |   87 +++
 include/linux/serial.h                   |    1
 include/linux/serial_core.h              |    1
 18 files changed, 1304 insertions(+), 412 deletions(-)

-- 
Martin Michlmayr
http://www.cyrius.com/

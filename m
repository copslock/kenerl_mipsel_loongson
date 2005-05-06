Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 11:12:22 +0100 (BST)
Received: from adsl-72-19.38-151.net24.it ([IPv6:::ffff:151.38.19.72]:7814
	"EHLO zaigor.enneenne.com") by linux-mips.org with ESMTP
	id <S8225351AbVEFKMH>; Fri, 6 May 2005 11:12:07 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 3.36 #1 (Debian))
	id 1DTzoS-0006er-00
	for <linux-mips@linux-mips.org>; Fri, 06 May 2005 12:12:04 +0200
Date:	Fri, 6 May 2005 12:12:04 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Subject: PCMCIA support doesn't compile
Message-ID: <20050506101204.GA25371@enneenne.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
Organization: Programmi e soluzioni GNU/Linux
X-PGP-Key: gpg --keyserver keyserver.penguin.de --recv-keys D25A5633
User-Agent: Mutt/1.5.6+20040722i
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here a little patch in order to allow PCMCIA support to correcly
compile (file bulkmem.c has been removed).

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@linux.it
Linux Device Driver                             giometti@enneenne.com
Embedded Systems                     home page: giometti.enneenne.com
UNIX programming                     phone:     +39 349 2432127

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

Index: Makefile
===================================================================
RCS file: /home/cvs/linux/drivers/pcmcia/Makefile,v
retrieving revision 1.39
diff -u -r1.39 Makefile
--- Makefile	25 Jan 2005 04:28:38 -0000	1.39
+++ Makefile	6 May 2005 10:05:11 -0000
@@ -32,7 +32,7 @@
 obj-$(CONFIG_PCMCIA_VRC4173)			+= vrc4173_cardu.o
 obj-$(CONFIG_PCMCIA_AU1X00)			+= au1x00_ss.o
 
-pcmcia_core-y					+= cistpl.o rsrc_mgr.o bulkmem.o cs.o socket_sysfs.o
+pcmcia_core-y					+= cistpl.o rsrc_mgr.o cs.o socket_sysfs.o
 pcmcia_core-$(CONFIG_CARDBUS)			+= cardbus.o
 
 sa11xx_core-y					+= soc_common.o sa11xx_base.o

--n8g4imXOkfNTN/H1--

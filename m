Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2007 18:26:25 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:7432 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022723AbXE3R0X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 May 2007 18:26:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3590EE1FBB;
	Wed, 30 May 2007 19:25:38 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c5W6S+5zVCqO; Wed, 30 May 2007 19:25:37 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B1AC2E1FAE;
	Wed, 30 May 2007 19:25:37 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l4UHPpaw006255;
	Wed, 30 May 2007 19:25:51 +0200
Date:	Wed, 30 May 2007 18:25:46 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jan Rekorajski <baggins@sith.mimuw.edu.pl>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] zs: Move to the serial subsystem
In-Reply-To: <20070530165842.GL29894@sith.mimuw.edu.pl>
Message-ID: <Pine.LNX.4.64N.0705301802570.27697@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl>
 <20070530165842.GL29894@sith.mimuw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.2/3331/Wed May 30 08:48:34 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 30 May 2007, Jan Rekorajski wrote:

> Look functional to me (just booted my DecStation 5000/240) :)

 Great!  Thanks for testing.

> Any chance to get LK201/401 keyboard and vsxxxaa mouse working with this?

 For the time being a solution is the patch below and then:

CONFIG_INPUT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_LKKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_VSXXXAA=y
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y

plus your framebuffer of choice.  To activate the keyboard you have to run 
the following program:

#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>

#define SPIOCSTYPE _IOW('q', 0x01, unsigned long)
#define SERIO_LKKBD 0x28

int main(void)
{
	int fd, ldisc = N_MOUSE, type = SERIO_LKKBD;
	char buf;

	fd = open("/dev/ttyS2", O_RDWR | O_NONBLOCK);
	ioctl(fd, TIOCSETD, &ldisc);
	ioctl(fd, SPIOCSTYPE, &type);
	read(fd, &buf, 1);
	close(fd);

	return 0;
}

Use "/dev/ttyS0" and:

#define SERIO_VSXXXAA 0x08

for the mouse as appropriate.  Before you run the program you need to set 
the line settings correctly -- that would be:

# stty -F /dev/ttyS2 4800 cstopb raw -echo -echoe -echok noflsh

for the keyboard and:

# stty -F /dev/ttyS0 4800 cstopb raw -echo -echoe -echok noflsh parenb parodd

for the mouse (considering it a temporary hack I have not added that bit 
to the program above).  Lacking a suitable rodent at hand I have only 
tested the keyboard -- it worked.  Please note that killing the program 
(which normally does not terminate -- read() blocks forever) removes the 
binding.

 I am looking into a solution that would make it automatic without the 
need of involving userland which just does not seem right here -- you do 
want to run your kernel with "init=/bin/bash" or suchlike and have your 
virtual terminal console usable.  I will remove the old lk201 bits then.

  Maciej

patch-mips-2.6.18-20060920-nolk201-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/tc/Makefile linux-mips-2.6.18-20060920/drivers/tc/Makefile
--- linux-mips-2.6.18-20060920.macro/drivers/tc/Makefile	2007-01-07 18:04:10.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/tc/Makefile	2007-01-07 18:33:47.000000000 +0000
@@ -5,7 +5,7 @@
 # Object file lists.
 
 obj-$(CONFIG_TC) += tc.o tc-driver.o
-obj-$(CONFIG_VT) += lk201.o lk201-map.o lk201-remap.o
+# obj-$(CONFIG_VT) += lk201.o lk201-map.o lk201-remap.o
 
 $(obj)/lk201-map.o: $(obj)/lk201-map.c
 

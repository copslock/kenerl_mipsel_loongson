Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 10:16:32 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:39442 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225293AbTDJJQb>;
	Thu, 10 Apr 2003 10:16:31 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id 182E3B4D0
	for <linux-mips@linux-mips.org>; Thu, 10 Apr 2003 11:15:05 +0200 (CEST)
Message-ID: <3E954651.C7AECB90@ekner.info>
Date: Thu, 10 Apr 2003 12:24:17 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: ext3 under MIPS?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

Hi,

I have been using ext3 with MIPS, and it seems to work fine during normal operations. However, when
doing an unclean shutdown things don't exactly behave the way I believe they should. Does anybody
know how the ext3 recovery is supposed to work?

Basically I just reset the system mid-stream to see what happens. This means the rc.sysinit "control
file "/.autofsck" is on the filesystem to indicate an unclean shutdown. During the next boot I get:

... stuff deleted

ttyS02 at 0xb1300000 (irq = 2) is a 16550
ttyS03 at 0xb1400000 (irq = 3) is a 16550
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 64k freed
Algorithmics/MIPS FPU Emulator v1.5
INIT: version 2.84 booting

So, it seems the kernel ext3 filesystem code runs some kind of recovery based on the
journal prior to the actual mount of / occurring, which is exactly what I would expect
to happen, right?

Then bootup continues with:


               Welcome to Red Hat Linux
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
Setting clock  (localtime): Thu Jan  1 01:00:13 CET 1970 [  OK  ]
Activating swap partitions:  [  OK  ]
Setting hostname copau01:  [  OK  ]
modprobe: Can't open dependencies file /lib/modules/2.4.21-pre4/modules.dep (No
such file or directory)
modprobe: Can't open dependencies file /lib/modules/2.4.21-pre4/modules.dep (No
such file or directory)
Your system appears to have shut down uncleanly
Press Y within 3 seconds to force file system integrity check...y
Checking root filesystem
/dev/hdc2: Inodes that were part of a corrupted orphan linked list found.

/dev/hdc2: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
        (i.e., without -a or -p options)
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a -f /dev/hdc2

[FAILED]

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
Give root password for maintenance
(or type Control-D for normal startup):


So can somebody tell me what the heck just happened? After the ext3 recovery done before the mount,
.autofsck is still on the disk, so the rc.sysinit script of course assumes the shutdown was unclean,
and pops the 5-second question. However, if I to be safe push "Y" here to get my filesystem check (which
I guess should be unnecessary, due to the ext3 recovery just run, right?), strange things happen and
fsck reports the "corrupted orphan list... " error.

Is there something wrong here, or how should the system behave?

/Hartvig

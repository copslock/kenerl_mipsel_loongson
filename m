Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6S03t518526
	for linux-mips-outgoing; Fri, 27 Jul 2001 17:03:55 -0700
Received: from web13908.mail.yahoo.com (web13908.mail.yahoo.com [216.136.175.71])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6S03sV18519
	for <linux-mips@oss.sgi.com>; Fri, 27 Jul 2001 17:03:54 -0700
Message-ID: <20010728000354.84537.qmail@web13908.mail.yahoo.com>
Received: from [61.187.62.84] by web13908.mail.yahoo.com; Fri, 27 Jul 2001 17:03:54 PDT
Date: Fri, 27 Jul 2001 17:03:54 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: serial console startup problem
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,all,

When linux 2.4.3 startup, our serial console can not
work. I use another serial port to print some debug
messages, it likes following:

hda: 16841664 sectorsp: (8623 MB)p: w/512KiB Cachep:,
CHS=16708/16/63p:
Partition check:
hda:[PTBL] [1048/255/63] hda1 hda4
Serial driver version 5.05 (2000-12-13) with
MANY_PORTS SHARE_IRQ SERIAL_PCI e
nabled
ttyS00 at 0xb8000000 (irq = 2) is a 16550A
ttyS01 at 0xb8100000 (irq = 3) is a 16550A
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 1020kb freed
Freeing unused kernel memory: 52k freed

kernel BUG at page_alloc.c:191!
kernel BUG at page_alloc.c:191!
kernel BUG at page_alloc.c:191!

Do someone know what's problem it is?
If you know, please help me.

Thanks!

Barry

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/

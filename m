Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2TAxmL07131
	for linux-mips-outgoing; Fri, 29 Mar 2002 02:59:48 -0800
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2TAxdq07117;
	Fri, 29 Mar 2002 02:59:39 -0800
Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
	by thoth.sbs.de (8.11.6/8.11.6) with ESMTP id g2TB20X25723;
	Fri, 29 Mar 2002 12:02:00 +0100 (MET)
Received: from MOWD019A.mow.siemens.ru ([139.24.18.3])
	by mail2.siemens.de (8.11.6/8.11.6) with ESMTP id g2TB1wC17247;
	Fri, 29 Mar 2002 12:01:58 +0100 (MET)
Received: by mowd019a.mow.siemens.ru with Internet Mail Service (5.5.2653.19)
	id <H6D31HLF>; Fri, 29 Mar 2002 14:06:55 +0300
Received: from MW1G17C ([163.242.193.31]) by MOWD019A.mow.siemens.ru with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id H6D31HL1; Fri, 29 Mar 2002 14:06:53 +0300
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: "'Raoul Borenius'" <raoul@shuttle.de>, linux-mips@oss.sgi.com
Cc: devfs@oss.sgi.com
Subject: RE: broken devfs-support in SGI Zilog8530 serial driver
Date: Fri, 29 Mar 2002 14:01:54 +0300
Message-ID: <000001c1d711$2492f070$1fc1f2a3@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
In-Reply-To: <20020329103244.GA15765@bunny.shuttle.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> I'm not sure if this is a devfs or mips problem so I'm sending it
> to both lists.
> 
> I just compiled my own mips-kernel from oss.sgi.com:/cvs to get
> devfs-support. Unfortunately there seems to be a problem with the
> serial-driver at least in the linux_2_4 branch:
> 
> SGI Zilog8530 serial driver version 1.00
> devfs_register(ttyS): could not append to parent, err: -17

This means that somebody else registered ttyS (and cua) before Zilog8530
driver attempted to do it. The possible reason could be that driver
calls tty_register_devfs itself in this case it must set
TTY_DRIVER_NO_DEVFS flag to prevent the same nodes registered by
tty_register_driver.

-andrej

> devfs_register(cua): could not append to parent, err: -17
> tty00 at 0xbfbd9830 (irq = 29) is a Zilog8530
> tty01 at 0xbfbd9838 (irq = 29) is a Zilog8530
> 
> The result is that the directories /dev/tts and /dev/cua are missing.
> 
> There are only the files /dev/ttS and /dev/cua which can be used to
get
> access to the first serial port.
> 
> I have attached the full dmesg output at the end.
> 
> Regards
> 
> Raoul

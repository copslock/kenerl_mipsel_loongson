Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f98JeOq24527
	for linux-mips-outgoing; Mon, 8 Oct 2001 12:40:24 -0700
Received: from dark-past (h117n1fls20o53.telia.com [213.64.214.117])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f98JeLD24524
	for <linux-mips@oss.sgi.com>; Mon, 8 Oct 2001 12:40:21 -0700
Received: from yog-sothoth.dark-past.mine.nu (yog-sothoth [192.168.1.7]) by dark-past (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id WAA03217 for <linux-mips@oss.sgi.com>; Mon, 8 Oct 2001 22:52:11 -0700
Message-Id: <5.1.0.14.0.20011008225207.00a60b40@192.168.1.5>
X-Sender: peter@192.168.1.5
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 08 Oct 2001 23:17:17 +0200
To: linux-mips@oss.sgi.com
From: Peter Andersson <peter@dark-past.mine.nu>
Subject: Trouble starting xserver/with tcpip.
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f98JeMD24525
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have recently installed mips-linux 7.0 on an sgi indy machine and 
installed the included XF86 rpms. When i execute the command startx i get 
the message "waiting for X server to begin accepting connections". After 
that nothing happens. I suppose this has to do with the network not working 
as it should because i can´t ping "localhost" or "hostname" on the 
mips-linux machine. The mips-linux machine can´t ping the other computers 
on the network (except for another sgi running irix) either but it can 
access them via ftp, nfs and telnet. All the other machines can ping and 
reach the sgi via telnet. I am quite stuck here and all out of ideas, if 
you have any clue what i have done wrong please let me know.

By the way do anyone know about a kernel with support for indys that doesnt 
have the newport graphics board (i have one indy with a GR2 XZ)?

Thanks

Peter

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9TITcv32076
	for linux-mips-outgoing; Mon, 29 Oct 2001 10:29:38 -0800
Received: from dark-past (h117n1fls20o53.telia.com [213.64.214.117])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9TITa032073
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 10:29:36 -0800
Received: from yog-sothoth.dark-past.mine.nu (yog-sothoth [192.168.1.7]) by dark-past (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id VAA21653 for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 21:41:12 -0800
Message-Id: <5.1.0.14.0.20011029204836.00a63170@192.168.1.5>
X-Sender: peter@192.168.1.5
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Oct 2001 21:08:10 +0100
To: linux-mips@oss.sgi.com
From: Peter Andersson <peter@dark-past.mine.nu>
Subject: "relocation truncated to fit"
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, i am trying to compile mozilla 0.9.5 on my indy running mips/redhat 
linux 7.0 and get hundreds of messages telling me "relocation truncated to 
fit: R_MIPS_GOT16". Does anyone know how to get around this? I tried to add 
the ld flags -G O but without success.

Thanks

Peter

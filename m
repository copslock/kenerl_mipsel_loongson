Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IErPf32653
	for linux-mips-outgoing; Tue, 18 Sep 2001 07:53:25 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IErMe32650
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 07:53:22 -0700
Message-Id: <200109181453.f8IErMe32650@oss.sgi.com>
Received: (qmail 27425 invoked from network); 18 Sep 2001 14:47:32 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 18 Sep 2001 14:47:32 -0000
Date: Tue, 18 Sep 2001 22:52:41 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: han han <piggie111000@yahoo.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: How to access kernel memory?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8IErNe32651
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,han han£¬
   There are several ways.For example:
   1.You can create a character device , implement its mmap function
to map the memory block you allcated.This can be done in a little
kernel module.There are some sample code before.
   2.via /dev/mem,/dev/kmem etc
   



ÔÚ 2001-09-18 07:35:00 you wrote£º
>Hi, All,
>
>I allocated a block of memory in the kernel space. But
>I don't know how to directly access kernel space from
>user space. Anyone can help me?
>
>Thanks in advance.
>
>piggie
>
>
>__________________________________________________
>Terrorist Attacks on U.S. - How can you help?
>Donate cash, emergency relief information
>http://dailynews.yahoo.com/fc/US/Emergency_Information/

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6U7H9l29199
	for linux-mips-outgoing; Mon, 30 Jul 2001 00:17:09 -0700
Received: from smtp.huawei.com (sz135.szptt.net.cn [202.96.135.132] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6U7GvV29191
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 00:17:04 -0700
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GH9YLH02.D2L for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001
          15:10:29 +0800 
Message-ID: <000901c118c7$b9bcc800$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: <linux-mips@oss.sgi.com>
References: <20010728000354.84537.qmail@web13908.mail.yahoo.com>
Subject: Embed linux-mips problems...
Date: Mon, 30 Jul 2001 15:17:42 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello, all:
     Now I will plan to port linux on our custom mips-based board. Since
this will be the first time I use linux on mips CPU and I am a newbie for
mips RC32334, I have several questions to ask:

1 What's the current stable linux kernel version for mips that you are
using?Especially, which  version can support IDT mips RC32334 CPU now? If
linux can not support RC32334 for the time being,which familys of Mips
should I take as example and what modifications should I do?
2 What IDE tools for Mips are you using to debug linux kernel and  APPs ?
3  Are there any sample boot codes which can be burnt into BOOTROM and which
will  initialize the mip-based boards when power-on and then load the
linux-kernel to RAM via network or flash?
4 Is it possible to use RTLinux for mips now? If so, which rtlinux version
should I take?

Any suggestions will be highly appreciated.

Thank you very much.
machael thailer

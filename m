Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f742FZL23938
	for linux-mips-outgoing; Fri, 3 Aug 2001 19:15:35 -0700
Received: from smtp.huawei.com (nszx104.121.szptt.net.cn [202.104.121.208] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f742FXV23931
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 19:15:33 -0700
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GHITZ201.I0M for <linux-mips@oss.sgi.com>; Sat, 4 Aug 2001
          10:09:02 +0800 
Message-ID: <000701c11c8b$77e039e0$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: <linux-mips@oss.sgi.com>
Subject: Where is the first entry point for linux-mips boot?
Date: Sat, 4 Aug 2001 10:16:27 +0800
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

Hello,all:

    Now I plan to port linux on our mips-based board. Since it is the first
time for me to work on linux-mips, I have several questions to ask:

    There are many many subdirectories in arch/mips, I don't know where is
the FIRST entry point for embedded linux-mips boot process? I find that
there is "kernel_entry" in arch/mips/kernel/head.S. I know this is the entry
point for linux kernel ,but it is not the FIRST entry point for embedded
linux-mips boot process. So my questions is :
    After the board initializations finish, it should load linux kernel into
RAM and jump there .  Just before it runs the linux kernel, who calls
"kernel_entry"?
    I don't know whether I have expressed my meaning apparently. Hope you
can understand me.

Thank you very much.

machael thailer

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6V3hke27155
	for linux-mips-outgoing; Mon, 30 Jul 2001 20:43:46 -0700
Received: from smtp.huawei.com (sz135.szptt.net.cn [202.96.135.132] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6V3hXV27148
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 20:43:33 -0700
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GHBJDT01.517; Tue, 31 Jul 2001 11:37:05 +0800 
Message-ID: <005e01c11973$1622d700$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Ian Soanes" <ians@lineo.com>
Cc: <linux-mips@oss.sgi.com>
References: <3AE44D0A.9080003@jungo.com> <Pine.GSO.4.02.10104231829020.19846-100000@chimene.enst.fr> <20010423170425.F4623@bacchus.dhis.org> <3AE541B0.410FDF8A@lineo.com>
Subject: Need your help:about RC32334 questions?
Date: Tue, 31 Jul 2001 11:44:22 +0800
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


> Hi Fabrice,
>
> This may not be totally relevant, but I'm currently trying to get
> gdbserver working on a RC32334 IDT board. I've been having some issues
> with single stepping, but am making a bit of progress.
>
> 1/ I started with a mips gdbserver port kindly supplied by Martin
> Rivers. It mostly works well but had some problems single stepping
> through conditional branches (the problem may have been due to a
> different target than Martin was using, or me... I am kind of new to
> this :)
>
> 2/ Previously I've had some luck single stepping kernel and module code
> with the kernel gdbstub (arch/mips/kernel/gdb-stub.c), so I ported the
> relevant single stepping code into gdbserver. The results were much
> better. The only thing that seems to be wrong now is stepping over
> function calls isn't working quite right. I can step into functions OK
> though.
>
> If you're interested I'll let you know how I get on over the next few
> days. If not, I won't be offended :)
>

Hello,
    Now I plan to port linux on our RC32334-based custom board. But I don't
know whether linux support RC32334 now.
Can you tell me which kernel version you use on your RC32334 IDT board? And
where can i download it?

Thanks in advance.

machael thailer

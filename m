Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7M2VxB05245
	for linux-mips-outgoing; Tue, 21 Aug 2001 19:31:59 -0700
Received: from smtp.huawei.com (61.144.GD.CN [61.144.161.21] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7M2Vv905240
	for <linux-mips@oss.sgi.com>; Tue, 21 Aug 2001 19:31:57 -0700
Received: from hechendong11752 ([10.105.33.128]) by
          smtp.huawei.com (Netscape Messaging Server 4.15) with SMTP id
          GIG6XP00.R4L for <linux-mips@oss.sgi.com>; Wed, 22 Aug 2001
          10:29:49 +0800 
Message-ID: <001201c12ab2$c7c4e700$8021690a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: <linux-mips@oss.sgi.com>
Subject: question about syscall and interrupts......
Date: Wed, 22 Aug 2001 10:33:08 +0800
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

Hello,
    I find that in handle_sys() of scall_o32.S, it calls:
        SAVE_SOME
    But in the various board interrupt handlers entry(int-handler.S), it
calls:
        SAVE_ALL

    So before entering syscall and interrupt handler entry, why do they need
save different registers? and interrupt need save more things than syscalls?

Thank you very much.

machael thailer

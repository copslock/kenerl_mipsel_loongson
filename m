Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2003 23:41:01 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:35344 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8224802AbTGOWk7>; Tue, 15 Jul 2003 23:40:59 +0100
Received: from WSSTEVELAPTOP ([192.168.1.62]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA469;
          Tue, 15 Jul 2003 15:40:34 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: "'Brian Murphy'" <brm@murphy.dk>, <linux-mips@linux-mips.org>
Subject: cvs update 2_4 branch breaks userland
Date: Tue, 15 Jul 2003 15:40:23 -0700
Message-ID: <007c01c34b22$14b98660$4383a8c0@WSSTEVELAPTOP>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <E19cVhA-0003M6-00@brian.localnet>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

My board runs userland apps that makes use of SIGUSR1. When I did a cvs
update today and recompiled the kernel, when I run my app it quits with
"User defined signal 1" and bails. The signal is delivered a pthread_kill
command. The app runs about 8 or 9 threads all blocking on various IO with
various priority levels. I boot the old kernel back up and it runs fine.

Board is running an NECVR4181
Toolchain is a uclibc something.19 (building 20 now) with gcc 3.3 and the
latest binutils

I have the 2.4.21 kernel and I did a cvs update on it today.

If anyone has any ideas I'd appreciate knowing.

Thanks!

Steve

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 19:07:29 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:15111 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8225202AbTDNSH1>; Mon, 14 Apr 2003 19:07:27 +0100
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA486
          for <linux-mips@linux-mips.org>; Mon, 14 Apr 2003 11:07:04 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@linux-mips.org>
Subject: uclibc printf and floats
Date: Mon, 14 Apr 2003 11:12:43 -0700
Message-ID: <04d001c302b1$7203e270$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.GSO.3.96.1030414192822.24742P-100000@delta.ds2.pg.gda.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

I switched over to uclibc a while ago and am running the release (also tried
the snapshot) of 0.1.19 or whatever it is. I notice that printf crashes with
floats. This was a problem found with uclibc on other archs back almost 2
years ago. If anyone can help me with some advice I'd appreciate it. I much
prefer to continue using uclibc on this VR4181 instead of glibc.

Thanks!

Steve

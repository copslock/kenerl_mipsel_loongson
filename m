Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 15:02:07 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:33553 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8225238AbTGPOCD>; Wed, 16 Jul 2003 15:02:03 +0100
Received: from WSSTEVELAPTOP ([192.168.1.60]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA455
          for <linux-mips@linux-mips.org>; Wed, 16 Jul 2003 07:01:43 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@linux-mips.org>
Subject: mmap broken on cvs update 2_4
Date: Wed, 16 Jul 2003 07:01:33 -0700
Message-ID: <004c01c34ba2$c499ba20$4383a8c0@WSSTEVELAPTOP>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20030716014340.GA12436@nevyn.them.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

The signal defined 1 problem is really a Bus error. uClibc is broken for
signals and got them from the x86 asm/signal.h file to build its default
string messages.

I'm using mmap. It maps successfully and has the proper ranges in
/proc/pid/maps.

When I try to access the memory I get a bus error. This did not happen
before I did a cvs update. I had even rebuilt a kernel prior to the cvs
update that didn't do that.

If someone can tell me where to look I'd appreciate it.

Steve

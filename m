Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2003 01:56:51 +0100 (BST)
Received: from host31.ipowerweb.com ([IPv6:::ffff:12.129.198.131]:5090 "EHLO
	host31.ipowerweb.com") by linux-mips.org with ESMTP
	id <S8225193AbTGXA4T>; Thu, 24 Jul 2003 01:56:19 +0100
Received: from rrcs-central-24-123-115-44.biz.rr.com ([24.123.115.44] helo=radium)
	by host31.ipowerweb.com with esmtp (Exim 3.36 #1)
	id 19fUP4-0003AG-00; Wed, 23 Jul 2003 17:56:19 -0700
From: "Lyle Bainbridge" <lyle@zevion.com>
To: "'Tiemo Krueger - mycable GmbH'" <tk@mycable.de>
Cc: <saravana_kumar@naturesoft.net>, <linux-mips@linux-mips.org>
Subject: RE: Cross Compilation
Date: Wed, 23 Jul 2003 19:55:56 -0500
Message-ID: <000101c3517e$5783a400$1400a8c0@radium>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <20030723100946.N3135@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host31.ipowerweb.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - zevion.com
Return-Path: <lyle@zevion.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lyle@zevion.com
Precedence: bulk
X-list: linux-mips


> I took a look.  It looks similar to one project that I worked on
> before.   Very interesting.
> 
> Has anybody tried successfully to do a cross MIPS yet?  From 
> a Linux/i386 host obviously ...

I have used the uclibc toolchain for big endian mips. It works great.  I
also have a gcc-3.2.3/glibc-2.2.5 based toolchain, and have used it to
cross compile a kernel and a simple root filesystem.

Lyle

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2003 13:19:25 +0000 (GMT)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:9738 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8224939AbTBMNTY>; Thu, 13 Feb 2003 13:19:24 +0000
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA493;
          Thu, 13 Feb 2003 05:19:18 -0800
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: "'Jun Sun'" <jsun@mvista.com>
Cc: <linux-mips@linux-mips.org>
Subject: RE: NEC VR4181A
Date: Thu, 13 Feb 2003 05:22:36 -0800
Message-ID: <02c101c2d362$f9e2eed0$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030212224837.D16015@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

>Osprey uses Vr4181, which is a different chip from vr4181a.

Yeah I didn't notice the A on there. We are looking into the possibility of
using the A in our board. Part of the problem is that the A only comes in
BGA and we don't like dealing with that.

>Interesting.  I was trying to get RT-Linux working at one time
>but aborted that effort in the middle.

Getting RTAI working wasn't easy. Took over a week and it was supposedly
already "ported." One of these days I really must find the time to check in
my changes to that project. It works very well and is quite stable. I think
46 us worst-case interrupt response off one of the VR4181's interrupts from
an external source is very good.

Steve

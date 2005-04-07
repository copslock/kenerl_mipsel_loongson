Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 13:26:09 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:24228
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8224942AbVDGMZ0> convert rfc822-to-8bit; Thu, 7 Apr 2005 13:25:26 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j37CPHlu014455;
	Thu, 7 Apr 2005 05:25:17 -0700 (PDT)
Received: from laptopuhler4 (laptop-uhler4.mips.com [192.168.2.2])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j37CPIGl003354;
	Thu, 7 Apr 2005 05:25:18 -0700 (PDT)
From:	"Michael Uhler" <uhler@mips.com>
To:	"'Greg Weeks'" <greg.weeks@timesys.com>,
	"'Ralf Baechle'" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: memcpy prefetch
Date:	Thu, 7 Apr 2005 05:25:15 -0700
Organization: MIPS Technologies, Inc.
Message-ID: <003901c53b6c$da8938e0$cf14a8c0@MIPS.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
In-Reply-To: <4255240E.4050701@timesys.com>
X-Scanned-By: MIMEDefang 2.39
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

> What's the performance hit for doing a pref on a cache line that is 
> already pref'd? Does it turn into a nop, or do we get some horrible 
> degenerate case? Are 64 bit processors always at least 32 byte cache 
> line size? I don't really expect anyone to know the answers 
> right now. I 
> expect I'll need to time code to tell. This makes generating 
> them at run 
> time look better and better.

As very general rules of thumb:

- A pref to a line which is already in the cache take a cycle in the
load/store unit and does not go back out to the memory subsystem.  There are
some possible ships-passing-in-the-night scenarios, but most processors do
what you'd expect.

- Most 64-bit processors are built for high-end applications, and most
high-end processors most likely have at least 32-bit lines.  One usually has
smaller line sizes when the processor is intended for lower-end
applications, or where the memory subsystem isn't all that good.

/gmu

---
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.   Email: uhler at mips.com
1225 Charleston Road
Mountain View, CA 94043

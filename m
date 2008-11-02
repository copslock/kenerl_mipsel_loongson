Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2008 08:24:45 +0000 (GMT)
Received: from kuber.nabble.com ([216.139.236.158]:53397 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S22963081AbYKBIYf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2008 08:24:35 +0000
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KwYG5-0002Cq-Py
	for linux-mips@linux-mips.org; Sun, 02 Nov 2008 01:24:29 -0700
Message-ID: <20287845.post@talk.nabble.com>
Date:	Sun, 2 Nov 2008 01:24:29 -0700 (PDT)
From:	cola99 <cola99a@yahoo.com.tw>
To:	linux-mips@linux-mips.org
Subject: About extendable stacks in non VM-system
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Nabble-From: cola99a@yahoo.com.tw
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cola99a@yahoo.com.tw
Precedence: bulk
X-list: linux-mips


I don't understand what this say~~~~

Extendable stacks and heaps in a non-VM system: Even when you don’t
have a disk and have no intention of supporting full demand paging, it
can still be useful to grow an application’s stack and heap on demand
while monitoring its growth. In this case you’ll need the TLB to map
the stack/heap addresses, and you’ll use TLB miss events to decide
whether to allocate more memory or whether the application is out
of control.

and this 

in the EntryLO Valid bit
Refill TLB is optimized for speed and doesn’t want to check for special
case. When some further processing is needed before a program can use a page
referred to by the memory-held table, the memory-held entry can be left
marked invalid. After TLB refill, this will cause a different kind of trap,
invoking special processing without having to put a test in every software
refill event

I can't understant why ??

Or someone can recommand where can discuss "see mips run " this book~~~~

-- 
View this message in context: http://www.nabble.com/About-extendable-stacks-in-non-VM-system-tp20287845p20287845.html
Sent from the linux-mips main mailing list archive at Nabble.com.

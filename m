Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 12:58:43 +0100 (CET)
Received: from p508B7FA8.dip.t-dialin.net ([80.139.127.168]:38045 "EHLO
	p508B7FA8.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225196AbSLJL6m>; Tue, 10 Dec 2002 12:58:42 +0100
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30712 "EHLO
	orion.mvista.com") by ralf.linux-mips.org with ESMTP
	id <S870066AbSLIXNS>; Tue, 10 Dec 2002 00:13:18 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gB9JwgW15300;
	Mon, 9 Dec 2002 11:58:42 -0800
Date: Mon, 9 Dec 2002 11:58:42 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: IDE module problem
Message-ID: <20021209115842.Q8642@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


If you configure IDE support as a module (CONFIG_IDE), you
will soon find that ide-std.o and ide-no.o are missing.
This is because arch/mips/lib/Makefile says:

obj-$(CONFIG_IDE)               += ide-std.o ide-no.o


Here are the possible fixes.  I'd like to hear your feedbacks.

1) change config-shared.in file so that CONFIG_IDE only
has a binary state (y or n)

2) change Makefile so that ide-std.o and ide-no.o are always
included.  Waste about 1K for systems don't use them at all.

3) use some smart trick in Makefile so that we include those
two files only if CONFIG_IDE is 'y' or 'm'.  (How?)

Jun

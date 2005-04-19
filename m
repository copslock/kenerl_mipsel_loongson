Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 15:52:07 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:43426 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8226122AbVDSOvw>; Tue, 19 Apr 2005 15:51:52 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.50 #1 (Debian))
	id 1DNu4q-0000da-T3; Tue, 19 Apr 2005 09:51:48 -0500
Subject: Re: sysv ipc msg functions
In-Reply-To: <426518D0.5080506@timesys.com>
To:	Greg Weeks <greg.weeks@timesys.com>
Date:	Tue, 19 Apr 2005 09:51:48 -0500 (CDT)
CC:	linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1DNu4q-0000da-T3@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

[ Charset ISO-8859-1 unsupported, converting... ]
> I needed this glibc patch to get the sysv ipc msgctl functions to work 
> correctly. This looks a bit hackish to me, so I wanted to run it past 
> everybody here before filing it with glibc.
> 
Perhaps is ignorance on my part, but I thought the compiler would
handle the endianness with regards to the structure members. Did
you have problems with big and little endian such that you had to
do all of the ugly #ifdef'ing? 

-Steve

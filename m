Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 19:05:31 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:23535 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225205AbTDJSFa>;
	Thu, 10 Apr 2003 19:05:30 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3AI5RA09536;
	Thu, 10 Apr 2003 11:05:27 -0700
Date: Thu, 10 Apr 2003 11:05:27 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: way selection bit for multi-way cache 
Message-ID: <20030410110527.E9002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


If a cache is multi-way set associative cache, one must
select the way for indexed cache operations.

The most common way selection is to use MSBs in the addressing
range of the whole cache size.  In other word, a two-way
cache of size d would use bit (log(d)-1) to select the way.

Some other CPUs often the LSB(s) in the address to select
ways.  Examples include R5432, R5500, TX49, TX39.  Does
anybody know other such CPUs?

And I think I have seen a third kind way selection, but I
can't remember which CPU it is.  Does anybody know any
other way selection schemes?

Thanks.

Jun

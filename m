Received:  by oss.sgi.com id <S553832AbRALXra>;
	Fri, 12 Jan 2001 15:47:30 -0800
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48389 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S553818AbRALXrN>;
	Fri, 12 Jan 2001 15:47:13 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14HDwC-0005GH-00; Fri, 12 Jan 2001 23:48:52 +0000
Subject: Re: broken RM7000 in CVS ...
To:     jsun@mvista.com (Jun Sun)
Date:   Fri, 12 Jan 2001 23:48:50 +0000 (GMT)
Cc:     carlson@sibyte.com, linux-mips@oss.sgi.com
In-Reply-To: <3A5F68CB.78D693B3@mvista.com> from "Jun Sun" at Jan 12, 2001 12:27:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HDwC-0005GH-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> My understanding is that we don't have a standard way to probe for external
> cache (L2 or L3).  So this problem is not only for MIPS32 cpus.

Cache is very arch specific. You don't want to know how you find L2 cache
on a MacII for example 8)

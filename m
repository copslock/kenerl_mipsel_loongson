Received:  by oss.sgi.com id <S553817AbRAIMTo>;
	Tue, 9 Jan 2001 04:19:44 -0800
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20491 "EHLO
        the-village.bc.nu") by oss.sgi.com with ESMTP id <S553803AbRAIMT2>;
	Tue, 9 Jan 2001 04:19:28 -0800
Received: from alan by the-village.bc.nu with local (Exim 2.12 #1)
	id 14FxiT-0006XP-00; Tue, 9 Jan 2001 12:17:29 +0000
Subject: Re: User applications
To:     michaels@jungo.com (Michael Shmulevich)
Date:   Tue, 9 Jan 2001 12:17:26 +0000 (GMT)
Cc:     macro@ds2.pg.gda.pl (Maciej W. Rozycki), linux-mips@oss.sgi.com
In-Reply-To: <3A5AFAC8.CA682600@jungo.com> from "Michael Shmulevich" at Jan 09, 2001 01:49:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FxiT-0006XP-00@the-village.bc.nu>
From:   Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> promoted to the syscall status? What is the situation that a user in its program
> would like
> to call cacheflush() ? Unless, of course, he is doing DoS.

A cache flush is not a denial of service attack. Its no less effective than a
1Mb memcpy 

> I can understand why we need this in kernel, for context switch, for example, but
> as a syscall?...

Self modifying code, dynamic compilation, glibc trampolines

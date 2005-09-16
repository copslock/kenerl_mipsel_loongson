Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2005 19:54:09 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:8110 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225428AbVIPSxu>; Fri, 16 Sep 2005 19:53:50 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.52 #1 (Debian))
	id 1EGKPJ-0005Pf-1K; Fri, 16 Sep 2005 12:53:53 -0500
Subject: Re: Location of MIPS KDB Patch?
In-Reply-To: <5C1FD43E5F1B824E83985A74F396286E5E9486@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
To:	Don Hiatt <Don_Hiatt@pmc-sierra.com>
Date:	Fri, 16 Sep 2005 12:53:52 -0500 (CDT)
CC:	linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1EGKPJ-0005Pf-1K@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> I just got an email from Sergey and he was referring to KGDB. So
> the mystery remains, has anyone already ported KDB? And if not, is
> it worth it when compared to KGDB (I haven't used either)?
> 
Use printk or a hardware debugger. Software kernel debuggers almost
never work and they're always buggy. The guys who did KGDB for MIPS
did a great job, but it looks like it's hard to keep that code up
to date and working with kernel changes and newer versions of gdb.
At least that's been my experience. In-kernel debuggers is like
saying "Physician heal thyself." or asking yourself to be objective.

-Steve

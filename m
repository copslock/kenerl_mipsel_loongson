Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 May 2007 20:01:14 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:21165 "EHLO
	bluesmobile.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20022919AbXEJTBM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 May 2007 20:01:12 +0100
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.specifix.com (Postfix) with ESMTP id 98F323B8F2;
	Thu, 10 May 2007 12:00:31 -0700 (PDT)
Subject: Re: Building a cross kernel for the IP27/Origin System
From:	Jim Wilson <wilson@specifix.com>
To:	Claus Herrmann <claus.herrmann@cybits.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4640911A.4080801@cybits.de>
References: <4640911A.4080801@cybits.de>
Content-Type: text/plain
Date:	Thu, 10 May 2007 12:00:35 -0700
Message-Id: <1178823635.2740.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-2.fc5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Tue, 2007-05-08 at 17:02 +0200, Claus Herrmann wrote:
> mips-linux-ld: Dwarf Error: found dwarf version '0', this reader only handles version 2 information.

When GNU ld prints an error message, it first looks to see if you
compiled with debug info, and if you did, it tries to read and parse the
debug info so it can pretty-print the error message with source file and
source line number info.  This makes it easier to figure out where the
problem is.  Unfortunately, this code sometimes fails.  The linker must
modify the debug info during the linking process by applying
relocations.  If we try to read the debug info at the wrong time, we may
get an inconsistent view of it, and may fail to read it correctly.  The
code is fail soft, so this is harmless, except that you get annoying
messages that make no sense to you.  Newer GNU ld versions handle this
much better than older GNU ld versions.  I suspect this is what is
happening in your case.

Just edit out the annoying and useless dwarf error messages, and you get

> arch/mips/mm/built-in.o: In function `mem_init':
> : multiple definition of `mem_init'
> arch/mips/sgi-ip27/built-in.o:: first defined here
> arch/mips/mm/built-in.o: In function `paging_init':
> : multiple definition of `paging_init'
> arch/mips/sgi-ip27/built-in.o:: first defined here

which is your real problem.  Looks like a problem with your mips kernel
configuration.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 16:04:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:44937 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029744AbXIZPEf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 16:04:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8QF4Y5B029414;
	Wed, 26 Sep 2007 16:04:35 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8QF4XJj029413;
	Wed, 26 Sep 2007 16:04:33 +0100
Date:	Wed, 26 Sep 2007 16:04:33 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	nigel@mips.com, linux-mips <linux-mips@linux-mips.org>
Subject: Re: Useless stack randomization patch
Message-ID: <20070926150433.GA28017@linux-mips.org>
References: <46FA6846.2080704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46FA6846.2080704@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 26, 2007 at 04:10:14PM +0200, Franck Bui-Huu wrote:

> We started stack inside page randomization through commit
> 941091024ef0f2f7e09eb81201d293ac18833cc8 but it currently does nothing
> usefull because ELF_PLATFORM is not defined on MIPS (see
> fs/binfm_elf.c, create_elf_tables() for details).
> 
> I tried several times to get information on lkml about that dependency
> but unfortunately I got no answer.

lkml has turned into a posting-only mailing list.  I've stopped reading
it years ago; the volume is so insane that I only use it to occasionally
to follow references from other sources.  So don't be surprised if you
don't get an answer.  Linus does not read lkml either.

> I'm not sure how ELF_PLATFORM is used by ld.so and I don't think it's
> a good idea to define it just for enabling stack randomization.
> 
> What do you think ?

I suppose we should give it a sane definition.  Not sure what would be
useful, if it should be like an ASCII string with the processor type or
more corse grained like just "mips32r2", should ASEs be mentioned ...

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2003 13:18:11 +0100 (BST)
Received: from p508B6A7B.dip.t-dialin.net ([IPv6:::ffff:80.139.106.123]:21220
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225239AbTFYMSJ>; Wed, 25 Jun 2003 13:18:09 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5PCI2DB012476;
	Wed, 25 Jun 2003 14:18:02 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5PCI1hn012469;
	Wed, 25 Jun 2003 14:18:01 +0200
Date: Wed, 25 Jun 2003 14:18:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: ik@cyberspace.org
Cc: linux-mips@linux-mips.org
Subject: Re: is there any docs/manuals for linker scripts symbols
Message-ID: <20030625121801.GA11496@linux-mips.org>
References: <20030624120017.GE4423@linux-mips.org> <Pine.SUN.3.96.1030625073721.22435A-100000@grex.cyberspace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SUN.3.96.1030625073721.22435A-100000@grex.cyberspace.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 25, 2003 at 08:01:24AM -0400, ik@cyberspace.org wrote:

> My board has a boot loader (rom) that enforce/restricts the sections in
> the elf header, hence I cannot use the default linker script that comes
> wit the kernel(arch/mips/). 

Are you sure the loader actually looks at the sections?  That seems plain
wrong.  Normally a loader should only look at all the PT_LOAD entries in
the ELF program header table for loading.

> I think your reply could be put as a howto/faqs in
> http://www.linux-mips.org (for the global symbols
> used in linux kernel).

So many things that deserve some well written documentation - yet so little
exists ...

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 13:28:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7649 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022883AbXEVM2X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 13:28:23 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4MCS9ku003341;
	Tue, 22 May 2007 13:28:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4MCS83E003340;
	Tue, 22 May 2007 13:28:08 +0100
Date:	Tue, 22 May 2007 13:28:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	sknauert@wesleyan.edu
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: SGI O2 meth: missing sysfs device symlink
Message-ID: <20070522122808.GD32557@linux-mips.org>
References: <1178743456.15447.41.camel@scarafaggio> <20070516151939.GH19816@deprecation.cyrius.com> <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org> <20070517151636.GJ3586@deprecation.cyrius.com> <20070521154726.GE5943@linux-mips.org> <20070522110956.GB29118@linux-mips.org> <1179834093.7896.23.camel@scarafaggio> <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34888.129.133.92.31.1179835313.squirrel@webmail.wesleyan.edu>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 22, 2007 at 08:01:53AM -0400, sknauert@wesleyan.edu wrote:

> I've noticed that besides kernel complied from the Debian 2.6.18, I can't
> get any other kernel (vanilla from kernel.org or the separate linux-MIPS
> repository) to boot on my O2.
> 
> If you need beta testers, I can try, but it will take a day or so
> (compiling on the O2 is slow).

Sounds almost like you're building an excessibly large kernel configuration.
A realistic kernel config will crosscompile within a few minutes on a
modest machine such as a 3GHz / 1GB P4-class PC.

But to lessen the pains of your aching CPU, here's a binary tarball:

ftp://ftp.linux-mips.org/pub/linux/mips/people/ralf/sgi-ip32/linux-2.6.22-rc2-gc6b5a619-dirty.tar.bz2

> Finally, I've been working on the PCI Legacy IO issue (progress is sadly
> slow - don't have a fully compiling patchset yet), would this patch be
> relevant since its also an O2 sysfs issue?

The two issues are entirely unrelated.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 12:55:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:27788 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021519AbXGFLzu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jul 2007 12:55:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l66BmKv2008635;
	Fri, 6 Jul 2007 12:48:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l66BmJ3p008634;
	Fri, 6 Jul 2007 12:48:19 +0100
Date:	Fri, 6 Jul 2007 12:48:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	saravanan <sar_van81@yahoo.co.in>, linux-mips@linux-mips.org
Subject: Re: error in crosscompiling autoboot for MIPS
Message-ID: <20070706114819.GA8551@linux-mips.org>
References: <357682.93280.qm@web94306.mail.in2.yahoo.com> <20070706092718.GA27044@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070706092718.GA27044@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 06, 2007 at 11:27:18AM +0200, Manuel Lauss wrote:

> That codebase can _only_ be compiled with AMD's gcc-3.4.3 for cygwin (can be
> found on the CD you get with the DB1200 board). It does not work with any
> other toolchain, unfortunately (yes, I tried a few, from 3.3.0 to 4.1.2
> with binutils from 2.15 to 2.17)

The differences between the mips*-linux targets and other MIPS ELF targets
are fairly small these days, typically stuff like cpp predefines and
similar.  So rewriting the code rarely is hard - unless of course
libraries are involved.

  Ralf

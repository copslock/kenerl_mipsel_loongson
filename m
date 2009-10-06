Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2009 14:14:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57583 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492969AbZJFMOF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Oct 2009 14:14:05 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n96CFDmb022339;
	Tue, 6 Oct 2009 14:15:13 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n96CFCan022337;
	Tue, 6 Oct 2009 14:15:12 +0200
Date:	Tue, 6 Oct 2009 14:15:12 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Toy lover <toylover@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: mipsel-sdelinux-v6.03.01-1.i386.rpm
Message-ID: <20091006121512.GD25263@linux-mips.org>
References: <81f85c130910032313u532c5bdt815f0633269bf79e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f85c130910032313u532c5bdt815f0633269bf79e@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 04, 2009 at 02:13:44PM +0800, Toy lover wrote:

> I am trying to compile kernel modules for a kernel compiled with
> mipsel-sdelinux-v6.03.01-1
> but the ftp://ftp.mips.com/
> pub/tools/software/sde-for-linux/v6.03.01-1/mipsel-*sdelinux*
> -v6.03.01-1.i386.rpm
> is no longer available. I am wondering whether any of you can send me a copy
> of mipsel-*sdelinux*-v6.03.01-1.i386.rpm
> which you might still own.

You do not need the same compiler; just the compiler options for the kernel
proper and the module need to be compatible, that is endianess, processor
type etc. need to be the same.

  Ralf

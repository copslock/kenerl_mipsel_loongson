Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2006 04:30:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39043 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027695AbWIGDaS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Sep 2006 04:30:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k873UpGF025530;
	Thu, 7 Sep 2006 05:30:51 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k873UosZ025529;
	Thu, 7 Sep 2006 05:30:50 +0200
Date:	Thu, 7 Sep 2006 05:30:50 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ashlesha Shintre <ashlesha@kenati.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: early_initcall
Message-ID: <20060907033050.GA17965@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D366028@exchange.ZeugmaSystems.local> <1157566247.6485.12.camel@sandbar.kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157566247.6485.12.camel@sandbar.kenati.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 06, 2006 at 11:10:47AM -0700, Ashlesha Shintre wrote:

> I googled early_initcall and found a patch which basically adds this
> line to the /include/init.h file:
> 
> #define early_initcall(fn)             __define_initcall(".early1",fn)

There is more infrastructure needed to get this to work.  And in fact why
are you trying to get it to work at all - a direct call from setup_arch
to your early init function is trivial to do.

> I built a kernel image with this new line included and now if I try
> executing it, the bootloader YAMON gives an exception error before it
> can even begin!  Here is the dump:

Such a dump could be from YAMON or in the very early phase of the kernel
initialization.

> A machine check means that an exception is generated due to duplicate
> TLB entries.  I dont understand why the kernel crashes so early.

There are also other implementation specified reasons that may result
in a machine check exception as well.

> Also, what does the ".early1" mean? Is that a definition of a different
> segment in the init.h file?

Section not segment.  It's just a section name.

> I checked output of the "readelf -a vmlinux" and found that the address
> for the early_initcall comes up about 5 times.  I m not sure what each
> of the fields mean, so I have attached the above part of the readelf in
> a file called readelf.

And if you had not quoted 50 lines of the previous message in this thread
but those lines from the readelf output we might actually tell you.

  Ralf

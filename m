Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2007 14:35:09 +0100 (BST)
Received: from post2.wesleyan.edu ([129.133.6.128]:27620 "EHLO
	post2.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20022294AbXFVNfH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Jun 2007 14:35:07 +0100
Received: from pony1.wesleyan.edu (pony1.wesleyan.edu [129.133.6.192])
	by courier2.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l5MDYxkU001102
	for <linux-mips@linux-mips.org>; Fri, 22 Jun 2007 09:34:59 -0400
Received: (from apache@localhost)
	by pony1.wesleyan.edu (8.12.11.20060308/8.12.11/Submit) id l5MDYxSw003904;
	Fri, 22 Jun 2007 09:34:59 -0400
Received: from 129.133.92.31
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Fri, 22 Jun 2007 09:34:58 -0400 (EDT)
Message-ID: <53391.129.133.92.31.1182519298.squirrel@webmail.wesleyan.edu>
In-Reply-To: <20070620.012206.30438292.anemo@mba.ocn.ne.jp>
References: <54672.129.133.92.31.1182184357.squirrel@webmail.wesleyan.edu>
    <20070619.121030.130240189.nemoto@toshiba-tops.co.jp>
    <Pine.LNX.4.64N.0706191246060.15474@blysk.ds.pg.gda.pl>
    <20070620.012206.30438292.anemo@mba.ocn.ne.jp>
Date:	Fri, 22 Jun 2007 09:34:58 -0400 (EDT)
Subject: Re: Legacy PCI IO for PCI graphics on SGI O2...Anybody?
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-Originating-IP: 129.133.6.192
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

> On Tue, 19 Jun 2007 13:03:24 +0100 (BST), "Maciej W. Rozycki"
> <macro@linux-mips.org> wrote:
>>  That should be taken care of in glibc (or your libc of choice) -- with
>> ioperm() or iopl() and then in{b,w,l}() and out{b,w,l}() as appropriate.
>> Either of the two formers are used to mmap() the right area of /dev/mem
>> and then the latters are used access the area with the desired width
>> (and
>> stride, if applicable -- portable code should not assume subsequent I/O
>> port addresses are adjacent in the MMIO space).  It has worked like this
>> for other platforms for at least ten years now.
>>
>>  Of course the function doing mmap() still has to know the CPU physical
>> address of the I/O space from somewhere.  For quite some time my feeling
>> has been it should come from /proc/iomem, where we actually fail to
>> register the I/O space, but these days sysfs is probably better (though
>> I
>> plan to have a look at /proc/iomem for the use of human beings anyway).
>

The only reason I even attempted to implement this is that I was told
X.org uses the sysfs legacy_ IO inorder to do its Int10 x86 emulation.
This is very useful as it is what allows X.org to POST most video cards on
non-x86 architectures. The fact that my X.org errors went down with my
preliminary patch gives more evidence that if this was correctly
implemented a much larger set of PCI graphics cards would work on MIPS.

> Oh I thought ioperm() or iopl() on archs other then x86 are all dummy
> routines, but apparently that was wrong.  Now I have looked some
> ioperm.c in glibc and am very suprised by so many hard-coded
> boardname/addresses ;)
>

This seems like a mistake, shouldn't the hardware specific chunks be in
the kernel?

>>  That still does not solve the problem of multiple independent I/O
>> spaces,
>> but I gather such configurations are very rare indeed.
>
> I agree.
> ---
> Atsushi Nemoto
>
>

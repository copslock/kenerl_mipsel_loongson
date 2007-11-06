Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 10:36:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11437 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28578316AbXKFKgI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Nov 2007 10:36:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA6Aa410029474;
	Tue, 6 Nov 2007 10:36:04 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA6Aa3ur029473;
	Tue, 6 Nov 2007 10:36:03 GMT
Date:	Tue, 6 Nov 2007 10:36:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Kill __bzero()
Message-ID: <20071106103603.GA24844@linux-mips.org>
References: <472D8058.5080209@gmail.com> <20071105112429.GC27893@linux-mips.org> <472F906F.7080205@gmail.com> <20071105231818.GA18820@linux-mips.org> <47301AF8.2000700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47301AF8.2000700@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 06, 2007 at 08:42:48AM +0100, Franck Bui-Huu wrote:

> > Older gcc used to generate significantly worse code for inline functions
> > than for macros so Linux became a fairly excessive user of macros.  This
> > has very much improved since, so these days inlines are prefered over
> > macros where possible.
> 
> Yes but ISTR that gcc generates some calls to memset and since
> builtin functions are disabled the final link failed if memset
> is inlined. I'll try to reproduce...

So both belt and suspenders then that is an inline/macro plus an outline
version?

> >> Yes I noticed this. Actually I'm wondering if we couldn't add a new
> >> function, fill_user() like the following:
> >>
> >> extern size_t fill_user(void __user *to, int c, size_t len);
> > 
> > That's much better function name than the old __bzero - except that
> 
> Actually I named it '__fill_user', since it doesn't call access_ok().
> 
> > __bzero effectivly took a long argument for the 2nd argument so 32-bit
> > on 32-bit kernels and 64-bit on 64-bit kernels.
> 
> Isn't size_t meaning ?
> 
> Perhaps in this case __kernel_size_t is better...

I wrote about the existing __bzero which takes the size_t length as third 
argument and a long sized fill pattern as the second.

> Yes I have a patchset which clean up a bit uaccess.h and does this but
> it's under construction.  It actually tries to convert all macros into
> inlines and the file is much more readable and as a bonus side we could
> easily add __must_check annotations which are currently missing.
> 
> I'll try to finish it this week but in the meantime can we just kill
> __bzero or do you want me to include it in the future patchset ?

There is enough time until 2.6.25 to complete your cleanups; no more
cleanups for 2.6.24.

  Ralf

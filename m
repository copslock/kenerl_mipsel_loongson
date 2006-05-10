Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 May 2006 11:11:53 +0200 (CEST)
Received: from ug-out-1314.google.com ([66.249.92.175]:8303 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133407AbWEJJLo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 May 2006 11:11:44 +0200
Received: by ug-out-1314.google.com with SMTP id e2so213029ugf
        for <linux-mips@linux-mips.org>; Wed, 10 May 2006 02:11:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e19b4B2B1d+PNv8jr4+5yZ6RtfCGU2WuuS/P2mdwkCnLtrWERkKcNsPLqhoGmiJ1cBqG3fJssk8X11tWCF68al3uFNfpzrnysd0gOlwPbcB7hAQH5bfh5J2LpR9QkLjjogmLRQg1jXh1ngSqQUxW35natS3j5657F+oCMpuZojA=
Received: by 10.78.57.11 with SMTP id f11mr81793hua;
        Wed, 10 May 2006 02:11:43 -0700 (PDT)
Received: by 10.78.39.13 with HTTP; Wed, 10 May 2006 02:11:43 -0700 (PDT)
Message-ID: <c58a7a270605100211o8181e23p5c0b1a7eb0060f90@mail.gmail.com>
Date:	Wed, 10 May 2006 10:11:43 +0100
From:	"Alex Gonzalez" <langabe@gmail.com>
To:	Mark.Zhan <rongkai.zhan@windriver.com>
Subject: Re: Boot time memory allocation
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <44614E0F.2000207@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <c58a7a270605090735t8e4f21ax6ca87f97b9143e3b@mail.gmail.com>
	 <20060509163411.GA8528@linux-mips.org>
	 <44614E0F.2000207@windriver.com>
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks for the answers.

I wrongly assumed I wouldn't be able to access unspecified memory
regions, or that I'd have to tweak it somehow.

Regards,
Alex

On 5/10/06, Mark.Zhan <rongkai.zhan@windriver.com> wrote:
> Ralf Baechle wrote:
> > On Tue, May 09, 2006 at 03:35:14PM +0100, Alex Gonzalez wrote:
> >
> >> I have two independent processors with access to a shared memory
> >> region, mapped in the 256MB to 512MB region (kseg0).
> >>
> >> One is running a propietary OS, and the second one is running Linux 2.6.12.
> >>
> >> How would I arrange to leave that shared memory region out of the
> >> scope of Linux's memory management system, but at the same time make
> >> it possible for a driver to access it?
> >>
> >> I have done similar things before with the help of alloc_bootmem, but
> >> this time I don't want the kernel to reserve the memory, I want the
> >> kernel to be completely unaware of it, and I need to specify its start
> >> and end.
> >
> > At kernel initialization time just don't tell the kernel about the
> > existence of your memory region.  For many systems that just means you
> > shrink the memory region passed to the add_memory_region() call to
> > something that suits your platform.
> >
> >   Ralf
> >
>
> Maybe it is a more flexible way to specify the memory regions via
> command line. You know, this will produce User-defined memory regions to
> kernel.
>

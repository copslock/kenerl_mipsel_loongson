Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5R2NSd03306
	for linux-mips-outgoing; Tue, 26 Jun 2001 19:23:28 -0700
Received: from yog-sothoth.sgi.com (eugate.sgi.com [192.48.160.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5R2NJV03303;
	Tue, 26 Jun 2001 19:23:19 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) by yog-sothoth.sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam-europe) via SMTP id EAA301202; Wed, 27 Jun 2001 04:23:15 +0200 (CEST)
	mail_from (kaos@ocs.com.au)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id MAA11464; Wed, 27 Jun 2001 12:21:57 +1000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: ksymoops changes for mips
In-reply-to: Your message of "Wed, 13 Jun 2001 22:19:14 +1000."
             <8465.992434754@ocs4.ocs-net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Jun 2001 12:21:57 +1000
Message-ID: <16633.993608517@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 13 Jun 2001 22:19:14 +1000, 
Keith Owens <kaos@melbourne.sgi.com> wrote:
>ksymoops is designed to run on any build arch and debug an oops report
>from any other target arch, as long as binutils supports the target
>arch.  The presence or absence of __MIPSEL__ or __MIPSEB__ on the build
>system says nothing about the type of the failing target, ksymoops
>relies on text in the oops report to determine special cases like 32
>bit userland and 64 bit kernel.
>
>The best option is for a mips64 kernel to indicate that it is 64 bit
>and its endianess.  Instead of printing
>
>  "epc     : %016lx\n"
>
>print
>
>  "epc     : %016lx (64 "
>#ifdef __MIPSEL__
>		"LSB"
>#else
>		"MSB"
>#endif
>		")\n"

I have a new ksymoops release coming up.  Is it OK if I include code to
look for (64 LSB) and (64 MSB) in the oops and decode accordingly.  I
don't expect the kernel to produce this output immediately, I just want
agreement on the format that will be produced.

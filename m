Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49CjDD23861
	for linux-mips-outgoing; Wed, 9 May 2001 05:45:13 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49Cj9F23857;
	Wed, 9 May 2001 05:45:09 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id A0EC51E261; Wed,  9 May 2001 14:45:08 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
Mail-Copies-To: never
To: sjhill@cotw.com
Cc: Florian Lohoff <flo@rfc822.org>, Tom Appermont <tea@sonycom.com>,
   Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
References: <20010505144708.A12575@paradigm.rfc822.org>
	<20010507163210.B2381@bacchus.dhis.org>
	<20010508202518.A13476@paradigm.rfc822.org>
	<20010508214313.A12528@bacchus.dhis.org>
	<20010509095955.A8392@sonycom.com>
	<20010509104635.D12267@paradigm.rfc822.org>
	<3AF934AE.38AB0089@cotw.com> <hoeltyemh0.fsf@gee.suse.de>
	<3AF93D3F.5E57070@cotw.com>
From: Andreas Jaeger <aj@suse.de>
Date: 09 May 2001 14:45:07 +0200
In-Reply-To: <3AF93D3F.5E57070@cotw.com> ("Steven J. Hill"'s message of "Wed, 09 May 2001 07:51:11 -0500")
Message-ID: <hopudid73g.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Steven J. Hill" <sjhill@cotw.com> writes:

> Andreas Jaeger wrote:
> > 
> > Ok, I finally understand.  Can you send a new patch for glibc with an
> > update for the FAQ?  I'll add it this time.
> > 
> diff -urN glibc-2.2.3/sysdeps/mips/rtld-ldscript.in glibc-2.2.3-patched/sysdeps/
> mips/rtld-ldscript.in
> --- glibc-2.2.3/sysdeps/mips/rtld-ldscript.in   Sat Jul 12 18:23:14 1997
> +++ glibc-2.2.3-patched/sysdeps/mips/rtld-ldscript.in   Sun Apr 29 22:32:35 2001
> @@ -1,4 +1,3 @@
> -OUTPUT_FORMAT("@@rtld-oformat@@")
>  OUTPUT_ARCH(@@rtld-arch@@)
>  ENTRY(@@rtld-entry@@)
>  SECTIONS
> 
> 
> There's the patch. It's not much but it is correct. I have built multiple

But it's not complete.  AFAIK remember you posted a patch with some
more changes and HJ even suggested to remove the rtld-ldscript.in file.

> toolchains and such using this patch. GCC out of CVS both the 3.0 and
> cutting edge branch work without patches for Linux. And as mentioned
> earlier, binutils is already fixed. As far as FAQ update...what do you
> want?

I need an update for the FAQ that explains which binutils version is
required for MIPS and I prefer to have a test that checks on
MIPS-Linux for the correct emulation in ld.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49Dnlr27159
	for linux-mips-outgoing; Wed, 9 May 2001 06:49:47 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49DniF27155;
	Wed, 9 May 2001 06:49:44 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 6A1D31E267; Wed,  9 May 2001 15:49:43 +0200 (MEST)
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
	<3AF93D3F.5E57070@cotw.com> <hopudid73g.fsf@gee.suse.de>
	<3AF94D3C.98A4E8@cotw.com>
From: Andreas Jaeger <aj@suse.de>
Date: 09 May 2001 15:49:43 +0200
In-Reply-To: <3AF94D3C.98A4E8@cotw.com> ("Steven J. Hill"'s message of "Wed, 09 May 2001 08:59:24 -0500")
Message-ID: <hor8xybpjc.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Steven J. Hill" <sjhill@cotw.com> writes:

> Andreas Jaeger wrote:
> > 
> > > There's the patch. It's not much but it is correct. I have built multiple
> > 
> > But it's not complete.  AFAIK remember you posted a patch with some
> > more changes and HJ even suggested to remove the rtld-ldscript.in file.
> > 
> I had this discussion with Ralf. He had reasons to not remove this
> file altogether. Perhaps some input from him would be prudent. Ralf?!

So the one-liner you mailed should be all that has to be added?

> > I need an update for the FAQ that explains which binutils version is
> > required for MIPS and I prefer to have a test that checks on
> > MIPS-Linux for the correct emulation in ld.
> > 
> As far as the versions for binutils:
> 
>    HJLu binutils-2.11.90.0.5 or greater
>    CVS binutils
>    binutils 2.11.1? (I'm not sure what the next release number is)
> 
> For the correct ld emulation, I assume you mean make changes in glibc
> to check for the proper target 'elf[32|64]trad[little|big]mips'?

That's what I mean,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj

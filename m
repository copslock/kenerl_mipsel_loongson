Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f345xO001883
	for linux-mips-outgoing; Tue, 3 Apr 2001 22:59:24 -0700
Received: from mail.kdt.de (mail.kdt.de [195.8.224.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f345xMM01880
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 22:59:23 -0700
Received: from arthur.inka.de (arthur.kdt.de [195.8.250.5])
	by mail.kdt.de (8.11.1/8.11.0) with ESMTP id f345xBg08190;
	Wed, 4 Apr 2001 07:59:11 +0200
Received: from gromit.rhein-neckar.de ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 14kgIF-0004Kb-00; Wed, 04 Apr 2001 07:57:23 +0200
Received: by gromit.rhein-neckar.de (Postfix, from userid 207)
	id BA83E1EA2E; Wed,  4 Apr 2001 07:57:22 +0200 (CEST)
Mail-Copies-To: never
To: sjhill@cotw.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Binutils fixed to deal with 'insmod' issue and discussion...
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses>
	<3AC90E16.AEF59359@cotw.com>
	<20010403041740.G5099@rembrandt.csv.ica.uni-stuttgart.de>
	<20010403102608.A30531@bacchus.dhis.org> <3ACA07F6.CB1119A4@cotw.com>
From: Andreas Jaeger <aj@suse.de>
Date: 04 Apr 2001 07:57:22 +0200
In-Reply-To: <3ACA07F6.CB1119A4@cotw.com> ("Steven J. Hill"'s message of "Tue, 03 Apr 2001 12:27:18 -0500")
Message-ID: <u8bsqdmcl9.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Steven J. Hill" <sjhill@cotw.com> writes:

> Ralf Baechle wrote:
> > 
> > IRIX ELF orders the symbol table of object files in a way that violates
> > the ABI.  Worse, these IRIX specialities are not documented anywhere.
> > 
> > Changing to ABI ELF only makes them look as they're supposed to ...
> > 
> Thanks for backing me up. Also, after discussion with Ralf on IRC,
> the decision has been made to except the patch as the fix. There will
> not be an additional target 'irix[little|big]mips' added. Linux and
> SVR4 will utilize 'trad[little|big]mips' and IRIX and other targets
> will use '[little|big]mips'. Also, when building for Linux targets,
> the 'elf[32|64]_[little|big]mips' targets (IRIX) will not be built as
> emulation targets.

Please send the patch to binutils@sources.redhat.com and get it
integrated into the official sources!

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj

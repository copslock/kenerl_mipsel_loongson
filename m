Received:  by oss.sgi.com id <S553847AbQJNRzr>;
	Sat, 14 Oct 2000 10:55:47 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:59910 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553843AbQJNRzZ>;
	Sat, 14 Oct 2000 10:55:25 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1043B7F8; Sat, 14 Oct 2000 19:55:23 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id D36AA900C; Sat, 14 Oct 2000 19:54:16 +0200 (CEST)
Date:   Sat, 14 Oct 2000 19:54:16 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Christopher C. Chimelis" <chris@debian.org>,
        Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001014195416.A1598@paradigm.rfc822.org>
References: <20001014125532.A1536@paradigm.rfc822.org> <Pine.LNX.4.21.0010140730280.17430-100000@spawn.hockeyfiend.com> <20001014162546.A6206@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001014162546.A6206@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Oct 14, 2000 at 04:25:46PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 04:25:46PM +0200, Ralf Baechle wrote:
> On Sat, Oct 14, 2000 at 07:33:35AM -0400, Christopher C. Chimelis wrote:
> 
> > > *urgs* 2.0.6 - I am currently building everything against 2.0.6 but
> > > i rather now then later stop using it - But currently i am not using 2.2
> > > because with the newest patch set by Ralf (glibc + binutils) i get
> > > a bus error while using rpcgen with the freshly build 2.2 glibc in
> > > the build process ...
> > 
> > Ugh.  Well, once you all figure out if binutils is to blame or if it's
> > gcc, drop me a note and I'll make sure to spit out a binutils package that
> > includes the good patch...
> 
> It's not obvious what's causing his problem.
> 
> Florian: Can you run elf/ld.so from your glibc 2.2 tree without any further
> options or does it die?

No it doesnt - Works as expected ... When running like

elf/ld.so --library-path . sunrpc/rpcgen

i get a "Bus Error"

Ill send you the LD_DEBUG=all ouput seperatly - It crashes after transfer
to the program ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."

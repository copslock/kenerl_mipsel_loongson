Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f793lK728963
	for linux-mips-outgoing; Wed, 8 Aug 2001 20:47:20 -0700
Received: from ns1.ltc.com (ns1.ltc.com [38.149.17.165])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f793lGV28957
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 20:47:16 -0700
Received: from prefect (gw1.ltc.com [38.149.17.163])
	by ns1.ltc.com (Postfix) with SMTP id 77C76590AB
	for <linux-mips@oss.sgi.com>; Wed,  8 Aug 2001 23:44:40 -0400 (EDT)
Message-ID: <046001c12086$4ba02ee0$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <linux-mips@oss.sgi.com>
References: <02a401c12063$cde1e830$3501010a@ltc.com> <20010808164502.A6966@nevyn.them.org> <02ca01c12066$164e5570$3501010a@ltc.com> <040c01c1207d$78b62b90$3501010a@ltc.com>
Subject: Re: gcc 3.0 / glibc 2.2.3 cross-toolchain
Date: Wed, 8 Aug 2001 23:49:30 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've chronicled my cross-toolchain mips-adventures at:

http://www.ltc.com/~brad/mips/mipsel-linux-cross-toolchain-building.txt

I included a copy of the glibc patch that has the MAP_BASE_ADDR fix in it in
the same directory, namely:

http://www.ltc.com/~brad/mips/

Regards,
Brad

----- Original Message -----
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Bradley D. LaRonde" <brad@ltc.com>; "Daniel Jacobowitz"
<dan@debian.org>
Cc: <linux-mips@oss.sgi.com>
Sent: Wednesday, August 08, 2001 10:44 PM
Subject: Re: gcc 3.0 / glibc 2.2.3 cross-toolchain


> Woohoo!  It works!  Thanks!  I was using H. J. Lu's first patch and that
was
> broken.  I found the second patch and it worked, except it left the first
> line in rtld-ldscript.in, when it really should have removed the file
> entirely.  Looks like it's right in the glibc CVS though.
>
> Regards,
> Brad
>
> ----- Original Message -----
> From: "Bradley D. LaRonde" <brad@ltc.com>
> To: "Daniel Jacobowitz" <dan@debian.org>
> Cc: <linux-mips@oss.sgi.com>
> Sent: Wednesday, August 08, 2001 7:58 PM
> Subject: Re: gcc 3.0 / glibc 2.2.3 cross-toolchain
>
>
> > ----- Original Message -----
> > From: "Daniel Jacobowitz" <dan@debian.org>
> > To: "Bradley D. LaRonde" <brad@ltc.com>
> > Cc: <linux-mips@oss.sgi.com>
> > Sent: Wednesday, August 08, 2001 7:45 PM
> > Subject: Re: gcc 3.0 / glibc 2.2.3 cross-toolchain
> >
> >
> > > On Wed, Aug 08, 2001 at 07:42:17PM -0400, Bradley D. LaRonde wrote:
> > > > I have spent quite a bit of time trying to get a gcc 3.0 / glibc
2.2.3
> > > > cross-toolchain working.  I am not a Toolchain Builder, but I really
> > wanted
> > > > to try this combo and I don't see any way around building it myself.
> > > >
> > > > I've had some success.  Everything seems to build fine.  However,
when
> I
> > try
> > > > to run a simple "hello world" dynamically linked with glibc, I get
> this:
> > > >
> > > >     <myprogram>: error while loading shared libraries: failed to map
> > > >     segment from shared object: cannot load shared object file:
> Invalid
> > > > argument
> > > >
> > > > I think it is trying to load libc.so.6, which is in my root in
/lib/,
> > > > symlinked to libc-2.2.3.so, and so is ld.so.1, symlinked to
> ld-2.2.3.so.
> > > >
> > > > I feel like I am pretty close, but I am starting to get discouraged
> and
> > > > could really use some help.  I really am clueless about what
> > > > should/shouldn't work.  I'm trying to do this based on bits and
pieces
> > of
> > > > information that I've collected from countless sources.  I have
heard
> > that
> > > > gcc 3.0 isn't really "working", but I still want to try.
> > > >
> > > > Here is what I've used:
> > > >
> > > >    * binutils-2.11.90.0.25.tar.gz (extracted from H. J. Lu's
> > > >      srpm on oss.sgi.com; I've tried others also)
> > > >    * gcc-3.0.tar.gz (released version - no patches)
> > > >    * glibc-linuxthreads-2.2.3.tar.gz (released version - no
> > > >      patches; glibc didn't want to configure without this)
> > > >    * glibc-2.2.3.tar.gz (released version)
> > >
> > > You're missing the patch to change MAP_BASE_ADDR.  You need that.
> > > Something as simple as changing it to 0 will work for you, since
you're
> > > building everything yourself.
> >
> > I tried applying the patch that H. J. Lu posted on linux-mips that
> contains
> > that fix, but then glibc would compile.  I'll try it again - maybe I
> messed
> > something up.  If that doesn't work, I'll try the simple fix.  Thanks.
> >
> > Regards,
> > Brad

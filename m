Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA7CTt308808
	for linux-mips-outgoing; Wed, 7 Nov 2001 04:29:55 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA7CTn008805;
	Wed, 7 Nov 2001 04:29:49 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 161Rpz-0001PR-00; Wed, 07 Nov 2001 13:29:47 +0100
Date: Wed, 7 Nov 2001 13:29:47 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: arcboot patches
Message-ID: <20011107132947.A5058@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
References: <20011104233218.A15847@bogon.ms20.nix> <20011106113517.F1524@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011106113517.F1524@dea.linux-mips.net>; from ralf@oss.sgi.com on Tue, Nov 06, 2001 at 11:35:18AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 06, 2001 at 11:35:18AM -0800, Ralf Baechle wrote:
> On Sun, Nov 04, 2001 at 11:32:19PM +0100, Guido Guenther wrote:
> 
> >  typedef struct {
> > +#ifdef __MIPSEL__
> >  	ULONG LowPart;
> > +	*LONG HighPart;
> > +#else /* !(__MIPSEL__) */
> >  	LONG HighPart;
> > +	ULONG LowPart;
> > +#endif
> >  } LARGEINTEGER;
> 
> Why not simply defining LARGEINTEGER as long long?
I'm giving the question back to you, since you checked the original
version into oss's cvs and started to adapt it for mips I assume. I just
added the __MIPSEL__ clobber.
> 
> > Index: arclib/spb.h
> > ===================================================================
> > RCS file: /cvs/arcboot/arclib/spb.h,v
> > retrieving revision 1.2
> > diff -u -u -r1.2 spb.h
> > --- arclib/spb.h	2001/03/20 02:55:56	1.2
> > +++ arclib/spb.h	2001/11/04 22:06:28
> > @@ -90,7 +90,7 @@
> >  	ADAPTER Adapters[1];
> >  } SPB;
> >  
> > -#define SystemParameterBlock	((SPB *) 0x1000)
> > +#define SystemParameterBlock	((SPB *) 0xA0001000UL) 
> 
> That should be 0x80001000UL I think.
Both refer to the same physical address. Since I don't want to get into
the way of any caches I used the former one(as does the kernel).

> > -EXT2LIB = /usr/lib/libext2fs.a
> > +#EXT2LIB = /usr/lib/libext2fs.a
> > +EXT2LIB = ../../e2fslib/e2fsprogs-1.25/lib/libext2fs.a
> 
> That needs to be a non-pic library which nobody has installed on his
> system so I suggest we just put a copy of libext2fs into the arcboot
> sources.  That would alos make arcboot selfcontained and eleminate
> build problems.
Someone has to rip the libext2fs specific part out of e2fsutils then.
I'll do so, when I have the kernel booting.
 -- Guido

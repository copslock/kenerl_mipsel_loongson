Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VFTJ500635
	for linux-mips-outgoing; Tue, 31 Jul 2001 08:29:19 -0700
Received: from epic8.Stanford.EDU (epic8.Stanford.EDU [171.64.15.41])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VFTIV00631
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 08:29:18 -0700
Received: (from johnd@localhost)
	by epic8.Stanford.EDU (8.11.1/8.11.1) id f6VFTCp28904;
	Tue, 31 Jul 2001 08:29:12 -0700 (PDT)
Date: Tue, 31 Jul 2001 08:29:12 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: Carsten Langgaard <carstenl@mips.com>
cc: SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: r4600 flag
In-Reply-To: <3B66B4E6.70B80D21@mips.com>
Message-ID: <Pine.GSO.4.31.0107310824430.28499-100000@epic8.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Looking at the system map from the generic build of 2.4.3, it looks like
the code is 64 bit.  The upper 32 bits are "f" instead of 0.  I built it
using the R4600 flag.  This differs from the system map for 2.4.0-test9
where the upper 32 bits are 0.  For the indy, do I specify mips2 to
generate 32 bit code?  objdump says it is ELF32, but it doesn't look like
that.  I would like to generate 32bit.

thanks,
john

On Tue, 31 Jul 2001, Carsten Langgaard wrote:

>
>
> Ralf Baechle wrote:
>
> > On Tue, Jul 31, 2001 at 09:28:22AM +0200, Thiemo Seufer wrote:
> >
> > > > The la macro is split into a lui and a daddiu. The daddiu is not correct
> > > > for a mips32 cpu. Getting rid of the -mcpu=4600 fixes the problem and
> > > > the daddiu is then changed addiu.
> > >
> > > This is IIRC a known bug in at least current binutils CVS, a patch
> > > to fix it really was already discussed.
> >
> > Is this macro expaned by the compiler or assembler?  Just -mcpu=r4600
> > should not make cc1 generate any instructions beyond MIPS I.
> >
> > In the past we already had inline assembler fragments that left the assembler
> > in .misp3 mode thus resulting the rest of the file bein assembled in
> > mips3 mode.
>
> Yes, and I'm sure I fixed that so it worked on MIPS32 CPUs, only leaving the
> "eret" instructions.
>
> >
> > > > Is there a truly correct -mcpu option for a mips32 cpu?
> >
> > None is really good, none is really bad ...
> >
> > > In theory, no -mcpu option (which is to be deprecated in
> > > favor of -march/-mtune) and -mips32 as ISA flag _should_ work.
> > >
> > > In practice, the patch which adds this to gas was discussed on the
> > > binutils list the last days and is likely to go in CVS
> > > today or tomorrow.
> >
> >   Ralf
>
>

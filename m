Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g09Is6w11725
	for linux-mips-outgoing; Wed, 9 Jan 2002 10:54:06 -0800
Received: from emma.patton.com (emma.patton.com [209.49.110.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g09Irxg11722
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 10:54:00 -0800
Received: from patton.com (decpc.patton.com [209.49.110.83])
	by emma.patton.com (8.9.0/8.9.0) with ESMTP id MAA09071;
	Wed, 9 Jan 2002 12:54:00 -0500 (EST)
Message-ID: <3C3C8370.2B1F1C54@patton.com>
Date: Wed, 09 Jan 2002 12:52:48 -0500
From: Paul Kasper <paul@patton.com>
Reply-To: paul@patton.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm@momenco.com>
CC: ellis@spinics.net, linux-mips@oss.sgi.com
Subject: Re: Galileo 64240
References: <NEBBLJGMNKKEEMNLHGAIGELHCEAA.mdharm@momenco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Matthew Dharm wrote:
> 
> I would love a copy of that, personally.  Could you send it to me (or
> the list)?
> 
> Matt
> 
> --
> Matthew D. Dharm                            Senior Software Designer
> Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> Momentum Works For You                      www.momenco.com
> 
> > I also have a hacked-up port of MontaVista's HHLinux gt96100eth code
> > that is functional on 64240 and 64240A in little-endian mode and
> > untested in BE.  It still lacks support for any "advanced"
> > features of
> > the Galileo chips.
> >
> > --
> >  /"\ . . . . . . . . . . . . . . . /"\
> >  \ /   ASCII Ribbon Campaign       \ /     Paul R. Kasper
> >   X    - NO HTML/RTF in e-mail      X      Patton Electronics Co.
> >  / \   - NO MSWord docs in e-mail  / \     301-975-1000 x173
> >

Matt:

I'll zip up a copy of the gt64240eth driver as soon as I can track down
the relvant include files, and send it to you.  I should mention that
I'm still running it on a 2.4.0-test9 kernel.

Maybe after you verify that it is complete, we can post it to the list.

Our board configuration is a QED RM5261A with GT64240A, Intel Flash,
STK1744 RTC/NVRAM, 16C2550 DUART, and a bunch of Conexant HDLC I/O --
not all of which is coded yet.

I do have the basic arch/mips/patton/{generic,dsl3224} board support
trees which were based on mips/atlas and ev96100 ports but,
unfortunately, I still reference some Galileo/VxWorks sample code in the
interrupt handler.  This needs to be cleaned up.  I originally used
their code only because I did not have a working 64240 board to test
with and the Galileo datasheets are so ambiguous that I thought that
their sample code programmers might have had some hidden insight into
the chips.  I since have learned that the opposite is true and need to
clean all of that stuff out.

--
Paul K.
--
 /"\ . . . . . . . . . . . . . . . /"\
 \ /   ASCII Ribbon Campaign       \ /     Paul R. Kasper
  X    - NO HTML/RTF in e-mail      X      Patton Electronics Co.
 / \   - NO MSWord docs in e-mail  / \     301-975-1000 x173

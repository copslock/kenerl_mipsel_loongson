Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0TKXJT24785
	for linux-mips-outgoing; Tue, 29 Jan 2002 12:33:19 -0800
Received: from mother.pmc-sierra.bc.ca (mother.pmc-sierra.bc.ca [216.241.224.12])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0TKX9d24781
	for <linux-mips@oss.sgi.com>; Tue, 29 Jan 2002 12:33:09 -0800
Received: (qmail 24083 invoked by uid 104); 29 Jan 2002 18:29:30 -0000
Received: from Manoj_Ekbote@pmc-sierra.com by mother with qmail-scanner-1.00 (uvscan: v4.1.40/v4183. . Clean. Processed in 0.461003 secs); 29 Jan 2002 18:29:30 -0000
Received: from unknown (HELO hymir.pmc-sierra.bc.ca) (134.87.114.120)
  by mother.pmc-sierra.bc.ca with SMTP; 29 Jan 2002 18:29:29 -0000
Received: from bby1exi01.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by hymir.pmc-sierra.bc.ca (jason/8.11.6) with ESMTP id g0TITRj09628;
	Tue, 29 Jan 2002 10:29:27 -0800 (PST)
Received: by bby1exi01 with Internet Mail Service (5.5.2653.19)
	id <XNR3G5VH>; Tue, 29 Jan 2002 10:29:29 -0800
Message-ID: <DC10067A2F4A5944B7811FCF59ABB1147450A0@sjc2exm01>
From: Manoj Ekbote <Manoj_Ekbote@pmc-sierra.com>
To: "'Pete Popov'" <ppopov@pacbell.net>, Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: RE: Help with OOPSes, anyone?
Date: Tue, 29 Jan 2002 10:27:24 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Yes,I have access to the CD that has Montavista's kernel(2.4.2) on it.

Manoj


> -----Original Message-----
> From: Pete Popov [mailto:ppopov@pacbell.net]
> Sent: Tuesday, January 29, 2002 8:47 AM
> To: Matthew Dharm
> Cc: linux-mips; Manoj Ekbote
> Subject: Re: Help with OOPSes, anyone?
> 
> 
> On Mon, 2002-01-28 at 22:18, Matthew Dharm wrote:
> > Do you know who, precisely, got the CD?  I'm going to try 
> to chase this
> > down, but exact names would be helpful.
> 
> I believe Manoj has access to it and I added him to the CC without
> asking ;-)
>  
> > Also, when you push that material out to the community, 
> when did you do
> > that?  That is, if your work is 2.4.2-based, is it 
> reasonable to assume
> > that 2.4.2 or 2.4.3 in the CVS repository will work?  
> 
> No, not necessarily.   Sometimes I push out patches for new 
> boards even
> if the support is not fully baked yet. But typically I wait until I've
> got something useful going.  That means that the work might have been
> done locally, on a 2.4.2 snapshot, and submitted once it was stable.
> However, oss might have been up to 2.4.5 at that point; that, and
> whatever delay is introduced because Ralf is too busy to immediately
> apply the patches means that a MontaVista 2.4.2 based release does not
> necessarily equal oss 2.4.2.
> 
> > Or do you take a more "fire and forget" sort of approach?
> 
> I'm not sure what you mean by that.  Hopefully the above is clear
> enough.
> 
> Pete
>  
> > Matthew Dharm
> > 
> > On Mon, Jan 28, 2002 at 06:29:22PM -0800, Pete Popov wrote:
> > > 
> > > > And 2.4.17 with the wait instruction turned off still crashes.
> > >  
> > > > The Montavista kernel (which claims to be 2.4.0 #5 
> build by jsun)
> > > > seems to work...  
> > > 
> > > Strange, that must have been some interim build Jun did.
> > > 
> > > > I've done several recompiles on it, and lots of I/O
> > > > traffic with no problems.  Unfortunatly, I don't have 
> the source code
> > > > to this particular kernel... tho I believe that 
> Montavista is required
> > > > to release their source cod by the GPL.
> > > 
> > > All of the open source work we do we push out to the 
> community tree 
> > > immediately.  That's a rule we live by and there's no 
> exceptions.  The Ocelot 
> > > code was pushed out back then. Since then I've seen lots 
> of additions to that 
> > > directory and obviously something got broke.
> > > 
> > > QED did receive an Alliance CD with the Ocelot LSP on it, 
> so they should
> > > be able to provide you with a copy of the cdimage, including the
> > > source.  But the kernel will be 2.4.2 based though -- I 
> don't know where
> > > the 2.4.0 came from.
> > >  
> > > > Tho here's a question:  What is the best compiler to 
> build a kernel
> > > > with?  I've built all mine with egcs-2.91.66 which I 
> downloaded from
> > > > oss.sgi.com a while ago.
> > > 
> > > MontaVista's, but I'm biased ;-)  The toolchain will be 
> on the CD as
> > > well.
> > > 
> > > Pete
> > > 
> > 
> > -- 
> > Matthew Dharm                              Work: mdharm@momenco.com
> > Senior Software Designer, Momentum Computer
> > 
> 
> 

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0THkbs15369
	for linux-mips-outgoing; Tue, 29 Jan 2002 09:46:37 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0THkSP15360
	for <linux-mips@oss.sgi.com>; Tue, 29 Jan 2002 09:46:29 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0TGiVB24258;
	Tue, 29 Jan 2002 08:44:31 -0800
Subject: Re: Help with OOPSes, anyone?
From: Pete Popov <ppopov@pacbell.net>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>,
   Manoj Ekbote
	 <Manoj_Ekbote@pmc-sierra.com>
In-Reply-To: <20020128221829.A24770@momenco.com>
References: <NEBBLJGMNKKEEMNLHGAIIEBLCFAA.mdharm@momenco.com>
	<1012271362.8518.219.camel@zeus>  <20020128221829.A24770@momenco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 29 Jan 2002 08:47:04 -0800
Message-Id: <1012322824.8522.232.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-01-28 at 22:18, Matthew Dharm wrote:
> Do you know who, precisely, got the CD?  I'm going to try to chase this
> down, but exact names would be helpful.

I believe Manoj has access to it and I added him to the CC without
asking ;-)
 
> Also, when you push that material out to the community, when did you do
> that?  That is, if your work is 2.4.2-based, is it reasonable to assume
> that 2.4.2 or 2.4.3 in the CVS repository will work?  

No, not necessarily.   Sometimes I push out patches for new boards even
if the support is not fully baked yet. But typically I wait until I've
got something useful going.  That means that the work might have been
done locally, on a 2.4.2 snapshot, and submitted once it was stable.
However, oss might have been up to 2.4.5 at that point; that, and
whatever delay is introduced because Ralf is too busy to immediately
apply the patches means that a MontaVista 2.4.2 based release does not
necessarily equal oss 2.4.2.

> Or do you take a more "fire and forget" sort of approach?

I'm not sure what you mean by that.  Hopefully the above is clear
enough.

Pete
 
> Matthew Dharm
> 
> On Mon, Jan 28, 2002 at 06:29:22PM -0800, Pete Popov wrote:
> > 
> > > And 2.4.17 with the wait instruction turned off still crashes.
> >  
> > > The Montavista kernel (which claims to be 2.4.0 #5 build by jsun)
> > > seems to work...  
> > 
> > Strange, that must have been some interim build Jun did.
> > 
> > > I've done several recompiles on it, and lots of I/O
> > > traffic with no problems.  Unfortunatly, I don't have the source code
> > > to this particular kernel... tho I believe that Montavista is required
> > > to release their source cod by the GPL.
> > 
> > All of the open source work we do we push out to the community tree 
> > immediately.  That's a rule we live by and there's no exceptions.  The Ocelot 
> > code was pushed out back then. Since then I've seen lots of additions to that 
> > directory and obviously something got broke.
> > 
> > QED did receive an Alliance CD with the Ocelot LSP on it, so they should
> > be able to provide you with a copy of the cdimage, including the
> > source.  But the kernel will be 2.4.2 based though -- I don't know where
> > the 2.4.0 came from.
> >  
> > > Tho here's a question:  What is the best compiler to build a kernel
> > > with?  I've built all mine with egcs-2.91.66 which I downloaded from
> > > oss.sgi.com a while ago.
> > 
> > MontaVista's, but I'm biased ;-)  The toolchain will be on the CD as
> > well.
> > 
> > Pete
> > 
> 
> -- 
> Matthew Dharm                              Work: mdharm@momenco.com
> Senior Software Designer, Momentum Computer
> 

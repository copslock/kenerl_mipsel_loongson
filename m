Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6CL4Av06240
	for linux-mips-outgoing; Thu, 12 Jul 2001 14:04:10 -0700
Received: from bug.ucw.cz (root@[194.213.32.142])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6CL46V06231
	for <linux-mips@oss.sgi.com>; Thu, 12 Jul 2001 14:04:07 -0700
Received: (from root@localhost)
	by bug.ucw.cz (8.9.3/8.8.5) id KAA00181;
	Thu, 12 Jul 2001 10:23:11 +0200
Date: Mon, 9 Jul 2001 12:02:44 +0000
From: Pavel Machek <pavel@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Pavel Machek <pavel@suse.cz>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   linux-mips@oss.sgi.com
Subject: Re: [ANNOUNCE] Secondary mips tree.
Message-ID: <20010709120243.A39@toy.ucw.cz>
References: <20010630145732.E255@toy.ucw.cz> <Pine.LNX.4.10.10107081059580.22673-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10107081059580.22673-100000@transvirtual.com>; from jsimmons@transvirtual.com on Sun, Jul 08, 2001 at 11:32:31AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

> > >  	We have started a secondary tree for linux mips. This tree will
> > > be to SGI mips tree as Alan Cox's tree is to linus branch. We will test
> > > and play with "experimental patches" and then in time hand them off to the
> > > main branch Ralf Baechle maintains. Also one of the main reasons for this
> > > branch was to unite several of the mips trees into one place. Anyones
> > > patches (if good) are welcomed. The site is 
> > 
> > Do you want to "eat" linux-vr tree? linux-vr list is dead and there's no
> > (or not much) development in its CVS (at 240t7 :-()
> 
> Yes. We are reworking the VR code and placing it into our tree. 

Good. I should definitely take a look. [Do you care about vr4130 or about
tx3912, too?]

> > > We also have a mailing list which instructions are on the SF page on how
> > > to join. Thank you. 
> > 
> > Is it ok to be used as linux-vr list?
> 
> I have no problem with it. VR is apart of the mips developement we are
> doing. Also we do alot of IT 8172 and au1000 devleopement as well. Plus
> some early work for the cobalt cube is being done. I will finish the cube 
> now that we have a pretty generic pci code layer that is shared amoung
> many boards.

Seems like there's one more mailinglist for me to read. Ook.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

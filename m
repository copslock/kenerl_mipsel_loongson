Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f68IWgr12402
	for linux-mips-outgoing; Sun, 8 Jul 2001 11:32:42 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f68IWdV12399
	for <linux-mips@oss.sgi.com>; Sun, 8 Jul 2001 11:32:39 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f68IWVbp023410;
	Sun, 8 Jul 2001 11:32:31 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f68IWV6a023406;
	Sun, 8 Jul 2001 11:32:31 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Sun, 8 Jul 2001 11:32:31 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
   linux-mips@oss.sgi.com
Subject: Re: [ANNOUNCE] Secondary mips tree.
In-Reply-To: <20010630145732.E255@toy.ucw.cz>
Message-ID: <Pine.LNX.4.10.10107081059580.22673-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> >  	We have started a secondary tree for linux mips. This tree will
> > be to SGI mips tree as Alan Cox's tree is to linus branch. We will test
> > and play with "experimental patches" and then in time hand them off to the
> > main branch Ralf Baechle maintains. Also one of the main reasons for this
> > branch was to unite several of the mips trees into one place. Anyones
> > patches (if good) are welcomed. The site is 
> 
> Do you want to "eat" linux-vr tree? linux-vr list is dead and there's no
> (or not much) development in its CVS (at 240t7 :-()

Yes. We are reworking the VR code and placing it into our tree. 

> > http://www.sf.net/projects/linux-mips
> 
> Is this sourceforge?

Yep.
 
> > We also have a mailing list which instructions are on the SF page on how
> > to join. Thank you. 
> 
> Is it ok to be used as linux-vr list?

I have no problem with it. VR is apart of the mips developement we are
doing. Also we do alot of IT 8172 and au1000 devleopement as well. Plus
some early work for the cobalt cube is being done. I will finish the cube 
now that we have a pretty generic pci code layer that is shared amoung
many boards.

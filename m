Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9GIp3v05779
	for linux-mips-outgoing; Tue, 16 Oct 2001 11:51:03 -0700
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9GIp1D05776
	for <linux-mips@oss.sgi.com>; Tue, 16 Oct 2001 11:51:01 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id LAA36984;
	Tue, 16 Oct 2001 11:50:59 -0700 (PDT)
Date: Tue, 16 Oct 2001 11:50:59 -0700
From: Geoffrey Espin <espin@idiom.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com
Subject: Re: [Linux-mips-kernel]PATCH
Message-ID: <20011016115059.A29701@idiom.com>
References: <3BC24525.8030201@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <3BC24525.8030201@mvista.com>; from Pete Popov on Mon, Oct 08, 2001 at 05:30:29PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete,

> I've attached a patch which adds zImage support for the Alchemy pb1000 board. 
> The image is burned in flash and yamon can be used to just jump to that location 
>... 
> Feedback would be appreciated, including whether or not arch/mips/zboot is the 
> most appropriate place to put the zImage support.

It ain't a pretty patch.  I do want to do this for the Korva-Markham
board... either arch/arm/boot/compressed or arch/ppc/boot scheme
would be nice to follow.  I think arch/ppc/boot/mbx/Makefile does
some of the magic offset stuff you need with quick `sh ` scripts
and also includes piggyback initrd stuff!

Geoff

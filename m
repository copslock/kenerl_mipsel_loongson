Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78G9PA21090
	for linux-mips-outgoing; Wed, 8 Aug 2001 09:09:25 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78G9OV21087
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 09:09:25 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id D2C9C125C3; Wed,  8 Aug 2001 09:09:23 -0700 (PDT)
Date: Wed, 8 Aug 2001 09:09:23 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Mark Mitchell <mark@codesourcery.com>
Cc: Eric Christopher <echristo@redhat.com>,
   "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Clean up Linux/mips.
Message-ID: <20010808090923.A28678@lucon.org>
References: <20010808084544.A28287@lucon.org> <35250000.997285978@gandalf.codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <35250000.997285978@gandalf.codesourcery.com>; from mark@codesourcery.com on Wed, Aug 08, 2001 at 08:52:58AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 08:52:58AM -0700, Mark Mitchell wrote:
> > I am trying to get gcc 3.x to work correctly on Linux/mips.
> 
> Sorry, that didn't answer my question either.
> 
> You need to explain what problem your patch solves, in detail, and how
> it solves it, so that even I, not as smart as you, can understand it.
> 

Well, the mips config is a mess and Eric suggested me to clean it up
at least for Linux/mips since I have been working on fixing the gcc
3.x for Linux/mips. I'd love to see Linux/mips be supported in gcc
3.0.1. But I am afraid I don't have the time to do more than what I
have done so far.


H.J.

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2503i104017
	for linux-mips-outgoing; Mon, 4 Mar 2002 16:03:44 -0800
Received: from ayrnetworks.com (64-166-72-137.ayrnetworks.com [64.166.72.137])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2503f904013;
	Mon, 4 Mar 2002 16:03:41 -0800
Received: (from wjhun@localhost)
	by  ayrnetworks.com (8.11.2/8.11.2) id g24N3Yl17733;
	Mon, 4 Mar 2002 15:03:34 -0800
Date: Mon, 4 Mar 2002 15:03:34 -0800
From: William Jhun <wjhun@ayrnetworks.com>
To: Jun Sun <jsun@mvista.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Compressed images?
Message-ID: <20020304150334.D1247@ayrnetworks.com>
References: <20020304120803.A1247@ayrnetworks.com> <20020304145709.A1332@oss.sgi.com> <3C83FA43.4090407@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C83FA43.4090407@mvista.com>; from jsun@mvista.com on Mon, Mar 04, 2002 at 02:50:43PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Mar 04, 2002 at 02:50:43PM -0800, Jun Sun wrote:
> 
> I think I am leaning towards leaving compressed image outside kernel itself.
> 
> I don't see any technical reason why it must be inside kernel.
> 
> Then it must be the code sharing argument.  However, it seem MIPS boards are 
> so much more diversified than x86 machines.  Any sharing, if there are any, is 
> limited.  Also there are other way of sharing code than stacking it into 
> kernle tree, I suppose.
> 
> Another aimless general rant .... :-)
> 
> Jun

But this is a good point. Our own compressed/ build requires building
several elf-header-mangling tools just to get our bootstrap (which we
can't change) to even recognize the finished image.

Though, I'm not sure how much the different decompression (misc.c)
routines vary; could there be some way to do this in a
platform-independent way?

Hmm!
Will

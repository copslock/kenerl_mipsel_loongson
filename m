Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8I6mLG23236
	for linux-mips-outgoing; Mon, 17 Sep 2001 23:48:21 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8I6mIe23233
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 23:48:18 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f8I6mFO06547;
	Tue, 18 Sep 2001 02:48:15 -0400
Date: Tue, 18 Sep 2001 02:48:15 -0400
From: Jim Paris <jim@jtan.com>
To: Pete Popov <ppopov@pacbell.net>
Cc: linux-mips@oss.sgi.com
Subject: Re: pcmcia (again)
Message-ID: <20010918024814.A6517@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20010917001922.A28670@neurosis.mit.edu> <3BA588AD.3070402@pacbell.net> <20010917123106.A396@neurosis.mit.edu> <3BA6C6FA.7070309@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA6C6FA.7070309@pacbell.net>; from ppopov@pacbell.net on Mon, Sep 17, 2001 at 09:00:58PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > Am I misunderstanding something here?  Is there some simple way to get
> > the PCMCIA driver to use isa_slot_offset when checking and
> > requesting memory regions?  I tried adding that offset to the
> > check_mem_resource, request_mem_region, and release_mem_region calls,
> > and changing all of the readx/writex() calls to isa_readx/isa_writex(),
> > but things still don't work right.

.. 

Success!!

The main problem was that I had subtly broken the ioremap function
while trying to update the linux-vr tree to 2.4.5ish.  Doh!

A second problem is that the pcmcia drivers needed to add
isa_slot_offset when calling {check,request,release}_mem_region
-- but the readx/writex calls do _not_ need this offset added.
(So this must be handled by the ioremap.  I still don't fully
understand when or where this remapping is done, but I know it's
happening.)

And it works!

This means that I now have a working 2.4.5 kernel on my Mobilon Tripad
(aka Vadem Clio) with a functional compact flash and wireless ethernet
card.  I'm quite happy.  Now I just need to build some binaries.

Pete, thanks for your help; it pointed me in the right direction.

-jim

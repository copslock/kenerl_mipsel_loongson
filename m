Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f42KsKP31465
	for linux-mips-outgoing; Wed, 2 May 2001 13:54:20 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f42KsKF31461
	for <linux-mips@oss.sgi.com>; Wed, 2 May 2001 13:54:20 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f42KrV032684;
	Wed, 2 May 2001 13:53:31 -0700
Message-ID: <3AF0724B.D74D9AF9@mvista.com>
Date: Wed, 02 May 2001 13:47:07 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: nick@snowman.net
CC: Matthew Dharm <mdharm@momenco.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Endianness...
References: <Pine.LNX.4.21.0105021603030.22170-100000@ns>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

nick@snowman.net wrote:
> 
> To the best of my knowledge Big endian is generally the way to run.
>         Nick
> 

BE is better known perhaps because all SGI workstations are BE.  Generally I
found networking systems tend to use BE while consumer electronic devices tend
to use LE (which means there are probably more MIPS CPUs running in LE.)

So far I have not found much difference in terms of endianess, although
occassionaly you have to IO swap in drivers for BE machine.

Jun

> On Wed, 2 May 2001, Matthew Dharm wrote:
> 
> > What's the preferred endianness for Linux-MIPS?  I can't really go
> > into why I'm asking (sensitive NDA information), but I'm basically
> > faced with a group that wants to work in LE.  However, my
> > understanding was that Linux-MIPS generally ran BE.
> >
> > Or can it be built either way?  I know OpenBSD runs LE.... not like
> > that means anything to this group, tho.
> >
> > Matt Dharm
> >
> > --
> > Matthew D. Dharm                            Senior Software Designer
> > Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
> > (760) 431-8663 X-115                        Carlsbad, CA 92008-7310
> > Momentum Works For You                      www.momenco.com
> >

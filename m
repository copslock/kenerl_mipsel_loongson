Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f499WY218675
	for linux-mips-outgoing; Wed, 9 May 2001 02:32:34 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f499WSF18671;
	Wed, 9 May 2001 02:32:28 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 7515A7D9; Wed,  9 May 2001 11:32:26 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id EF422F38D; Wed,  9 May 2001 10:46:35 +0200 (CEST)
Date: Wed, 9 May 2001 10:46:35 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Tom Appermont <tea@sonycom.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010509104635.D12267@paradigm.rfc822.org>
References: <20010505144708.A12575@paradigm.rfc822.org> <20010507163210.B2381@bacchus.dhis.org> <20010508202518.A13476@paradigm.rfc822.org> <20010508214313.A12528@bacchus.dhis.org> <20010509095955.A8392@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010509095955.A8392@sonycom.com>; from tea@sonycom.com on Wed, May 09, 2001 at 09:59:55AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 09, 2001 at 09:59:55AM +0200, Tom Appermont wrote:
> On Tue, May 08, 2001 at 09:43:13PM -0300, Ralf Baechle wrote:
> > On Tue, May 08, 2001 at 08:25:18PM +0200, Florian Lohoff wrote:
> > 
> > > > > compatibility. I read the whole thread on linux-mips but i didnt get the point
> > > > > why this has to happen - If we are repairing a real bug for it.
> > > > > 
> > > > > Could someone please elaborate on whats going on as i feel i missed ~200 mails
> > > > > discussion and i dont want to purge the whole debian archive until i know
> > > > > what for we actually drop the compatibility.
> > > > 
> > > > We don't.
> > > 
> > > Could you explain a bit more - I'd like to understand the whole issue.
> > 
> > The whole point was to switch from our IRIX ELF flavoured binaries to
> > standard ABI ELF.  These two variants are close but not identical which
> > for example made modutils missbehave.
> 
> What is the current status on this? The patches for the tools are already
> integrated in their cvs trees (right?). But I don't think everybody was
> happy with this in the end, aspecially the people wearing debian hats. 
> Is anybody working on a solution, or are we waiting for the debian people 
> to rebuild all the packages?

As the binary compatibility is not going to break we dont need to rebuild.
I wasnt really happy with the answer of ralf as it brought me nothing
nearer in the understanding of the whole issue. But asking 3 times
to get a fully explanation on where the problem is, what breaks, 
and how to fix is enough.

I'll lean back, continue building .debs and wait for others to fix it.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

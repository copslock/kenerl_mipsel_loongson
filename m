Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4F1FvM28933
	for linux-mips-outgoing; Mon, 14 May 2001 18:15:57 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4F1FpF28928
	for <linux-mips@oss.sgi.com>; Mon, 14 May 2001 18:15:53 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4F15Zx14778;
	Mon, 14 May 2001 22:05:35 -0300
Date: Mon, 14 May 2001 22:05:35 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Momentum Computer Ocelot: Making the latest CVS tree build
Message-ID: <20010514220535.D9945@bacchus.dhis.org>
References: <NEBBLJGMNKKEEMNLHGAIGEGOCBAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIGEGOCBAA.mdharm@momenco.com>; from mdharm@momenco.com on Mon, May 14, 2001 at 04:35:43PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 14, 2001 at 04:35:43PM -0700, Matthew Dharm wrote:

> Attached is a patch against the latest CVS tree (as of about 3 hours
> ago).  It makes the Momentum Computer Ocelot board build again --
> apparently, some of the PCI code has been changed.

Except your patch doesn't even touch the PCI but interrupt code.

> It seems likely to me that this is not the best way to do this
> patch... if it's unacceptable to the powers that be (Ralf?), could
> someone point out to me the new convention for board-specific PCI
> initialization?

Applied, but without the two extra junk segment in the patch.

  Ralf

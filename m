Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1L2plS05167
	for linux-mips-outgoing; Wed, 20 Feb 2002 18:51:47 -0800
Received: from dea.linux-mips.net (a1as20-p220.stg.tli.de [195.252.194.220])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1L2pg905164
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 18:51:42 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1L1pLm29629;
	Thu, 21 Feb 2002 02:51:21 +0100
Date: Thu, 21 Feb 2002 02:51:21 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: Adding code to the tree...
Message-ID: <20020221025121.A29466@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAICEKCCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAICEKCCFAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, Feb 20, 2002 at 05:38:59PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 20, 2002 at 05:38:59PM -0800, Matthew Dharm wrote:

> So, I'm porting Linux to our latest board... and I've got this pile of
> new code, and I'm itching to check it in somewhere.  It's not perfect
> yet, but the board definately starts to come up, and the Symbios
> 53c875 driver can probe and identify devices on the SCSI bus.... so
> I'm thinking that I'm doing pretty well here.
> 
> So, if I send this code as is, will it be accepted into the tree?  Or
> do I have to wait until it's completely finished before I send it?  I
> can see arguments either way, so I'm guessing it really comes down to
> Ralf's personal preferences...

I also take patches for partial support if I have confidence that the
support will be completed not too far after.

> P.S. Is there any way to get permission to make CVS commits, or should
> everything be done via Ralf?  I've got another 2 designs behind this
> one which will all get Linux ported to them...

The intent is to move CVS to another machine in the near future.  By
then I'll be able to generate accounts as I want but at this time it's
a pain to go through the SGI burocracy so I'm trying to avoid it.

  Ralf

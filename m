Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g17B8Wi20092
	for linux-mips-outgoing; Thu, 7 Feb 2002 03:08:32 -0800
Received: from dea.linux-mips.net (a1as20-p188.stg.tli.de [195.252.194.188])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g17B8SA20089
	for <linux-mips@oss.sgi.com>; Thu, 7 Feb 2002 03:08:28 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g17B6Ms18043;
	Thu, 7 Feb 2002 12:06:22 +0100
Date: Thu, 7 Feb 2002 12:06:22 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: PATCH: Momentum Ocelot (CP7000) fixes
Message-ID: <20020207120622.A18012@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIAEFJCFAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIAEFJCFAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, Feb 06, 2002 at 05:21:55PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Feb 06, 2002 at 05:21:55PM -0800, Matthew Dharm wrote:

> Attached to this message is a patch to make the Momentum Computer
> Ocelot (CP7000) SBC port of Linux work.  I made this patch against a
> recent (2 days ago) CVS snapshot.  Please apply it to the CVS
> repository.
> 
> It turns out that the existing code only worked for boards with 512MiB
> of SDRAM.  This patch makes all memory configurations work.  While
> discontiguous memory configurations seemed to work, there was some
> "unusual" behavior.  This patch uses a contiguous memory approach,
> which seems much more stable.

Applied,

  Ralf

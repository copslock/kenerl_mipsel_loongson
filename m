Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2010 22:39:31 +0100 (CET)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:50230 "EHLO
        chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491790Ab0AVVj1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2010 22:39:27 +0100
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
        id 9076E83148; Fri, 22 Jan 2010 21:39:26 +0000 (GMT)
Date:   Fri, 22 Jan 2010 21:39:26 +0000
From:   Alexander Clouter <alex@digriz.org.uk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCHv2] MIPS: fix vmlinuz build for 32bit-only math shells
Message-ID: <20100122213926.GL32413@chipmunk>
References: <vs6k27-7b2.ln1@chipmunk.wormnet.eu> <20100122145256.GA5570@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100122145256.GA5570@linux-mips.org>
Organization: diGriz
X-URL:  http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15022

Hi,

* Ralf Baechle <ralf@linux-mips.org> [2010-01-22 15:52:56+0100]:
>
> On Wed, Jan 20, 2010 at 08:50:07PM +0000, Alexander Clouter wrote:
> 
> > Counter to the documentation for the dash shell, it seems that on my
> > x86_64 filth under Debian only does 32bit math.  As I have configured my
> 
> POSIX apparently specifies at least "long" type arithmetic for shells, so
> if your dash indeed is a 64-bit binary it's in violation of POSIX.
>
/me points to the 'Counter to the documentation for the dash shell...' 
	he put in his description...

> What does
> 
>   file $(which $SHELL)
> 
> say?
> 
Well, 'bash' (x86-64) as thats my *interactive* shell, I use dash for 
the non-interactive stuff.

> The dash binary on my Fedora 12 i386 seems to perform 64-bit arithmetic.
> 
...does it really matter, we still are leaving all the 32bit users out 
there in the lurch?

When I get around to looking at the problem further I'll report it to 
the Debian folk...meanwhile, builds on 32bit math only shells is broken 
for vmlinuz regardless of my borkened shell :)

Cheers

-- 
Alexander Clouter
.sigmonster says:   We are not anticipating any emergencies.

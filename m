Received:  by oss.sgi.com id <S553824AbQJYRoc>;
	Wed, 25 Oct 2000 10:44:32 -0700
Received: from gandalf1.physik.uni-konstanz.de ([134.34.144.69]:22024 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553818AbQJYRoR>; Wed, 25 Oct 2000 10:44:17 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13oUaa-0000Kc-00; Wed, 25 Oct 2000 19:43:48 +0200
Date:   Wed, 25 Oct 2000 19:43:48 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
Cc:     linux-mips@oss.sgi.com
Subject: Re: fdisk/kernel oddity
Message-ID: <20001025194348.A1164@gandalf.physik.uni-konstanz.de>
References: <20001025190129.A28426@bilbo.physik.uni-konstanz.de> <20001025101453.A11789@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001025101453.A11789@chem.unr.edu>; from wesolows@chem.unr.edu on Wed, Oct 25, 2000 at 10:14:53AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 25, 2000 at 10:14:53AM -0700, Keith M Wesolowski wrote:
> On Wed, Oct 25, 2000 at 07:01:29PM +0200, Guido Guenther wrote:
> Not to sound defensive, but I'm fairly sure this isn't an
> fdisk-related problem. The partitions that fdisk creates follow the
> spec as far as I can see.
I didn't want to blame fdisk for that(how could I, I want you to send
the patches upstream ASAP :)
> 
> > What puzzles me even more is that I get illegal instructions for almost 
> > all commands I execute afterwards. Any comments on this one?
> 
> I rather suspect that this is the same problem that causes the request
> for the out-of-bounds block in the first place: kernel memory
> corruption. Unfortunately I have few ideas as to what the specific
> problem is. I would start bug-hunting in the sgi disklabel kernel
> parts. Make sure that it's compatible with what fdisk is doing.
That's a starting point - thanks. Ian pointed out that it might be
related to the fact that I use two harddisks which is interesting since
I see the problems only when writing on sda, sdb seems to be o.k.
Regards,
 -- Guido

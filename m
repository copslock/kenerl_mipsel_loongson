Received:  by oss.sgi.com id <S42207AbQGBXMl>;
	Sun, 2 Jul 2000 16:12:41 -0700
Received: from u-102.karlsruhe.ipdial.viaginterkom.de ([62.180.10.102]:15876
        "EHLO u-102.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42202AbQGBXM2>; Sun, 2 Jul 2000 16:12:28 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1405658AbQGBXM1>;
        Mon, 3 Jul 2000 01:12:27 +0200
Date:   Mon, 3 Jul 2000 01:12:27 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Marc Esipovich <marc@mucom.co.il>
Cc:     linux-mips@oss.sgi.com
Subject: Re: NetBSD on O2 ;)
Message-ID: <20000703011227.A1849@bacchus.dhis.org>
References: <20000630145251.A9590@darkstar.netvision>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000630145251.A9590@darkstar.netvision>; from marc@mucom.co.il on Fri, Jun 30, 2000 at 02:52:51PM -0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jun 30, 2000 at 02:52:51PM -0200, Marc Esipovich wrote:

>  I just noticed this on Slashdot:
> 
> NetBSD have added another platform to their supported hardware
> list. As the NetBSD/sgimips and announcement pages say,
> NetBSD/sgimips is now stable enough to run multi-user, making
> NetBSD the first OpenSource OS to run on the SGI O2. Currently it's
> known to work on the R5000 CPU, R10K and R12K are untested due to
> lack of hardware. 
> 
> http://www.netbsd.org/Ports/sgimips/
> 
>  From my understanding R1[02]K do have their issues with cache coherency,
> this is a big step forward, it wouldn't be long before we see NetBSD and
> probably soon-to-follow Linux on O2 with all CPU configurations.

Cache coherency is the trivial part; it's already been solved for other
MIPS ports.  The big problem is the interaction of speculative stores
with cache coherency.  It's not a CPU bug but more the R10000 being used
in an environment it was not intended to be used in.  The workaround is
rather complex and requires compiler modifications.  The R12000 is
better on this, it has the option to disable speculative stores which
makes a port of an OS easy.

  Ralf

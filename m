Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 18:23:29 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39349 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022919AbZERRX0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2009 18:23:26 +0100
Date:	Mon, 18 May 2009 18:23:26 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	jfraser@broadcom.com, Andrew Wiley <debio264@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Bigsur?
In-Reply-To: <4A118D72.8050202@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0905181753160.20791@ftp.linux-mips.org>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com> <1242663215.18301.26.camel@chaos.ne.broadcom.com> <4A118D72.8050202@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 May 2009, David Daney wrote:

> > Are people just looking for eval type boards with MIPS cpus?
> > 
> 
> I think the answer to that is: Yes.
> 
> There are not really any commercially available MIPS based devices that can be
> used as a general purpose server/workstation.  Some people are working on old
> SGI Octanes, but there is really nothing available for currently produced
> processors.

 I think it would be more precise to say that people are looking for 
decently-performing MIPS-based systems suitable for development.  Such 
that they do not start, say, a full three-stage GCC bootstrap and then 
they cannot let it finish because they have to relocate (e.g., my estimate 
is the task would take about a month on the fastest DECstation, assuming 
its maximum of 480MB of RAM installed).  And ones which can have local 
storage.  The BigSur (and some other Broadcom boards, like the SWARM) 
certainly fits here very well.  But people do not necessarily need all the 
fancy bits a development board usually has for use with special equipment, 
like a JTAG port, logic analyser pods, test points, etc.

  Maciej

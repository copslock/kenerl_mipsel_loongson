Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 23:47:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:58029 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024444AbZERWrt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2009 23:47:49 +0100
Date:	Mon, 18 May 2009 23:47:49 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Jon Fraser <jfraser@broadcom.com>,
	Andrew Wiley <debio264@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Bigsur?
In-Reply-To: <20090518222334.GD16847@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0905182335510.20791@ftp.linux-mips.org>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com> <1242663215.18301.26.camel@chaos.ne.broadcom.com> <20090518222334.GD16847@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 May 2009, Ralf Baechle wrote:

> A clear yes.  In particular the Swarm and Big Sur boards which aside of
> graphics are as close to an workstation or server board, are highly
> sought after as indicated by usually high 2nd hand prices on ebay.

 Even *including* graphics AFAIK -- there is apparently support for VGA 
console I/O for some chips in CFE.  Of course for that you have to get a 
universal classic PCI card, but that's not undoable and then you can 
attach a keyboard and a mouse to the onboard USB ports without taking a 
PCI slot even.  So yes, a full-featured graphics workstation if you like.

> Even though far from new these boards are the backbone of the native
> compile farms of several Linux distributions including Debian and the
> native testing by various commercial and non-commercial software
> developers including myself.  Aside of mostly SGI surplus workstations
> the Sibyte boards are clearly the most popular among those who somehow
> managed to get hold of them.

 Yes, invaluable for native builds and there is a considerable number of 
software packages which is not capable of being cross-compiled, or 
requires extreme contortions to be built this way, or if buildable with a 
reasonable effort, the functionality is limited.  Besides a three-stage 
GCC bootstrap is a good way of verifying the quality of the tool, never 
mind standard DejaGNU-based regression testing which although possible 
using cross-tools and a remote target, is awfully painful to be set up 
this way.

  Maciej

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Oct 2008 18:51:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53734 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S22437427AbYJZSvD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Oct 2008 18:51:03 +0000
Date:	Sun, 26 Oct 2008 18:51:03 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Chad Reese <kreese@caviumnetworks.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, ddaney@caviumnetworks.com,
	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 35/37] Set c0 status for ST0_KX on Cavium OCTEON.
In-Reply-To: <49051A78.8080601@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0810261840031.8719@ftp.linux-mips.org>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-36-git-send-email-ddaney@caviumnetworks.com> <20081026124821.GN25297@linux-mips.org> <49051A78.8080601@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 26 Oct 2008, Chad Reese wrote:

> The Octeon IO space regions are significantly larger than a 32bit kernel
> could tlb map easily. The entire range takes 49 bits to address. As a

 Do you need them all at once?  If not, you may be able to get away with 
ioremap() called on demand.

> not particularly clean, but working alternative, we enable 64bit
> addressing in the kernel and used XKPHYS to access IO. Every access was
> surrounded by a local_irq_save/local_irq_restore. Since this is ugly to
> the extreme, maybe we should drop being able to boot a 32bit kernel on
> Octeon until something better is worked out.

 Good idea anyway I would say.  With 64-bit processors support for a 
32-bit kernel may be a nice feature, but really only if it works straight 
away with no strange hacks.  Otherwise a 64-bit kernel is the obvious 
choice providing a superset of the functionality, including but not 
limited to support for the same plain 32-bit (o32) userland if need be.  
And with the GCC/GAS changes to support -msym32 that happened a while ago 
the overhead from using a 64-bit kernel has become quite negligible.

  Maciej

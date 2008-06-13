Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 19:24:29 +0100 (BST)
Received: from isilmar.linta.de ([213.133.102.198]:26068 "EHLO linta.de")
	by ftp.linux-mips.org with ESMTP id S20036153AbYFMSY1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2008 19:24:27 +0100
Received: (qmail 2924 invoked by uid 1000); 13 Jun 2008 18:24:20 -0000
Date:	Fri, 13 Jun 2008 20:24:20 +0200
From:	Dominik Brodowski <linux@dominikbrodowski.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-pcmcia@lists.infradead.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/9] pcmcia: fix Alchemy warnings
Message-ID: <20080613182420.GB2649@isilmar.linta.de>
Mail-Followup-To: Ralf Baechle <ralf@linux-mips.org>,
	linux-pcmcia@lists.infradead.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
References: <20080530212821.GA30197@comet.dominikbrodowski.net> <1212183079-30505-6-git-send-email-linux@dominikbrodowski.net> <20080613140258.GE16344@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080613140258.GE16344@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <linux@dominikbrodowski.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@dominikbrodowski.net
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, Jun 13, 2008 at 03:02:58PM +0100, Ralf Baechle wrote:
> On Fri, May 30, 2008 at 11:31:16PM +0200, Dominik Brodowski wrote:
> 
> > Subject: [PATCH 6/9] pcmcia: fix Alchemy warnings
> > 
> > From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > 
> > Fix the following warnings:
> > 
> > drivers/pcmcia/au1000_generic.c: In function `au1x00_pcmcia_socket_probe':
> > drivers/pcmcia/au1000_generic.c:405: warning: integer constant is too large for
> > "long" type
> > drivers/pcmcia/au1000_generic.c:413: warning: integer constant is too large for
> > "long" type
> > 
> > by properly postfixing the socket constants. While at it, fix the lines over 80
> > characters long in the vicinity...
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > CC: linux-mips@linux-mips.org
> 
> Any reason why this patch still isn't merged?  It looks right and seems to
> do what it promised,

It's in the queue for what is to be merged for 2.6.27-rc1.

Best,
	Dominik

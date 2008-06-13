Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 15:03:25 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:38856 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20035270AbYFMODW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 15:03:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5DE30gY022613;
	Fri, 13 Jun 2008 15:03:00 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5DE2wm9022591;
	Fri, 13 Jun 2008 15:02:58 +0100
Date:	Fri, 13 Jun 2008 15:02:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominik Brodowski <linux@dominikbrodowski.net>
Cc:	linux-pcmcia@lists.infradead.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/9] pcmcia: fix Alchemy warnings
Message-ID: <20080613140258.GE16344@linux-mips.org>
References: <20080530212821.GA30197@comet.dominikbrodowski.net> <1212183079-30505-6-git-send-email-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1212183079-30505-6-git-send-email-linux@dominikbrodowski.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 30, 2008 at 11:31:16PM +0200, Dominik Brodowski wrote:

> Subject: [PATCH 6/9] pcmcia: fix Alchemy warnings
> 
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> Fix the following warnings:
> 
> drivers/pcmcia/au1000_generic.c: In function `au1x00_pcmcia_socket_probe':
> drivers/pcmcia/au1000_generic.c:405: warning: integer constant is too large for
> "long" type
> drivers/pcmcia/au1000_generic.c:413: warning: integer constant is too large for
> "long" type
> 
> by properly postfixing the socket constants. While at it, fix the lines over 80
> characters long in the vicinity...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> CC: linux-mips@linux-mips.org

Any reason why this patch still isn't merged?  It looks right and seems to
do what it promised,

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

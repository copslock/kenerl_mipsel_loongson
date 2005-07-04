Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2005 13:58:31 +0100 (BST)
Received: (from localhost user: 'ralf' uid#501 fake: STDIN
	(ralf@zet-pt.tunnel.tserv1.fmt.ipv6.he.net)) by linux-mips.org
	id <S8226154AbVGDM6Q>; Mon, 4 Jul 2005 13:58:16 +0100
Date:	Mon, 4 Jul 2005 13:58:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Arianna Arona <arianna@dsi.unimi.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: IOC3 not working on SGI O2K
Message-ID: <20050704125816.GD3329@linux-mips.org>
References: <200507041444.00289.arianna@dsi.unimi.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507041444.00289.arianna@dsi.unimi.it>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Arianna,

On Mon, Jul 04, 2005 at 02:44:00PM +0200, Arianna Arona wrote:

> Here are boot logs:
> [.....]
> [33] 0:1 0; <6> eth%d: link down 0000000004e00791
> [.....]
> [63] 0:1 0; 725e700004e00791
> Found DS1981U NIC registration number 07:e0:04:70:5e, CRC 72.
> Ethernet address is 08:00:69:0d:16:00
> eth0: link down
> eth0: using PHY 0, vendor 0x2000, model 0, rev 3.

You need to update the kernel or at least to apply this fix:
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-cvs-patches&i=e3d7626b64e5384ac570b0d42c3ecf3f%40NO-ID-FOUND.mhonarc.org

  Ralf

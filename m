Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 May 2003 15:31:26 +0100 (BST)
Received: from p508B64F1.dip.t-dialin.net ([IPv6:::ffff:80.139.100.241]:9858
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbTEDObX>; Sun, 4 May 2003 15:31:23 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h44EVJY09750;
	Sun, 4 May 2003 16:31:19 +0200
Date: Sun, 4 May 2003 16:31:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Guo Michael <michael_e_guo@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: linux_2_4 on RM7000
Message-ID: <20030504163119.A9719@linux-mips.org>
References: <BAY8-F66OgRGkQ6mByS0000fd73@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BAY8-F66OgRGkQ6mByS0000fd73@hotmail.com>; from michael_e_guo@hotmail.com on Sun, May 04, 2003 at 10:01:16PM +0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 04, 2003 at 10:01:16PM +0800, Guo Michael wrote:

> I've found the problem, I should define CONFIG_BOARD_SCACHE and 
> CONFIG_RM7000_CPU_SCACHE first, right? But it still said scache_way_size is 
> undefined in sc-rm7k.c and the printk on line 143 in rm7k_sc_probe need a 
> little fix. After I fixed these it works.

Oh - seems like I fixed that little problem without noticing in this
source tree.  Actually I tried to fix some R10000 silliness :-)

  Ralf

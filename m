Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 23:26:48 +0000 (GMT)
Received: from mail21.bluewin.ch ([195.186.18.66]:23458 "EHLO
	mail21.bluewin.ch") by ftp.linux-mips.org with ESMTP
	id S8135891AbVKHX0a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Nov 2005 23:26:30 +0000
Received: from localhost.localdomain (83.79.73.183) by mail21.bluewin.ch (Bluewin 7.2.068.1)
        id 435F9851002C7BDE; Tue, 8 Nov 2005 23:27:43 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 9C3CAFE93; Tue,  8 Nov 2005 18:27:36 -0500 (EST)
Date:	Tue, 8 Nov 2005 18:27:36 -0500
To:	Alexey Dobriyan <adobriyan@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Domen Puncer <domen@coderock.org>, linux-mips@linux-mips.org,
	Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Remove arch/mips/pmc-sierra/yosemite/ht-irq.c
Message-ID: <20051108232736.GA20359@krypton>
References: <20051108180413.GG7631@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108180413.GG7631@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.9i
From:	a.othieno@bluewin.ch (Arthur Othieno)
Return-Path: <a.othieno@bluewin.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.othieno@bluewin.ch
Precedence: bulk
X-list: linux-mips

On Tue, Nov 08, 2005 at 09:04:13PM +0300, Alexey Dobriyan wrote:
> From: Domen Puncer <domen@coderock.org>
> 
> Remove nowhere referenced file ("grep ht-irq -r ." didn't find anything).

And arch/mips/pmc-sierra/yosemite/ht.c, apparently..

> Signed-off-by: Domen Puncer <domen@coderock.org>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Index: linux-kj/arch/mips/pmc-sierra/yosemite/ht-irq.c
> ===================================================================
> --- linux-kj.orig/arch/mips/pmc-sierra/yosemite/ht-irq.c	2005-11-08 20:46:25.000000000 +0300
> +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> @@ -1,52 +0,0 @@
> -/*
> - * Copyright 2003 PMC-Sierra
> - * Author: Manish Lachwani (lachwani@pmc-sierra.com)
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
> - *
> - *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> - *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> - *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> - *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> - *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> - *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> - *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> - *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> - *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> - *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - *  You should have received a copy of the  GNU General Public License along
> - *  with this program; if not, write  to the Free Software Foundation, Inc.,
> - *  675 Mass Ave, Cambridge, MA 02139, USA.
> - */
> -
> -#include <linux/types.h>
> -#include <linux/pci.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <asm/pci.h>
> -
> -/*
> - * HT Bus fixup for the Titan
> - * XXX IRQ values need to change based on the board layout
> - */
> -void __init titan_ht_pcibios_fixup_bus(struct pci_bus *bus)
> -{
> -        struct pci_bus *current_bus = bus;
> -        struct pci_dev *devices;
> -        struct list_head *devices_link;
> -
> -	list_for_each(devices_link, &(current_bus->devices)) {
> -                devices = pci_dev_b(devices_link);
> -                if (devices == NULL)
> -                        continue;
> -	}
> -
> -	/*
> -	 * PLX and SPKT related changes go here
> -	 */
> -
> -}

arch/mips/pmc-sierra/yosemite/ht.c:418:        titan_ht_pcibios_fixup_bus(c);

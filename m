Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 20:18:00 +0100 (BST)
Received: from p508B6C80.dip.t-dialin.net ([IPv6:::ffff:80.139.108.128]:34342
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225201AbUJNTR4>; Thu, 14 Oct 2004 20:17:56 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9EJHtZf008382;
	Thu, 14 Oct 2004 21:17:55 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9EJHsBv008381;
	Thu, 14 Oct 2004 21:17:54 +0200
Date: Thu, 14 Oct 2004 21:17:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
Message-ID: <20041014191754.GB30516@linux-mips.org>
References: <416DE31E.90509@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416DE31E.90509@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 13, 2004 at 07:23:26PM -0700, Manish Lachwani wrote:

> This small patch is required to get PCI working on the Broadcom SWARM 
> board in 2.6. Without this patch, the PCI bus scan is skipped due to 
> resource conflict. Tested using the E100 network card

> -       ioport_resource.end = 0x0000ffff;       /* 32MB reserved by 
> sb1250 */
> +       ioport_resource.end = 0xffffffff;       /* 32MB reserved by 
> sb1250 */

I'm too lazy to dig up the actual numbers from the BCM1250 manuals but
it definately does not have 4GB of port address space.

  Ralf

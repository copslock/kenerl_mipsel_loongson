Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2006 18:33:11 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53180 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S3489795AbWGFRdD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2006 18:33:03 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k66HWrex005057;
	Thu, 6 Jul 2006 18:32:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k66HWaHi005056;
	Thu, 6 Jul 2006 18:32:36 +0100
Date:	Thu, 6 Jul 2006 18:32:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] sparsemem fix
Message-ID: <20060706173235.GA4739@linux-mips.org>
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp> <44AB79D0.90002@innova-card.com> <20060705.192054.128618288.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705.192054.128618288.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 05, 2006 at 07:20:54PM +0900, Atsushi Nemoto wrote:

> > For now it seems to be implemented only in sgi-ip27 machine. Maybe we should
> > make things clear by adding:
> > 
> > #ifdef CONFIG_SGI_IP27
> > #define pfn_valid	[...]
> > #else

The fact that the code is only used on IP27 doesn't mean it is IP27-specific.

> > #error discontigmem model is only supported by sgi-ip27 platforms.
> > #error Please try to implement a generic solution if you plan to
> > #error use this memory model. Good luck ;)
> > #endif /* CONFIG_SGI_IP27 */
> 
> Though the pfn_valid() is only used by ip27 for now, I suppose it
> could be used other NUMA systems (not sure).

Yes, and there will be one or two more NUMA systems.

  Ralf

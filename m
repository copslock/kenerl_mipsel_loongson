Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 16:03:18 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:58887 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133507AbWAXQC7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 16:02:59 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A5A2464D3D; Tue, 24 Jan 2006 16:07:14 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 8B2FB854B; Tue, 24 Jan 2006 16:06:30 +0000 (GMT)
Date:	Tue, 24 Jan 2006 16:06:30 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, t.sailer@alumni.ethz.ch, perex@suse.cz
Subject: Re: Ensoniq ES1371 problem on Cobalt MIPS
Message-ID: <20060124160630.GF2924@deprecation.cyrius.com>
References: <20060124030725.GA14063@deprecation.cyrius.com> <20060124.132832.37533152.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124.132832.37533152.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Atsushi Nemoto <anemo@mba.ocn.ne.jp> [2006-01-24 13:28]:
> ALSA uses virt_to_page() but this is not work for buffers returned by
> pci_alloc_consistent() on MIPS with CONFIG_DMA_NONCOHERENT.  We can
> make virt_to_page() bulletproof but it might have some performance
> impact.  It seems API something like dma_to_page() should be
> introduced.

Can you start a discusion about this on lkml?  I'd assume some other
platforms have similar problems.

> Anyway, here is my ugly patch against 2.6.15.  It would fix some
> problems with ALSA on noncoherent MIPS platform.

This patch didn't really improve anything.
-- 
Martin Michlmayr
http://www.cyrius.com/

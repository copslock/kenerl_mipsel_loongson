Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2008 11:39:07 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:22444
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20025455AbYH0KjF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2008 11:39:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7RAd0Qq019975;
	Wed, 27 Aug 2008 11:39:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7RAcwRp019970;
	Wed, 27 Aug 2008 11:38:58 +0100
Date:	Wed, 27 Aug 2008 11:38:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Takashi Iwai <tiwai@suse.de>
Cc:	Grant Grundler <grundler@parisc-linux.org>,
	Joel Soete <soete.joel@scarlet.be>,
	"James.Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-parisc <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] mips: Add dma_mmap_coherent()
Message-ID: <20080827103858.GA26940@linux-mips.org>
References: <K6047O$07C3A675C0E02FC7BE973C0D5DEF9AAA@scarlet.be> <s5hy72pmefh.wl%tiwai@suse.de> <48B0678E.9010208@scarlet.be> <s5hej4blrx7.wl%tiwai@suse.de> <20080826210118.GA26235@colo.lackof.org> <s5h4p57hv4h.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h4p57hv4h.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 27, 2008 at 07:42:06AM +0200, Takashi Iwai wrote:

> Right now it has to be a compile-time option because
> - dma_mmap_coherent() isn't implemented in every architecture (thus
>   fails to build), and 
> - pages allocated via dma_mmap_coherent() aren't always suitable for
>   SG-mapping.

I suggest you take this issue to linux-arch or linux-kernel.  There will
be some more people who will have input on this.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 09:43:14 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:58549
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28581349AbYGPInM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 09:43:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6G8hAc7023108;
	Wed, 16 Jul 2008 09:43:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6G8hAab023107;
	Wed, 16 Jul 2008 09:43:10 +0100
Date:	Wed, 16 Jul 2008 09:43:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3 part 2] [MIPS] make the pcibios_max_latency
	variable static
Message-ID: <20080716084310.GA22957@linux-mips.org>
References: <1216141052-28005-2-git-send-email-dmitri.vorobiev@movial.fi> <1216195309-13069-1-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1216195309-13069-1-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2008 at 11:01:49AM +0300, Dmitri Vorobiev wrote:

> Along with making the pcibios_max_latency variable static,
> its declaration needs to be removed from the header file.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
> ---
> 
> Hi Ralf,
> 
> Forgot about this one yesterday, sorry.

No big deal, lmo's internet connection was down for part of the afternoon
so I wasn't doing as much patch stuff as I was hoping to ...

I folded part 2 into part 1 of your patch and applied the result.

Thanks,

  Ralf

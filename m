Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2009 02:20:35 +0000 (GMT)
Received: from fwtops.0.225.230.202.in-addr.arpa ([202.230.225.126]:3334 "EHLO
	topsms.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S21368719AbZCQCU1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Mar 2009 02:20:27 +0000
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 732FA42B62;
	Tue, 17 Mar 2009 11:13:50 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 6665F42A59;
	Tue, 17 Mar 2009 11:13:50 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id n2H2KJnf026653;
	Tue, 17 Mar 2009 11:20:19 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 17 Mar 2009 11:20:19 +0900 (JST)
Message-Id: <20090317.112019.147212126.nemoto@toshiba-tops.co.jp>
To:	dan.j.williams@intel.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1237240246.27945.6.camel@dwillia2-linux.ch.intel.com>
References: <20090313.011950.61509382.anemo@mba.ocn.ne.jp>
	<20090313.231659.41197617.anemo@mba.ocn.ne.jp>
	<1237240246.27945.6.camel@dwillia2-linux.ch.intel.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 16 Mar 2009 14:50:46 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
> > And above "continue" looks buggy anyway.  Keeping incomplete channels
> > in device->channels list looks very dangerous...
> 
> Yes it does.  Here is the proposed fix:
> ----->
> dmaengine: fail device registration if channel registration fails
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Atsushi points out:
> "If alloc_percpu or kzalloc failed, chan_id does not match with its
> position in device->channels list.
> 
> And above "continue" looks buggy anyway.  Keeping incomplete channels
> in device->channels list looks very dangerous..."
> 
> Reported-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thanks, but it seems a hole sill exists.  If alloc_percpu or kzalloc
for the first channel failed, when idr_ref will be freed ?

Hmm.. why idr_ref is dynamically allocated?  Just putting it in
dma_device makes thing more simple, no?

---
Atsushi Nemoto

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2009 15:32:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:58330 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20026382AbZDQOcU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Apr 2009 15:32:20 +0100
Received: from localhost (p7033-ipad307funabasi.chiba.ocn.ne.jp [123.217.185.33])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7D6C8A4F9; Fri, 17 Apr 2009 23:32:12 +0900 (JST)
Date:	Fri, 17 Apr 2009 23:32:21 +0900 (JST)
Message-Id: <20090417.233221.07457681.anemo@mba.ocn.ne.jp>
To:	dan.j.williams@intel.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DMA: TXx9 Soc DMA Controller driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <e9c3a7c20904161823j2cce3a6fpea95ba79ccf871a3@mail.gmail.com>
References: <1239033288-3086-1-git-send-email-anemo@mba.ocn.ne.jp>
	<e9c3a7c20904161823j2cce3a6fpea95ba79ccf871a3@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 16 Apr 2009 18:23:35 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Apr 6, 2009 at 8:54 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > This patch adds support for the integrated DMAC of the TXx9 family.
> >
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > ---
> 
> Just so you know I have not forgotten about this...  I have pulled
> this version and integrated it into my cross-compile environment, so
> far so good.  I will try to get you an Acked-by by tomorrow.

Thanks!

> Ralf, I think I will leave the merge up to you.  As long as NET_DMA=n
> and ASYNC_TX_DMA=n the chance for a regression is low, but it's your
> call.

I believe there will be at least one more merge from mips tree before
2.6.30 ;)

---
Atsushi Nemoto

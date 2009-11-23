Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 14:59:34 +0100 (CET)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:42501 "EHLO
	mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493194AbZKWN71 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 14:59:27 +0100
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
	by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id 5C53256423B;
	Mon, 23 Nov 2009 22:59:22 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
	by vcmba.ocn.ne.jp (Postfix) with ESMTP;
	Mon, 23 Nov 2009 22:59:22 +0900 (JST)
Date:	Mon, 23 Nov 2009 22:59:19 +0900 (JST)
Message-Id: <20091123.225919.44090248.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	dmitri.vorobiev@movial.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Move several variables from .bss to .init.data
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20091123134633.GB28687@linux-mips.org>
References: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com>
	<20091123.222609.74748367.anemo@mba.ocn.ne.jp>
	<20091123134633.GB28687@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 23 Nov 2009 13:46:33 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > And for console option strings parts, I doubt these can be marked as
> > __initdata.  Theoretically, the console driver might be a module,
> 
> No; if the driver is a module we don't offer console functionality.  Typical
> example:

Oh, I missed that.  Thanks.  Then no objections for this part.

---
Atsushi Nemoto

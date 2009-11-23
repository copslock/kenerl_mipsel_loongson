Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 15:06:27 +0100 (CET)
Received: from mv-drv-hcb004.ocn.ad.jp ([118.23.109.134]:38047 "EHLO
	mv-drv-hcb004.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493198AbZKWOGU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 15:06:20 +0100
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
	by mv-drv-hcb004.ocn.ad.jp (Postfix) with ESMTP id EBB091B402E;
	Mon, 23 Nov 2009 23:06:16 +0900 (JST)
Received: from localhost (softbank221040169135.bbtec.net [221.40.169.135])
	by vcmba.ocn.ne.jp (Postfix) with ESMTP;
	Mon, 23 Nov 2009 23:06:16 +0900 (JST)
Date:	Mon, 23 Nov 2009 23:06:16 +0900 (JST)
Message-Id: <20091123.230616.70220116.anemo@mba.ocn.ne.jp>
To:	dmitri.vorobiev@gmail.com
Cc:	dmitri.vorobiev@movial.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] [MIPS] Move several variables from .bss to .init.data
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <90edad820911230543i64f1e33fg86770f3ab2b6510b@mail.gmail.com>
References: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com>
	<20091123.222609.74748367.anemo@mba.ocn.ne.jp>
	<90edad820911230543i64f1e33fg86770f3ab2b6510b@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 23 Nov 2009 15:43:27 +0200, Dmitri Vorobiev <dmitri.vorobiev@gmail.com> wrote:
> On Mon, Nov 23, 2009 at 3:26 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > On Mon, 23 Nov 2009 13:53:37 +0200, Dmitri Vorobiev <dmitri.vorobiev@movial.com> wrote:
> >> Several static uninitialized variables are used in the scope of
> >> __init functions but are themselves not marked as __initdata.
> >> This patch is to put those variables to where they belong and
> >> to reduce the memory footprint a little bit.
> >>
> >> Also, a couple of lines with spaces instead of tabs were fixed.
> >>
> >> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
> >
> > NAK, at least for txx9 parts.  The struct mtd_partition arrays will be
> > referenced by mtd map drivers via platform_data.
> 
> You are right, thanks. What do you think about moving the variables to
> file scope then?

Well, why?  Does it make any check-scripts or something happy?

---
Atsushi Nemoto

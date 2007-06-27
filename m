Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2007 08:51:36 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:36704 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022316AbXF0Hvb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Jun 2007 08:51:31 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 27 Jun 2007 16:51:29 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 26E084138C;
	Wed, 27 Jun 2007 16:51:26 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 1B3EE35146;
	Wed, 27 Jun 2007 16:51:26 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l5R7pPAF037947;
	Wed, 27 Jun 2007 16:51:25 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 27 Jun 2007 16:51:25 +0900 (JST)
Message-Id: <20070627.165125.18312467.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] generic clk API implementation for MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80706261302r67629f62hf560d5229df34663@mail.gmail.com>
References: <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com>
	<20070627.013312.25479645.anemo@mba.ocn.ne.jp>
	<cda58cb80706261302r67629f62hf560d5229df34663@mail.gmail.com>
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
X-archive-position: 15550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 26 Jun 2007 22:02:53 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> It seems that clock configuration highly depends on the board, not the
> arch. For example, a board can have only static clocks which won't be
> unregistered later. In that case most of code provided by the patch is
> useless.
> 
> So maybe the best thing is to let each board implements their own
> generic clock API (exactly like the generic GPIO API you did
> recently). Or make a default implementation (your patch) and allow
> others boards to make their own implementation.

Hmm... I had thought the default implementation would be useful, but
now I change my mind ;)  What people expected on its implementation
would vary too much.

Now I think leaving all implementation to platform code is better.
I'll send rbtx4938 implementation (minimum one just for SPI driver)
soon.

Ralf, please do not apply or queue this patch :)

---
Atsushi Nemoto

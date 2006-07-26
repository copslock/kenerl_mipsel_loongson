Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 16:20:39 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:59389 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133806AbWGZPU3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2006 16:20:29 +0100
Received: from localhost (p2027-ipad203funabasi.chiba.ocn.ne.jp [222.146.81.27])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 303D485B1; Thu, 27 Jul 2006 00:20:24 +0900 (JST)
Date:	Thu, 27 Jul 2006 00:21:53 +0900 (JST)
Message-Id: <20060727.002153.41632148.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44C77D49.90205@innova-card.com>
References: <44B3625B.7000700@innova-card.com>
	<20060711.222458.74752678.anemo@mba.ocn.ne.jp>
	<44C77D49.90205@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 26 Jul 2006 16:33:45 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> I don't think that's correct to mark them as "reserved". Basicaly
> "reserved" means that it belongs to the kernel (code or data), these
> holes are not and we will end up to have wrong value as you pointed
> out.
> 
> Having quick look at sparsemem code, I don't think that it expects
> to have holes inside a section, do it ? If so you probably have to
> fix up your section size...

Yes, for such small holes, sparsemem and flatmem is same.  We can use
smaller section size to save more memory, but I suppose it will be a
bit slower.

> > Talking about nr_kernel_pages (calculated by zones_size[] and
> > zones_holes[]) and num_physpages, these values are used to determine
> > sizes of some kernel data structures, it would be better to set more
> > precise value for them.
> > 
> > While large holes in a section wastes some memory, make the section
> > size customizable might be a good idea.  Anyone?  ;-)
> > 
> 
> hey, you are working in this area, aren't you ? ;)

Well, not actively now since I'm comfort with 256MB section size :-)

---
Atsushi Nemoto

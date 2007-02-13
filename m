Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 14:36:31 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:34045 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28573702AbXBMOg0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Feb 2007 14:36:26 +0000
Received: from localhost (p7211-ipad32funabasi.chiba.ocn.ne.jp [221.189.139.211])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BDF528908; Tue, 13 Feb 2007 23:35:05 +0900 (JST)
Date:	Tue, 13 Feb 2007 23:35:05 +0900 (JST)
Message-Id: <20070213.233505.64804701.anemo@mba.ocn.ne.jp>
To:	djohnson+linux-mips@sw.starentnetworks.com
Cc:	linux-mips@linux-mips.org
Subject: Re: problems booting sb1250, page fault issue?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <17872.61204.190437.109367@zeus.sw.starentnetworks.com>
References: <17869.2075.900049.547334@zeus.sw.starentnetworks.com>
	<20070211.010336.15248113.anemo@mba.ocn.ne.jp>
	<17872.61204.190437.109367@zeus.sw.starentnetworks.com>
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
X-archive-position: 14071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 12 Feb 2007 17:49:56 -0500, Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com> wrote:
> I added both flush_data_cache_page to c-sb1.c and
> __flush_icache_page() to flush_icache_page in cacheflush.h.
> 
> With those, the page faults work correctly and booting seems to be
> reliable on 2.6.18.

I think the problem of c-sb1.c was fixed in lmo 2.6.18-stable branch.
Could you try it?

---
Atsushi Nemoto

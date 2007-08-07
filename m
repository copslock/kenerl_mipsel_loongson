Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 15:01:02 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:28927 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024239AbXHGOAx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 15:00:53 +0100
Received: from localhost (p1089-ipad303funabasi.chiba.ocn.ne.jp [123.217.147.89])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 198BDA635; Tue,  7 Aug 2007 23:00:47 +0900 (JST)
Date:	Tue, 07 Aug 2007 23:01:57 +0900 (JST)
Message-Id: <20070807.230157.59463765.anemo@mba.ocn.ne.jp>
To:	jiankemeng@gmail.com
Cc:	tiansm@lemote.com, linux-mips@linux-mips.org,
	alsa-devel@alsa-project.org, ralf@linux-mips.org, tiwai@suse.de,
	greg@kroah.com
Subject: Re: ALSA on MIPS platform
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com>
References: <46B332AC.8020403@lemote.com>
	<5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com>
	<5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com>
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
X-archive-position: 16111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 7 Aug 2007 10:18:04 +0400, "Dajie Tan" <jiankemeng@gmail.com> wrote:
>  static inline unsigned long virt_to_phys(volatile const void *address)
>  {
> -       return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
> +       return ((unsigned long)address & 0x1fffffff) + PHYS_OFFSET;
>  }

This makes virt_to_phys() a bit slower, and more importantly, breaks
64-bit kernel.

---
Atsushi Nemoto

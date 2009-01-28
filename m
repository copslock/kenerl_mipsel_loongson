Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2009 15:28:59 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:10708 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21102816AbZA1P24 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Jan 2009 15:28:56 +0000
Received: from localhost (p4220-ipad312funabasi.chiba.ocn.ne.jp [123.217.222.220])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 95D0AABDD; Thu, 29 Jan 2009 00:28:50 +0900 (JST)
Date:	Thu, 29 Jan 2009 00:28:50 +0900 (JST)
Message-Id: <20090129.002850.118974677.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	ddaney@caviumnetworks.com, msundius@cisco.com,
	linux-mips@linux-mips.org, dvomlehn@cisco.com, msundius@sundius.com
Subject: Re: memcpy and prefetch
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090128103753.GC2234@linux-mips.org>
References: <497F9214.1000609@cisco.com>
	<497F93C1.3090401@caviumnetworks.com>
	<20090128103753.GC2234@linux-mips.org>
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
X-archive-position: 21858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 28 Jan 2009 10:37:53 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > The Cavium OCTEON port overrides the default memcpy and does use  
> > prefetch.  It was recently merged (2.6.29-rc2).  Look at octeon-memcpy.S
> >
> > I have thought that memcpy could be generated by mm/page.c as copy_page  
> > and clear_page are.
> 
> No, these two only generate copy_page and clear_page.  I and Thiemo were
> considering to extend this to a full memcopy however.

BTW, this code in memcpy.S (and memcpy-atomic.S) looks weird.

#if !defined(CONFIG_DMA_COHERENT) || !defined(CONFIG_DMA_IP27)
#undef CONFIG_CPU_HAS_PREFETCH
#endif
#ifdef CONFIG_MIPS_MALTA
#undef CONFIG_CPU_HAS_PREFETCH
#endif

Are there any configuration which do not undef CONFIG_CPU_HAS_PREFETCH ? ;-)

---
Atsushi Nemoto

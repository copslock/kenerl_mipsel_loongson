Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 06:58:24 +0100 (BST)
Received: from [IPv6:::ffff:202.230.225.5] ([IPv6:::ffff:202.230.225.5]:21262
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225228AbUJTF6I>; Wed, 20 Oct 2004 06:58:08 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 20 Oct 2004 05:58:06 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id E6F51239E46; Wed, 20 Oct 2004 14:57:33 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i9K5vX3i037893;
	Wed, 20 Oct 2004 14:57:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 20 Oct 2004 14:56:25 +0900 (JST)
Message-Id: <20041020.145625.52159105.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: kmalloc alignment
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041019165901.GA18385@linux-mips.org>
References: <20041019.235129.25480859.anemo@mba.ocn.ne.jp>
	<20041019165901.GA18385@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 19 Oct 2004 18:59:01 +0200, Ralf Baechle <ralf@linux-mips.org> said:
ralf> The alignment needs to be large enough to store an arbitrary
ralf> fundamental data type including the 64-bit types such as long
ralf> long or double.

ralf> cache_line_size() is only used if a slab has SLAB_HWCACHE_ALIGN
ralf> set.

SLAB_HWCACHE_ALIGN is default ARCH_KMALLOC_FLAGS, so normal kmalloc
will use cache_line_size() (if no ARCH_KMALLOC_MINALIGN).

ralf> The alignment requirements are documented in
ralf> Documentation/DMA-API.txt and they are specified the way they
ralf> are for good reason.

Hmm... I had been thought of many PCI ether driver (which maps
skbuff), but I found skb_init() calls kmem_cache_create with
SLAB_HWCACHE_ALIGN.  Maybe I should learn much about it...  Thank you.

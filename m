Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2006 05:16:38 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:57969 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20027677AbWHWEQg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Aug 2006 05:16:36 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 23 Aug 2006 13:16:34 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 138D9204A5;
	Wed, 23 Aug 2006 13:16:30 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 082542049C;
	Wed, 23 Aug 2006 13:16:30 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k7N4GRW0010138;
	Wed, 23 Aug 2006 13:16:27 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 23 Aug 2006 13:16:27 +0900 (JST)
Message-Id: <20060823.131627.75185523.nemoto@toshiba-tops.co.jp>
To:	manoje@broadcom.com
Cc:	mark.e.mason@broadcom.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, ths@networkno.de
Subject: Re: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <710F16C36810444CA2F5821E5EAB7F230A0465@NT-SJCA-0752.brcm.ad.broadcom.com>
References: <20060818.105105.41197512.nemoto@toshiba-tops.co.jp>
	<710F16C36810444CA2F5821E5EAB7F230A0465@NT-SJCA-0752.brcm.ad.broadcom.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 21 Aug 2006 12:27:47 -0700, "Manoj Ekbote" <manoje@broadcom.com> wrote:
> The patch doesn't help. The kernel hangs in the same fashion. 

Thank you for testing.

Then I have no idea why the kernel hangs...


Random thoughts:

Does it still hang on init=/bin/sh?

Does enabling second and third "#if 0" blocks in arch/mips/mm/fault.c
show some useful information?

Finally, I think there is no serious reason separating c-sb1.c from
c-r4k.c.  The c-r4k.c support both vtagged-icache and pindexed-dcache,
therefore SB1 can use it too.

mm/c-r4k.c:probe_pcache()
	switch (c->cputype) {
	case CPU_20KC:
	case CPU_25KF:
	case CPU_SB1:
	case CPU_SB1A:
		c->dcache.flags |= MIPS_CACHE_PINDEX;
	case CPU_R10000:
	case CPU_R12000:
	case CPU_R14000:
		break;

kernel/cpu-probe.c:cpu_probe_sibyte()
#if 0
	c->options &= ~MIPS_CPU_4K_CACHE;
	c->options |= MIPS_CPU_SB1_CACHE;
#endif

---
Atsushi Nemoto

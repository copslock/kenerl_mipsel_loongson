Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2005 17:16:02 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:54985 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225555AbVHaQPr>; Wed, 31 Aug 2005 17:15:47 +0100
Received: from localhost (p8037-ipad31funabasi.chiba.ocn.ne.jp [221.189.132.37])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 51CBE84C0; Thu,  1 Sep 2005 01:22:01 +0900 (JST)
Date:	Thu, 01 Sep 2005 01:22:47 +0900 (JST)
Message-Id: <20050901.012247.36920050.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	ralf@linux-mips.org, geoman@gentoo.org, linux-mips@linux-mips.org
Subject: Re: compiling kernel 2.6.13
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050831155526.GW21717@hattusa.textio>
References: <4315CD1C.80203@gentoo.org>
	<20050831153509.GF3377@linux-mips.org>
	<20050831155526.GW21717@hattusa.textio>
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
X-archive-position: 8848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 31 Aug 2005 17:55:26 +0200, Thiemo Seufer <ths@networkno.de> said:
>> But that seems an IP22-specific problem.

ths> I _think_ it hits every 64bit kernel which uses mappings in
ths> CKSEG0.  Do you know a system where this works?

Though I do not have IP22, I think this line in mach-ip22/space.h is
inappropriate.

#define MAP_BASE		0xffffffffc0000000

It will make VMALLOC_END in pgtabe-64.h overflow.

#define VMALLOC_START		MAP_BASE
#define VMALLOC_END	\
	(VMALLOC_START + PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE)

Shoule we use 0xc000000000000000 as MAP_BASE for IP22 ?

---
Atsushi Nemoto

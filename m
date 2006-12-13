Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2006 00:52:26 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:49627 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039656AbWLMAwW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 Dec 2006 00:52:22 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 13 Dec 2006 09:52:20 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id AF77C41DB9;
	Wed, 13 Dec 2006 09:52:17 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9D46721F8F;
	Wed, 13 Dec 2006 09:52:17 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kBD0qHW0016324;
	Wed, 13 Dec 2006 09:52:17 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 13 Dec 2006 09:52:17 +0900 (JST)
Message-Id: <20061213.095217.126574007.nemoto@toshiba-tops.co.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] csum_partial and copy in parallel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061212171809.GG21819@networkno.de>
References: <20061213.012206.98747230.anemo@mba.ocn.ne.jp>
	<20061212171809.GG21819@networkno.de>
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
X-archive-position: 13438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 12 Dec 2006 17:18:10 +0000, Thiemo Seufer <ths@networkno.de> wrote:
> > +#define odd t5
> > +#define errptr t6
> 
> Does this work for 64 bit? t5/t6/t7 look weird for that.

Yes.  I tested on 32/64 bit, little/big endian.

Excerpt from head of csum_partial.S (or memcpy.S):

#ifdef CONFIG_64BIT
/*
 * As we are sharing code base with the mips32 tree (which use the o32 ABI
 * register definitions). We need to redefine the register definitions from
 * the n64 ABI register naming to the o32 ABI register naming.
 */
#undef t0
#undef t1
#undef t2
#undef t3
#define t0	$8
#define t1	$9
#define t2	$10
#define t3	$11
#define t4	$12
#define t5	$13
#define t6	$14
#define t7	$15

---
Atsushi Nemoto

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2007 04:33:13 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:53225 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021848AbXGYDdK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jul 2007 04:33:10 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 25 Jul 2007 12:33:08 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 726D041753;
	Wed, 25 Jul 2007 12:32:40 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5F49E416FC;
	Wed, 25 Jul 2007 12:32:40 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l6P3WaAF068857;
	Wed, 25 Jul 2007 12:32:36 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 25 Jul 2007 12:32:36 +0900 (JST)
Message-Id: <20070725.123236.97297895.nemoto@toshiba-tops.co.jp>
To:	ths@networkno.de
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] tx49xx: add some mach specific headers
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070724212034.GA26960@networkno.de>
References: <20070725.015008.78730579.anemo@mba.ocn.ne.jp>
	<46A6302A.5010105@ru.mvista.com>
	<20070724212034.GA26960@networkno.de>
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
X-archive-position: 15893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 24 Jul 2007 22:20:34 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> >> +#define cpu_has_mips32r1	0
> >> +#define cpu_has_mips32r2	0
> >> +#define cpu_has_mips64r1	0
> >> +#define cpu_has_mips64r2	0
> >
> >    Hm, really?
> 
> IIRC it is MIPS IV. (tx99 is MIPS64R1).

It is MIPS III.

---
Atsushi Nemoto

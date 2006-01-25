Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 15:07:22 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:44739 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133367AbWAYPG4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2006 15:06:56 +0000
Received: from localhost (p2064-ipad01funabasi.chiba.ocn.ne.jp [61.207.63.64])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 08776B022; Thu, 26 Jan 2006 00:11:18 +0900 (JST)
Date:	Thu, 26 Jan 2006 00:10:51 +0900 (JST)
Message-Id: <20060126.001051.59032477.anemo@mba.ocn.ne.jp>
To:	tbm@cyrius.com
Cc:	linux-mips@linux-mips.org, t.sailer@alumni.ethz.ch, perex@suse.cz
Subject: Re: Ensoniq ES1371 problem on Cobalt MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060124160630.GF2924@deprecation.cyrius.com>
References: <20060124030725.GA14063@deprecation.cyrius.com>
	<20060124.132832.37533152.nemoto@toshiba-tops.co.jp>
	<20060124160630.GF2924@deprecation.cyrius.com>
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
X-archive-position: 10145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 24 Jan 2006 16:06:30 +0000, Martin Michlmayr <tbm@cyrius.com> said:

tbm> Can you start a discusion about this on lkml?  I'd assume some
tbm> other platforms have similar problems.

OK, I did it.  (Subject: ALSA on MIPS platform)

>> Anyway, here is my ugly patch against 2.6.15.  It would fix some
>> problems with ALSA on noncoherent MIPS platform.

tbm> This patch didn't really improve anything.

Then there would be other problem...  I'v been using the ALSA patch
from time to time (since kernel 2.4 ages) with ymfpci and cmipci
driver.

---
Atsushi Nemoto

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2005 13:51:59 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:11249 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224942AbVBINvo>; Wed, 9 Feb 2005 13:51:44 +0000
Received: from localhost (p6066-ipad203funabasi.chiba.ocn.ne.jp [222.146.85.66])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9C39D2606; Wed,  9 Feb 2005 22:51:41 +0900 (JST)
Date:	Wed, 09 Feb 2005 22:52:56 +0900 (JST)
Message-Id: <20050209.225256.92587183.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: copy_from_user_page/copy_to_user_page fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20050209125105.GA27875@linux-mips.org>
References: <20050209.184947.30439119.nemoto@toshiba-tops.co.jp>
	<20050209125105.GA27875@linux-mips.org>
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
X-archive-position: 7214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 9 Feb 2005 13:51:05 +0100, Ralf Baechle <ralf@linux-mips.org> said:

ralf> I'm going to apply this because it's a correct fix; the
ralf> temporary mapping strategy as we've discussed for the dup_mmap
ralf> problem would be preferable.

Thank you.  I agree that the temporary mapping will be more efficient
though I chose a simple fix.  I suppose a performance requirement for
ptrace() would be less than the dup_mmap (fork()).

---
Atsushi Nemoto

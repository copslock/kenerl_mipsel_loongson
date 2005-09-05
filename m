Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2005 14:38:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:55751 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225196AbVIENhp>; Mon, 5 Sep 2005 14:37:45 +0100
Received: from localhost (p2231-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.231])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7F7737C75; Mon,  5 Sep 2005 22:44:29 +0900 (JST)
Date:	Mon, 05 Sep 2005 22:45:34 +0900 (JST)
Message-Id: <20050905.224534.25910293.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	spodstavin@ru.mvista.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: a patch for generic MIPS RTC
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.61L.0509051204140.29615@blysk.ds.pg.gda.pl>
References: <1124355290.5441.45.camel@localhost.localdomain>
	<20050905.135422.112260934.nemoto@toshiba-tops.co.jp>
	<Pine.LNX.4.61L.0509051204140.29615@blysk.ds.pg.gda.pl>
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
X-archive-position: 8876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 5 Sep 2005 12:08:34 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> said:

macro>  That's how other architectures do this, see e.g.
macro> "arch/alpha/kernel/time.c".  Why should we be different, even
macro> for now?

Please elaborate more ?  Do you mean we should implement default
rtc_set_mmss() and take the rtc_lock in it ?  Or do you mean we should
take rtc_lock in each board-dependent rtc_set_time/rtc_set_time ?  

macro> Also the call is named rtc_set_mmss() for an unknown reason
macro> while all the others have set_rtc_mmss().

IIRC, you are (one of) the godfather of the function, aren't you?  :-)

---
Atsushi Nemoto

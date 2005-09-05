Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2005 16:18:57 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:10764 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225201AbVIEPSl>; Mon, 5 Sep 2005 16:18:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D036CE1C91; Mon,  5 Sep 2005 17:25:23 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08046-04; Mon,  5 Sep 2005 17:25:23 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7931DE1CB5; Mon,  5 Sep 2005 17:25:23 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j85FPN0f018677;
	Mon, 5 Sep 2005 17:25:23 +0200
Date:	Mon, 5 Sep 2005 16:25:32 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	spodstavin@ru.mvista.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: a patch for generic MIPS RTC
In-Reply-To: <20050905.224534.25910293.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.61L.0509051620020.29615@blysk.ds.pg.gda.pl>
References: <1124355290.5441.45.camel@localhost.localdomain>
 <20050905.135422.112260934.nemoto@toshiba-tops.co.jp>
 <Pine.LNX.4.61L.0509051204140.29615@blysk.ds.pg.gda.pl>
 <20050905.224534.25910293.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1063/Mon Sep  5 13:16:34 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 5 Sep 2005, Atsushi Nemoto wrote:

> macro>  That's how other architectures do this, see e.g.
> macro> "arch/alpha/kernel/time.c".  Why should we be different, even
> macro> for now?
> 
> Please elaborate more ?  Do you mean we should implement default
> rtc_set_mmss() and take the rtc_lock in it ?  Or do you mean we should
> take rtc_lock in each board-dependent rtc_set_time/rtc_set_time ?  

 I'm not sure all chips actually require it.  Certainly the null function 
does not, so that spinlock would incur an unnecessary overhead.  Therefore 
yes, it should be board- or chip-dependent.

> macro> Also the call is named rtc_set_mmss() for an unknown reason
> macro> while all the others have set_rtc_mmss().
> 
> IIRC, you are (one of) the godfather of the function, aren't you?  :-)

 Hmm, I must have got influenced by rtc_set_time()...  Perhaps it wasn't 
that bad after all and it's all the others that should be fixed instead. 
;-)

  Maciej

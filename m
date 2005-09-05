Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2005 12:02:46 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:1039 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224976AbVIELBs>; Mon, 5 Sep 2005 12:01:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5182BE1D46; Mon,  5 Sep 2005 13:08:30 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 10307-02; Mon,  5 Sep 2005 13:08:30 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BE153E1CBE; Mon,  5 Sep 2005 13:08:29 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j85B8R1R009479;
	Mon, 5 Sep 2005 13:08:28 +0200
Date:	Mon, 5 Sep 2005 12:08:34 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	spodstavin@ru.mvista.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: a patch for generic MIPS RTC
In-Reply-To: <20050905.135422.112260934.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.61L.0509051204140.29615@blysk.ds.pg.gda.pl>
References: <1124355290.5441.45.camel@localhost.localdomain>
 <20050905.135422.112260934.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1062/Sun Sep  4 09:55:30 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 5 Sep 2005, Atsushi Nemoto wrote:

> 3. We should protect rtc_set_mmss() call during get_rtc_time or
>    set_rtc_time (this is not your patch's fault).
> 
> How about this patch?  The rtc_lock could be manipulated in each
> RTC-dependent routines, but I choose a simple way for now.

 That's how other architectures do this, see e.g. 
"arch/alpha/kernel/time.c".  Why should we be different, even for now?  
Also the call is named rtc_set_mmss() for an unknown reason while all the 
others have set_rtc_mmss().

  Maciej

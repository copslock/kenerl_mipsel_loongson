Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2008 01:46:30 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:31728 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28581767AbYDWAq1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Apr 2008 01:46:27 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m3N0kRcS028261;
	Wed, 23 Apr 2008 02:46:27 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m3N0kH7I028255;
	Wed, 23 Apr 2008 01:46:26 +0100
Date:	Wed, 23 Apr 2008 01:46:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] [MIPS] add DECstation I/O ASIC clocksource
In-Reply-To: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>
Message-ID: <Pine.LNX.4.55.0804230135190.23679@cliff.in.clinika.pl>
References: <20080423085140.a693b2e5.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 23 Apr 2008, Yoichi Yuasa wrote:

> add DECstation I/O ASIC clocksource

 Thanks, I will have a look into it; reasonably soon I hope -- I'm
updating my tree right now.  I am quite surprised you care about this 
platform too.

> +void __init dec_ioasic_clocksource_init(void)
> +{
> +	clocksource_dec.rating = 200;
> +	clocksource_set_clock(&clocksource_dec, 25000000);
> +
> +	clocksource_register(&clocksource_dec);
> +}

 This is not true for all systems -- the clock rate is based on the
TURBOchannel clock and it varies across systems.  And some have no counter
in the I/O ASIC at all (it has been added in a later revision of the 
chip), which the old code handled albeit not in the prettiest way (by 
chance actually, as originally I did know of the older revision).

  Maciej

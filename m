Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Sep 2009 07:03:55 +0200 (CEST)
Received: from mgw1.diku.dk ([130.225.96.91]:47466 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491879AbZIOFDt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Sep 2009 07:03:49 +0200
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id BAE1B52C3C5;
	Tue, 15 Sep 2009 07:03:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tqSW4wq9EoWG; Tue, 15 Sep 2009 07:03:42 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 7C21452C3C3;
	Tue, 15 Sep 2009 07:03:42 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E39DB6DF823; Tue, 15 Sep 2009 07:01:50 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
	id 5D9FBF3A6; Tue, 15 Sep 2009 07:03:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ask.diku.dk (Postfix) with ESMTP id 530F5F0AB;
	Tue, 15 Sep 2009 07:03:42 +0200 (CEST)
Date:	Tue, 15 Sep 2009 07:03:42 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/8] arch/mips/txx9: introduce missing kfree, iounmap
In-Reply-To: <Pine.LNX.4.64.0909132113520.31000@ask.diku.dk>
Message-ID: <Pine.LNX.4.64.0909150701170.11392@ask.diku.dk>
References: <Pine.LNX.4.64.0909111820370.10552@pc-004.diku.dk>
 <20090913.232548.253168283.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0909131708190.25903@ask.diku.dk>
 <20090914.003321.160496287.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64.0909132113520.31000@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

> +out_pdev:
> +	platform_device_put(pdev);
> +out_gpio:
> +	gpio_remove(&iocled->chip);

I just noticed that the prototype of gpio_remove has __must_check
I don't think there is anything to check here; since the thing is not 
fully initialized here, it is unlikely to be busy.  Should there be (void) 
in front of it?

julia

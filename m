Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g17IxGi30705
	for linux-mips-outgoing; Thu, 7 Feb 2002 10:59:16 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g17IxDA30702
	for <linux-mips@oss.sgi.com>; Thu, 7 Feb 2002 10:59:13 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g17Iv0B16346;
	Thu, 7 Feb 2002 10:57:00 -0800
Subject: Re: madplay on MIPS
From: Pete Popov <ppopov@pacbell.net>
To: Hartvig Ekner <hartvige@mips.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <200202071846.TAA27734@copsun18.mips.com>
References: <200202071846.TAA27734@copsun18.mips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 07 Feb 2002 11:00:39 -0800
Message-Id: <1013108440.2956.40.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-02-07 at 10:46, Hartvig Ekner wrote:
> I seem to recall somebody asking about madplay mp3 player about a week
> ago. For what it's worth, we just ran mad-0.14.2b on our Malta board
> with the 2.4.3 kernel, and it works without a hitch (so far only LE
> tested). CPU utilization is around 25% of a 200 MHz CPU.
> 
> The soundcard was a Creative SB card, based on the Ensoniq chip and
> using the es1371.c driver.

OK, thanks. I'll take a look at the es1371 driver.

Pete

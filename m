Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Sep 2004 20:27:44 +0100 (BST)
Received: from baikonur.stro.at ([IPv6:::ffff:213.239.196.228]:30086 "EHLO
	baikonur.stro.at") by linux-mips.org with ESMTP id <S8225253AbUIBT1b>;
	Thu, 2 Sep 2004 20:27:31 +0100
Received: from localhost (localhost [127.0.0.1])
	by baikonur.stro.at (Postfix) with ESMTP id 717865C065;
	Thu,  2 Sep 2004 21:27:28 +0200 (CEST)
Received: from baikonur.stro.at ([127.0.0.1])
	by localhost (baikonur [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32735-09; Thu, 2 Sep 2004 21:27:27 +0200 (CEST)
Received: from sputnik (M802P011.adsl.highway.telekom.at [62.47.132.43])
	by baikonur.stro.at (Postfix) with ESMTP id C79AD5C008;
	Thu,  2 Sep 2004 21:27:27 +0200 (CEST)
Received: from max by sputnik with local (Exim 4.34)
	id 1C2xF3-0003OO-5x; Thu, 02 Sep 2004 21:27:29 +0200
Date: Thu, 2 Sep 2004 21:27:29 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch 1/1]  minmax-removal 	arch/mips/au1000/common/usbdev.c
Message-ID: <20040902192729.GF1894@stro.at>
References: <E1C2ceP-0000Me-GX@sputnik> <20040902103407.GC19884@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902103407.GC19884@linux-mips.org>
User-Agent: Mutt/1.5.6+20040722i
X-Virus-Scanned: by Amavis (ClamAV) at stro.at
Return-Path: <max@stro.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: janitor@sternwelten.at
Precedence: bulk
X-list: linux-mips

On Thu, 02 Sep 2004, Ralf Baechle wrote:

> On Wed, Sep 01, 2004 at 11:28:17PM +0200, janitor@sternwelten.at wrote:
> 
> > Patch (against 2.6.8.1) removes unnecessary min/max macros and changes
> > calls to use kernel.h macros instead.
> 
> The patch description isn't really right here; the MAX macro in
> arch/mips/au1000/common/usbdev.c was unused so removing it was a
> nobrainer.

you are right,
sorry it was one of a bigger list of MIN/MAX conversions.
that's no excuse, i'll better double check next time.
 
> > Since I dont have the hardware those patches are not tested.
> 
> I guess that's excusable in this case ;-)

thanks.

--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

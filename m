Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 21:13:32 +0200 (CEST)
Received: from mail.asbjorn.biz ([185.38.24.25]:44965 "EHLO mail.asbjorn.biz"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992285AbcIMTN0IKsx7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Sep 2016 21:13:26 +0200
Received: from x201s.roaming.asbjorn.biz (mon1.fiberby.net [193.104.135.42])
        by mail.asbjorn.biz (Postfix) with ESMTPSA id 67E681C00C69;
        Tue, 13 Sep 2016 19:13:25 +0000 (UTC)
Received: by x201s.roaming.asbjorn.biz (Postfix, from userid 1000)
        id ACDB2205DD9; Tue, 13 Sep 2016 19:09:59 +0000 (UTC)
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   =?iso-8859-1?q?Asbj=F8rn_Sloth_T=F8nnesen?= <asbjorn@asbjorn.st>
Subject: Re: [PATCH] MIPS: Octeon: Use defines instead of magic numbers
Message-ID: <1473793494.15480.1@x201s.roaming.asbjorn.biz>
References: <20160912210314.GB1658@raspberrypi.musicnaut.iki.fi>
In-Reply-To: <20160912210314.GB1658@raspberrypi.musicnaut.iki.fi>
Date:   Tue, 13 Sep 2016 19:04:54 +0000
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-KVG4CiMFLK/H49O+U8qs"
Return-Path: <ast@asbjorn.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: asbjorn@asbjorn.st
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--=-KVG4CiMFLK/H49O+U8qs
Content-Type: text/plain; charset=UTF-8

Hi Aaro,

On Tue, 13 Sep 2016 00:03:14 +0300, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Mon, Sep 12, 2016 at 08:33:43PM +0000, Asbjoern Sloth Toennesen wrote:
> > The patch will be followed by a similar patch to
> > drivers/staging/octeon/ethernet.c
> 
> I think you should:
> 
> 	1. Move this function to staging/octeon
> 
> 	2. Do required cleanups there
> 
> 	3. Finally delete the function under arch/mips
> 
> We shouldn't start making cleanups (except code removal) to ethernet code
> under mips/cavium-octeon/executive as it really does not belong there...

I agree that this would make sense, however I just came across this looking
at the general MTU code across drivers, and don't have a real interest in
this particular driver nor mips, so I am not looking to fall that deep into
the rabbit hole.

-- 
Best regards
Asbjørn Sloth Tønnesen

--=-KVG4CiMFLK/H49O+U8qs--

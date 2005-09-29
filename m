Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2005 12:18:05 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:38375 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133635AbVI2LRt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Sep 2005 12:17:49 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id C3CBDC063;
	Thu, 29 Sep 2005 13:17:22 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id F01231BC081;
	Thu, 29 Sep 2005 13:17:24 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 4D7C71A18B1;
	Thu, 29 Sep 2005 13:17:25 +0200 (CEST)
Subject: RE: Floating point performance
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Ulrich Eckhardt <Eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <6EC3F44BE5E6B742BE3EBC3465525944096814@emea-exchange3.emea.dps.local>
References: <6EC3F44BE5E6B742BE3EBC3465525944096814@emea-exchange3.emea.dps.local>
Content-Type: text/plain
Date:	Thu, 29 Sep 2005 13:16:40 +0200
Message-Id: <1127992600.10179.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> > I've built soft float toolchain (with crosstool) and then build
> > MPlayer with it. The performance is very low. I cannot even play the
> > mp3 file with MPlayer on DBAU1200 with 400MHz CPU!
> [...]
> > Any other suggestions?
> 
> I'm not sure what you are doing, but if you only want to play music, 
> I'd use Ogg Vorbis instead, which has a decoder that only uses integer 
> arithmetic for exactly the case of FPU-less machines and the Au1200. 
> I could also imagine an MP3 decoder written for integer only being 
> written somewhere, but I don't know anything about it.

Yes, I can use madplay (libmad) for music only, which uses int
arithmetics (also special version for MIPS).

But I also want to play video and currently I am testing this with
MPlayer (maybe I'll add support for MAE, sometime in the future).
Then I found out, that MPlayer can use libmad for MP3 and it
works great know.

Now I'll try to write XV driver for MAE backend so I'll have
HW accelerated Color Space Conversion (form YV12->RGB) and
Scaling. 

I thought that SF *should* be relatively fast, because I have
experience with it on ARM, where Nicolas Pitre wrote amazing 
SF support for the glibc.
How can we speed-up SF on MIPS? 
Does anybody have some suggestions?

BR,
Matej

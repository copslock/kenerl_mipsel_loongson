Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jul 2009 22:50:43 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:53532 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493757AbZG3Uuh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Jul 2009 22:50:37 +0200
Received: by ewy12 with SMTP id 12so1775480ewy.0
        for <multiple recipients>; Thu, 30 Jul 2009 13:50:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+h9zbRYalM2ChhVV8NAPyEj/dAnpVnpodTxLCBhESi0=;
        b=e1iEMjfBdEuVfEuFxdoWYznQtDD8v/cS2zCbKnHlsipXCJmlMuM2CVREgZ+74wBF+w
         +dn3BkRJBghIh5XVznXbg1M8LtnUeF6ypiwqQ6px3RocKPUeyzsMNPH6gYz3F16DagAT
         NMSlb86nfXTv32vzUzD7PQNW3vvi9OMSpT0MY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=avuHZcuGchF4j8M6bsZMPzB1m7Iy94BVJW1NZBsZzDBMyD00KIkwMC065HEclFtH1f
         Va3e3FXdDbN9OgFH7v1prwRi4Zj1ydxaX52SJfQTpszGdDIwu8hkIPgy38GWRfHmn97n
         iyI8x4e0I1APfYDNTxoVdibASL27GgJS5TLzo=
Received: by 10.210.102.9 with SMTP id z9mr1988256ebb.93.1248987030110;
        Thu, 30 Jul 2009 13:50:30 -0700 (PDT)
Received: from ?192.168.254.2? (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 5sm1429313eyf.58.2009.07.30.13.50.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 13:50:27 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 1/4] alchemy: register au1000_eth as a platform driver  part one
Date:	Thu, 30 Jul 2009 22:50:20 +0200
User-Agent: KMail/1.9.9
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200907282300.14118.florian@openwrt.org> <4A70517A.6060006@ru.mvista.com> <f861ec6f0907290727q3955d0fave0fb0a18bb035284@mail.gmail.com>
In-Reply-To: <f861ec6f0907290727q3955d0fave0fb0a18bb035284@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200907302250.21044.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel, Sergei,

Le Wednesday 29 July 2009 16:27:02 Manuel Lauss, vous avez écrit :
> Hi Sergei,
>
> >> Yes I know ;) I was just wanting to get this out quickly before you kill
> >> platform.c
> >
> >   I'd NAK such patch (and have already done so, AFAIR).
>
> I've already surrendered myself to the fact that I'll never be able to get
> rid of this file in my lifetime.  However I've set a timer on my mail
> machine to send a patch (which I'll keep rebasing to latest sources) trying
> that again in 80 years or so ;-)
>
> >> I will make the au1000-eth devices be registered on a per-board basis.
> >
> >   Please don't. You can register them in platform.c, and yet leave
> > actually board specific platform data in the board files. There's no
> > reason to duplicate the platfrom device itself.
>
> Let's say I have 2 pieces of hardware, indentical in all things,
> except one has an Au1100, and the other Au1500 (different MAC mmio
> address and unit counts).  I want to build a kernel which runs on both.
> This can certainly be done, but the existence of common/platform.c and
> your insistence on maintaining the status-quo limits me to one board
> per kernel (theoretical example currently, i know).

I am still a big fan of a single kernel approach for a SoC whenever runtime 
identification is possible.

>
> I also dislike having to #ifdef around this file when a new platform
> is introduced which doesn't need/use all devices registered in there!
> (for example au1200 mmc platform data. Suppose I have a platform
> which doesn't use mmc; I can either add a #ifdef for my new board or
> provide empty platform data stubs in my board code.  Both solutions
> suck IMO; the former because then when I (and others) submit new
> board code upstream common/platform.c will develop into a mess of
> random #ifdefs (just look at common/reset.c!) and the latter because
> platform data and -device registration are in different places in the
> source tree.

Well, right now, the au1000_eth driver has been converted in a way that even 
passing no platform_data to it makes it pick the right defaults (searching 
for PHY1 on MAC0) so this is not a big problem here, this might not be the 
case with other drivers.

Even though it duplicates quite a lot of code, it's still cleaner when you 
either have to pick up the eval board which is the closest to your design, or 
have to add a new board.

I am going to respin the patches with the Ethernet driver registered in a 
per-board platform.c file, which lets room for other platform devices to be 
registered there too. Everyone can then make up his mid about which approach 
he prefers ;)
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Jun 2009 07:06:23 +0200 (CEST)
Received: from mail-ew0-f205.google.com ([209.85.219.205]:43557 "EHLO
	mail-ew0-f205.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491906AbZF1FGQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Jun 2009 07:06:16 +0200
Received: by ewy1 with SMTP id 1so91954ewy.0
        for <multiple recipients>; Sat, 27 Jun 2009 22:01:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UHf6J2kx9kaNksCpys92dKbW49/Vaje12YrnQ8TYG8Y=;
        b=pTNbzp26PQGZAuWnRrxaJgfmT34QufgtxoZ+7RFQClyKRa1KN76j5c70J8FgHFxCxO
         OyLrfO8qsg1DBSOuZnrNzpN+0ZYXJLyrbGlrkLPMlV1T5tRnpOwglFxJ/da6kOQUd4J1
         A+hCZ2H6DJvaQ1/xTzgEVtbG5jlkchifyd49c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EhwG4wOG3gAiyhRBAkhD0X1jysDWYlxx4uHSSY+kMM8gCzJh4tXZrpSboFW/hWMyuC
         g0+ok9LTMyxC7nRGQ7e73/nf/saDy/NitNTXBpFxM15cYKTi0UjkhXrNQb6Yw9gK4/eE
         UOqNZgDO2Sdtnx2LwoMK/yr+e/6u55qkdpPcw=
Received: by 10.211.199.11 with SMTP id b11mr1549637ebq.68.1246165302891;
        Sat, 27 Jun 2009 22:01:42 -0700 (PDT)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 5sm2865644eyf.32.2009.06.27.22.01.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 22:01:41 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Subject: Re: [PATCH] fix build failures on msp_irq_slp.c
Date:	Sun, 28 Jun 2009 07:01:29 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200904271659.48357.florian@openwrt.org> <200904291512.19297.florian@openwrt.org> <b2b2f2320904290718pe9a28efy9a8af432887778cb@mail.gmail.com>
In-Reply-To: <b2b2f2320904290718pe9a28efy9a8af432887778cb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906280701.32649.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Shane,

Le Wednesday 29 April 2009 16:18:11 Shane McDonald, vous avez écrit :
> Hello:
>
> On Wed, Apr 29, 2009 at 7:12 AM, Florian Fainelli 
<florian@openwrt.org>wrote:
> > Hi Ralf, Shane,
> >
> > Le Wednesday 29 April 2009 13:58:59 Ralf Baechle, vous avez écrit :
> > > The whole irq chip thing in this file is looking suspect as it treats
> > > acknowledging and mask an interrupt as the same thing.  Sure that is
> > > the right thing?
> >
> > That is a quick and dirty fix which compiles, I assumed that the function
> > meant to be called is mask_msp_slp_irq, Shane probably knows more about
> > how this should be fixed.
>
> It's been quite a while since I messed around with the 4200.  I'll do some
> digging and ask some questions of guys who probably know better.

Any updates on that patch ? Thank you very much.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------

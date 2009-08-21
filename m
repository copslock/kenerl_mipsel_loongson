Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Aug 2009 19:23:53 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:59758 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492209AbZHURXr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Aug 2009 19:23:47 +0200
Received: by bwz4 with SMTP id 4so793988bwz.0
        for <multiple recipients>; Fri, 21 Aug 2009 10:23:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mhR+JyU1now7PawTaLc9AbtV6XjxvwugHLeo8n2Bj2Y=;
        b=whsY2Bb0dOcY+zi7A4G71VWr5oTRwOuzeARngTcDqgHQL1soP8xpkTgI/hu/7N1LVN
         SfrWErssDZAGWyETdf0kqewihYPzvcUrD2cy1t4Oei38/A24Q5EiTTcgxFD5tC8xvy7S
         phpvP4FHH5rzVgNE6Voi0114mmVhsA8nWtpuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RXz3JslB99FGiaThUxQCMCcIbZIeFniNhvX1ZP3Jjunz43CPHVZ+GjdMMv8eTldTbw
         glHB9ipgz6V0h2WsuBVPm/P2uKYBkKmrUB0KfEdA8fSgBaMAprVUQP5QqwFCMhWWlWgd
         cPngP00jIzxxeW9NPe4Uo0q7qE5pVrgCQuLjI=
MIME-Version: 1.0
Received: by 10.223.54.152 with SMTP id q24mr321990fag.19.1250875419201; Fri, 
	21 Aug 2009 10:23:39 -0700 (PDT)
In-Reply-To: <200908211853.07969.florian@openwrt.org>
References: <200908170105.38154.florian@openwrt.org>
	 <4A8AC125.3020602@ru.mvista.com>
	 <200908181801.41602.florian@openwrt.org>
	 <200908211853.07969.florian@openwrt.org>
Date:	Fri, 21 Aug 2009 19:23:39 +0200
Message-ID: <f861ec6f0908211023t3eb7ff1p12b6160feb94efb4@mail.gmail.com>
Subject: Re: [PATCH 1/2] alchemy: add au1000-eth platform device
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Florian,

On Fri, Aug 21, 2009 at 6:53 PM, Florian Fainelli<florian@openwrt.org> wrote:
> Le Tuesday 18 August 2009 18:01:40 Florian Fainelli, vous avez écrit :
>> Le Tuesday 18 August 2009 16:56:37 Sergei Shtylyov, vous avez écrit :
>> > Hello.
>> >
>> > Florian Fainelli wrote:
>> > > This patch adds the board code to register a per-board au1000-eth
>> > > platform device to be used wit the au1000-eth platform driver in a
>> > > subsequent patch. Note that the au1000-eth driver knows about the
>> > > default driver settings such that we do not need to pass any
>> > > platform_data informations in most cases except db1x00.
>> >
>> >     Sigh, NAK...
>> >     Please don't register the SoC device per board, do it in
>> > alchemy/common/platfrom.c and find a way to pass the board specific
>> > platform data from the board file there instead -- something like
>> > arch/arm/mach-davinci/usb.c does.
>>
>> Ok, like I promised, this was the per-board device registration. Do you
>> prefer something like this: --
>> From fd75b7c7fa3c05c21122c43e43260d2785475a79 Mon Sep 17 00:00:00 2001
>> From: Florian Fainelli <florian@openwrt.org>
>> Date: Tue, 18 Aug 2009 17:53:21 +0200
>> Subject: [PATCH] alchemy: add au1000-eth platform device (v2)
>>
>> This patch makes the board code register the au1000-eth
>> platform device. The au1000-eth platform data can be
>> overriden with the au1xxx_override_eth0_cfg function
>> like it has to be done for the Bosporus board.
>
> Sergei, any comments on that version? What about you Manuel?

Obviously I *much* prefer your first version, but I'm okay with this
second version too.

(I usually only comment if I don't like things, so take my silence as
approval).

Thanks for your work!

Manuel Lauss

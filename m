Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 11:58:17 +0100 (WEST)
Received: from fg-out-1718.google.com ([72.14.220.153]:39981 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023289AbZFFK6K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2009 11:58:10 +0100
Received: by fg-out-1718.google.com with SMTP id 22so754814fge.9
        for <linux-mips@linux-mips.org>; Sat, 06 Jun 2009 03:58:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VFHaxxXKqBqTxPUBcWeYIBsdIdLY1JfUBOIj56pfxZo=;
        b=YSNLGTwfUlA4zdiR9bQsouPoWAU7uFfCM52psvRZ6DC8eU7Mo3emKlAZSnfONnC0z4
         SGgDXO1lMmGJA0IgIn+CoSXOW30VW4tm9BcuXi1YilkBzVCdAygssGiYDEiBrKIDHBbe
         kmqSrxaUTN/mVDuvEvG/OLA3ezb0XKhRyD/g4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Zkq3/8TIYEagIBmkOUQ7yXRmrNrc6Ug8fF9DFp0sgbg4bUNBsOlQ9XNVyiSgVccJPh
         TyQGK23etKVCFeOPjQvJguf7ZUgdZtuwsE4Aw36k+M6WHyNGDvz5FHuI6fWvX77ocL+A
         F0BA93aE2dygsCuHwn8mcgdncPqE1hzYx9CbA=
Received: by 10.86.91.3 with SMTP id o3mr4886779fgb.40.1244285889200;
        Sat, 06 Jun 2009 03:58:09 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id d6sm2032713fga.12.2009.06.06.03.58.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 03:58:08 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	castet.matthieu@free.fr
Subject: Re: add bcm47xx watchdog driver
Date:	Sat, 6 Jun 2009 12:58:02 +0200
User-Agent: KMail/1.9.9
Cc:	wim@iguana.be, Linux Kernel list <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org,
	Aleksandar Radovanovic <biblbroks@sezampro.rs>
References: <4A282D98.6020004@free.fr> <200906051558.02303.florian@openwrt.org> <1244213922.4a2932a272094@imp.free.fr>
In-Reply-To: <1244213922.4a2932a272094@imp.free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906061258.04284.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 05 June 2009 16:58:42 castet.matthieu@free.fr, vous avez écrit :
> Hi Florian,
>
> Quoting Florian Fainelli <florian@openwrt.org>:
> > Your driver looks good, could you turn this into a platform device/driver
> > instead ? You declare bcm47xx_wdt_platform_device which is unused and you
> > also declare a MODULE_ALIAS which suggets it is one.
>
> What's the advantage of using platform device/driver ?
> Not all watchdog driver use it (for example softdog).
> This seems useless in this case because the driver don't have any resource,
> don't care about suspend/resume and add complexity in the code (2 registers
> in module probe, ...).

Indeed, I was suggesting that either you turn it into a full platform driver 
or your remove references to it (bcm47xx_wdt_platform_device and 
MODULE_ALIAS).
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 14:58:17 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:52032 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023046AbZFEN6K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Jun 2009 14:58:10 +0100
Received: by bwz25 with SMTP id 25so1572638bwz.0
        for <linux-mips@linux-mips.org>; Fri, 05 Jun 2009 06:58:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=i1oHTJrvjZV7K+NstYFEh8ZuXsfianMZ6AGjzDdHKmU=;
        b=nFafPkOsZKaFk+znH28TULHJ003TVm0tGc8F5SQ6O8aYr4PMb21zkFEBl2qlAKV5UL
         fcZmJJnLDCW22o8+TJ1OpweZGDRgsO375mW2JzqtO+bSKrDxsnyv6j/Ytnlsuaxeevq6
         YS2N/idERs1ByARB0ndEE1vUFqQHZZTEnqZPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gsLrRkfuU6p84wKIrlf1TT0biTqQ7msW11jAOtyUJblkPhLKtqrBCkRohVXue56rOL
         mSBJOoP6xMwI5PjxuOXnZDljYT/g2InALIoHAPkpBkJFQqQlFyKDlRvRbLtQrN0xozNa
         p2RMmCzdRd0vSCAajKHyRvRKgt79dbeCzqbTY=
Received: by 10.204.31.218 with SMTP id z26mr3195053bkc.84.1244210284600;
        Fri, 05 Jun 2009 06:58:04 -0700 (PDT)
Received: from florian (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 31sm12868527fkt.13.2009.06.05.06.58.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 06:58:03 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	matthieu castet <castet.matthieu@free.fr>
Subject: Re: add bcm47xx watchdog driver
Date:	Fri, 5 Jun 2009 15:58:01 +0200
User-Agent: KMail/1.9.9
Cc:	wim@iguana.be, Linux Kernel list <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org,
	Aleksandar Radovanovic <biblbroks@sezampro.rs>
References: <4A282D98.6020004@free.fr>
In-Reply-To: <4A282D98.6020004@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906051558.02303.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Salut Matthieu,

Le Thursday 04 June 2009 22:24:56 matthieu castet, vous avez écrit :
> This add watchdog driver for broadcom 47xx device.
> It uses the ssb subsytem to access embeded watchdog device.
>
> Because the watchdog timeout is very short (about 2s), a soft timer is used
> to increase the watchdog period.
>
> Note : A patch for exporting the ssb_watchdog_timer_set will
> be submitted on next linux-mips merge. Without this patch it can't
> be build as a module.

Your driver looks good, could you turn this into a platform device/driver 
instead ? You declare bcm47xx_wdt_platform_device which is unused and you 
also declare a MODULE_ALIAS which suggets it is one.

You are also missing your name in both the header the the MODULE_AUTHOR macro.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 10:26:38 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:59920 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492498AbZH1I0c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Aug 2009 10:26:32 +0200
Received: by ewy25 with SMTP id 25so1874429ewy.33
        for <multiple recipients>; Fri, 28 Aug 2009 01:26:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=er2hxpAAS053UbFAON/5AotgwJIZsoA/vLHM+Y2yznA=;
        b=rUSWNO6/zgr2CDj82b5H7GXI0VsrtVVXZhuo0fpIU9zPYi1rg/3wQlzzjiect0CH/Y
         nBrS1AiJQSYRMvDytI6EENwglUmP0cbDrcTvwvebIE4ni6UrMfB34R4+H/MyTaLw+wEe
         egSz49nTISTem3D1vbo5HOI4hpGP6nArHwhYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OTTcFQMDah+1PqdPz8sY8qlSz8iFIdAuB3tmQIB/GI5d4NDkun3yDnzoJyMr4sEDfW
         L0OmGy5w1mN4NRAStloDSBdiZBC1Fpy5Dc197eUP+DUvp7/2exC0hjOdm3FFS2z+c3Ih
         GrIVG4P+BXbIuxsMkJkUO1BuFjxgYnV+lInqw=
Received: by 10.210.93.27 with SMTP id q27mr902149ebb.9.1251447986773;
        Fri, 28 Aug 2009 01:26:26 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 28sm1577521eye.36.2009.08.28.01.26.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 01:26:26 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: MTX build failure
Date:	Fri, 28 Aug 2009 10:26:15 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <20090828074709.GA11637@linux-mips.org>
In-Reply-To: <20090828074709.GA11637@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908281026.17446.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 28 August 2009 09:47:09 Ralf Baechle, vous avez écrit :
>   CC      drivers/input/keyboard/gpio_keys.o
> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c: In
> function ‘gpio_keys_probe’:
> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:123:
> error: implicit declaration of function ‘gpio_request’
> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:135:
> error: implicit declaration of function ‘gpio_free’ make[5]: ***
> [drivers/input/keyboard/gpio_keys.o] Error 1
> make[4]: *** [drivers/input/keyboard] Error 2
> make[3]: *** [drivers/input] Error 2
> make[2]: *** [drivers] Error 2
> make[1]: *** [sub-make] Error 2

Will see what happens, thanks for notifying.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------

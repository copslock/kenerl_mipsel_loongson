Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 11:12:15 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.145]:45579 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492499AbZH1JMJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2009 11:12:09 +0200
Received: by ey-out-1920.google.com with SMTP id 13so356842eye.52
        for <linux-mips@linux-mips.org>; Fri, 28 Aug 2009 02:12:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=mde6ccVmM1eG7sKYtNL9zcgb/P6DStnRvyvSB2iJxMI=;
        b=wzrWFmiRiW4VfFuJf3X9Q2xgnJTtT5VCDj8SHp9pq3AUAjwshpX9VNBq+yG6WJa5Oj
         qglinSUSUTwsR7byNJXswaWDJ3D2pJLvrqGsfuqt1Fc9zp7cFHlh1tdFx67dIao0Imdr
         SNRhY2i/QyCHjvRJEgeHQGMrrxhc0tsYUjdqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Yejy7QKaqemxpTofXCtjZIhDJBSlC6RhBG3Gu8XN4ju071UimuHIvqeEUXxEJdCSRv
         LwrmpEpMrkPYUQG72NgODrAp6ElUgxxuX01I7Rg2X5Nji4APf298FZLQDUMs6229Qo4r
         gbgiHryt7YVzkMu93bNgFFvJn3TGT1xdKrbho=
Received: by 10.210.206.12 with SMTP id d12mr947161ebg.32.1251450728702;
        Fri, 28 Aug 2009 02:12:08 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 28sm1541755eye.20.2009.08.28.02.12.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Aug 2009 02:12:08 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	loody <miloody@gmail.com>
Subject: Re: how to make /dev/random work?
Date:	Fri, 28 Aug 2009 11:12:05 +0200
User-Agent: KMail/1.9.9
Cc:	Kernel Newbies <kernelnewbies@nl.linux.org>,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <3a665c760908272341h1b3d21afmda7415282c40261b@mail.gmail.com>
In-Reply-To: <3a665c760908272341h1b3d21afmda7415282c40261b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908281112.06100.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi,

Le Friday 28 August 2009 08:41:41 loody, vous avez écrit :
> Dear all:
> I made linux running on Mips machine.
> Right now I found the /dev/random doesn't work properly, since I use
> "dd if=/dev/random of=/tmp/random.txt", it stops working.
> If I use "cat /dev/random", it will not pop out anything.
>
> Is there any setting I forget while make menuconfig or should i add
> another driver for /dev/random such that I can make /dev/random work?
> appreciate your help,

Could it be that your system does not generate enough entropy so you end up in 
having nothing going out from /dev/random ? In case your system has very 
little entropy, better use /dev/urandom.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------

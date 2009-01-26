Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2009 22:41:07 +0000 (GMT)
Received: from mail-ew0-f17.google.com ([209.85.219.17]:43176 "EHLO
	mail-ew0-f17.google.com") by ftp.linux-mips.org with ESMTP
	id S21102800AbZAZWlD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2009 22:41:03 +0000
Received: by ewy10 with SMTP id 10so6241229ewy.0
        for <multiple recipients>; Mon, 26 Jan 2009 14:40:57 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Vw3kwwD9ovMcTkbj4Wrl6Y4/c+7NRiwWMsiER7mlO+Q=;
        b=a1e62pfIt2DQ/WgxTfqOR4dsfNMNZ1cfTWNiO6LJUGdRHAynN6PLRs91g0zHc4pLYt
         mkC4DbzALa1+my0qtoZ17NAGut9a3PLdv3lhnUGZvWsRvVUKsRys8VWQ2bRmIYkUY0wT
         QBp60qnzFT5roZ33K7qMXmDbBuabHdmZ9gmp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LUf6PLW+f+A/+oCHPij2hkWR+cqe+C9k+AF1DfMDeSzQT03+A5Oof9tIijR1k77kp3
         gVPZchKNLq5BuBzj9kFoYUtQebbinn3RTmZwaTjAiLsXa8o7m/7c+5SYAsbOccQR6vyN
         DZPrQqumvmHZ6fCPgQ8LnugAZpKcUcjkNvAno=
Received: by 10.103.212.2 with SMTP id o2mr3693447muq.131.1233009657412;
        Mon, 26 Jan 2009 14:40:57 -0800 (PST)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id j6sm14151363mue.54.2009.01.26.14.40.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 14:40:56 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] au1000: convert to using gpiolib
Date:	Mon, 26 Jan 2009 23:40:27 +0100
User-Agent: KMail/1.9.9
Cc:	ralf@linux-mips.org, Linux-MIPS <linux-mips@linux-mips.org>
References: <200901151646.49591.florian@openwrt.org> <20090116174753.GA18764@roarinelk.homelinux.net> <200901191812.24377.florian@openwrt.org>
In-Reply-To: <200901191812.24377.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200901262340.27613.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel,

Le Monday 19 January 2009 18:12:23 Florian Fainelli, vous avez écrit :
> This patch converts the GPIO board code to use gpiolib.
> Changes from v1:
> - allow users not to use the default gpio accessors
> - do not lock au1000_gpio2_set

I did not receive comments from you on this patch, can I consider it being 
ok ?
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------

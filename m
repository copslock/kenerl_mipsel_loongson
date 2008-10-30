Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 20:26:34 +0000 (GMT)
Received: from mu-out-0910.google.com ([209.85.134.188]:61754 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22759728AbYJ3U0Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 20:26:25 +0000
Received: by mu-out-0910.google.com with SMTP id w9so702354mue.4
        for <linux-mips@linux-mips.org>; Thu, 30 Oct 2008 13:26:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=DryMO8sAP7IZ+m1avBMDA7kf0J8n00ZheFEmBvfx9eE=;
        b=Ho6FUJi02NzhXIR8MIiKWZBu4YOwGGDGgSVoGZSwUbzSLexb48o5D7Ql7lvCqvBUNr
         9ZF926W9MOKnhiEaDI2502REgJWrMRx1Z+/rGkQz1ZzopUTR9UhSp7NC5dSWUa5mzhJI
         cTyDRil3rfISRDOUigTIVGMoseyim+5xFEUpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=vkXdZp+y9kGlKPa3U9S1HtUy0o8aNsNS5IMTobeyxxpsOp5bGY5CUEjdiZva2qzdDd
         h8JDbtnsU5fLEQloFyL0yt0bc60W6DvT3msl97PuIBqplCwWM4Ivgs8w9+uTNUKb3N10
         zlAizo5zgDAkY0TPmP2quK99W3ZEZdRUsl1jQ=
Received: by 10.181.156.11 with SMTP id i11mr2782417bko.177.1225398383641;
        Thu, 30 Oct 2008 13:26:23 -0700 (PDT)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
        by mx.google.com with ESMTPS id b17sm1257234fka.7.2008.10.30.13.26.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Oct 2008 13:26:22 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] provide functions for gpio configuration
Date:	Thu, 30 Oct 2008 21:26:17 +0100
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <200810301916.25290.florian@openwrt.org> <1225398000-24020-1-git-send-email-n0-1@freewrt.org>
In-Reply-To: <1225398000-24020-1-git-send-email-n0-1@freewrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200810302126.18217.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Thursday 30 October 2008 21:20:00 Phil Sutter, vous avez écrit :
> As gpiolib doesn't support pin multiplexing, it provides no way to
> access the GPIOFUNC register. Also there is no support for setting
> interrupt status and level. These functions provide access to them and
> are needed by the CompactFlash driver.
>
> Also do a complete configuration of the GPIO pin used by the cf driver,
> which also serves as example for future drivers.

Great work, thanks !

>
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>

Acked-by: Florian Fainelli <florian@openwrt.org>

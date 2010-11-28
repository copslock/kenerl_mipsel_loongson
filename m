Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Nov 2010 09:32:02 +0100 (CET)
Received: from mail-gx0-f193.google.com ([209.85.161.193]:56835 "EHLO
        mail-gx0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491172Ab0K1Ib7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Nov 2010 09:31:59 +0100
Received: by gxk7 with SMTP id 7so1058678gxk.0
        for <multiple recipients>; Sun, 28 Nov 2010 00:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FjmeYd7SMnE5K6LZdRYpHUmL40s5Fu+HOEad4UF/GHA=;
        b=lZW7jgwNa1DTgoYFUmfZYKKBVecU1U0vCiPwwo7h2IfFBMq7PZCNviEkQtk/BC/LJz
         5Rp1ypxAUB432VVsgRsVkqNWZ21ONVJtVfagq0zcWAAnRC9bLDWfYr5Zu4MZ0B59yr1S
         buya3mHAKi6oMSUqMceRNiz3e8SjSYSwuO17o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IT4g7T/9hIY/nDzcAvvAFreAtlmpzi7sL0ZCTEve8IaLwOW3nxJXyFH8FirIZY1LPv
         sDtQH94s6Ybt9og/DlZzQ+JLuVsuhK8o7hX3+3VSvYO6T3X6hfo46EaBbRWJxgjUn/9y
         6wq0+BIEDcED2MbRZNPj4z4AI+SNmNjakk7o0=
Received: by 10.91.10.21 with SMTP id n21mr7103496agi.75.1290933112529;
        Sun, 28 Nov 2010 00:31:52 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-98-234-113-65.hsd1.ca.comcast.net [98.234.113.65])
        by mx.google.com with ESMTPS id m22sm55676yha.27.2010.11.28.00.31.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 00:31:50 -0800 (PST)
Date:   Sun, 28 Nov 2010 00:31:45 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH 09/18] input: add input driver for polled GPIO buttons
Message-ID: <20101128083145.GF14499@core.coreip.homeip.net>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
 <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 23, 2010 at 04:06:31PM +0100, Gabor Juhos wrote:
> + *
> + *  This file was based on: /include/linux/gpio_keys.h
> + *	The original gpio_keys.h seems not to have a license.
> + *

This is incorrect statement. Unless otherwise specified Linux kernel
sources are licensed under GPL v2.

Thanks.

-- 
Dmitry

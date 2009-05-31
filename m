Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 19:56:52 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:36864 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024497AbZEaS4q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 31 May 2009 19:56:46 +0100
Received: by ewy19 with SMTP id 19so7644663ewy.0
        for <multiple recipients>; Sun, 31 May 2009 11:56:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FEODg8wsSuV2mX4wgs3mfOxJgpANgFGw8L3sDythYH0=;
        b=brUd27MXZErREd8DuJQeRd7ESJc2AtVUt/A5B8/zGcox+JDr6TQ2tj7Az2XoTbYkVJ
         vjKsbqXl80KDcwYsoO7u9G1bzrx/SpuALPrNswdB/y+U10C6wgRnBKRmH0xYE9mZlP4r
         OmvlHovcGdmln+7FIELSN99CgCNuu3qWJlqek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Rr9ODMBSBIbB7eCEAmWFLyyLEQ1/a/FU3civTNf/g9n8v53gCVwe4vAcwqgYmj2Q6E
         VkPpi3UH/S5ZcQ4NAMjlhmkapfFmgYPnM8mWTrs3gIvd+prpv6laRtM3pXGZF8KJy3Pm
         nsBFEQUKtJVI1nm1SJYm32WMhOsJJ08ewSjqE=
Received: by 10.210.16.11 with SMTP id 11mr2048405ebp.18.1243796200360;
        Sun, 31 May 2009 11:56:40 -0700 (PDT)
Received: from ?192.168.1.20? (207.130.195-77.rev.gaoland.net [77.195.130.207])
        by mx.google.com with ESMTPS id 24sm3645348eyx.33.2009.05.31.11.56.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 May 2009 11:56:39 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 04/10] bcm63xx: register a fallback SPROM require for b43 to work
Date:	Sun, 31 May 2009 20:56:35 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
References: <200905312028.02939.florian@openwrt.org>
In-Reply-To: <200905312028.02939.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200905312056.36809.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Sunday 31 May 2009 20:28:02 Florian Fainelli, vous avez écrit :
> In order to get b43 working, we have to register a SPROM
> which provides sane values to calibrate the radio, provide
> GPIO settings and country code. The SSB bus is initialized
> when the PCI bus is registered and expects to find the
> SPROM at init time. Thus we have to move our device
> registration from device_initcall to arch_initcall. The rationale
> behind this comes from Broadcom not providing on-chip
> EEPROM to store such settings, but relying on the main
> system Flash to provide them by software means.

Forgot to mention that it is possible to actually register a fallback SPROM
thanks to Michael's patch, see 
http://marc.info/?l=linux-wireless&m=123575046807993&w=2
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------

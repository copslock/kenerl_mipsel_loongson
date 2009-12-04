Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 15:01:42 +0100 (CET)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:50536 "EHLO
        mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492977AbZLDOBj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 15:01:39 +0100
Received: by ewy24 with SMTP id 24so2807717ewy.26
        for <linux-mips@linux-mips.org>; Fri, 04 Dec 2009 06:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:organization:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=3x5XUb50hKPduza7puEywm1+jxuUzILSxAkD47KWqe4=;
        b=p3nqNpIj2xGx4HAOaMwnPh1TfOSBU+jktaLWKqg5qPP4hlfqDX2t8GhvOBuhI876T6
         DHA9HVXaPzTZuu2MYCOWFgMZzw6CO1ywmmegVJH1qcfx88frPF48V16/gtdmPi/V+eNz
         hJHGnyJ/vswKyrWuZBcMB8FQKh6a3xKPkKU/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :organization:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=GQ3ck+raEDnokwvfXSQZ4VYwzXNSn/02G+9n4T3SP4HukFvW6lKqr24Ogbrh9/uXhT
         g91CAl8gnXWMrNksCRouYtt4l270rivvdh/0iMkIPV1r7MXFkolCbmjFvdSbbdO+cWtU
         NUp/PqnMITPBD2Fpo+QC20bNtRdqMO6gzHpfw=
Received: by 10.213.0.139 with SMTP id 11mr10703663ebb.36.1259935293479;
        Fri, 04 Dec 2009 06:01:33 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 16sm1897182ewy.2.2009.12.04.06.01.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 06:01:31 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] leds: use default-on trigger for Cobalt Qube
Date:   Fri, 4 Dec 2009 15:01:37 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-15-server; KDE/4.3.2; x86_64; ; )
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Martin Michlmayr <tbm@cyrius.com>,
        Sameer Verma <sverma@sfsu.edu>
References: <200911261941.02431.florian@openwrt.org>
In-Reply-To: <200911261941.02431.florian@openwrt.org>
Organization: OpenWrt
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200912041501.37415.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Richard,

Did you get this patch? Thanks.

On Thursday 26 November 2009 19:41:02 Regards, Florian Fainelli wrote:
> This patch changes the default trigger from "ide-disk"
> to "default-on". Users updating from kernels not having this
> LED driver will prefer having the same LED behavior as they
> used to.
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/drivers/leds/leds-cobalt-qube.c
>  b/drivers/leds/leds-cobalt-qube.c index 8816806..81b2014 100644
> --- a/drivers/leds/leds-cobalt-qube.c
> +++ b/drivers/leds/leds-cobalt-qube.c
> @@ -31,7 +31,7 @@ static struct led_classdev qube_front_led = {
>  	.name			= "qube::front",
>  	.brightness		= LED_FULL,
>  	.brightness_set		= qube_front_led_set,
> -	.default_trigger	= "ide-disk",
> +	.default_trigger	= "default-on",
>  };
> 
>  static int __devinit cobalt_qube_led_probe(struct platform_device *pdev)
> 

-- 
Regards, Florian

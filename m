Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jun 2010 17:51:30 +0200 (CEST)
Received: from mail-ww0-f52.google.com ([74.125.82.52]:51328 "EHLO
        mail-ww0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491756Ab0FNPv1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jun 2010 17:51:27 +0200
Received: by wwb28 with SMTP id 28so481957wwb.25
        for <multiple recipients>; Mon, 14 Jun 2010 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=S/C25wSVeTLN1w5Bd8Ucwq7VrS/LzsfT+ijlT4VFYNI=;
        b=LDXBjxx3vYaLV0R2AmY/oK4LZwXSsnIa3VgYLOKd6PfJtwqtz2E6nQxMsFTnBHE/5p
         pEqMNu9WEX/z+vCSn3XetnI2VsVLjIwBcAp6UvSYxfzRPNtjKsGdlDlKbsXjLMyiFmoF
         0FsrXT8KHU682WdWTve9sjndv2n0HhO5+X1Zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EF0KzzedG/ELvdUj41qhEfiUcAvKDrOsTXH7PGYGCNJLp18Wt069KKz2hRmKg0Jgl0
         Eah46Q0IaLFTQpm8E62QyrpPqe/+OVKh7YSWu0A2cEgADZRX7yKlyETo6k/9U3Lp8jW5
         Lk3oLWPKYF582MhrJpyLLSYOfM16Vi2Qnyel8=
Received: by 10.227.68.144 with SMTP id v16mr5827761wbi.156.1276530672670;
        Mon, 14 Jun 2010 08:51:12 -0700 (PDT)
Received: from localhost ([213.79.90.226])
        by mx.google.com with ESMTPS id y31sm37809634wby.10.2010.06.14.08.51.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 08:51:11 -0700 (PDT)
Date:   Mon, 14 Jun 2010 19:51:08 +0400
From:   Anton Vorontsov <cbouatmailru@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 23/26] power: Add JZ4740 battery driver.
Message-ID: <20100614155108.GA30552@oksana.dev.rtsoft.ru>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
 <1275505950-17334-7-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1275505950-17334-7-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cbouatmailru@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9571

On Wed, Jun 02, 2010 at 09:12:29PM +0200, Lars-Peter Clausen wrote:
> This patch adds support for the battery voltage measurement part of the JZ4740
> ADC unit.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> ---

Looks good. I see this is an RFC. Do you want me to apply it
or there's a newer version to be submitted?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

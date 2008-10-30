Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 17:13:17 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.153]:15635 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S22751237AbYJ3RNN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 17:13:13 +0000
Received: by fg-out-1718.google.com with SMTP id d23so574861fga.32
        for <linux-mips@linux-mips.org>; Thu, 30 Oct 2008 10:13:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=1apHrDdzgsXpX7yocXthbc9MsAGssHGA8PG9UC5HVaQ=;
        b=NcJpwOn6GGx+aq/QNGz5Jn3GGKGoV5r3KuKQ8LT13KMYxC78eKZ1Hpbz3mW6ppO5ze
         Nc1p8omRJPhuEOs4MrmBvHgiGasmhG10LhRqffsbqa/22LehLckPGhLmiH7hp6ZJuwio
         CQNDAoNXSJyXtttUnSgRoTfl4gQ2hCtqA/CTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=xMiaUj7iuvfPCrhzUGSjGEZ3pFfMYQB+2+Z9V9DeLa6IApebi/eJ0E5zXCzY8rAoQV
         xomHqCLwRg1kk9tlrYKBVFKfnmwsn1gIZZXQPcqFdl4GtjBbvP/l0bJqFB/Sh6Yrg09X
         2yX0hF9pJPE/0pSE0j474iYo5wgAlCAqHq2Ik=
Received: by 10.181.226.2 with SMTP id d2mr383356bkr.204.1225386790648;
        Thu, 30 Oct 2008 10:13:10 -0700 (PDT)
Received: from florian.headquarters.openpattern.org (headquarters.openpattern.org [82.240.17.188])
        by mx.google.com with ESMTPS id 21sm990362fkx.13.2008.10.30.10.13.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Oct 2008 10:13:09 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] provide functions for gpio configuration
Date:	Thu, 30 Oct 2008 18:13:05 +0100
User-Agent: KMail/1.9.9
Cc:	Linux-Mips List <linux-mips@linux-mips.org>
References: <1225310409-4440-1-git-send-email-n0-1@freewrt.org> <200810292107.43818.florian@openwrt.org> <20081029211046.GC17108@nuty>
In-Reply-To: <20081029211046.GC17108@nuty>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200810301813.05710.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Phil,

Le Wednesday 29 October 2008 22:10:46 Phil Sutter, vous avez écrit :
> Yes it does, but that's not part of gpiolib itself. Accessing them needs
> a combination of gpio_to_chip() and container_of() to be used, which I
> doubt makes sense on a device with a single, platform gpio chip.

Yes, that makes it unexportable the way it is done yet. What I suggest is not 
overriding the struct rb532_gpio_chip with thoses callbacks, but do like you 
suggested initially.

> I'm not sure if this is absolutely true. The original CompactFlash
> driver e.g. clears interrupt level in cf_irq_handler() and sets it in
> prepare_cf_irq(). The latter function is called more than once.

This should be moved the IRQ handler, where a specific check for the IRQ being 
a GPIO one should set the interrupt status and level accordingly.

Thanks.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------

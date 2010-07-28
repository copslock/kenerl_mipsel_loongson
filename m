Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jul 2010 15:24:50 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:40501 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492558Ab0G1NYq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jul 2010 15:24:46 +0200
Received: by eyd10 with SMTP id 10so1190497eyd.36
        for <multiple recipients>; Wed, 28 Jul 2010 06:24:43 -0700 (PDT)
Received: by 10.14.22.10 with SMTP id s10mr1283959ees.22.1280323482314;
        Wed, 28 Jul 2010 06:24:42 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id z55sm9511290eeh.3.2010.07.28.06.24.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 06:24:41 -0700 (PDT)
Message-ID: <4C502F65.2020701@mvista.com>
Date:   Wed, 28 Jul 2010 17:23:49 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/4] MIPS: BCM47xx: Setup and register serial early
References: <1280261566-8247-1-git-send-email-hauke@hauke-m.de> <1280261566-8247-5-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1280261566-8247-5-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Hauke Mehrtens wrote:

> Swap the first and second serial if console=ttyS1 was set.
> Set it up and register it for early serial support.

> This patch has been in OpenWRT for a long time.

> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
[...]
> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 516ac89..a40d88e 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
[...]
> @@ -190,12 +192,45 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
>  
>  void __init plat_mem_setup(void)
>  {
> -	int err;
> +	int i, err;
> +	char buf[100];
> +	struct ssb_mipscore *mcore;
>  
>  	err = ssb_bus_ssbbus_register(&ssb_bcm47xx, SSB_ENUM_BASE,
>  				      bcm47xx_get_invariants);
>  	if (err)
>  		panic("Failed to initialize SSB bus (err %d)\n", err);
> +	mcore = &ssb_bcm47xx.mipscore;
> +
> +	nvram_getenv("kernel_args", buf, sizeof(buf));
> +	if (!strncmp(buf, "console=ttyS1", 13)) {

    Perhaps strstr()? Else you're limiting the console= parameter to always 
come first in the command line...

> +	for (i = 0; i < mcore->nr_serial_ports; i++) {
> +		struct ssb_serial_port *port = &(mcore->serial_ports[i]);
> +		struct uart_port s;
> +
> +		memset(&s, 0, sizeof(s));
> +		s.line = i;
> +		s.mapbase = (unsigned int) port->regs;
> +		s.membase = port->regs;

    Is the MMIO region identity-mapped? Why you have the same value in the 
'mapbase' and 'membase' fields?

WBR, Sergei

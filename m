Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 16:31:09 +0100 (CET)
Received: from smtp2.infineon.com ([217.10.60.23]:33832 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903777Ab1KUPbB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 16:31:01 +0100
X-SBRS: None
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/ADH-AES256-SHA; 21 Nov 2011 16:30:56 +0100
Received: from mucse411.eu.infineon.com (mucse411.eu.infineon.com [172.23.29.21])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 21 Nov 2011 16:30:55 +0100 (CET)
Received: from MUCSE591.eu.infineon.com (172.23.7.80) by
 mucse411.eu.infineon.com (172.23.29.21) with Microsoft SMTP Server (TLS) id
 8.2.247.2; Mon, 21 Nov 2011 16:30:54 +0100
Received: from MUCSE501.eu.infineon.com ([169.254.7.150]) by
 MUCSE591.eu.infineon.com ([172.23.7.80]) with mapi id 14.01.0323.002; Mon, 21
 Nov 2011 16:30:54 +0100
From:   <thomas.langer@lantiq.com>
To:     <blogic@openwrt.org>, <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: RE: [PATCH V2 4/6] MIPS: lantiq: add basic support for FALC-ON
Thread-Topic: [PATCH V2 4/6] MIPS: lantiq: add basic support for FALC-ON
Thread-Index: AQHMqEonPFSp6pJjTkadys9CQuxlZZW3Ytaw
Date:   Mon, 21 Nov 2011 15:30:53 +0000
Message-ID: <0509FD3B91656A408BE277C2D2CD5B3B0FFAAD@MUCSE501.eu.infineon.com>
References: <1321882525-13780-1-git-send-email-blogic@openwrt.org>
 <1321882525-13780-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1321882525-13780-4-git-send-email-blogic@openwrt.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.8.248]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 31880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.langer@lantiq.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17413

Hello John,

I found an issue with the machine_restart function.

> +
> +static void
> +ltq_machine_restart(char *command)
> +{
> +	pr_notice("System restart\n");
> +	local_irq_disable();
> +
> +	/* reboot magic */
> +	ltq_w32(BOOT_PW1, (void *)BOOT_PW1_REG); /* 'LTQ\0' */
> +	ltq_w32(BOOT_PW2, (void *)BOOT_PW2_REG); /* '\0QTL' */
> +	ltq_w32(0, (void *)BOOT_REG_BASE); /* reset Bootreg RVEC */
> +
> +	/* watchdog magic */
> +	ltq_w32(WDT_PW1, (void *)WDT_REG_BASE);
> +	ltq_w32(WDT_PW2 |
> +		(0x3 << 26) | /* PWL */
> +		(0x2 << 24) | /* CLKDIV */
> +		(0x1 << 31) | /* enable */
> +		(1), /* reload */
> +		(void *)WDT_REG_BASE);

The watchdog needs some time for the reset (1 tick of watchdog but many
ticks of the cpu). With unreachable(), there is no valid code after the
register access. Please add some loop like
	while(1)
		;
here (and a comment).

> +	unreachable();
> +}

Can you please create and send an updated patch?

Thanks,
Thomas

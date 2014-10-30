Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 12:09:34 +0100 (CET)
Received: from mail-la0-f42.google.com ([209.85.215.42]:56877 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012281AbaJ3LJcv4bE7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 12:09:32 +0100
Received: by mail-la0-f42.google.com with SMTP id gq15so4186872lab.29
        for <linux-mips@linux-mips.org>; Thu, 30 Oct 2014 04:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=MNNZg2nxh3+dwEYzyO9D+s1Iff9cZep918jM/EoHSzk=;
        b=bWUAGs7EbdtPScFRiHv/b9NdmJQoCD9uCmyylqAkWknBQaqFtAmG/0saNeIyVOipL+
         IXLU1R/NDW4Dd4fmn6MHpnCCTdsxtkAJygMrL/NEbEZjy9o2O2jpb8ySRe5h+kbZwQ0P
         r32BY92Ri6U97BcS0A65APrvj1RwHSwvj81PpeNW5TWYKFZt5yaUPjgEHrqn8a/4PAnj
         YjMlfyZaPOzt4Sy3Omc/39QmcgWUlpeAuU+QT/7gUTANLzVXZGEmgTzjqYNItIQt8DIN
         xsBjzEY0EoXe4fTEBk4gknVT/00hpslUpSU5a+Jze1GAPZyMZKg0tZccEMhJH9QTfzvS
         Griw==
X-Gm-Message-State: ALoCoQni7VhZRopPtu5pFKUr57gnIldr2hA9J6o/8wDytDKsJ2ecAhGjQ+U0pfrJTOzljQXwufPI
X-Received: by 10.112.170.99 with SMTP id al3mr16722939lbc.17.1414667367140;
        Thu, 30 Oct 2014 04:09:27 -0700 (PDT)
Received: from [192.168.2.5] (ppp21-199.pppoe.mtu-net.ru. [81.195.21.199])
        by mx.google.com with ESMTPSA id r4sm3082028lar.3.2014.10.30.04.09.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2014 04:09:26 -0700 (PDT)
Message-ID: <54521C65.8060603@cogentembedded.com>
Date:   Thu, 30 Oct 2014 14:09:25 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, arnd@arndb.de,
        f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, lethal@linux-sh.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 08/15] irqchip: bcm7120-l2: Eliminate bad IRQ check
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-9-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414635488-14137-9-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello.

On 10/30/2014 5:18 AM, Kevin Cernekee wrote:

> This check may be prone to race conditions, e.g.

> 1) Some external event (e.g. GPIO level) causes an IRQ to become pending
> 2) Peripheral asserts the L2 IRQ
> 3) CPU takes an interrupt
> 4) The event from #1 goes away
> 5) bcm7120_l2_intc_irq_handle() reads back a 0 status

> Unlike the hardware supported by brcmstb-l2, the bcm7120-l2 controller
> does not latch the IRQ status.  Bits can change if the inputs to the
> controller change.  Also, do_bad_IRQ() is an ARM-specific macro.

> So let's just nuke it.

> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/irqchip/irq-bcm7120-l2.c | 9 ---------
>   1 file changed, 9 deletions(-)

> diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
> index b9f4fb8..49d8f3d 100644
> --- a/drivers/irqchip/irq-bcm7120-l2.c
> +++ b/drivers/irqchip/irq-bcm7120-l2.c
[...]
> @@ -51,19 +49,12 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
>   	chained_irq_enter(chip, desc);
>
>   	status = __raw_readl(b->base + IRQSTAT);
> -
> -	if (status == 0) {
> -		do_bad_IRQ(irq, desc);
> -		goto out;
> -	}
> -
>   	do {

    I think this needs to now become:

	while (status) {

>   		irq = ffs(status) - 1;
>   		status &= ~(1 << irq);

    In case 'status' is 0, 'irq' will be equal to -1. How does the shift by 
negative value work?

>   		generic_handle_irq(irq_find_mapping(b->domain, irq));
>   	} while (status);

WBR, Sergei

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 17:04:43 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60569 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827652Ab3BOQEbTMftK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 17:04:31 +0100
Message-ID: <511E5BD9.1040407@openwrt.org>
Date:   Fri, 15 Feb 2013 17:01:29 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: Re: [PATCH 04/11] MIPS: ath79: add IRQ handling code for the QCA955X
 SoCs
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org> <1360939105-23591-5-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1360939105-23591-5-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>


>
>   	if (soc_is_ar71xx() || soc_is_ar913x())
>   		ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
> -	else if (soc_is_ar724x() || soc_is_ar933x() || soc_is_ar934x())
> +	else if (soc_is_ar724x() ||
> +		 soc_is_ar933x() ||
> +		 soc_is_ar934x() ||
> +		 soc_is_qca955x())
>   		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
Hi,

the list is getting long. not a blocker but might be worth thinking of a 
different way to solve the different revisions of the irq core


> +	if (status&  QCA955X_EXT_INT_USB1) {
> +		/* TODO: flush DDR? */
> +		generic_handle_irq(ATH79_IP3_IRQ(0));
> +	}
> +
> +	if (status&  QCA955X_EXT_INT_USB2) {
> +		/* TODO: flsuh DDR? */
> +		generic_handle_irq(ATH79_IP3_IRQ(1));
> +	}

flsuh typo


     John

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 18:26:53 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:33561 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827653Ab3BOR0wSFpIy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 18:26:52 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0crYfCOyq23N; Fri, 15 Feb 2013 18:26:41 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 289482801AE;
        Fri, 15 Feb 2013 18:26:41 +0100 (CET)
Message-ID: <511E6FD4.6060802@openwrt.org>
Date:   Fri, 15 Feb 2013 18:26:44 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: Re: [PATCH 04/11] MIPS: ath79: add IRQ handling code for the QCA955X
 SoCs
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org> <1360939105-23591-5-git-send-email-juhosg@openwrt.org> <511E5BD9.1040407@openwrt.org>
In-Reply-To: <511E5BD9.1040407@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 35772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.02.15. 17:01 keltezéssel, John Crispin írta:
> 
>>
>>       if (soc_is_ar71xx() || soc_is_ar913x())
>>           ath79_misc_irq_chip.irq_mask_ack = ar71xx_misc_irq_mask;
>> -    else if (soc_is_ar724x() || soc_is_ar933x() || soc_is_ar934x())
>> +    else if (soc_is_ar724x() ||
>> +         soc_is_ar933x() ||
>> +         soc_is_ar934x() ||
>> +         soc_is_qca955x())
>>           ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
> Hi,
> 
> the list is getting long. not a blocker but might be worth thinking of a
> different way to solve the different revisions of the irq core

This code runs only once, so it is not worth the effort IMHO.

If I would introduce a table to store the revision of the IRQ core, I would have
to put a value into that for each different SoC. That means 15 entries at the
moment.

Alternatively I can introduce a global variable to store the revision, and
intialize that variable from the SoC detection code. However I would have to set
that variable individually for each SoC and that means 15 lines of code.


>> +    if (status&  QCA955X_EXT_INT_USB1) {
>> +        /* TODO: flush DDR? */
>> +        generic_handle_irq(ATH79_IP3_IRQ(0));
>> +    }
>> +
>> +    if (status&  QCA955X_EXT_INT_USB2) {
>> +        /* TODO: flsuh DDR? */
>> +        generic_handle_irq(ATH79_IP3_IRQ(1));
>> +    }
> 
> flsuh typo

Yep, will fix it.

Thanks,
Gabor

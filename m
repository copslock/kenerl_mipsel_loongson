Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 17:42:29 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:53697 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827496Ab3BOQm2lKtRt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 17:42:28 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id As9vFoI_TWBu; Fri, 15 Feb 2013 17:42:17 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 4B0DE2801AE;
        Fri, 15 Feb 2013 17:42:17 +0100 (CET)
Message-ID: <511E656C.5080501@openwrt.org>
Date:   Fri, 15 Feb 2013 17:42:20 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "Rodriguez, Luis" <rodrigue@qca.qualcomm.com>,
        "Giori, Kathy" <kgiori@qca.qualcomm.com>,
        QCA Linux Team <qca-linux-team@qca.qualcomm.com>
Subject: Re: [PATCH 02/11] MIPS: ath79: add SoC detection code for the QCA955X
 SoCs
References: <1360939105-23591-1-git-send-email-juhosg@openwrt.org> <1360939105-23591-3-git-send-email-juhosg@openwrt.org> <511E5BB8.8060800@openwrt.org>
In-Reply-To: <511E5BB8.8060800@openwrt.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 35770
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

2013.02.15. 17:00 keltezéssel, John Crispin írta:
> 
>>
>> -    sprintf(ath79_sys_type, "Atheros AR%s rev %u", chip, rev);
>> +    if (soc_is_qca955x())
>> +        sprintf(ath79_sys_type, "Qualcomm Atheros QCA%s rev %u",
>> +            chip, rev);
>> +    else
>> +        sprintf(ath79_sys_type, "Atheros AR%s rev %u", chip, rev);
>>       pr_info("SoC: %s\n", ath79_sys_type);
>>   }
>>   
> Hi,
> 
> maybe a soc_is_qca() could be used here, otherwise you will need to patch this
> line again for the next SoC and so on ....

Hm, if I would add a soc_is_qca() macro, I would have to patch that macro for
the next SoCs instead of this line.

Maybe it would be better to add the AR/QCA prefix to each chip name, and use
'Qualcomm Atheros' unconditionally in the sprintf call?

-Gabor

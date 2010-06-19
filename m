Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 20:00:33 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:38095 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491865Ab0FSSA2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 20:00:28 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 25E483A4;
        Sat, 19 Jun 2010 20:00:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id t8o5zuOnyB6e; Sat, 19 Jun 2010 20:00:22 +0200 (CEST)
Received: from [172.31.16.228] (d044235.adsl.hansenet.de [80.171.44.235])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 656583A3;
        Sat, 19 Jun 2010 20:00:05 +0200 (CEST)
Message-ID: <4C1D0587.7030308@metafoo.de>
Date:   Sat, 19 Jun 2010 19:59:35 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Jean Delvare <khali@linux-fr.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add JZ4740 ADC driver
References: <1276924111-11158-24-git-send-email-lars@metafoo.de>        <1276958820-8862-1-git-send-email-lars@metafoo.de> <20100619182410.171856ae@hyperion.delvare>
In-Reply-To: <20100619182410.171856ae@hyperion.delvare>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13591

Hi

Jean Delvare wrote:
> Hi Lars-Peter,
>
> On Sat, 19 Jun 2010 16:47:00 +0200, Lars-Peter Clausen wrote:
>   
>> This patch adds support for reading the ADCIN pin of ADC unit on JZ4740 SoCs.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: lm-sensors@lm-sensors.org
>>
>> --
>> Changes since v1
>> - Move ADC core access synchronizing from the HWMON driver to a MFD driver. The
>>   ADC driver now only reads the adcin value.
>> Changes since v2
>> - Add name sysfs attribute
>> - Report adcin in value in millivolts
>>     
>
> Changes look good. A few more comments below; other than these, your
> driver look good, and I can add it to my hwmon tree and schedule it for
> 2.6.36 if you want.
>   
Great thanks :)
As written in the introduction mail to this thread it would be good if
the majority of the patches could go through Ralfs tree. So if you don't
see any problems doing this, it would be nice if you could give your
Acked-By once I sent a updated patch.

- Lars

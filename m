Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 13:00:39 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:42821 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490995Ab1FFLAf convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 13:00:35 +0200
Received: by qwi2 with SMTP id 2so2071568qwi.36
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g3a68JGgAoCoxXg8BlCkX4SRBq/EDK7rMpFLEzJHblI=;
        b=rrbDtHFJcGp+HFB9tLvXEFPYHhrFKonU6aFFQdxhY8sL5cbKH57uMRyE50XyGjJez2
         UtylmCKhuW5S3dkl73MswIR4I0eTa0v4qr4lr7vHxmsDH2SGrIIWjDKE7GaPz5hF01Ol
         IOi2PQlTVOLBpsSj0V1/MF8XJQhQqVAWAiP5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hLcUwJHvUxgu/vCOx2gei21yzCnxGGfOgSls/BaRqzlGmNRRvjEwPY+o5ZkHIJg92c
         TJyIimDdR9GoxuwiX1vcz5xY2i+NQHZKi8Y0PboIZbPlbg519i+lmoT1xbERMg/JuKOi
         BcStGymhhBHn5UciQGvPYbn5LKs6PElI0hrUU=
MIME-Version: 1.0
Received: by 10.229.43.99 with SMTP id v35mr3446500qce.8.1307358029361; Mon,
 06 Jun 2011 04:00:29 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 04:00:29 -0700 (PDT)
In-Reply-To: <4DECB232.70308@broadcom.com>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-4-git-send-email-hauke@hauke-m.de>
        <BANLkTi=T6xO9q+vOCk5Fu+2J_nUTwX3dcg@mail.gmail.com>
        <1307356322.28734.11.camel@dev.znau.edu.ua>
        <BANLkTimkKFAEfbKaWo81=uyuDS=gjESHAw@mail.gmail.com>
        <4DECB232.70308@broadcom.com>
Date:   Mon, 6 Jun 2011 13:00:29 +0200
Message-ID: <BANLkTimAtq+8EmTckqytL+WyaVigNYfQwA@mail.gmail.com>
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     George Kashperko <george@znau.edu.ua>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4112

W dniu 6 czerwca 2011 12:55 użytkownik Arend van Spriel
<arend@broadcom.com> napisał:
> On 06/06/2011 12:51 PM, Rafał Miłecki wrote:
>>
>> W dniu 6 czerwca 2011 12:32 użytkownik George Kashperko
>> <george@znau.edu.ua>  napisał:
>>>
>>> Hi,
>>>
>>>> Hauke,
>>>>
>>>> My idea for naming schema was to use:
>>>> bcma_host_TYPE_*
>>>>
>>>> Like:
>>>> bcma_host_pci_*
>>>> bcma_host_sdio_*
>>>>
>>>> You are using:
>>>> bcma_host_bcma_*
>>>>
>>>> What do you think about changing this to:
>>>> bcma_host_embedded_*
>>>> or just some:
>>>> bcma_host_emb_*
>>>> ?
>>>>
>>>> Does it make more sense to you? I was trying to keep names in bcma
>>>> really clear, so every first-time-reader can see differences between
>>>> hosts, host and driver, etc.
>>>
>>> how about bcma_host_soc ?
>>
>> We get then inconsistency with "BCMA_HOSTTYPE_EMBEDDED". I'd like to
>> 1) See something like bcma_host_emb...
>> xor
>> 2) Use bcma_host_soc_* and BCMA_HOSTTYPE_SOC
>>
>
> I would go for option 2). It more clearly says what it is. Embedded is a
> broader term. As an example, a handset is an embedded device, but it may use
> BCMA_HOSTTYPE_SDIO.

Good point, agree.

-- 
Rafał

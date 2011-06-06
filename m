Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 12:40:19 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:36302 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFKkQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 12:40:16 +0200
Received: by qwi2 with SMTP id 2so2063949qwi.36
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 03:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pa7u+Qq1FYpCR4COrWNYJvtK1mO0sOEaVw5owJ5KkCg=;
        b=BVAIWJ+atMbLRFbeKYuhM8RhkPzzdyK8S3GGCIp3oH7PPxqEWdiYSh0w3I+5oVqw0t
         BIZ2wKpjhs5s6rM3y5F/WAiCqv9Exbu8mxfmGOP4pcs2Z81NbEviN5ArPROXx3az50UD
         xFPkTt5tHzRU9ar/oq3FqE1J9ip0WfvvDIyfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JBrV/hSo/G51C21t53F93DSVv/hlDY/AhvOVCKFqL9W1b6/yB99POxVcSvlyzOFDUo
         t4gEaKcG7Wbmd2sTAdoWl/xfXDpDV4BRy2yCMQyq9GyTHI9+ELLKvKKOxwgdd6aW4qNs
         JvKsAoDTBXMkYbYg/E4EiLTSa4rOjbQwGG7gg=
MIME-Version: 1.0
Received: by 10.229.35.1 with SMTP id n1mr3392977qcd.84.1307356810634; Mon, 06
 Jun 2011 03:40:10 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 03:40:10 -0700 (PDT)
In-Reply-To: <BANLkTim74Km0T3XRo+W8jCrb2n-dv3XxNg@mail.gmail.com>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-7-git-send-email-hauke@hauke-m.de>
        <BANLkTim74Km0T3XRo+W8jCrb2n-dv3XxNg@mail.gmail.com>
Date:   Mon, 6 Jun 2011 12:40:10 +0200
Message-ID: <BANLkTimdAoB=ye27qfxzdj2K-VBS6ch+ow@mail.gmail.com>
Subject: Re: [RFC][PATCH 06/10] bcma: get CPU clock
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4092

W dniu 6 czerwca 2011 12:34 użytkownik Rafał Miłecki <zajec5@gmail.com> napisał:
> 2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
>> +u32 bcma_cpu_clock(struct bcma_drv_mips *mcore)
>> +{
>> +       struct bcma_bus *bus = mcore->core->bus;
>> +
>> +       if (bus->drv_cc.capabilities & BCMA_CC_CAP_PMU)
>> +               return bcma_pmu_get_clockcpu(&bus->drv_cc);
>> +
>> +       pr_err("No PMU available, need this to get the cpu clock\n");
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(bcma_cpu_clock);
>
> Are you really going to use this in some separated driver? If you're,
> I heard that exporting symbol should go in pair with patch enabling
> usage of such a symbol.

I've just read patch 09/10, sorry for the noise :)

-- 
Rafał

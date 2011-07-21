Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 01:04:17 +0200 (CEST)
Received: from mail-pz0-f47.google.com ([209.85.210.47]:57169 "EHLO
        mail-pz0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491809Ab1GUXEN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jul 2011 01:04:13 +0200
Received: by pzk36 with SMTP id 36so2635399pzk.34
        for <multiple recipients>; Thu, 21 Jul 2011 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=W6mFYfu+/QZTIyM9HjMNLrw1TvxxMZzc8gpkX1C+TX0=;
        b=sMpve5rI5ppfffO2z4l+N3tStwFM/c1RwmcEQOKDdz1xVUIXVUdQwQFEJ1KaPTrtFn
         ib7n+uCGHm1P+RBrTTa+YZk+oy975tk1bkmH3xAeAEe/GxQKLRe5aijNXcwDaD8uKkiE
         LoL+LdQKeRsRw4FKo4huDH67h7VHVoQYUtLpI=
MIME-Version: 1.0
Received: by 10.68.13.193 with SMTP id j1mr1051136pbc.384.1311289446834; Thu,
 21 Jul 2011 16:04:06 -0700 (PDT)
Received: by 10.68.49.98 with HTTP; Thu, 21 Jul 2011 16:04:06 -0700 (PDT)
In-Reply-To: <CACna6ryPABAx87b2+-gsTY5a5_qHTo61Otre-Pm+vYH8ad9hNg@mail.gmail.com>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
        <1310835342-18877-4-git-send-email-hauke@hauke-m.de>
        <CACna6ryPABAx87b2+-gsTY5a5_qHTo61Otre-Pm+vYH8ad9hNg@mail.gmail.com>
Date:   Fri, 22 Jul 2011 01:04:06 +0200
Message-ID: <CACna6rxRjxEoh+nrkk_3w5p18DkOb8G2qFGsKkK3tmLCCM1ivQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] bcma: add functions to scan cores needed on SoCs
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jonas.gorski@gmail.com, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15606

W dniu 22 lipca 2011 00:35 użytkownik Rafał Miłecki <zajec5@gmail.com> napisał:
> 2011/7/16 Hauke Mehrtens <hauke@hauke-m.de>:
>> @@ -159,5 +159,8 @@ static void bcma_pcicore_serdes_workaround(struct bcma_drv_pci *pc)
>>
>>  void bcma_core_pci_init(struct bcma_drv_pci *pc)
>>  {
>> +       if (pc->setup_done)
>> +               return;
>>        bcma_pcicore_serdes_workaround(pc);
>> +       pc->setup_done = true;
>>  }
>
> This won't apply to the upstream driver_pci.c. Fix is obvious for me
> and you, but could be nice to don't bother John/Ralf.

Acked-by: Rafał Miłecki <zajec5@gmail.com>
After you rebase patch.

Please, be careful about this place. "git am" takes it as fuzzy and
applied in the incorrect place!

-- 
Rafał

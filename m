Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 14:48:46 +0100 (CET)
Received: from mail-yw0-x242.google.com ([IPv6:2607:f8b0:4002:c05::242]:33713
        "EHLO mail-yw0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991955AbdARNskK8Lo7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 14:48:40 +0100
Received: by mail-yw0-x242.google.com with SMTP id u68so1036681ywg.0
        for <linux-mips@linux-mips.org>; Wed, 18 Jan 2017 05:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q1rdMlIJ2SOT+JPNqQOb48OXsOMp46PnuoyARnFjoKI=;
        b=j2Sov+QcN9y5fly+IY9kOE8l09ePkgRc1k551CTMQcbnh+ozW3dEwwXmv+wjrKW/lV
         pbFO3I/N8pNa5L4gOGdp1Vq+xDeEN3e7NSKnm6/PTnT0eNcCzIhd85YLR+ZJyNdAwPWs
         ISeiSlyJ0jDvCU4gS4iA/rUcNjh7dhuGNITPO1mQ6xr6/uhcRjv33BqzoddZlLfYAmny
         xl7gwgYBZL7ZeXz/pclR7gVA3K+BnhSQsLRAow0CSwMRrwUdUGf5DU7SRcSQ6ddqHW/k
         NvoI0Cw84GNvqck3Inhgy8TVLw9bOnHOZTfrS7tr5iW2KPEg8uSJ4ZRIKFgHI+NI/ljC
         IoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q1rdMlIJ2SOT+JPNqQOb48OXsOMp46PnuoyARnFjoKI=;
        b=tRw3G6yNlocP77Odvio5eIkxmrGWw6L4it9ZeiTpoItksuHhR0r4bI9OzliFLwOO0H
         3eOfsqnAoMzTCexYpfkCMxBnNptg3cSj/0c1S8WkdBRz/blr97d/xI9RO7QGTMgZPc7f
         IwfERsLITHF4GyLDDBHO90isBWBqZyZ30mApe92B+HS57gw5FS3SSVm4/dYUQ763ZQMl
         +IQ6yKh5SKIi/Z5l5PcDGdgOpftdG5HX52EDUrjg+eetwzQOiBfE3LEJ8diPbZvPYStO
         wkDK8rtrf4Z0AN9UqEMFqV+J/mdnQG0o+whwOSsFQjMEkzolfwdw3YwToXwbei7ofI+p
         zV/g==
X-Gm-Message-State: AIkVDXKA8d6wEu5l1fQIyTEsVw10SaBGIzc0OMDEA67o81pWqS8ysrizj9EJ1OooiMpt3Iy+ySz3x1p9HFMJ4g==
X-Received: by 10.13.212.149 with SMTP id w143mr2798636ywd.180.1484747314363;
 Wed, 18 Jan 2017 05:48:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.192.68 with HTTP; Wed, 18 Jan 2017 05:48:33 -0800 (PST)
In-Reply-To: <e5bb2245-a0d0-5b66-2c75-9af26c6ea846@phrozen.org>
References: <1484741452-27141-1-git-send-email-sebtx452@gmail.com> <e5bb2245-a0d0-5b66-2c75-9af26c6ea846@phrozen.org>
From:   Seb <sebtx452@gmail.com>
Date:   Wed, 18 Jan 2017 14:48:33 +0100
Message-ID: <CA+hF=GeD0dhBUkR+wR_35pSXgSnU0kW6EfYWa9h2QrGOTReMnA@mail.gmail.com>
Subject: Re: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap
 is enabled
To:     John Crispin <john@phrozen.org>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <sebtx452@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebtx452@gmail.com
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

Hi John,


>>
>>       ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;
>
> this line should be dropped

Yes, I noticed this mistake. I fixed it but forgotten to add thix fix
to my commit -_-

>> +     /* We swap the addresses only if the EBU endianness swap is disabled */
>> +     if (ltq_ebu_r32(LTQ_EBU_BUSCON0) & BIT(30))
>
> add a define for BIT(30) please and we should really check if this a
> v1.2 or newer. if my memory is correct this was a silicon bug inside
> v1.0 and v1.1

In my kernel (OpenWrt) boot log I have :

[    0.000000] Linux version 4.4.14 (qa@serveurQA) (gcc version 5.3.0
(OpenWrt GCC 5.3.0 50020) ) #150 SMP Tue Jan 17 09:18:24 UTC 2017
[    0.000000] SoC: xRX200 rev 1.2
[    0.000000] bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)

It would be better to ensure that the SoC version is >= 1.2 (as this
bug was fixed in this version).

You can get more informations in my OpenWrt pull request :

https://github.com/openwrt/openwrt/pull/321


Regards,

Sebastien.

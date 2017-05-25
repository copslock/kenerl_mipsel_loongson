Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 May 2017 08:21:26 +0200 (CEST)
Received: from mail-vk0-x242.google.com ([IPv6:2607:f8b0:400c:c05::242]:33947
        "EHLO mail-vk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdEYGVTw58H5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 May 2017 08:21:19 +0200
Received: by mail-vk0-x242.google.com with SMTP id w1so10675393vkd.1;
        Wed, 24 May 2017 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VpnuCWciPuTcYKHVTXhtY7ee5SQRigl/7lUWlqF9xaA=;
        b=txtw9ZOPYw6fyWDyhZb1dD9SZQV8568j+gCMMYYRlFKmS/u3pj4A0mNBCALuQtm4wd
         5EE9pMRpuxIk26jn1tFoqoK9h3itcBs6VAm0LfcpblWIkyCPJHRlhrGPJAzJsmP8j9Wr
         HR5aqhC5qYYQeRVWU9PHPO7Olas/IQbzkQlGmgCItTiydsUxnDGhyqMvwTnGJZPzpXP9
         7zUJsJOPMP+ALiPAB+YNxfczozPtibOAVV8x1DT5j1fWekex0bwPmumqupOwhzIKUc0d
         0NG/Xdz6VstU+wkinS2JkxLuZYel7npIIqysAoA308EowdYMACE1OG4tTSfPWZ5RdpPZ
         bCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VpnuCWciPuTcYKHVTXhtY7ee5SQRigl/7lUWlqF9xaA=;
        b=g0GrPLu/ZI+6fl6q9k8LpvsVdeZqL7gn7fxXrTKxXheZEfuXoOUgzSuhMDcUaPQL1p
         B1NLGQjsLO0YSHvhW6Juo14GdQXcfsw/sAt9488IeIzJJzxCFvZrojyempVuM94VVDFe
         7SbSroNDTqB88vDSqbyB6O+q2E2NKJkyWujtBa5nRFNOTH/Pgh+tgR3CQvRXUVkbWsUx
         DK2ELswIbWGPRl7j1k7cQwDl0tKGtOIhpP9P3NomrZqoE5SVerTNm8r5pVYT0bbo5mbj
         xkUYrm44fF8PHwoRcrg6s/kDYCYhqEDxH4/AZDBGIks0P9lh6UdadUDDhIrp2oc25RSc
         Q/8g==
X-Gm-Message-State: AODbwcASQ2fCZGqbCVZpGEHkt3bH84cApm3uwmfhFCjaCEuwEMDcYM1t
        J6tQCVw3Z1ISgcGTadjtYZZseaNayw==
X-Received: by 10.31.97.133 with SMTP id v127mr13686825vkb.16.1495693274051;
 Wed, 24 May 2017 23:21:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.68.135 with HTTP; Wed, 24 May 2017 23:20:33 -0700 (PDT)
In-Reply-To: <796029e7-60a3-a94b-8b5c-4686a0656560@users.sourceforge.net>
References: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
 <CAOLZvyHq-7q0XxiBsyX3q0g0J3kjfFv4SU7amX1hpjRDyK+feQ@mail.gmail.com> <796029e7-60a3-a94b-8b5c-4686a0656560@users.sourceforge.net>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 25 May 2017 08:20:33 +0200
Message-ID: <CAOLZvyH-DF_r77kzcVcn+A-tTov+aNZ1oGNQLnGWXE35UODqtQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: Delete an error message for a failed
 memory allocation in alchemy_pci_probe()
To:     SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?B?UmFsZiBCw6RjaGxl?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Wed, May 24, 2017 at 8:15 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> +++ b/arch/mips/pci/pci-alchemy.c
>>> @@ -377,7 +377,6 @@ static int alchemy_pci_probe(struct platform_device *pdev)
>>>
>>>         ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>>>         if (!ctx) {
>>> -               dev_err(&pdev->dev, "no memory for pcictl context\n");
>>>                 ret = -ENOMEM;
>>>                 goto out;
>>>         }
>>> --
>>> 2.13.0
>>
>> Why are you removing just this one dev_err()?
>
> How do you think about to achieve a small code reduction also for this software module?

Generally speaking, sure.  But why remove just this one?  Is it
because it loosely follows a
pattern that was deemed removable in that slidedeck you linked to?
(the "usb_submit_urb()" part)?


>> What issue are you trying to address?
>
> Do you find information from a Linux allocation failure report sufficient
> for such a function implementation?

Yes, I wrote that code, and in case this driver doesn't load, I'd like
to know precisely where
initialization failed.  I can happily spare a few bytes for that.

Manuel

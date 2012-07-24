Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2012 17:37:12 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:40048 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903773Ab2GXPhE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2012 17:37:04 +0200
Received: by yhjj52 with SMTP id j52so7242636yhj.36
        for <multiple recipients>; Tue, 24 Jul 2012 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oszyrvpLbtyymrJWYojdfquT31F6+AbqEd7llvr2IH0=;
        b=cDemOVWpfeZZmLO64TkIW2PLbSQi9+M+o2540HrVjS6LT9+9ah8UYH6uem78+3Ha59
         Lw09mxEbvcgZxmJ29T4tIPzlwIWVDY2axeeLI6f1m6GAuRxfeOcYkcEctZVNInJV0lUg
         ttB8vfouuVm6c8ntTV9cwRxv9PZtaO1mBiHz1p5Q8yxyxGyjL/X9z9e1DNuvHPJeJ6FJ
         4JUQdzuMA5/WDe7lolDYMxwmEAJSr4KucJy9DsMbcGVkMICDnuRTXo7VPB6ZR1zohxzh
         wDshotxAUIozPZdbyTHuEzLENcTMRx5qNGcsm6U9S2Jzy9B+q1+bjZDa3QkEYmm2unnv
         h/BA==
Received: by 10.101.176.15 with SMTP id d15mr1875574anp.65.1343144218290; Tue,
 24 Jul 2012 08:36:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.92.208 with HTTP; Tue, 24 Jul 2012 08:36:18 -0700 (PDT)
In-Reply-To: <500EBE6F.5030208@einfach.org>
References: <1342126445-13408-1-git-send-email-br1@einfach.org>
 <500EBB99.5050209@einfach.org> <CAOLZvyEvV7EQtZAQrzh8Ui-MD9BDXcdFGG6u6uQVeLQ6pqU6JQ@mail.gmail.com>
 <500EBE6F.5030208@einfach.org>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Tue, 24 Jul 2012 17:36:18 +0200
Message-ID: <CAOLZvyHhkrZrbEKz_hDLjtH5F28YrQqjxO46OrYfKtwL56ByCw@mail.gmail.com>
Subject: Re: [PATCH] mtx-1: add udelay to mtx1_pci_idsel
To:     Bruno Randolf <br1@einfach.org>
Cc:     linux-mips@linux-mips.org, manuel.lauss@googlemail.com,
        ralf@linux-mips.org, florian@openwrt.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 33967
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Jul 24, 2012 at 5:25 PM, Bruno Randolf <br1@einfach.org> wrote:
> On 07/24/2012 04:20 PM, Manuel Lauss wrote:
>>
>> On Tue, Jul 24, 2012 at 5:13 PM, Bruno Randolf <br1@einfach.org> wrote:
>>>
>>> Hello? Any feedback?
>>>
>>> I know the description is not very good, but this patch is necessary for
>>> PCI
>>> to work on the Surfbox.
>>>
>>> Thanks,
>>> bruno
>>>
>>>
>>> On 07/12/2012 09:54 PM, Bruno Randolf wrote:
>>>>
>>>>
>>>> Without this udelay(1) PCI idsel does not work correctly on the
>>>> "singleboard"
>>>> (T-Mobile Surfbox) for the MiniPCI device. The result is that PCI
>>>> configuration
>>>> fails and the MiniPCI card is not detected correctly. Instead of
>>>>
>>>> PCI host bridge to bus 0000:00
>>>> pci_bus 0000:00: root bus resource [mem 0x40000000-0x4fffffff]
>>>> pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
>>>> pci 0000:00:03.0: BAR 0: assigned [mem 0x40000000-0x4000ffff]
>>>> pci 0000:00:00.0: BAR 0: assigned [mem 0x40010000-0x40010fff]
>>>> pci 0000:00:00.1: BAR 0: assigned [mem 0x40011000-0x40011fff]
>>>>
>>>> We see only the CardBus device:
>>>>
>>>> PCI host bridge to bus 0000:00
>>>> pci_bus 0000:00: root bus resource [mem 0x40000000-0x4fffffff]
>>>> pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
>>>> pci 0000:00:00.0: BAR 0: assigned [mem 0x40000000-0x40000fff]
>>>> pci 0000:00:00.1: BAR 0: assigned [mem 0x40001000-0x40001fff]
>>>>
>>>> Later the device driver shows this error:
>>>>
>>>> ath5k 0000:00:03.0: cannot remap PCI memory region
>>>> ath5k: probe of 0000:00:03.0 failed with error -5
>>>>
>>>> I assume that the logic chip which usually supresses the signal to the
>>>> CardBus
>>>> card has some settling time and without the delay it would still let the
>>>> Cardbus interfere with the response from the MiniPCI card.
>>>>
>>>> What I cannot explain is why this behaviour shows up now and not in
>>>> earlier
>>>> kernel versions before. Maybe older PCI code was slower?
>>>>
>>>> Signed-off-by: Bruno Randolf <br1@einfach.org>
>>>> ---
>>>>    arch/mips/alchemy/board-mtx1.c |    2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/mips/alchemy/board-mtx1.c
>>>> b/arch/mips/alchemy/board-mtx1.c
>>>> index 295f1a9..e107a2f 100644
>>>> --- a/arch/mips/alchemy/board-mtx1.c
>>>> +++ b/arch/mips/alchemy/board-mtx1.c
>>>> @@ -228,6 +228,8 @@ static int mtx1_pci_idsel(unsigned int devsel, int
>>>> assert)
>>>>           * adapter on the mtx-1 "singleboard" variant. It triggers a
>>>> custom
>>>>           * logic chip connected to EXT_IO3 (GPIO1) to suppress IDSEL
>>>> signals.
>>>>           */
>>>> +       udelay(1);
>>>> +
>>>>          if (assert && devsel != 0)
>>>>                  /* Suppress signal to Cardbus */
>>>>                  alchemy_gpio_set_value(1, 0);   /* set EXT_IO3 OFF */
>>>>
>>
>> Why don't you increase the delay value in the udelay() immediately
>> following
>> this part?
>
>
> Yes that would be logical and was my first try. Unfortunately it does not
> work. It's weird, but the delay needs to be before as well.

I don't get it.  I suppose the activation phase of the signal is too short, yes?
Maybe a _much_ larger value (100/1000) would do the trick?   Do you have an
oscilloscope to check the duty cycle?

Manuel

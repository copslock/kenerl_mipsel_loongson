Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Oct 2015 22:44:03 +0200 (CEST)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36543 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007295AbbJXUoAvpA28 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Oct 2015 22:44:00 +0200
Received: by oiao187 with SMTP id o187so82392945oia.3;
        Sat, 24 Oct 2015 13:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=VJYBJyDzQzpf/FOO3A3ce/YINznUUtpwZYn4Ofq0qEE=;
        b=uK+2ydE9pkJiMjc/kNyjZK0u7S/bJ5kj025q1UiREUvHqygP3wtaXB6YXEsRmAqC1h
         p81FrPPl3qcofFFk1ps1V0AF6BCBlegygGOhOHCiOO8JQn44CMyL5DTmYoQFHZnj9mhk
         UBNJ15FVKrRckzFc9w87WfxYMjEraX3GiHb/d/Tj+Mf+QEEynjPFraooYnTpp/keLutQ
         7AAe2Jwbqj8Ild+JDgAYvQnL2he1XFwP9L/vGlfZzfPg3RwIRKxReSuqlXWLVZuJ0HI+
         Bn9Yn3xmnoj9v5j+J35ul+pcZmE8yTbYQAxEZVvH/kiF1izqK9Y2DGVE1iNjqeu28tSJ
         LDvw==
X-Received: by 10.202.177.9 with SMTP id a9mr18501226oif.16.1445719434793;
        Sat, 24 Oct 2015 13:43:54 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:c883:e5d9:4cb0:9a4b? ([2001:470:d:73f:c883:e5d9:4cb0:9a4b])
        by smtp.googlemail.com with ESMTPSA id wa2sm11133573oeb.2.2015.10.24.13.43.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Oct 2015 13:43:54 -0700 (PDT)
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
To:     Jaedon Shin <jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <20151023035817.GA18907@mtj.duckdns.org>
 <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
 <E3E038D1-BD83-49D8-887A-B215AA685701@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <562BED88.5070100@gmail.com>
Date:   Sat, 24 Oct 2015 13:43:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <E3E038D1-BD83-49D8-887A-B215AA685701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Le 23/10/2015 21:51, Jaedon Shin a écrit :
> On Oct 23, 2015, at 1:51 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> 2015-10-22 20:58 GMT-07:00 Tejun Heo <tj@kernel.org>:
>>> On Fri, Oct 23, 2015 at 10:44:13AM +0900, Jaedon Shin wrote:
>>>> Hi all,
>>>>
>>>> This patch series adds support SATA for BMIPS_GENERIC.
>>>>
>>>> Ralf,
>>>> I request you to drop already submitted patches for NAND device nodes.
>>>> It is merge conflicts with this patches.
>>>> http://patchwork.linux-mips.org/patch/10577/
>>>> http://patchwork.linux-mips.org/patch/10578/
>>>> http://patchwork.linux-mips.org/patch/10579/
>>>> http://patchwork.linux-mips.org/patch/10580/
>>>>
>>>> Jaedon Shin (10):
>>>>  ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
>>>>  ata: ahch_brcmstb: add data for port offset
>>>>  ata: ahci_brcmstb: add support 40nm platforms
>>>
>>> ata part looks fine to me.  Let me know when the other parts get in.
>>> I'll apply the ata ones to libata/for-4.4.
>>
>> There are a few comments coming on the ATA and Device Tree part, and I
>> also would like Brian Norris (who submitted the patches) to take a
>> look at these. But overall, this looks great.
>>
>> I think we have a bit too many compatible strings defined, I need to
>> lookup tomorrow when I am back in the office which BCM7xxx started
>> featuring a SATA3 AHCI compliant core, it might be 7420, but I am not
>> sure
>>
> 
> I agree with you. If you have good opinion, I want you to tell me.

Based on Kevin's feedback, we should be using 7425 as the compatible
string for these AHCI controllers.

Thanks!
-- 
Florian

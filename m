Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 15:02:38 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36654 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993340AbcHLNCbrrVgY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 15:02:31 +0200
Received: by mail-pa0-f66.google.com with SMTP id ez1so1479883pab.3;
        Fri, 12 Aug 2016 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BxCW0CfLDx/5p33G9GKsZEeAVKBOopR/9w68aQupJic=;
        b=Lk4bRu6UHoLcYV+G6+AA5md6+ipCJLHtt+RubgGnhYnpWrGXFqAndoXLbHjvUjdBsQ
         jdIjBV6591NgMjWP4krJ8jKpKbldxbL2cWHFP/z5zPDn7vkBp6XrzgdN2hy7O2tRLUI8
         211ce50X3HjkGYynh9zFptsToKXNctdvv5ssFH7mKeX4H9heU+6nVOMAqZuv3dNYRnJV
         MiNyjyYdCvKa3KLcNzs86d7nAJ029k+pGfF7p3nHU8arOEVE2MvYeEf6uIebq/1KYd8t
         r+T/x1oLhqKKFwUw9ni/cnbVQtYLg4uJ6DtHOYBOFn0oDu8FXN+JlyQ9wc/qxBEjUgS7
         NIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BxCW0CfLDx/5p33G9GKsZEeAVKBOopR/9w68aQupJic=;
        b=YhQ1wM+ExkOkcQZdvn12bTmOF8ExyzMgRhiZ3OkrzzmWXZshvd1CzybIIhOp036/tc
         2Eo0s4rjDZNSp36fUH+uPbEprIGV/SIdxRTrAZTPJsA8n7I3V7Sd0fv99SuDzLoOKiK/
         LhxoLd46YHwANAF88nw4GhQlcio1NgwCZBbSoKiE2mxefJOQmMtfP5V8T3NLGoNJWCN3
         kmmASKEekxsrgmbfN4io3lPwNUUcHi+iAe0WYHKqR3hg75kG/pVxFSMkOVIsb3rVrusu
         LxH+bH1D0bxCOh4p6fnScsDHgoQtCYWgL3ECKvdXv3WaJ0YW8H+JQBUmPp/+3Gg7mQtt
         UB3A==
X-Gm-Message-State: AEkoouvdobqmC6rTViYL9bgnbU4o6VLtNhsk7ntOHHOXVFbVnOBHQEwIFR7gM6+IHDPjWA==
X-Received: by 10.66.82.3 with SMTP id e3mr26968453pay.54.1471006945744;
        Fri, 12 Aug 2016 06:02:25 -0700 (PDT)
Received: from [192.168.0.100] ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id y3sm13068308pfd.65.2016.08.12.06.02.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 06:02:25 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [v3 0/5] Add device nodes for BCM7xxx SoCs
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <CAOiHx=m7_3xwfQRJJJHencjqd38He+wOU1aVkgTf1j7ucDtubg@mail.gmail.com>
Date:   Fri, 12 Aug 2016 22:02:21 +0900
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Transfer-Encoding: 7bit
Message-Id: <FC21FE99-E04A-43D7-990B-A369004B3BF9@gmail.com>
References: <20160812085231.53290-1-jaedon.shin@gmail.com> <CAOiHx=ke2CC9tm6Rn01A5UAGRscb1QJGWq-som74r5UO5_g9EA@mail.gmail.com> <293A0898-C1DE-4275-9293-5BE29FC61018@gmail.com> <CAOiHx=m7_3xwfQRJJJHencjqd38He+wOU1aVkgTf1j7ucDtubg@mail.gmail.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
X-Mailer: Apple Mail (2.3124)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Jonas,

On Aug 12, 2016, at 9:23 PM, Jonas Gorski <jonas.gorski@gmail.com> wrote:
> 
> Hi,
> 
> On 12 August 2016 at 14:19, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> Hi Jonas,
>> 
>> On Aug 12, 2016, at 7:51 PM, Jonas Gorski <jonas.gorski@gmail.com> wrote:
>>> 
>>> Hi,
>>> 
>>> On 12 August 2016 at 10:52, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>>>> This patch series adds support for Broadcom BCM7xxx MIPS based SoCs.
>>>> 
>>>> The NAND device nodes have common file including chip select, BCH
>>>> and partitions for the reference board with the same properties.
>>>> 
>>>> Changes in v3:
>>>> - Fixed incorrect interrupt number in aon_pm_l2_intc.
>>>> 
>>>> Changes in v2:
>>>> - Removed status properties in always enabled GPIO nodes.
>>>> - Removed NAND nodes for v3.3 brcmnand controller.
>>>> - Renamed interrupt-controller instead of lable string.
>>>> - Renamed bcm97xxx-nand-cs1-bch8.dtsi
>>>> 
>>>> Jaedon Shin (5):
>>>> MIPS: BMIPS: Add support PWM device nodes
>>>> MIPS: BMIPS: Add support GPIO device nodes
>>>> MIPS: BMIPS: Add support SDHCI device nodes
>>>> MIPS: BMIPS: Add support NAND device nodes
>>>> MIPS: BMIPS: Use interrupt-controller node name
>>> 
>>> Please directly add the interrupt controller names with the correct
>>> name instead of fixing them up later.
>>> 
>>> Also please CC devicetree@vger for device tree related patches.
>>> 
>>> 
>>> Regards
>>> Jonas
>> 
>> The last commit "MIPS: BMIPS: Use interrupt-controller node name" has
>> on all changes about interrupt-controller@ not only your comments.
>> I think it is needed for consistency and historicity.
> 
> That's fine if you want to fix up other wrong usages, but don't
> introduce them first just to modify them later in the same patch set.
> So please update your patches to ad the nodes with the right names
> right away.
> 
> 
> Jonas

Okay, I will update patches with your review. They will have the right names
at first, and the other wrong usages will be fixed.

Please let me know if you have other comments.

Thanks,
Jaedon

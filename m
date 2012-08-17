Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 23:25:54 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:49919 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903487Ab2HQVZt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 23:25:49 +0200
Received: by yhjj52 with SMTP id j52so4719437yhj.36
        for <linux-mips@linux-mips.org>; Fri, 17 Aug 2012 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=GbZfjBJFh5CdxV/BvqMTZw9hYzK4UjTQTyebycwzZJQ=;
        b=bi9hmymbNwKp/ezGGhb7Rg9tIqfIDpl+gauO2yg0WfJfeRzxv26NU/Vx/LUmxqCQnd
         7JnXQ4WUYO9Q8L8Gth9+j6GbikQHCierXKoJqeQMh2VrRc4NBhKKsUYON/QndQXVV8x2
         SVsEvWGqwVIKgH0/hSPZKkjEB8SPuKegj5dL3JZvh7Wgy+eIy86W4kpeVaqv1IGpGomR
         7mOlPktjoOTC1aZktp1tMoPkjGRyzd1Zhzk2E23Rx9GMJ7eiEmB6CoKTpMqm9VSHhKOK
         9jiZnznFetEQFFvLuKLnpC2MEDyHj8AY5u0br1fRIULIUx1A9qXCqbBjmu1LWLCGSV1Z
         q/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=GbZfjBJFh5CdxV/BvqMTZw9hYzK4UjTQTyebycwzZJQ=;
        b=AcovjUg975t6RC13GKv8FZatPNDFzEzYOJ6WR8goBJrNEWJc3eL8e3dI5t0JDu2O0K
         CD9cZ3UX1jnqW+6oDcyO+ql3qmLxoX3oWmhY1OwBb58a/vm1GEIaIMHESngdphpL364q
         w1FWst5Zw1g+s/Je+RCfXgtYc8UG5uJf5/9m7kpkgWJ5L+1FRD3jeq6hwA9SJ7xWMEdY
         /iaoJL507gw7xaSQ9501IwfudEi3OZdNvLD9l30+NpwwQ6jcjFqbinIUzoO9BSUg9IAM
         8Fuf5DQxGAyBqySacNi9wDkxy/YR/jcdr0+CI235oLeweTllUAPZCN2PPkbcySI2ns+J
         jEig==
Received: by 10.50.213.6 with SMTP id no6mr3251013igc.30.1345238743124;
        Fri, 17 Aug 2012 14:25:43 -0700 (PDT)
Received: by 10.50.213.6 with SMTP id no6mr3250994igc.30.1345238742839; Fri,
 17 Aug 2012 14:25:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.26.99 with HTTP; Fri, 17 Aug 2012 14:25:22 -0700 (PDT)
In-Reply-To: <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
References: <502E8115.90507@gmail.com> <CAErSpo7a77wAxrgZYfg_UdqLEtEf0wUxcbxTghnR7HbRsncKRQ@mail.gmail.com>
 <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
 <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
 <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
 <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
 <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de> <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 17 Aug 2012 15:25:22 -0600
Message-ID: <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnbnqQf8Tea8Ff3g8D69aezRy5FIBQSs+SijQjh5eq1gMtwoIwm4Lkhy8vbSLnEhOxFsvHDOFhz/siV8tHy9hnw3z3v5Qy5zZl08//gzlqAWLgRMmxHyz6YiYbFZs4C+VMS04Wbd5DstAoAwaKNOGAhNocYLq1ZUTmNh4N4JLC3OIxp7HkeATZMgfiNVxBrDXJjNVuEHF4reG7ty7Ux5WlAX4IQew==
X-archive-position: 34266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Fri, Aug 17, 2012 at 3:07 PM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Fri, Aug 17, 2012 at 10:48:39PM +0200, Thierry Reding wrote:
>> On Fri, Aug 17, 2012 at 02:39:34PM -0600, Bjorn Helgaas wrote:
> [...]
>> > Well, maybe you just need to turn on CONFIG_HOTPLUG.  How would that
>> > affect you?  I think we would still have to change some __inits to
>> > __devinit, including pcibios_update_irq(), but it might be more
>> > manageable.
>>
>> You said that depending on HOTPLUG wouldn't be enough because it would
>> exclude reenumeration at runtime if HOTPLUG wasn't defined. Also it is
>> theoretically possible to build a kernel without HOTPLUG but have the
>> enumeration start after init because of deferred probing. Those cases
>> won't work if we keep __init or __devinit respectively, right?
>
> Another possibility would be to make PCI select HOTPLUG or depend on it.
> That way it would be made sure that __devinit wouldn't cause all the
> functions to be discarded after init.

There's been some discussion recently about whether CONFIG_HOTPLUG is
worth keeping any more, but nothing's been resolved yet.  If we did
decide to remove CONFIG_HOTPLUG, or require it for PCI, I would rather
just remove all the __devinit annotations because they'd be
superfluous.

> Also, using PCI without HOTPLUG is sort of contradictory.

I'm not sure I follow this one.  I can easily imagine embedded systems
that use PCI internally but have no slots or connectors, so there's no
possibility of anything changing.

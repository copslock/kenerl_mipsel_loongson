Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 16:09:42 +0100 (CET)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:41781
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992956AbeARPJevussT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jan 2018 16:09:34 +0100
Received: by mail-oi0-x243.google.com with SMTP id n81so15891942oig.8;
        Thu, 18 Jan 2018 07:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=voxFTxjqBui0NgMl62vcZGxWMIPMj6tbb8OOyE3g0n0=;
        b=cMJRpujj4LtYpwJ5/7a399NoPKd1R9ztyfntuUfeG3TSSbmiZA0AjW7XY6r4gw5pY8
         oe4Tl5Qj7wsSO6c3kyYDy5NjAaODGp153+WpwO5xe5YZurUtMRpaZ3EydpAjBpD+Hh/r
         FvX2YqZC9GepFIphTEGdZc2kNrTZF3y9eiqUSWjjgTJ8SV7iDhVZv4xoP0qRs/N2PfVe
         1Qpz2ogCuikAainb4jXKhXj0vqpE5yhTBdkEggFOO9FOn26Cit6/lJBNpHlZTJ805Vk7
         TB++QTYTG2x9bwkXe/r5VP5ikcZCYf/+c8cysO4TCKM32aa2W/2OshF1zSoF4HHKwng0
         YmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=voxFTxjqBui0NgMl62vcZGxWMIPMj6tbb8OOyE3g0n0=;
        b=KcBepOI6vYga3k9tT+CBKZG6RKTrg/7ohpIAT93Eh0e7JOAhiy3qPpV7whoGiGfPp1
         Yd5h61AhIHb9afzy71lcUxL/ZqAv6rBk1XlP5rQq9mk2BzGS+SLY63xESNZRFrsADoYl
         h/e8UCNDwVB9WSExiHsbr+Q2u/hd969T7vpSzMSpPBRUt6v5PXT1aWCpWg3BEfy4WKQJ
         Oz4B4XvbnXrv8xs7fxcMZi/rj2GH5YC/T3muXz684upZHadwIfwwNOBkH/CB58ptFqy2
         tN4RdrQ9QR5e+jUfsrL90KSZySE2uo4zsLB6quQJrkVKv/sLsBT8HycUrmZdl/g0O1mi
         guzg==
X-Gm-Message-State: AKwxytdC2IN9nPLcVvp52UEjwTx4Gs/MXpGk5Zz5QK2Vr3vf3YREAhMJ
        4ozlJK2jTmsh8kK7FCGLobc=
X-Google-Smtp-Source: ACJfBotiISvTtlZciKFHR57d8W3hbFTWOA/P6K+QFktlwQBa3lzkbqq/rw1zeTqtCNnifhmGv+UCYQ==
X-Received: by 10.202.219.66 with SMTP id s63mr3234057oig.168.1516288168325;
        Thu, 18 Jan 2018 07:09:28 -0800 (PST)
Received: from nexus5x-flo.lan (ip68-109-195-31.pv.oc.cox.net. [68.109.195.31])
        by smtp.gmail.com with ESMTPSA id s35sm3396077otd.50.2018.01.18.07.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 07:09:27 -0800 (PST)
Date:   Thu, 18 Jan 2018 07:09:23 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20180118073123.GA15766@lst.de>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com> <1516058925-46522-5-git-send-email-jim2101024@gmail.com> <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com> <20180118073123.GA15766@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for inbound     traffic
To:     Christoph Hellwig <hch@lst.de>, Rob Herring <robh+dt@kernel.org>
CC:     Jim Quinlan <jim2101024@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-pci@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62233
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

On January 17, 2018 11:31:23 PM PST, Christoph Hellwig <hch@lst.de> wrote:
>On Wed, Jan 17, 2018 at 08:15:33PM -0600, Rob Herring wrote:
>> > (a) overriding/redefining the dma_to_phys() and phys_to_dma() calls
>> > that are used by the dma_ops routines.  This is the approach of
>> >
>> >         arch/mips/cavium-octeon/dma-octeon.c
>> 
>> MIPS is rarely an example to follow. :)
>
>But in this case it actually is the example to follow as told
>previously.
>
>NAK again for these chained dma ops that only create problems.

Care to explain what should be done instead?

-- 
Florian

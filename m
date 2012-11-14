Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2012 13:12:52 +0100 (CET)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:63252 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823910Ab2KNMMrdLd6z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2012 13:12:47 +0100
Received: by mail-oa0-f49.google.com with SMTP id l10so288486oag.36
        for <multiple recipients>; Wed, 14 Nov 2012 04:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=W1w04TJtqkpx9DpCckt/99u7qOmaHFVSAgI9TccGNwE=;
        b=pb9gT3n/ISWvm1sLmTdD/uUteZCmXJcSKaMBwwz9dk1+uQtmav+ABHrS2pxnqzxe27
         qYltTCyWaJA8c1fC1Rgrm7zrUUpjgz7TZjXI1Kt0E6Ds/9EKPofbwsER8mT8ERXuHb3N
         eF+Ocg9CX5kucHgqV7av+U9JMsbYIe/N5vTGiK9BCQw+84UFp7aj5bDSEK94tXHDBxNt
         1GZIuKmYei6cd1Olntll2TdVDaxwCYUOdiSiVkp0+15C2RbZq2sWfX9Kt8apy4BhmKRg
         l51QsYlPIU0ruSSnQ+xUYYxV38U+JbU6wZSXGVkf5trqCr5F60Zq65qFc1/Qcm/qp75i
         +YHw==
Received: by 10.60.172.138 with SMTP id bc10mr20410225oec.33.1352895161082;
 Wed, 14 Nov 2012 04:12:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.28.70 with HTTP; Wed, 14 Nov 2012 04:12:20 -0800 (PST)
In-Reply-To: <50A1D4E4.50308@wwwdotorg.org>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
 <1352638249-29298-11-git-send-email-jonas.gorski@gmail.com> <50A1D4E4.50308@wwwdotorg.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 14 Nov 2012 13:12:20 +0100
Message-ID: <CAOiHx==UhqBWMAgqGaVM+P=eUueq1uKTDUaTg+ROsHYitUi+MQ@mail.gmail.com>
Subject: Re: [RFC] MIPS: BCM63XX: switch to common clock and Device Tree
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 13 November 2012 06:04, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/11/2012 05:50 AM, Jonas Gorski wrote:
>> Switch BCM63XX to the common clock framework and use clkdev for
>> providing clock name lookups for non-DT devices.
>>
>> Clocks can have a frequency and gate-bit, or none, in case they
>> are just provided for drivers expecting them to be present.
>
>> diff --git a/Documentation/devicetree/bindings/clock/bcm63xx-clock.txt b/Documentation/devicetree/bindings/clock/bcm63xx-clock.txt
>
> A very minor nit, but it might be nice to add the DT binding
> documentation before (or as part of) the patches that use them (code
> that parses them, or using the bindings in .dts files)
>
> Of course, I'm relying on my email receive order, to judge this since
> the patch numbering didn't come through, so perhaps the patches are
> already set up this way...

No you are right, the bindings are being added earlier. I move it to
the patch adding the (then still unused) binding to the dts(i) files.
I'd rather not split it up completely, and add it with the binding
usage together so it's easier to spot if I do something with the
bindings that contradicts the documentation or is missing ;-).


Jonas

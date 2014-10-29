Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 00:23:01 +0100 (CET)
Received: from mail-qc0-f182.google.com ([209.85.216.182]:46504 "EHLO
        mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011766AbaJ2XW7DBuzO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 00:22:59 +0100
Received: by mail-qc0-f182.google.com with SMTP id m20so3259358qcx.41
        for <multiple recipients>; Wed, 29 Oct 2014 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tK87EsHKcxc/nGVI/4Gh87o3EivxQ00qWKNBzMlVEI8=;
        b=hl0nHbBBvwdKRVonZtr8wcxgcQn5oCAsPri6Q6iL1ltcHA3ug/fsW9ZTW6ViRXT5yc
         7Q8ZHpSqRTN+4zWfIW5yLUMPRuuoz9Z1unhq8HD5DM7osOBjc01UtEzkJNEh/v6A3Kbn
         fXVdQS+ij2cLdYjMoR0h5HlsqLQKhgDtyPnv0jUkQsXDFECosYfBnjJaASlZiR6O7gcY
         P2tl4yvIDQ/o+yjwdXpOxsV49K/FIbRhKvBuANyEoH1AIVGZIUCvtW9I6qDaKPQYWmSD
         FFGemMIATGUIbx+wK16vsq14Bivf3tpsr67PDqQNyUHiRcgnWXXYWs330N4fT2fFEBTI
         2drw==
X-Received: by 10.140.91.87 with SMTP id y81mr19609574qgd.52.1414624971737;
 Wed, 29 Oct 2014 16:22:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 29 Oct 2014 16:22:31 -0700 (PDT)
In-Reply-To: <7518897.LmfE2WsusV@wuerfel>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com>
 <1414555138-6500-10-git-send-email-cernekee@gmail.com> <7518897.LmfE2WsusV@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 29 Oct 2014 16:22:31 -0700
Message-ID: <CAJiQ=7D+QhFjg7mR49KE2Lu1SC72djBLhbv4sC37tSTga+BVCQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] irqchip: bcm7120-l2: Extend driver to support 64+
 bit controllers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Wed, Oct 29, 2014 at 12:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 28 October 2014 20:58:57 Kevin Cernekee wrote:
>> Most implementations of the bcm7120-l2 controller only have a single
>> 32-bit enable word + 32-bit status word.  But some instances have added
>> more enable/status pairs in order to support 64+ IRQs (which are all
>> ORed into one parent IRQ input).  Make the following changes to allow
>> the driver to support this:
>>
>>  - Extend DT bindings so that multiple words can be specified for the
>>    reg property, various masks, etc.
>>
>>  - Add loops to the probe/handle functions to deal with each word
>>    separately
>>
>>  - Allocate 1 generic-chip for every 32 IRQs, so we can still use the
>>    clr/set helper functions
>>
>>  - Update the documentation
>>
>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>
> You should probably specify a 'big-endian' DT property for the driver
> to check. If you have both LE and BE versions of this device, we
> must make sure that we use the correct accessors.
>
> As long as we don't need to build a kernel that supports both (if
> I understand you correctly, the ARM SoCs use a LE instance of this
> device, while the MIPS SoCs use a BE version) you can still decide
> at compile-time which one you want, but please add the runtime check
> now, so if we ever get a new combination we can handle it at runtime
> with a more complex driver implementation.

Under discussion in the other thread...

> If I read your code right, you have decided to use one IRQ domain
> per register set, rather than one domain for all of them. I don't
> know which of the two ways is better here, but it would be good if
> you could explain in the patch description why you did it like this.

This uses one domain per bcm7120-l2 DT node.  If the DT node defines
multiple enable/status pairs (i.e. >=64 IRQs) then the driver will
create a single IRQ domain with 2+ generic chips.

Multiple generic chips are required because the generic-chip code can
only handle one enable/status register pair per instance.

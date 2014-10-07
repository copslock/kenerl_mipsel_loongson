Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 19:11:13 +0200 (CEST)
Received: from mail-oi0-f48.google.com ([209.85.218.48]:43218 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010625AbaJGRLMGr--6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 19:11:12 +0200
Received: by mail-oi0-f48.google.com with SMTP id g201so5429605oib.7
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 10:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Iigiq301J2psOJVWZqvLgIlZ2/eTazdaT0E7BWmj/ps=;
        b=Ym1MR2WFHnJJ3Qz/cGTclJuudX2NMV4yV41Mkx/jBfjPOEJVDiZjn+dz0ww+qAJSjJ
         wJnpMPrvtvwgab1vyybFB2XltTdDCx3nuHw/nS1NXGFdlkj27w7ayswSw14OBfKIJW+s
         hYc7PDtzy1T2dJ2EdO5Fqdn0HLHClcVTYPtyKtB+5y513B91Z4BT6scWzzTgIlKhbgVZ
         L4Mhz6mcU1zrh0zQcDlxnNcuRvz0y9MM+ozX89DkBz4Yyf1rsX9EK1ZTFOg7tyP+wjvk
         hiITfJpFO9TFRhbYsquxre00pax3swK03c5roF6L5HOqKJOPvvxxAuraftfqhuxgvG8N
         bBxw==
X-Gm-Message-State: ALoCoQlDLjsigg29x18Tlg83roPzYO8X22MEI6Lg3Vh4Wk32X6EuBdiOZjw8qosAILhspyRxU4pr
X-Received: by 10.60.63.8 with SMTP id c8mr5824681oes.26.1412701865549;
        Tue, 07 Oct 2014 10:11:05 -0700 (PDT)
Received: from [192.168.1.12] (cpe-72-182-51-248.austin.res.rr.com. [72.182.51.248])
        by mx.google.com with ESMTPSA id f8sm12275199oev.4.2014.10.07.10.10.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 10:11:04 -0700 (PDT)
Message-ID: <54341EA2.6010806@landley.net>
Date:   Tue, 07 Oct 2014 12:10:58 -0500
From:   Rob Landley <rob@landley.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 05/44] mfd: as3722: Drop reference to pm_power_off from
 devicetree bindings
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net> <1412659726-29957-6-git-send-email-linux@roeck-us.net> <543412F7.8040909@landley.net> <20141007163131.GE28835@roeck-us.net> <54341BF1.9020001@gmail.com>
In-Reply-To: <54341BF1.9020001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 10/07/14 11:59, David Daney wrote:
> On 10/07/2014 09:31 AM, Guenter Roeck wrote:
>> On Tue, Oct 07, 2014 at 11:21:11AM -0500, Rob Landley wrote:
>>> On 10/07/14 00:28, Guenter Roeck wrote:
>>>> Devicetree bindings are supposed to be operating system independent
>>>> and should thus not describe how a specific functionality is
>>>> implemented
>>>> in Linux.
>>>
>>> So your argument is that linux/Documentation/devicetree/bindings should
>>> not be specific to Linux. Merely hosted in the Linux kernel source
>>> repository.
>>>
>>> Well that's certainly a point of view.
>>>
>> Not specifically my argument, really, and nothing new either. But,
>> yes, I do
>> think that devicetree bindings descriptions should not include
>> implementation
>> details, especially since those may change over time (as is the case
>> here).
>>
> 
> I fully agree.
> 
> Many device trees come from outside the kernel (i.e. they are supplied
> by the system boot environment).  Obviously these device trees cannot be
> changed at the whim of kernel developers, *and* it is perfectly
> reasonable to think that software other than the Linux kernel will run
> on this type of system too.
> 
> So yes, it is really true, device trees are not a Linux kernel private
> implementation detail, they are really an external ABI that, although
> documented in the kernel source tree, cannot be changed in incompatible
> ways as time progresses.

Ah. Existing thing with backstory among the in-crowd, so I'll assume
"git subtree" was previously suggested and you had that discussion
already and decided against it.

Carry on,

Rob

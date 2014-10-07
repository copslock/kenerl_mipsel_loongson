Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 18:59:39 +0200 (CEST)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:40552 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010625AbaJGQ7ikdXtv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 18:59:38 +0200
Received: by mail-ie0-f170.google.com with SMTP id rd18so5787272iec.15
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IQmBW/ecm0PlBOnNT1tmvTyGhPpEN+BG3k+K+8XnQAY=;
        b=pWBorCMq1eXduZiVcf3gaU7QHS/EPu8ZXHWt+PfF9KdK7ozE3k2wh89+u0Q8g8ikqp
         EQn+BXYNgkI3hRDGELWv+3nLHjQRlfe5O9Vb7vY1STmktBCVFAP+OFAKX0iRnva2EMus
         JfhaO00M36epbU0e4sCCgGOfCQw2xnM2O2jpfXFxCVdmqPycGvCCW9FgM1HTuS7sr9cB
         O64d7T/vj6muGVnt2VytRs6qAo+IFyfJul4+FqDxnqY7hEVUfD3Nhf4AypscddyjZTBL
         u64KIGIicQavYjyK29H/pF4hUkOr006m6zf0ypKh6fXqLkjVnW/y42h5kYgh3AJ3wOtG
         Ld4Q==
X-Received: by 10.50.25.65 with SMTP id a1mr33614579igg.3.1412701172477;
        Tue, 07 Oct 2014 09:59:32 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id z5sm12441449igl.21.2014.10.07.09.59.29
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 09:59:31 -0700 (PDT)
Message-ID: <54341BF1.9020001@gmail.com>
Date:   Tue, 07 Oct 2014 09:59:29 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>, Rob Landley <rob@landley.net>
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
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net> <1412659726-29957-6-git-send-email-linux@roeck-us.net> <543412F7.8040909@landley.net> <20141007163131.GE28835@roeck-us.net>
In-Reply-To: <20141007163131.GE28835@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 10/07/2014 09:31 AM, Guenter Roeck wrote:
> On Tue, Oct 07, 2014 at 11:21:11AM -0500, Rob Landley wrote:
>> On 10/07/14 00:28, Guenter Roeck wrote:
>>> Devicetree bindings are supposed to be operating system independent
>>> and should thus not describe how a specific functionality is implemented
>>> in Linux.
>>
>> So your argument is that linux/Documentation/devicetree/bindings should
>> not be specific to Linux. Merely hosted in the Linux kernel source
>> repository.
>>
>> Well that's certainly a point of view.
>>
> Not specifically my argument, really, and nothing new either. But, yes, I do
> think that devicetree bindings descriptions should not include implementation
> details, especially since those may change over time (as is the case here).
>

I fully agree.

Many device trees come from outside the kernel (i.e. they are supplied 
by the system boot environment).  Obviously these device trees cannot be 
changed at the whim of kernel developers, *and* it is perfectly 
reasonable to think that software other than the Linux kernel will run 
on this type of system too.

So yes, it is really true, device trees are not a Linux kernel private 
implementation detail, they are really an external ABI that, although 
documented in the kernel source tree, cannot be changed in incompatible 
ways as time progresses.

David Daney

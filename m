Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2012 23:03:04 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37187 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903378Ab2IMVDA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2012 23:03:00 +0200
Received: by obbta17 with SMTP id ta17so5477458obb.36
        for <multiple recipients>; Thu, 13 Sep 2012 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UNpuo3wZgbfCHiGgUVSRyXc93sb+xRVJqxG9ogQd5BQ=;
        b=TRKxmPbvmPOqA6YmmXJgKiImJTk1szN08aOOIxokTJfOPJR9ViRzB1mr5minZ8Y/yZ
         KIdtsxywn2o8pCPID1FLGRuLnlIJOnMGubEtsdrVGpyGuLKYZM76xDQAWj0scmbPu2cs
         bmHzVR3sbVQ0hYpVAjm1sH6ck85mih9tDxeQVZTZZpjUXECuFR1o+hsv9CWqFXoYc2vb
         2xNe2qf6hkAsNNXAClKs1Zyp3D5iF4XiH41TMVAprlvlEoMkaVDv5bdnsmlm/2AbbnG0
         acKvLswaSjS67hGRTjTLOoHk9SnL5bv9jNPK9kCm/v70VWQ2RELtcVirLSHpUD41i4Bv
         6erw==
Received: by 10.60.154.198 with SMTP id vq6mr721272oeb.20.1347570173648;
        Thu, 13 Sep 2012 14:02:53 -0700 (PDT)
Received: from [10.10.10.90] ([173.226.190.126])
        by mx.google.com with ESMTPS id l10sm20414669oeb.13.2012.09.13.14.02.50
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Sep 2012 14:02:52 -0700 (PDT)
Message-ID: <505249F9.7050201@gmail.com>
Date:   Thu, 13 Sep 2012 16:02:49 -0500
From:   Rob Herring <robherring2@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Cyril Chemparathy <cyril@ti.com>, linux-mips@linux-mips.org,
        x86@kernel.org, a-jacquiot@ti.com, mahesh@linux.vnet.ibm.com,
        linus.walleij@linaro.org, grant.likely@secretlab.ca,
        paul.gortmaker@windriver.com, paulus@samba.org, hpa@zytor.com,
        m.szyprowski@samsung.com, jonas@southpole.se,
        linux@arm.linux.org.uk, linux-c6x-dev@linux-c6x.org,
        nico@linaro.org, david.daney@cavium.com, mingo@redhat.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        benh@kernel.crashing.org, suzuki@in.ibm.com, linux@openrisc.net,
        arnd@arndb.de, microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org, msalter@redhat.com,
        rob.herring@calxeda.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, blogic@openwrt.org,
        dhowells@redhat.com, monstr@monstr.eu,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org, tj@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] of: specify initrd location using 64-bit
References: <1347465937-7056-1-git-send-email-cyril@ti.com> <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com> <5050CE33.9060909@ti.com> <5050E965.5080405@linutronix.de> <505107DF.5020105@gmail.com> <5051816A.3050705@linutronix.de>
In-Reply-To: <5051816A.3050705@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On 09/13/2012 01:47 AM, Sebastian Andrzej Siewior wrote:
> On 09/13/2012 12:08 AM, Rob Herring wrote:
>>> Geert is right here. If it is a physical address, it should be
>>> phys_addr_t.
>>
>> While generally true, for the DT specific code I think it should be a
>> fixed u64. The size of the address is defined by the FDT, not the
>> kernel. It is very likely we could have a FDT that specifies addresses
>> in 64-bit values, but then we boot a kernel is compiled for !LPAE.
>> phys_addr_t is currently sized based on LPAE setting.
> 
> If your kernel is 32bit without PAE and your DTB address is >32ibt than
> you can't handle it. If you don't notice this in your dt code than you
> remap the wrong memory ioremap().

The size of the initrd fields are set by #address-cells properties and
determined when you create the dtb. The address to load the initrd is
decided by the bootloader/user and set at that point later in time. The
dtb should not be tied to the kernel you are booting. Obviously, if you
want to boot a non-PAE kernel, everything has to be placed at <4GB.

I can boot i386 and i386-pae kernels on an i386-pae machines. I expect
to generally be able to do that on ARM. Perhaps some SOCs like this one
will not allow that, it is not always true.

Rob

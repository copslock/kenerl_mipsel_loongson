Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 08:54:46 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:43847
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdLAHyi305TE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 08:54:38 +0100
Received: by mail-wm0-x243.google.com with SMTP id n138so1895344wmg.2
        for <linux-mips@linux-mips.org>; Thu, 30 Nov 2017 23:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FBm+24tds0IaVGVjErr5bSl33I+AfAjQv3penxN3QCo=;
        b=wdt2CXZtCO00l2rQUt+aY1NoMd9R/dsuNnnD38jF+tseadLeVj/DxmhUvS+ag0hQVO
         mtMEP78HwK5ThuIt1v/4cK4OX66NSpAy7o2F0Lkt8gtpQL6Krp3maNUOIWZ43ol8qcR3
         Zn7sYnjYr/awP67rQFhoiDtpSPqRca/aAL2OMPMtsVGwu6IuNB11by3l1wdHe9j3vEeh
         jseYpRRuaYLNRM/+4cKhyylixgIAxE0Zxn6g+vLLlwx0mdePhPVSpizjbP0TaygSvOQO
         H2o3Q+T/3zt3R4CN0NhsXYRt91599gt8plfYjNPH/qiZtgF/0wKzhAosoGCC6urDcCMC
         2sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FBm+24tds0IaVGVjErr5bSl33I+AfAjQv3penxN3QCo=;
        b=EZLgyrY+CLWk8uqFa7UePW8NrdRyNe9541bU/dN8KnqPNicwvkijj00hHGtyVA5EjC
         g0O+6BpYSERmu2PqAAi9mbhVxMFAUoMrBezXBPr4KJJzg3aMRsto0RZ7R8+MD76SJXZX
         0cSsIqNbTcTEUgAEeat0uBeU94yrNbuTzmTbyM2nfma/HMWVbrtMgFHJLt4XeNBUb97w
         4uRlmegopNmM11qyPGJ+4KyC14SxtcSrXtBZ6Z2OVHm/2/DqvWT2mGN4jlMY7aH53YwL
         VAiDLQA/QLWLuYQDefyYMj5kX/mL9snZDEG1jw5Z2yz+zOeqE+qXhP/PDN6GSiBU8M4/
         WCbg==
X-Gm-Message-State: AKGB3mIgNBea12G0XxTTNmfA2/UqtU4amGDo9YdlXNcWC3iUPYUfC8tF
        IPTBo3BPWtn/9QvIqeNd3UgwbtUfOej9du/fdCgr5A==
X-Google-Smtp-Source: AGs4zMZZZxjW1iuhnemZcBorEfXUYfLQ7K854Dp664sFpmsRVjUbEr9a+6+d8sUurPBhPk9DC+caNFf8oqFKQr/wn74=
X-Received: by 10.28.26.139 with SMTP id a133mr456728wma.90.1512114872998;
 Thu, 30 Nov 2017 23:54:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.195 with HTTP; Thu, 30 Nov 2017 23:53:52 -0800 (PST)
In-Reply-To: <20171130225333.GI27409@jhogan-linux.mipstec.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-4-david.daney@cavium.com> <20171130225333.GI27409@jhogan-linux.mipstec.com>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Fri, 1 Dec 2017 08:53:52 +0100
Message-ID: <CAOFm3uGhRTTrvygBd0dMdzWZQC5kFi8yXuWQsnhDvDLtW2z7aA@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] MIPS: Octeon: Add a global resource manager.
To:     Carlos Munoz <cmunoz@cavium.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        James Hogan <james.hogan@mips.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

Carlos,

On Thu, Nov 30, 2017 at 11:53 PM, James Hogan <james.hogan@mips.com> wrote:
> On Tue, Nov 28, 2017 at 04:55:35PM -0800, David Daney wrote:
>> From: Carlos Munoz <cmunoz@cavium.com>
>>
>> Add a global resource manager to manage tagged pointers within
>> bootmem allocated memory. This is used by various functional
>> blocks in the Octeon core like the FPA, Ethernet nexus, etc.
>>
>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>  arch/mips/cavium-octeon/Makefile       |   3 +-
>>  arch/mips/cavium-octeon/resource-mgr.c | 371 +++++++++++++++++++++++++++++++++
>>  arch/mips/include/asm/octeon/octeon.h  |  18 ++
>>  3 files changed, 391 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/mips/cavium-octeon/resource-mgr.c
>>
>> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
>> index 7c02e542959a..0a299ab8719f 100644
>> --- a/arch/mips/cavium-octeon/Makefile
>> +++ b/arch/mips/cavium-octeon/Makefile
>> @@ -9,7 +9,8 @@
>>  # Copyright (C) 2005-2009 Cavium Networks
>>  #
>>
>> -obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
>> +obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o \
>> +      resource-mgr.o
>
> Maybe put that on a separate line like below.
>
>>  obj-y += dma-octeon.o
>>  obj-y += octeon-memcpy.o
>>  obj-y += executive/
>> diff --git a/arch/mips/cavium-octeon/resource-mgr.c b/arch/mips/cavium-octeon/resource-mgr.c
>> new file mode 100644
>> index 000000000000..ca25fa953402
>> --- /dev/null
>> +++ b/arch/mips/cavium-octeon/resource-mgr.c
>> @@ -0,0 +1,371 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Resource manager for Octeon.
>> + *
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + *
>> + * Copyright (C) 2017 Cavium, Inc.
>> + */

Since you nicely included an SPDX id, you would not need the
boilerplate anymore. e.g. these can go alright?

>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.

-- 
Cordially
Philippe Ombredanne

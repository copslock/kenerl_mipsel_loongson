Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2012 18:42:01 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:54087 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903756Ab2DWQlr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2012 18:41:47 +0200
Received: by ghbf11 with SMTP id f11so6988033ghb.36
        for <linux-mips@linux-mips.org>; Mon, 23 Apr 2012 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bDhzEcqTTfMZGKmrss7W0Uu7v4pj6MrNKKMcnxEP2bs=;
        b=yQy265C8z/3B2P6qjZRQ2aGosLnwvesANMxAcZs4qkCEl0qTzstXOVat4r6aF8ggkg
         t8cBAjH8Rg/u3WPsvvc3kN3gV7SfqIGrgu2XGJqZkE/M7wFmOm6KtRMM0+nRIzqo/mnP
         76A4e9i5/fQxIKY+0fIqauIJje+BAAwJQ1+nSOOPUtqfIApiVCMWtSAMisVy7FLtgJNQ
         kQNGEaXsiccBkAGkFf5l4iKpB6VxJE+QPGwKftm1CjsoFbkWR8DEb6J2EgpFi9ml6QbK
         a25RmzI+y/Kug1USxOlfHfH6AGZxR3IZfd6mVGRzloOJNN/HvoaKvKPa/iiC5ZWWRR1D
         Avmw==
Received: by 10.60.18.197 with SMTP id y5mr11817830oed.58.1335199301084;
        Mon, 23 Apr 2012 09:41:41 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ju5sm6811838obb.23.2012.04.23.09.41.38
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 09:41:39 -0700 (PDT)
Message-ID: <4F958641.7070708@gmail.com>
Date:   Mon, 23 Apr 2012 09:41:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Miller <davem@davemloft.net>
CC:     david.s.daney@gmail.com, ddaney.cavm@gmail.com,
        grant.likely@secretlab.ca, rob.herring@calxeda.com,
        devicetree-discuss@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org
Subject: Re: [PATCH v5 2/3] netdev/of/phy: Add MDIO bus multiplexer support.
References: <1334791254-15987-3-git-send-email-ddaney.cavm@gmail.com>   <20120421.153201.2103447307695063734.davem@davemloft.net>       <4F9325DF.7020003@gmail.com> <20120421.190335.1197591560590885057.davem@davemloft.net>
In-Reply-To: <20120421.190335.1197591560590885057.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/21/2012 04:03 PM, David Miller wrote:
> From: David Daney<david.s.daney@gmail.com>
> Date: Sat, 21 Apr 2012 14:25:51 -0700
>
>> If we were to specify the dependencies in both places, we gain nothing
>> other than duplication of information.
>
> Each Kconfig option enabling a module has to have appropriate
> dependencies.
>
I will send a revised patch set.

Thanks,
David Daney

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 16:17:45 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34881 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823126Ab2LLPRof7aVO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 16:17:44 +0100
Received: by mail-lb0-f177.google.com with SMTP id n10so743600lbo.36
        for <multiple recipients>; Wed, 12 Dec 2012 07:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qPW7EssFAccBBgr1jC27oIkIQWglovQhi/S0FGj5Dgc=;
        b=X7t/obbnbKcakW6fB7TS3OCRGnyfFeXaleP76JLzOFc8scaAewaRPLWnZXOz9fp51H
         LOdUnqUm1qntVbX6vhuX0VvJnzj1SWwBhXjBsH2Q3ojlLdQAtq5xNzN4OA7O7my1ejGK
         odLIkQ9zEp+FqJ9N6CfwEx0IimAm7CJQr7qLB/RMfckDB7CQ3WggR3d4kBzTcv8WHxmw
         utb0a61tO4A2UDRz9nY1RBVbPxUWRvfaDDCYyy6XpAmzcflZpoQTY9lDn4Fpvpq0RF7c
         unZmrZwx4r2r9LZu9L7e2DOt60sAyp6gnZ2nii0Fzm/+OCrgdgex78qyRMB/y4Buuo4e
         PwUg==
Received: by 10.112.45.232 with SMTP id q8mr603765lbm.23.1355325458925;
        Wed, 12 Dec 2012 07:17:38 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id pg5sm9366346lab.6.2012.12.12.07.17.37
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 07:17:38 -0800 (PST)
Message-ID: <50C89F96.7010605@openwrt.org>
Date:   Wed, 12 Dec 2012 16:15:34 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: MIPS: sead3: Implement OF support.
References: <1354857297-28863-1-git-send-email-sjhill@mips.com> <50C894D4.4090008@openwrt.org> <50C89A6C.705@metafoo.de> <20121212145545.GC11791@linux-mips.org> <50C89C67.7040908@openwrt.org> <20121212151204.GD11791@linux-mips.org>
In-Reply-To: <20121212151204.GD11791@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Le 12/12/12 16:12, Ralf Baechle a écrit :
> On Wed, Dec 12, 2012 at 04:01:59PM +0100, Florian Fainelli wrote:
>
>> The convention for vendor prefixes is to use the stock exchange
>> prefix, giving us "mips". The same problem exist for ARM Ltd. vs
>> architecture and they use "arm" as a prefix unconditionaly.
> ARM is traded at LSE as ARM but on Nasdaq as ARMH.  Pick one ;)
>
> Conventions are made to be violated for good reasons ...

As I looked into Documentation/device-tree/bindings/vendor-prefixes.txt 
I found quite some good counter examples as well, so let's go for "mti".
--
Florian

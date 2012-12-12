Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 16:04:14 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:41500 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825653Ab2LLPEJiSfUW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 16:04:09 +0100
Received: by mail-la0-f49.google.com with SMTP id r15so698359lag.36
        for <multiple recipients>; Wed, 12 Dec 2012 07:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=UhJPmKxXUfPQv8cRkaK6ZaWphfGH1Z0vKVeUBUwUw/Q=;
        b=z75k6nBsXv3L0gInj0WiZpONVYw2xF6jAQdzeCf7EfLlkR7fb7p7Tk6np4kwgeC6W9
         eRMXeBhW628WpxKSVBEJah7+yTDMPNmGoXHjHj8FofnqwKTAZQTCVLHg5pOKbbaUwZO4
         a9GIWd3DM9JS3tfLHzFo0/K6TrlP85h2OA7PEFuFs+2DP29TDBX6VMVtyQb1eSEpJnm6
         kHS43cugQcRSYyHz6T3uIfHBHovBTVVCyhUcjcvApdSuR7rLZBDun4VU3nF2wULzXRuo
         Nt4M2ZcqOcRyUzH2uhGcxoZxkAr6O9CwdbwwYPVZ/jSBViwuFVEsZEAnLW8qhEgzHZLY
         wmvQ==
Received: by 10.112.25.193 with SMTP id e1mr583947lbg.94.1355324644017;
        Wed, 12 Dec 2012 07:04:04 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id v7sm9716867lbj.13.2012.12.12.07.04.02
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 07:04:03 -0800 (PST)
Message-ID: <50C89C67.7040908@openwrt.org>
Date:   Wed, 12 Dec 2012 16:01:59 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: MIPS: sead3: Implement OF support.
References: <1354857297-28863-1-git-send-email-sjhill@mips.com> <50C894D4.4090008@openwrt.org> <50C89A6C.705@metafoo.de> <20121212145545.GC11791@linux-mips.org>
In-Reply-To: <20121212145545.GC11791@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35266
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

Le 12/12/12 15:55, Ralf Baechle a écrit :
> On Wed, Dec 12, 2012 at 03:53:32PM +0100, Lars-Peter Clausen wrote:
>
>> This is one compatible string though, what you describe is for when use
>> multiple compatible string. E.g.
>> compatible = "mips14KEc", "mips14Kc", "mips";
>>
>> The "mips" in Stevens patch is probably the vendor prefix. Maybe a more
>> correct compatible would be.
> How about using something like mti (for MIPS Technologies, Inc.) instead
> of MIPS to differenciate the architecture from the company name?

The convention for vendor prefixes is to use the stock exchange prefix, 
giving us "mips". The same problem exist for ARM Ltd. vs architecture 
and they use "arm" as a prefix unconditionaly.
--
Florian

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 20:09:02 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:45723 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817207Ab2LLTJBrXtbT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 20:09:01 +0100
Received: by mail-pa0-f49.google.com with SMTP id bi1so817769pad.36
        for <multiple recipients>; Wed, 12 Dec 2012 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EXeJQ9F3o9y9sAk8Qu4H1r35WCcRfqv0552iyFhwZqQ=;
        b=fiV7s61uAP/jZhKv4/+1lv150JLWGXIde+eiEVrRExqUx8NAGk/n4uJ3MDyd72uUUB
         zla5wC20K5wu2x+y+UZyKBxtzwYZ/zE0ATQTP3fv7hkOsL+9ZbTdGf5l8ksYxSbfRT5M
         nTWYgRdoJYIJ4GBWVDuoVFVY/7cE0UFa55Tc3C/5hRJLGBWzVXUU24US5JBY4zD+/uos
         bWyUgXWej+ZkJvsG272km3eXbKGvD1dUfK+GQyQ8D07d39AhIdNJ6QpuKwQCeICO0QMn
         lfmvLaDMrLjwGtY3AcmCogr4uYuxvijN1juum4A8EwL+CJkuyz33uhp7CW47PE4IO4Qd
         Qpiw==
Received: by 10.66.90.1 with SMTP id bs1mr5041374pab.19.1355339334799;
        Wed, 12 Dec 2012 11:08:54 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ip8sm16086127pbc.36.2012.12.12.11.08.53
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2012 11:08:53 -0800 (PST)
Message-ID: <50C8D644.9060103@gmail.com>
Date:   Wed, 12 Dec 2012 11:08:52 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hill, Steven" <sjhill@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Make CP0 config registers readable via sysfs.
References: <1354858280-29576-1-git-send-email-sjhill@mips.com>,<50C89870.5000704@metafoo.de> <31E06A9FC96CEC488B43B19E2957C1B801146AA779@exchdb03.mips.com> <50C8D1D4.5050200@metafoo.de>
In-Reply-To: <50C8D1D4.5050200@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35273
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 12/12/2012 10:49 AM, Lars-Peter Clausen wrote:
> On 12/12/2012 05:44 PM, Hill, Steven wrote:
>> Lars,
>>
>> This patch was requested by our DSP/Codec group to help with selecting the best user-space codecs at runtime. Simply reading /proc/cpuinfo was insufficient. I posted this patch more for feedback and interest with minimal expectations that it would make it upstream. This patch will always be in our supported branches, but I will defer to everyone else on its worth for upstream.
>>
>> -Steve
>
> Well if it is something that is useful it makes sense to upstream it,
> especially if you are developing applications. Many people before you have
> learned the hard way that stashing stuff away in their private branches was not
> the best idea. If you are smart you are going to avoid that.
>
> It may not be the best solution though to just dump all the cp register to
> userspace. As Florian suggested there might be a smarter way to solve this.


If you want to have glibc's ld.so automatically select optimal libraries 
for a given platform, then the elf_platform is the way to do it.

However I don't think this is necessarily the case here.  elf_platform 
cannot easily handle a bunch of orthogonal capabilities.  So I am in 
favor of the principle of this patch.

There should be a per CPU file (probably in 
/sys/devices/system/cpu/cpuXX) with the CP0_Config values.

One question I have is:  Should it be a single file with one row for 
each implemented Config register, or one file per register?

David Daney

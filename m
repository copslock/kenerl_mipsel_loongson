Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2012 10:49:10 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:45734 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816900Ab2LQJtGS4WbI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Dec 2012 10:49:06 +0100
Received: by mail-lb0-f177.google.com with SMTP id n10so4458522lbo.36
        for <multiple recipients>; Mon, 17 Dec 2012 01:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=4sDQm90M4KUZLH0sfmPHwP26kGvgPKATh8ItJ/Eep9g=;
        b=xDi7mrbfaPem6lQ0dMzyT1BCE+zOwrsLiGfUEVHe7jnWreh6tZpixnVMwaEN/N1xLC
         eapG0Y8buuzbLP3jzkPaEyydcYI1L8l0uL3U6ZKRtInIcldEMw4D4j2srVStUAoiAb2q
         zSAcOJGjC7zPj+ayOliVA0LJ6Bz8znv7eQMrNmvqiMKMnI4F+YL0pJfhTYtxwaK+f1vF
         GSYDPS3Lj0B2H/PRjPnif1kM7R37rjI0GHZwLHADrNKz88BDKqSAmby99PBb297KNP1i
         QGVZgBUXbg/nRGZ7NCLWJrtnLys9/V6hdiTTNN9MQdy7W3r3pCf79MOe5lqlyIsKUC0l
         93Xg==
Received: by 10.152.114.66 with SMTP id je2mr10207088lab.40.1355737740350;
        Mon, 17 Dec 2012 01:49:00 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id n7sm4664496lbg.3.2012.12.17.01.48.59
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Dec 2012 01:48:59 -0800 (PST)
Message-ID: <50CEEA0B.6030606@openwrt.org>
Date:   Mon, 17 Dec 2012 10:46:51 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH v2] MIPS: dsp: Add assembler support for DSP ASEs.
References: <1355547967-13779-1-git-send-email-sjhill@mips.com> <CAOiHx==V+owqPzFRgSYqz2VYtQoq8XevpJgfmwQLyxdLZ-52qQ@mail.gmail.com>
In-Reply-To: <CAOiHx==V+owqPzFRgSYqz2VYtQoq8XevpJgfmwQLyxdLZ-52qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35302
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

Le 12/16/12 12:42, Jonas Gorski a écrit :
> On 15 December 2012 06:06, Steven J. Hill <sjhill@mips.com> wrote:
>> (snip)
>> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
>> index 33a96a9..c3c8cba 100644
>> --- a/arch/mips/kernel/Makefile
>> +++ b/arch/mips/kernel/Makefile
>> @@ -98,4 +98,31 @@ obj-$(CONFIG_HW_PERF_EVENTS) += perf_event_mipsxx.o
>>
>>   obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
>>
>> +#
>> +# DSP ASE supported for MIPS32 or MIPS64 Release 2 cores only
>> +#
>> +ifeq ($(CONFIG_CPU_MIPSR2), y)
>> +CFLAGS_DSP                     = -DHAVE_AS_DSP
>
> 24K (non-E) is MIPS32r2, but not not implement any DSP ASEs, is this a
> problem here?

I do not think it is, all code-paths making use of the rddsp() wrdsp() 
macros are checking cpu_has_dsp() so we should be pretty safe here. It 
might be worth adding this comment to the Makefile though.
--
Florian

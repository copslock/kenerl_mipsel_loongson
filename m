Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 21:13:00 +0200 (CEST)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40593 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833463Ab3FETMzmPDxy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 21:12:55 +0200
Received: by mail-pd0-f170.google.com with SMTP id x10so2266574pdj.15
        for <multiple recipients>; Wed, 05 Jun 2013 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6Lai5vzuRgAiAapzPfIJbRbMlFy9R1ZFJfczT/J1Gm0=;
        b=f19DkHcZeDx0wYWw8mvTdyaANEfJIim/Y3MQJbZNbtn6ulQbrIXVYoguti4wghNRRU
         sY2EgTEy0BimXnSeJsDF5ITw2gdnsxbXtPKh3xSIimWIx+gGMU59pal7J1Sospm4iSRB
         VaU7tqmuN5ncePariH618TBmg//9JQzW5d3mdTjROtRjFa7HCBY0Axg8mki87dwh6GxP
         2b7prCevbmleR/7medsHtq0xIdkoUAvRH55eWaze+b+EJZqfRMzSZFBV1aesTwPSIPCO
         HnZSrwEdHH6wtYnuFq0iAgtJRiOhkVSlbWd6yrKGD3k9Ziqx/KVbQ2k61zfNa8THfgS4
         qHnA==
X-Received: by 10.68.129.197 with SMTP id ny5mr34068794pbb.180.1370459568931;
        Wed, 05 Jun 2013 12:12:48 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id vu10sm69241085pbc.27.2013.06.05.12.12.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 12:12:47 -0700 (PDT)
Message-ID: <51AF8DAE.30206@gmail.com>
Date:   Wed, 05 Jun 2013 12:12:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370455529-19621-1-git-send-email-Steven.Hill@imgtec.com> <alpine.LFD.2.03.1306052004030.15274@linux-mips.org>
In-Reply-To: <alpine.LFD.2.03.1306052004030.15274@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36700
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

On 06/05/2013 12:08 PM, Maciej W. Rozycki wrote:
> On Wed, 5 Jun 2013, Steven J. Hill wrote:
>
>> diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
>> index ff8caff..76e0205 100644
>> --- a/arch/mips/mti-malta/malta-init.c
>> +++ b/arch/mips/mti-malta/malta-init.c
>> @@ -106,6 +106,8 @@ extern struct plat_smp_ops msmtc_smp_ops;
>>
>>   void __init prom_init(void)
>>   {
>> +	set_micromips_exception_mode();
>> +
>>   	mips_display_message("LINUX");
>>
>>   	/*
>> diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
>> index bfbd17b..9e314cb 100644
>> --- a/arch/mips/mti-sead3/sead3-init.c
>> +++ b/arch/mips/mti-sead3/sead3-init.c
>> @@ -130,6 +130,8 @@ static void __init mips_ejtag_setup(void)
>>
>>   void __init prom_init(void)
>>   {
>> +	set_micromips_exception_mode();
>> +
>>   	board_nmi_handler_setup = mips_nmi_setup;
>>   	board_ejtag_handler_setup = mips_ejtag_setup;
>
>   Shouldn't this be in a generic place such as trap_init instead?
>

I think it is fine here.  If it spreads to more systems, then factoring 
them out into trap_init might make sense.  For now it doesn't seem like 
we should clutter up trap_init when there aren't many microMIPS systems 
in existence.

David Daney


>    Maciej
>
>

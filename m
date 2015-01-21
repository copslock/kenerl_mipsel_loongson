Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 19:43:06 +0100 (CET)
Received: from mail-ie0-f177.google.com ([209.85.223.177]:64954 "EHLO
        mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009730AbbAUSnF1BQOU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 19:43:05 +0100
Received: by mail-ie0-f177.google.com with SMTP id at20so17370433iec.8;
        Wed, 21 Jan 2015 10:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2Ex0ocNdtTtYvVjCoGWk6l9hQh0gu85FV37J7Ui0l6c=;
        b=sjb7esWsVzrAYwluA3uwp8iwjVkdErLIVXl06yhLWCl/QavDY2R2VCGJ855jv0W+n5
         G3O9v6Hd4FVsITSDNcrY0bRlYyVxLQxqUgLbQa/fXSCAfot8qY7l4E+p5FoHH71zo+lv
         vnmDuI4oME731KjnCkobLK40h1NoTyJFqioB0Jd7bGsPNRJ+FH0Y5ilU0X389qvPM9vk
         lSBE4UZFvhIBjN7/7y09IfcBwSoHROk7n8006maAUB7rnJdHajGvXX3hpv9+c5xm0nDC
         VnN6m8EsNhDN9eSk/95jNv774e50up+NMm+49YrZzJ0EFKpQFPyFkB/T4fli19jIKYNa
         vl1w==
X-Received: by 10.43.92.9 with SMTP id bo9mr43422050icc.54.1421865779683;
        Wed, 21 Jan 2015 10:42:59 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id vk4sm6493482igc.11.2015.01.21.10.42.58
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 10:42:59 -0800 (PST)
Message-ID: <54BFF332.1040003@gmail.com>
Date:   Wed, 21 Jan 2015 10:42:58 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org> <54BF14D2.70006@gentoo.org> <54BF7DE6.6050704@imgtec.com> <20150121183817.GB644@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20150121183817.GB644@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45421
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

On 01/21/2015 10:38 AM, Aaro Koskinen wrote:
> Hi,
>
> On Wed, Jan 21, 2015 at 10:22:30AM +0000, Markos Chandras wrote:
>> I believe this patch is mostly useful for cores that can boot in both LE
>> and BE so being able to tell the byteorder from cpuinfo can be helpful
>> at times. Having readelf and other tools in your userland may not always
>> be the case, but you surely have "cat" :)
>>
>> So that patch looks good to me but i think the #ifdefs can be avoided.
>> Can we use
>>
>> if (config_enabled(CONFIG_CPU_BIG_ENDIAN) {
>
> Kernel has already support making whole .config available in /proc
> where you can check such things.
>
You  mean like this?:

~ # zcat /proc/config.gz | grep 'CPU.*ENDIAN='
CONFIG_CPU_BIG_ENDIAN=y

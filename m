Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 15:53:28 +0100 (CET)
Received: from smtp-out-249.synserver.de ([212.40.185.249]:1080 "EHLO
        smtp-out-249.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825730Ab2LLOx2FJbuq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 15:53:28 +0100
Received: (qmail 26908 invoked by uid 0); 12 Dec 2012 14:53:26 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 26804
Received: from p4fe627b7.dip.t-dialin.net (HELO ?192.168.0.176?) [79.230.39.183]
  by 217.119.54.87 with AES256-SHA encrypted SMTP; 12 Dec 2012 14:53:26 -0000
Message-ID: <50C89A6C.705@metafoo.de>
Date:   Wed, 12 Dec 2012 15:53:32 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.10) Gecko/20121027 Icedove/10.0.10
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] OF: MIPS: sead3: Implement OF support.
References: <1354857297-28863-1-git-send-email-sjhill@mips.com> <50C894D4.4090008@openwrt.org>
In-Reply-To: <50C894D4.4090008@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 12/12/2012 03:29 PM, Florian Fainelli wrote:
> Hello Steven,
> 
> Le 12/07/12 06:14, Steven J. Hill a écrit :
> [snip]
> 
>> +/ {
>> +    #address-cells = <1>;
>> +    #size-cells = <1>;
>> +    compatible = "mips,sead-3";
>> +
>> +    cpus {
>> +        cpu@0 {
>> +            compatible = "mips,mips14Kc,mips14KEc";
>> +        };
> 
> You probably want this the other way around:
> 
> mips14KEc,mips14Kc,mips
> 
> you should always have the left-most string being the most descriptive about
> the hardware and the last one being the less descriptive and thus less
> "specializing" in order to be backward compatible.

This is one compatible string though, what you describe is for when use
multiple compatible string. E.g.
compatible = "mips14KEc", "mips14Kc", "mips";

The "mips" in Stevens patch is probably the vendor prefix. Maybe a more
correct compatible would be.

compatible = "mips,mips14KEc", "mips,mips14Kc";

But in anyway the patch should also add documentation under
Documentation/devicetree/bindings describing the binding.

> 
>> +    };
>> +
>> +    chosen {
>> +        bootargs = "console=ttyS1,38400 rootdelay=10 root=/dev/sda3";
>> +    };
>> +
>> +    memory {
>> +        device_type = "memory";
>> +        reg = <0x0 0x08000000>;
>> +    };
>> +};
>>
> 

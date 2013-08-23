Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 20:45:01 +0200 (CEST)
Received: from mail-oa0-f41.google.com ([209.85.219.41]:43063 "EHLO
        mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822345Ab3HWSo6ugQVc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Aug 2013 20:44:58 +0200
Received: by mail-oa0-f41.google.com with SMTP id j6so1210884oag.0
        for <multiple recipients>; Fri, 23 Aug 2013 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jEts101NzL0yFAnmE/pqBnQNfeBeLsq3Nys+tt1x5Qs=;
        b=0hOZd1R1tbyHSdWbqcbZgHrCU7fd7LahijluXM7fGINgWhJSBL0ZtkEpPLLgdzMK1V
         MoNIkAjoXP0s+7L9k6VpvF2i17C13DsVXnhjesojqvAt0JTSJAAxaRPlZE+h5Boz+SYS
         y5BK/SzzWg8ZArxjYTWMcMJE9xrjp5zRUzsV+dJCKQr3tRXFnYyeDwQm7NzQIV684Qx+
         6x5C6a5nRnqE4bmW6GBmDQ4k+CQHv/YcVmYHjNzq4gtBOz/vSbUpk60IXAjlH4y8FiDv
         N47/LdV+sOHitmCatBmncMbM94NufodvF+pxk9fgCQfQ/iBAV3D+SDvX20j+gBmn5Cyr
         jFdw==
X-Received: by 10.60.15.106 with SMTP id w10mr868428oec.82.1377283492627;
        Fri, 23 Aug 2013 11:44:52 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id a18sm1061389obf.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 11:44:51 -0700 (PDT)
Message-ID: <5217ADA1.4070100@gmail.com>
Date:   Fri, 23 Aug 2013 11:44:49 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 4/6] DT: MIPS: ralink: add RT2880 dts files
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org> <1365843026-11015-4-git-send-email-blogic@openwrt.org> <5217AB25.3050106@cogentembedded.com>
In-Reply-To: <5217AB25.3050106@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37669
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

On 08/23/2013 11:34 AM, Sergei Shtylyov wrote:
> On 04/13/2013 12:50 PM, John Crispin wrote:
>
>> Add a dtsi file for RT2880 SoC and a sample dts file.
>
>     You forgot to mention Kconfig entry...
>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
> [...]
>
>> diff --git a/arch/mips/ralink/dts/Makefile
>> b/arch/mips/ralink/dts/Makefile
>> index 1a69fb3..f635a01 100644
>> --- a/arch/mips/ralink/dts/Makefile
>> +++ b/arch/mips/ralink/dts/Makefile
>> @@ -1 +1,2 @@
>> +obj-$(CONFIG_DTB_RT2880_EVAL) := rt2880_eval.dtb.o
>>   obj-$(CONFIG_DTB_RT305X_EVAL) := rt3052_eval.dtb.o
>> diff --git a/arch/mips/ralink/dts/rt2880.dtsi
>> b/arch/mips/ralink/dts/rt2880.dtsi
>> new file mode 100644
>> index 0000000..182afde
>> --- /dev/null
>> +++ b/arch/mips/ralink/dts/rt2880.dtsi
>> @@ -0,0 +1,58 @@
>> +/ {
>> +    #address-cells = <1>;
>> +    #size-cells = <1>;
>> +    compatible = "ralink,rt2880-soc";
>> +
>> +    cpus {
>> +        cpu@0 {
>> +            compatible = "mips,mips4KEc";
>> +        };
>> +    };
>> +
>> +    cpuintc: cpuintc@0 {
>
>     According to ePAPR spec [1], the node name should be
> "interrupt-controller".
>
>> +        #address-cells = <0>;
>> +        #interrupt-cells = <1>;
>> +        interrupt-controller;
>> +        compatible = "mti,cpu-interrupt-controller";
>
>     So, it's "mips" or "mti"?

I agree that it should be consistent.  vendor-prefixes.txt doesn't have 
an entry for MIPS, so ...

Isn't this the CP0 interrupt controller?  I wonder if something like:

"mips,r4k-cp0-interrupt-controller" might be more descriptive.

David Daney

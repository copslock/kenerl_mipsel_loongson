Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2018 06:05:18 +0200 (CEST)
Received: from mga07.intel.com ([134.134.136.100]:60239 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992907AbeHHEFOLJixR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Aug 2018 06:05:14 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 21:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="scan'208";a="79467487"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.42]) ([10.226.39.42])
  by fmsmga001.fm.intel.com with ESMTP; 07 Aug 2018 21:05:08 -0700
Subject: Re: [PATCH v2 08/18] serial: intel: Get serial id from dts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-9-songjun.wu@linux.intel.com>
 <CAMuHMdXkGchPN337dXbBVOFsb1o-Tkh8S_z=uCm3Z0sDjPVMKA@mail.gmail.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <734bddbc-a5aa-d50d-0e7b-d8adc4d1afb2@linux.intel.com>
Date:   Wed, 8 Aug 2018 12:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXkGchPN337dXbBVOFsb1o-Tkh8S_z=uCm3Z0sDjPVMKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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



On 8/7/2018 3:33 PM, Geert Uytterhoeven wrote:
> Hi Songjun,
>
> On Fri, Aug 3, 2018 at 5:04 AM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> Get serial id from dts.
>>
>> "#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
>> macro is defined in lantiq_soc.h.
>> lantiq_soc.h is in arch path for legacy product support.
>>
>> arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
>>
>> If "#ifdef preprocessor" is changed to
>> "if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
>> code using LTQ_EARLY_ASC is compiled.
>> Compilation will fail for no LTQ_EARLY_ASC defined.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> Thanks for your patch!
>
>> @@ -699,9 +700,19 @@ lqasc_probe(struct platform_device *pdev)
>>                  return -ENODEV;
>>          }
>>
>> -       /* check if this is the console port */
>> -       if (mmres->start != CPHYSADDR(LTQ_EARLY_ASC))
>> -               line = 1;
>> +       /* get serial id */
>> +       line = of_alias_get_id(node, "serial");
>> +       if (line < 0) {
>> +#ifdef CONFIG_LANTIQ
>> +               if (mmres->start == CPHYSADDR(LTQ_EARLY_ASC))
>> +                       line = 0;
>> +               else
>> +                       line = 1;
>> +#else
>> +               dev_err(&pdev->dev, "failed to get alias id, errno %d\n", line);
>> +               return line;
> Please note that not providing a fallback here makes life harder when using
> DT overlays.
> See the description of commit 7678f4c20fa7670f ("serial: sh-sci: Add support
> for dynamic instances") for background info.
Thanks for your comment.
The logic in commit 7678f4c20fa7670f is not suitable here.
We need to know which serial instance is used for console.
We cannot use dynamic serial instance here.

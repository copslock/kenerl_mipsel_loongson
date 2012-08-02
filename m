Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2012 06:42:17 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:39109 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903482Ab2HBEmJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2012 06:42:09 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q724fw28020449
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 1 Aug 2012 21:42:00 -0700 (PDT)
Received: from [128.224.162.155] (128.224.162.155) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.309.2; Wed, 1 Aug
 2012 21:41:56 -0700
Message-ID: <501A05D7.5060005@windriver.com>
Date:   Thu, 2 Aug 2012 12:45:11 +0800
From:   Fan Du <fan.du@windriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Fan Du <fdu@windriver.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        vincent wen <vincentwenlinux@gmail.com>
Subject: Re: [PATCH] MIPS: oops when show backtrace of all active cpu
References: <1343878276-4108-1-git-send-email-fdu@windriver.com> <CAJiQ=7Abc2sR2E2FXmeTr_Hc+CWH+J25=juB3wL172Tn6-PYuA@mail.gmail.com>
In-Reply-To: <CAJiQ=7Abc2sR2E2FXmeTr_Hc+CWH+J25=juB3wL172Tn6-PYuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [128.224.162.155]
X-archive-position: 34019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fan.du@windriver.com
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



On 2012年08月02日 12:18, Kevin Cernekee wrote:
> On Wed, Aug 1, 2012 at 8:31 PM, Fan Du<fdu@windriver.com>  wrote:
>> show_backtrace must have an valid task when calling unwind_stack,
>> so fix it by checking first.
> [...]
>> --- a/arch/mips/kernel/traps.c
>> +++ b/arch/mips/kernel/traps.c
>> @@ -151,6 +151,10 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs)
>>                  show_raw_backtrace(sp);
>>                  return;
>>          }
>> +
>> +       if (task == NULL)
>> +               task = current;
>> +
>>          printk("Call Trace:\n");
>>          do {
>>                  print_ip_sym(pc);
>
> FYI, a slightly different version of this change was accepted:
>
> https://patchwork.linux-mips.org/patch/3524/
>
>

Oh, Looks like I'm late :)
thanks anyway.


-- 

Love each day!
--fan

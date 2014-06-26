Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2014 23:55:45 +0200 (CEST)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:46016 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817913AbaFZVznnve9L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jun 2014 23:55:43 +0200
Received: by mail-ig0-f177.google.com with SMTP id c1so1251234igq.4
        for <multiple recipients>; Thu, 26 Jun 2014 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ouj4f8rEMURVsw11moyCkkyzks8qvJ0xW25TC4eGjns=;
        b=UwsJgYMkG8HMHd8NFLwOyOnseytvxROQSwSyzhfasrWdm5BPd26ZaCdJBenfeaDFdu
         pLqoVWzVqWjvp3ukl/OK4/urPyz/5IXWc8UTmc52+0Zsr1TgTj8ta9hxbuIC8NiwXsI5
         XLA5f6O0cu3nB6pOMbARj/OWIt9rh+Mvkek+zRLRyfYccLJv6MDtPSZqKBBA06hSFr6E
         tSDLLxpqnkRSoTjvQLn1rmRR47uzt8rEb6fJzV5koaaYA0B0ggxNtFirRtBMeywtqJrW
         eVSVcKhOVDJIngIkNKSUoY5SAoQzkGaL6e11pnNNGguOEtL3H2w88ligT1R5bqiDQNW9
         N6Zg==
X-Received: by 10.50.61.234 with SMTP id t10mr7687677igr.38.1403819737412;
        Thu, 26 Jun 2014 14:55:37 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id jc2sm7678214igb.19.2014.06.26.14.55.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 14:55:37 -0700 (PDT)
Message-ID: <53AC96D7.8040208@gmail.com>
Date:   Thu, 26 Jun 2014 14:55:35 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
CC:     pbonzini@redhat.com, gleb@kernel.org, kvm@vger.kernel.org,
        sanjayl@kymasys.com, james.hogan@imgtec.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v4 5/7] MIPS: KVM: Rename files to remove the prefix "kvm_"
 and "kvm_mips_"
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com> <1403809900-17454-6-git-send-email-dengcheng.zhu@imgtec.com> <53AC7466.6070401@gmail.com> <53AC7AAD.7010007@imgtec.com>
In-Reply-To: <53AC7AAD.7010007@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40861
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

On 06/26/2014 12:55 PM, Deng-Cheng Zhu wrote:
> On 06/26/2014 12:28 PM, David Daney wrote:
>> On 06/26/2014 12:11 PM, Deng-Cheng Zhu wrote:
>>> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>>
>>> Since all the files are in arch/mips/kvm/, there's no need of the
>>> prefixes
>>> "kvm_" and "kvm_mips_".
>>>
>>
>> I don't like this change.
>>
>> It will leads me to confuse arch/mips/kvm/interrupt.h with
>> include/linux/interrupt.h
>
> We have <linux/interrupt.h> and "interrupt.h".
>
>>
>> x86 calls these things irq.c and irq.h, perhaps that would be a little
>> better.
>
> There's also include/linux/irq.h
>

Yes, I know.

>>
>> There is precedence in x86 for some of the names though.
>>
>> But really why churn up the code in the first place?  the kvm_mips
>> prefix does tell us exactly what we are dealing with.
>
> That's why people created the arch/mips/kvm directory, isn't it?

No.  Segregating things into directories keeps code related to one 
functional area together.

File names are different.  They should carry as much meaning as possible.

For examples of this look at some of these directories:

drivers/net/ethernet/intel/ixgb
drivers/i2c/busses

It is not bad to have a filename prefix related to the function of the 
files.


>
>
> Deng-Cheng
>
>
>

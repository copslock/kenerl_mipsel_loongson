Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 02:32:33 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:39045 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860043AbaF0Aca3qul0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 02:32:30 +0200
Received: by mail-ie0-f171.google.com with SMTP id x19so3764693ier.2
        for <multiple recipients>; Thu, 26 Jun 2014 17:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XLf0OwuF97/uSCr2YqIaYUgLEPJgz+FDSfJBrNa751M=;
        b=RZU6xtcz3m2mTWCOuHFAPsCJlI5sSwsgojYaD+x3EBzwosP6jxqvMkJPiX2zJ3NZ+R
         fQx2LIsZCspCa/39ewuRSrnC1/O44CJuJC1vb5nKS+8LE7b+lGnO3cd50lcAJD981Igq
         ZdqDWXwXF9paJEn36M+wgotzu5Zx+FqeTMKD8uGxs0VfwZOfokF1ZBC/VN7LSry4mD3R
         fM54XW7IS/npa0oIYsDM1fERb1CGNe4RgaGKUpquzAKSI23w7HtGZoHjqXCa/TINSeIG
         er7dVhfkQ/EdJqRMhq8o8FfPN2emRNRPVIzwY/XNQlUuVhS6TglGvH029iIQoayHIkQE
         Imog==
X-Received: by 10.50.77.34 with SMTP id p2mr8491721igw.31.1403829143931;
        Thu, 26 Jun 2014 17:32:23 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ga11sm8743549igd.8.2014.06.26.17.32.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 17:32:23 -0700 (PDT)
Message-ID: <53ACBB96.9030803@gmail.com>
Date:   Thu, 26 Jun 2014 17:32:22 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v4 5/7] MIPS: KVM: Rename files to remove the prefix "kvm_"
 and "kvm_mips_"
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com> <1403809900-17454-6-git-send-email-dengcheng.zhu@imgtec.com> <53AC7466.6070401@gmail.com> <53AC7AAD.7010007@imgtec.com> <53AC96D7.8040208@gmail.com> <CAAG0J99aDdsku1ZXX=aBxK4NVwEZK2wa+gV638yZN735qZnT+A@mail.gmail.com>
In-Reply-To: <CAAG0J99aDdsku1ZXX=aBxK4NVwEZK2wa+gV638yZN735qZnT+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40863
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

On 06/26/2014 04:21 PM, James Hogan wrote:
> On 26 June 2014 22:55, David Daney <ddaney.cavm@gmail.com> wrote:
>>>> There is precedence in x86 for some of the names though.
>>>>
>>>> But really why churn up the code in the first place?  the kvm_mips
>>>> prefix does tell us exactly what we are dealing with.
>>>
>>>
>>> That's why people created the arch/mips/kvm directory, isn't it?
>>
>>
>> No.  Segregating things into directories keeps code related to one
>> functional area together.
>>
>> File names are different.  They should carry as much meaning as possible.
>>
>> For examples of this look at some of these directories:
>>
>> drivers/net/ethernet/intel/ixgb
>> drivers/i2c/busses
>>
>> It is not bad to have a filename prefix related to the function of the
>> files.
>
> Hi David,
>
> More importantly if you look in arch/*/kvm/, very few of the files
> have kvm in their names except for mips.
>
> Personally I find the filenames Deng-Cheng is suggesting must less
> cumbersome to type. Most of the files start with kvm_mips_ at the
> moment, which is completely redundant.
>
> As for churn, renaming the files hardly produces much churn compared
> to cleaning up coding style issues like some of the other patches, but
> I still think even they are worth doing.

I have expressed my opinion.  I don't want to spend any more time on it.

Let the maintainers decide what they want to do.

David Daney

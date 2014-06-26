Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 01:21:58 +0200 (CEST)
Received: from mail-oa0-f45.google.com ([209.85.219.45]:50799 "EHLO
        mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860042AbaFZXV4friw2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 01:21:56 +0200
Received: by mail-oa0-f45.google.com with SMTP id o6so4707809oag.4
        for <linux-mips@linux-mips.org>; Thu, 26 Jun 2014 16:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=I2lSVkwV+QIDIVH9kxfuS4I8O7vGe6AsdP/sbZVGu+I=;
        b=dKTtzXxUEdGx8oWCyyol32F1NToUp+8F9WdemkgHW/Mq3HBvbafHhdT1KRy5jA2Y9r
         BpeWCrW/LEeaI7oTB3LuYwqRigDzjZyLh4uOgz9Wsi28uQljH4Pk17TytpcEaHt54PoM
         6JDh2OwrVdSwO86KjeVTpHBmEUGoDoFOnkBsjV4QCTobn274LtV4jQroaEvS6EFiBxUS
         mtgauy2xnL1HgvDnQHWCAfvf+J8esZgnQnVJIW5AvOaf+Rs4tP+VuPMNCr8WqSThlD3I
         eCU11kJ9WDfDLE7FT6ymsg5ON9J1JlBmZJnqK8nYzne2iNrknrbxeQ674sooNparnfJq
         HyvQ==
X-Gm-Message-State: ALoCoQmEfnRJdfrnenyloN232/H2UlThQhUGyX/pT9tLzvKefhfZtMQsPcfYM+K4OPMH1oFDgPTc
MIME-Version: 1.0
X-Received: by 10.60.57.3 with SMTP id e3mr19158298oeq.33.1403824909842; Thu,
 26 Jun 2014 16:21:49 -0700 (PDT)
Received: by 10.202.81.137 with HTTP; Thu, 26 Jun 2014 16:21:49 -0700 (PDT)
X-Originating-IP: [212.159.75.221]
In-Reply-To: <53AC96D7.8040208@gmail.com>
References: <1403809900-17454-1-git-send-email-dengcheng.zhu@imgtec.com>
        <1403809900-17454-6-git-send-email-dengcheng.zhu@imgtec.com>
        <53AC7466.6070401@gmail.com>
        <53AC7AAD.7010007@imgtec.com>
        <53AC96D7.8040208@gmail.com>
Date:   Fri, 27 Jun 2014 00:21:49 +0100
X-Google-Sender-Auth: oZezDuzGQe5ylDPP16cook71Bfc
Message-ID: <CAAG0J99aDdsku1ZXX=aBxK4NVwEZK2wa+gV638yZN735qZnT+A@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] MIPS: KVM: Rename files to remove the prefix
 "kvm_" and "kvm_mips_"
From:   James Hogan <james.hogan@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 26 June 2014 22:55, David Daney <ddaney.cavm@gmail.com> wrote:
>>> There is precedence in x86 for some of the names though.
>>>
>>> But really why churn up the code in the first place?  the kvm_mips
>>> prefix does tell us exactly what we are dealing with.
>>
>>
>> That's why people created the arch/mips/kvm directory, isn't it?
>
>
> No.  Segregating things into directories keeps code related to one
> functional area together.
>
> File names are different.  They should carry as much meaning as possible.
>
> For examples of this look at some of these directories:
>
> drivers/net/ethernet/intel/ixgb
> drivers/i2c/busses
>
> It is not bad to have a filename prefix related to the function of the
> files.

Hi David,

More importantly if you look in arch/*/kvm/, very few of the files
have kvm in their names except for mips.

Personally I find the filenames Deng-Cheng is suggesting must less
cumbersome to type. Most of the files start with kvm_mips_ at the
moment, which is completely redundant.

As for churn, renaming the files hardly produces much churn compared
to cleaning up coding style issues like some of the other patches, but
I still think even they are worth doing.

Cheers
James

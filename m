Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2014 17:17:44 +0200 (CEST)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:62185 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6837167AbaD1PRUq0M11 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Apr 2014 17:17:20 +0200
Received: by mail-ob0-f176.google.com with SMTP id wp4so7360008obc.21
        for <linux-mips@linux-mips.org>; Mon, 28 Apr 2014 08:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=F3z8+LmuNU6tuRNARkQNoJ9hEaD7kc23j1Q4MFwMntc=;
        b=AgCEA/wNtRSYUnOfL8hMLvc6sF7l8K43tBL1xEPd331PQtwoRsCwL29SD3KEIuMqRs
         i3PmE1Oe4VIKboEKfXwpPnPrU4N/s6EzdHD+Lf3F1+eou5lS6hLziSLMlo+MGuUZAe+s
         SmYUlwgxXCClgw9XXwhtQ4JtXJ69GiaBDVV7ucVOcqAg4+iEmf68KW30FqklKTeMN8Gc
         PfvOr7wuoLnuyjkrFJdODwJaX7phzowGXJE9EUcSW/9j+4sCopCDrON0vLE8gc1VKX6F
         0ZwZKFPjyihvyj9kgmQuQnXn5KgCKLZcD1Gma6nNStjOvoSvNqID4735b7RvEhc+etAk
         EWzg==
X-Gm-Message-State: ALoCoQlP3JiYj1VQ5kPAywjhyUxC5d/o+155kqsLMXmU+GfubBCN9pHpkzfslyk63AKLDpszenH8
MIME-Version: 1.0
X-Received: by 10.60.69.71 with SMTP id c7mr1079294oeu.82.1398698234356; Mon,
 28 Apr 2014 08:17:14 -0700 (PDT)
Received: by 10.76.124.165 with HTTP; Mon, 28 Apr 2014 08:17:14 -0700 (PDT)
X-Originating-IP: [217.156.156.35]
In-Reply-To: <535E4310.10308@redhat.com>
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com>
        <1398439204-26171-15-git-send-email-james.hogan@imgtec.com>
        <535E4310.10308@redhat.com>
Date:   Mon, 28 Apr 2014 16:17:14 +0100
X-Google-Sender-Auth: KWAA9xMj8wvp0gy1v2rqwXeeJQo
Message-ID: <CAAG0J981KYb6vqC7FZ1=cJykj3Pmk02FwPGQvVFuZaowHzAMFg@mail.gmail.com>
Subject: Re: [PATCH 14/21] MIPS: KVM: Add nanosecond count bias KVM register
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39964
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

Hi Paolo,

On 28 April 2014 13:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 25/04/2014 17:19, James Hogan ha scritto:
>
>> Expose the KVM guest CP0_Count bias (from the monotonic kernel time) to
>> userland in nanosecond units via a new KVM_REG_MIPS_COUNT_BIAS register
>> accessible with the KVM_{GET,SET}_ONE_REG ioctls. This gives userland
>> control of the bias so that it can exactly match its own monotonic time.
>>
>> The nanosecond bias is stored separately from the raw bias used
>> internally (since nanoseconds isn't a convenient or efficient unit for
>> various timer calculations), and is recalculated each time the raw count
>> bias is altered. The raw count bias used in CP0_Count determination is
>> recalculated when the nanosecond bias is altered via the KVM_SET_ONE_REG
>> ioctl.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Gleb Natapov <gleb@kernel.org>
>> Cc: kvm@vger.kernel.org
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Cc: David Daney <david.daney@cavium.com>
>> Cc: Sanjay Lal <sanjayl@kymasys.com>
>
>
> If it is possible and not too hairy to use a raw value in userspace
> (together with KVM_REG_MIPS_COUNT_HZ), please do it---my suggestions were
> just that, a suggestion.  Otherwise, the patch looks good.

Do you mean expose the raw internal offset to userland instead of the
nanosecond one? Yeh it should be possible & slightly simpler for both
kernel and Qemu actually.

Qemu could then store that value (or the Count register) straight into
env->CP0_Count (depending on Cause.DC), then hw/mips/cputimer.c would
pretty much continue to work accurately. cputimer.c is only really
made use of by tcg at the moment though (reading/writing
count/compare/cause.DC), but it still makes sense to be consistent.

Cheers
James

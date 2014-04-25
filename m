Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2014 19:27:28 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40924 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843065AbaDYR10Ui6sd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2014 19:27:26 +0200
Received: by mail-ie0-f173.google.com with SMTP id rl12so4130910iec.32
        for <multiple recipients>; Fri, 25 Apr 2014 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=fxMTSjQlbJhnxn1alojTS/pGlnMq7WiNBMUNv/qLj5c=;
        b=m5ftOurQam5EoJpJaLjT9xx56HTpAdPHMhY0a3d0/WjEr67ZPDINC86xT1lE8rCsuu
         x/2J0BbmtQ05Kf7eQhXNcqU0KPvleU4W3jszsLufZL4vrqpcJkl4sqF+CNf+5bAP0zkg
         q0qYRSEvuzmpwiGiR/c/IfTkea27UgAR/iclSbkTRmmbiBiKtl3JNYVpoULkAojdwFOh
         6IDfRIc9DCvHG3PVpEQ2L/4dDPPvRYPExcCAtiKrNOQycbppdWkC59RZFXBW+GyqmBVe
         nJFysIP54NvtYIrE4GW77AJpLIfEgZNLiFOpyaiaVzOwhD/+PsVeYL1ynkyLY2cO0gTL
         0YCQ==
X-Received: by 10.42.67.130 with SMTP id t2mr8359552ici.17.1398446840310;
        Fri, 25 Apr 2014 10:27:20 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id lp5sm10234761igb.1.2014.04.25.10.27.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 10:27:18 -0700 (PDT)
Message-ID: <535A9AF5.30105@gmail.com>
Date:   Fri, 25 Apr 2014 10:27:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Gleb Natapov <gleb@kernel.org>, kvm@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: Re: [PATCH 14/21] MIPS: KVM: Add nanosecond count bias KVM register
References: <1398439204-26171-1-git-send-email-james.hogan@imgtec.com> <1398439204-26171-15-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1398439204-26171-15-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39951
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

On 04/25/2014 08:19 AM, James Hogan wrote:
> Expose the KVM guest CP0_Count bias (from the monotonic kernel time) to
> userland in nanosecond units via a new KVM_REG_MIPS_COUNT_BIAS register
> accessible with the KVM_{GET,SET}_ONE_REG ioctls. This gives userland
> control of the bias so that it can exactly match its own monotonic time.
>
> The nanosecond bias is stored separately from the raw bias used
> internally (since nanoseconds isn't a convenient or efficient unit for
> various timer calculations), and is recalculated each time the raw count
> bias is altered. The raw count bias used in CP0_Count determination is
> recalculated when the nanosecond bias is altered via the KVM_SET_ONE_REG
> ioctl.
>

Is this really necessary?

The architecture has CP0_COUNT.  How does the concept of this noew 
synthetic bias value interact with the architecture's CP0_COUNT?

It seems like by adding this you new have two ways to access and 
manipulate the same thing.

1) The architecturally specified CP0_COUNT.
2) This new bias thing.

What if we just let userspace directly manipulate the CP0_COUNT, and if 
necessary only maintain a bias as an internal implementation detail?

David Daney.

> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: kvm@vger.kernel.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: David Daney <david.daney@cavium.com>
> Cc: Sanjay Lal <sanjayl@kymasys.com>
> ---
>   arch/mips/include/asm/kvm_host.h |  3 +++
>   arch/mips/include/uapi/asm/kvm.h |  9 ++++++++
>   arch/mips/kvm/kvm_mips.c         |  3 +++
>   arch/mips/kvm/kvm_mips_emul.c    | 46 ++++++++++++++++++++++++++++++++++++++++
>   arch/mips/kvm/kvm_trap_emul.c    |  6 ++++++
>   5 files changed, 67 insertions(+)
>

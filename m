Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 19:15:50 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:36644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27024946AbcFWRPpqLpNz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Jun 2016 19:15:45 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E2C46439A;
        Thu, 23 Jun 2016 17:15:37 +0000 (UTC)
Received: from [10.36.112.75] (ovpn-112-75.ams2.redhat.com [10.36.112.75])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5NHFXnR008923
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 23 Jun 2016 13:15:34 -0400
Subject: Re: [PATCH] MIPS: KVM: Combine entry trace events into class
To:     James Hogan <james.hogan@imgtec.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <1466183980-11264-1-git-send-email-james.hogan@imgtec.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7dc4d017-8eed-84e8-a721-34637b6c71a1@redhat.com>
Date:   Thu, 23 Jun 2016 19:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1466183980-11264-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 23 Jun 2016 17:15:37 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 17/06/2016 19:19, James Hogan wrote:
> Combine the kvm_enter, kvm_reenter and kvm_out trace events into a
> single kvm_transition event class to reduce duplication and bloat.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 93258604ab6d ("MIPS: KVM: Add guest mode switch trace events")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org
> ---
>  arch/mips/kvm/trace.h | 62 ++++++++++++++++++---------------------------------
>  1 file changed, 22 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/mips/kvm/trace.h b/arch/mips/kvm/trace.h
> index 75f1fda08f70..e7d140fc574e 100644
> --- a/arch/mips/kvm/trace.h
> +++ b/arch/mips/kvm/trace.h
> @@ -20,50 +20,32 @@
>  /*
>   * Tracepoints for VM enters
>   */
> -TRACE_EVENT(kvm_enter,
> -	    TP_PROTO(struct kvm_vcpu *vcpu),
> -	    TP_ARGS(vcpu),
> -	    TP_STRUCT__entry(
> -			__field(unsigned long, pc)
> -	    ),
> -
> -	    TP_fast_assign(
> -			__entry->pc = vcpu->arch.pc;
> -	    ),
> -
> -	    TP_printk("PC: 0x%08lx",
> -		      __entry->pc)
> +DECLARE_EVENT_CLASS(kvm_transition,
> +	TP_PROTO(struct kvm_vcpu *vcpu),
> +	TP_ARGS(vcpu),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, pc)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pc = vcpu->arch.pc;
> +	),
> +
> +	TP_printk("PC: 0x%08lx",
> +		  __entry->pc)
>  );
>  
> -TRACE_EVENT(kvm_reenter,
> -	    TP_PROTO(struct kvm_vcpu *vcpu),
> -	    TP_ARGS(vcpu),
> -	    TP_STRUCT__entry(
> -			__field(unsigned long, pc)
> -	    ),
> +DEFINE_EVENT(kvm_transition, kvm_enter,
> +	     TP_PROTO(struct kvm_vcpu *vcpu),
> +	     TP_ARGS(vcpu));
>  
> -	    TP_fast_assign(
> -			__entry->pc = vcpu->arch.pc;
> -	    ),
> -
> -	    TP_printk("PC: 0x%08lx",
> -		      __entry->pc)
> -);
> +DEFINE_EVENT(kvm_transition, kvm_reenter,
> +	     TP_PROTO(struct kvm_vcpu *vcpu),
> +	     TP_ARGS(vcpu));
>  
> -TRACE_EVENT(kvm_out,
> -	    TP_PROTO(struct kvm_vcpu *vcpu),
> -	    TP_ARGS(vcpu),
> -	    TP_STRUCT__entry(
> -			__field(unsigned long, pc)
> -	    ),
> -
> -	    TP_fast_assign(
> -			__entry->pc = vcpu->arch.pc;
> -	    ),
> -
> -	    TP_printk("PC: 0x%08lx",
> -		      __entry->pc)
> -);
> +DEFINE_EVENT(kvm_transition, kvm_out,
> +	     TP_PROTO(struct kvm_vcpu *vcpu),
> +	     TP_ARGS(vcpu));
>  
>  /* The first 32 exit reasons correspond to Cause.ExcCode */
>  #define KVM_TRACE_EXIT_INT		 0
> 

Queued, thanks.

Paolo

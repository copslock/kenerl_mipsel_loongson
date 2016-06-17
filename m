Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 16:08:54 +0200 (CEST)
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:38523 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27042813AbcFQOIwx0olw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 16:08:52 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 41B3C2691B5;
        Fri, 17 Jun 2016 14:08:51 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: unit19_4d2013bf4b616
X-Filterd-Recvd-Size: 2576
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Jun 2016 14:08:49 +0000 (UTC)
Date:   Fri, 17 Jun 2016 10:08:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 5/8] MIPS: KVM: Add guest mode switch trace events
Message-ID: <20160617100848.4a91b313@gandalf.local.home>
In-Reply-To: <1465893617-5774-6-git-send-email-james.hogan@imgtec.com>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
        <1465893617-5774-6-git-send-email-james.hogan@imgtec.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Tue, 14 Jun 2016 09:40:14 +0100
James Hogan <james.hogan@imgtec.com> wrote:


> --- a/arch/mips/kvm/trace.h
> +++ b/arch/mips/kvm/trace.h
> @@ -17,6 +17,54 @@
>  #define TRACE_INCLUDE_PATH .
>  #define TRACE_INCLUDE_FILE trace
>  
> +/*
> + * Tracepoints for VM enters
> + */
> +TRACE_EVENT(kvm_enter,
> +	    TP_PROTO(struct kvm_vcpu *vcpu),
> +	    TP_ARGS(vcpu),
> +	    TP_STRUCT__entry(
> +			__field(unsigned long, pc)
> +	    ),
> +
> +	    TP_fast_assign(
> +			__entry->pc = vcpu->arch.pc;
> +	    ),
> +
> +	    TP_printk("PC: 0x%08lx",
> +		      __entry->pc)
> +);
> +
> +TRACE_EVENT(kvm_reenter,
> +	    TP_PROTO(struct kvm_vcpu *vcpu),
> +	    TP_ARGS(vcpu),
> +	    TP_STRUCT__entry(
> +			__field(unsigned long, pc)
> +	    ),
> +
> +	    TP_fast_assign(
> +			__entry->pc = vcpu->arch.pc;
> +	    ),
> +
> +	    TP_printk("PC: 0x%08lx",
> +		      __entry->pc)
> +);
> +
> +TRACE_EVENT(kvm_out,
> +	    TP_PROTO(struct kvm_vcpu *vcpu),
> +	    TP_ARGS(vcpu),
> +	    TP_STRUCT__entry(
> +			__field(unsigned long, pc)
> +	    ),
> +
> +	    TP_fast_assign(
> +			__entry->pc = vcpu->arch.pc;
> +	    ),
> +
> +	    TP_printk("PC: 0x%08lx",
> +		      __entry->pc)
> +);

Please combine the above TRACE_EVENT()s to use a single
DECLARE_EVENT_CLASS() and three DEFINE_EVENT()s.

-- Steve

> +
>  /* The first 32 exit reasons correspond to Cause.ExcCode */
>  #define KVM_TRACE_EXIT_INT		 0
>  #define KVM_TRACE_EXIT_TLBMOD		 1

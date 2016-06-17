Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 16:10:33 +0200 (CEST)
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:44722 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27042813AbcFQOK3iT1mw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 16:10:29 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id AFD4F23411;
        Fri, 17 Jun 2016 14:10:27 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: toy64_5b2a251394816
X-Filterd-Recvd-Size: 1645
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Jun 2016 14:10:26 +0000 (UTC)
Date:   Fri, 17 Jun 2016 10:10:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/8] MIPS: KVM: Clean up kvm_exit trace event
Message-ID: <20160617101025.3ae9e691@gandalf.local.home>
In-Reply-To: <1465893617-5774-4-git-send-email-james.hogan@imgtec.com>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
        <1465893617-5774-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54095
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

On Tue, 14 Jun 2016 09:40:12 +0100
James Hogan <james.hogan@imgtec.com> wrote:


>  TRACE_EVENT(kvm_exit,
>  	    TP_PROTO(struct kvm_vcpu *vcpu, unsigned int reason),
> @@ -34,7 +71,8 @@ TRACE_EVENT(kvm_exit,
>  	    ),
>  
>  	    TP_printk("[%s]PC: 0x%08lx",
> -		      kvm_mips_exit_types_str[__entry->reason],
> +		      __print_symbolic(__entry->reason,
> +				       kvm_trace_symbol_exit_types),
>  		      __entry->pc)
>  );
>  

BTW, I'm curious. Can you show me what you see in:

 /sys/kernel/debug/tracing/events/kvm/kvm_exit/format

Thanks!

-- Steve

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 16:29:54 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:40069 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27042813AbcFQO3v0V0on (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 16:29:51 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16C928E900;
        Fri, 17 Jun 2016 14:29:42 +0000 (UTC)
Received: from [10.36.112.68] (ovpn-112-68.ams2.redhat.com [10.36.112.68])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u5HETbBE001210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 17 Jun 2016 10:29:39 -0400
Subject: Re: [PATCH 5/8] MIPS: KVM: Add guest mode switch trace events
To:     Steven Rostedt <rostedt@goodmis.org>,
        James Hogan <james.hogan@imgtec.com>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
 <1465893617-5774-6-git-send-email-james.hogan@imgtec.com>
 <20160617100848.4a91b313@gandalf.local.home>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b6e9e4e-3cbb-9c6e-bfa7-390f8a4f8d24@redhat.com>
Date:   Fri, 17 Jun 2016 16:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160617100848.4a91b313@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 17 Jun 2016 14:29:42 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54096
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



On 17/06/2016 16:08, Steven Rostedt wrote:
>> > +/*
>> > + * Tracepoints for VM enters
>> > + */
>> > +TRACE_EVENT(kvm_enter,
>> > +	    TP_PROTO(struct kvm_vcpu *vcpu),
>> > +	    TP_ARGS(vcpu),
>> > +	    TP_STRUCT__entry(
>> > +			__field(unsigned long, pc)
>> > +	    ),
>> > +
>> > +	    TP_fast_assign(
>> > +			__entry->pc = vcpu->arch.pc;
>> > +	    ),
>> > +
>> > +	    TP_printk("PC: 0x%08lx",
>> > +		      __entry->pc)
>> > +);
>> > +
>> > +TRACE_EVENT(kvm_reenter,
>> > +	    TP_PROTO(struct kvm_vcpu *vcpu),
>> > +	    TP_ARGS(vcpu),
>> > +	    TP_STRUCT__entry(
>> > +			__field(unsigned long, pc)
>> > +	    ),
>> > +
>> > +	    TP_fast_assign(
>> > +			__entry->pc = vcpu->arch.pc;
>> > +	    ),
>> > +
>> > +	    TP_printk("PC: 0x%08lx",
>> > +		      __entry->pc)
>> > +);
>> > +
>> > +TRACE_EVENT(kvm_out,
>> > +	    TP_PROTO(struct kvm_vcpu *vcpu),
>> > +	    TP_ARGS(vcpu),
>> > +	    TP_STRUCT__entry(
>> > +			__field(unsigned long, pc)
>> > +	    ),
>> > +
>> > +	    TP_fast_assign(
>> > +			__entry->pc = vcpu->arch.pc;
>> > +	    ),
>> > +
>> > +	    TP_printk("PC: 0x%08lx",
>> > +		      __entry->pc)
>> > +);
> 
> Please combine the above TRACE_EVENT()s to use a single
> DECLARE_EVENT_CLASS() and three DEFINE_EVENT()s.

James,

I've committed the patch already, so please send a follow up.

Thanks,

Paolo

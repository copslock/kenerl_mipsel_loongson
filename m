Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 17:35:16 +0200 (CEST)
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:50876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27042843AbcFQPfMInj1f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2016 17:35:12 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4AFB812BA15;
        Fri, 17 Jun 2016 15:35:10 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: fall84_672d625caac4d
X-Filterd-Recvd-Size: 2439
Received: from gandalf.local.home (cpe-67-246-153-56.stny.res.rr.com [67.246.153.56])
        (Authenticated sender: rostedt@goodmis.org)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Jun 2016 15:35:08 +0000 (UTC)
Date:   Fri, 17 Jun 2016 11:35:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/8] MIPS: KVM: Clean up kvm_exit trace event
Message-ID: <20160617113507.7e09b997@gandalf.local.home>
In-Reply-To: <20160617144746.GM30921@jhogan-linux.le.imgtec.org>
References: <1465893617-5774-1-git-send-email-james.hogan@imgtec.com>
        <1465893617-5774-4-git-send-email-james.hogan@imgtec.com>
        <20160617101025.3ae9e691@gandalf.local.home>
        <20160617144746.GM30921@jhogan-linux.le.imgtec.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54102
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

On Fri, 17 Jun 2016 15:47:46 +0100
James Hogan <james.hogan@imgtec.com> wrote:

> > BTW, I'm curious. Can you show me what you see in:
> > 
> >  /sys/kernel/debug/tracing/events/kvm/kvm_exit/format  
> 
> Sure:
> 
> name: kvm_exit
> ID: 472
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:unsigned long pc;	offset:8;	size:4;	signed:0;
> 	field:unsigned int reason;	offset:12;	size:4;	signed:0;
> 
> print fmt: "[%s]PC: 0x%08lx", __print_symbolic(REC->reason, { 0, "Interrupt" }, { 1, "TLB Mod" }, { 2, "TLB Miss (LD)" }, { 3, "TLB Miss (ST)" }, { 4, "Address Error (LD)" }, { 5, "Address Err (ST)" }, { 8, "System Call" }, { 9, "Break Inst" }, { 10, "Reserved Inst" }, { 11, "COP0/1 Unusable" }, { 13, "Trap Inst" }, { 14, "MSA FPE" }, { 15, "FPE" }, { 21, "MSA Disabled" }, { 32, "WAIT" }, { 33, "CACHE" }, { 34, "Signal" }), REC->pc

OK, cool. I just wanted to make sure that there were numbers there.
Otherwise you would need to use the TRACE_DEFINE_ENUM() trick like what
is done in include/trace/events/writeback.h

-- Steve

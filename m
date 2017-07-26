Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2017 16:42:29 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:26026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992036AbdGZOmSm3Z8Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jul 2017 16:42:18 +0200
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8DF861D37;
        Wed, 26 Jul 2017 14:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com C8DF861D37
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=pbonzini@redhat.com
Received: from [10.36.117.59] (ovpn-117-59.ams2.redhat.com [10.36.117.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E278B6A751;
        Wed, 26 Jul 2017 14:42:08 +0000 (UTC)
Subject: Re: [PATCH v2] smp_call_function: use inline helpers instead of
 macros
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20170726133447.2056379-1-arnd@arndb.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cc227181-ef9f-dede-d478-ba0714e4bfbb@redhat.com>
Date:   Wed, 26 Jul 2017 16:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170726133447.2056379-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 26 Jul 2017 14:42:12 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59282
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

On 26/07/2017 15:32, Arnd Bergmann wrote:
> A new caller of smp_call_function() passes a local variable as the 'wait'
> argument, and that variable is otherwise unused, so we get a warning
> in non-SMP configurations:
> 
> virt/kvm/kvm_main.c: In function 'kvm_make_all_cpus_request':
> virt/kvm/kvm_main.c:195:7: error: unused variable 'wait' [-Werror=unused-variable]
>   bool wait = req & KVM_REQUEST_WAIT;
> 
> This addresses the warning by changing the two macros into inline functions.
> As reported by the 0day build bot, a small change is required in the MIPS
> r4k code for this, which then gets a warning about a missing variable.
> 
> Fixes: 7a97cec26b94 ("KVM: mark requests that need synchronization")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Link: https://patchwork.kernel.org/patch/9722063/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This is not needed anymore, I've fixed it in KVM:

    commit b49defe83659cefbb1763d541e779da32594ab10
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Fri Jun 30 13:25:45 2017 +0200

    kvm: avoid unused variable warning for UP builds

    The uniprocessor version of smp_call_function_many does not evaluate
    all of its argument, and the compiler emits a warning about "wait"
    being unused.  This breaks the build on architectures for which
    "-Werror" is enabled by default.

    Work around it by moving the invocation of smp_call_function_many to
    its own inline function.

    Reported-by: Paul Mackerras <paulus@ozlabs.org>
    Cc: stable@vger.kernel.org
    Fixes: 7a97cec26b94c909f4cbad2dc3186af3e457a522
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 20:36:15 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:50396 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6827443Ab3E3SgDWjgwI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 May 2013 20:36:03 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Thu, 30 May 2013 11:35:56 -0700
Subject: Re: [PATCH 06/18] KVM/MIPS32-VZ: VZ-ASE related callbacks to handle guest exceptions that trap to the Root context.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <51A4D7F8.3060300@redhat.com>
Date:   Thu, 30 May 2013 11:35:56 -0700
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <2F16EB10-AFB8-4922-BAC1-EDCED4CC540E@kymasys.com>
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-7-git-send-email-sanjayl@kymasys.com> <51A4D7F8.3060300@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


On May 28, 2013, at 9:14 AM, Paolo Bonzini wrote:

> Il 19/05/2013 07:47, Sanjay Lal ha scritto:
>> +#endif
>> +		local_irq_save(flags);
>> +		if (kvm_mips_handle_vz_root_tlb_fault(badvaddr, vcpu) < 0) {
>> +			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>> +			er = EMULATE_FAIL;
>> +		}
>> +		local_irq_restore(flags);
>> +	}
> 
> This is introduced much later.  Please make sure that, with
> CONFIG_KVM_MIPS_VZ, every patch builds.
> 
> Paolo
> 

Again, I think this has to do with the fact that the patches were against 3.10-rc2, will rebase for v2.

Regards
Sanjay

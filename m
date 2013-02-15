Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Feb 2013 19:22:23 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:38526 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6827653Ab3BOSWX0CHZe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Feb 2013 19:22:23 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Fri, 15 Feb 2013 10:22:13 -0800
Subject: Re: [PATCH v2 09/18] KVM/MIPS32: COP0 accesses profiling.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <20130206131715.GB7837@redhat.com>
Date:   Fri, 15 Feb 2013 13:22:15 -0500
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
Message-Id: <88677E83-88FD-4AD2-88BD-09FF6BA68F63@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com> <1353551656-23579-10-git-send-email-sanjayl@kymasys.com> <20130206131715.GB7837@redhat.com>
To:     Gleb Natapov <gleb@redhat.com>
X-Mailer: Apple Mail (2.1283)
X-archive-position: 35775
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
Return-Path: <linux-mips-bounce@linux-mips.org>


On Feb 6, 2013, at 8:17 AM, Gleb Natapov wrote:

> On Wed, Nov 21, 2012 at 06:34:07PM -0800, Sanjay Lal wrote:
>> 
>> +int kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
>> +{
>> +	int i, j __unused;
>> +#ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
>> +	printk("\nKVM VCPU[%d] COP0 Access Profile:\n", vcpu->vcpu_id);
>> +	for (i = 0; i < N_MIPS_COPROC_REGS; i++) {
>> +		for (j = 0; j < N_MIPS_COPROC_SEL; j++) {
>> +			if (vcpu->arch.cop0->stat[i][j])
>> +				printk("%s[%d]: %lu\n", kvm_cop0_str[i], j,
>> +				       vcpu->arch.cop0->stat[i][j]);
>> +		}
>> +	}
>> +#endif
>> +
>> +	return 0;
>> +}
> You need to use ftrace event for that. Much more flexible with perf
> integration and no need to recompile to enabled/disable.
> 
> --
> 			Gleb.

Agreed, I'll start using trace for keeping track of COP0 accesses.

Regards
Sanjay

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2013 14:11:22 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:16830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822501Ab3BFNLUJXOu7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Feb 2013 14:11:20 +0100
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r16DBGVm019133
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 6 Feb 2013 08:11:16 -0500
Received: from dhcp-1-237.tlv.redhat.com (dhcp-4-26.tlv.redhat.com [10.35.4.26])
        by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r16DBFUC004693;
        Wed, 6 Feb 2013 08:11:15 -0500
Received: by dhcp-1-237.tlv.redhat.com (Postfix, from userid 13519)
        id 4FE7E18D479; Wed,  6 Feb 2013 15:11:14 +0200 (IST)
Date:   Wed, 6 Feb 2013 15:11:14 +0200
From:   Gleb Natapov <gleb@redhat.com>
To:     Sanjay Lal <sanjayl@kymasys.com>
Cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 02/18] KVM/MIPS32: Arch specific KVM data structures.
Message-ID: <20130206131114.GA7837@redhat.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
 <1353551656-23579-3-git-send-email-sanjayl@kymasys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353551656-23579-3-git-send-email-sanjayl@kymasys.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
X-archive-position: 35715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gleb@redhat.com
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

On Wed, Nov 21, 2012 at 06:34:00PM -0800, Sanjay Lal wrote:
> +struct kvm_mips_callbacks {
> +	int (*handle_cop_unusable) (struct kvm_vcpu *vcpu);
> +	int (*handle_tlb_mod) (struct kvm_vcpu *vcpu);
> +	int (*handle_tlb_ld_miss) (struct kvm_vcpu *vcpu);
> +	int (*handle_tlb_st_miss) (struct kvm_vcpu *vcpu);
> +	int (*handle_addr_err_st) (struct kvm_vcpu *vcpu);
> +	int (*handle_addr_err_ld) (struct kvm_vcpu *vcpu);
> +	int (*handle_syscall) (struct kvm_vcpu *vcpu);
> +	int (*handle_res_inst) (struct kvm_vcpu *vcpu);
> +	int (*handle_break) (struct kvm_vcpu *vcpu);
> +	int (*vm_init) (struct kvm *kvm);
> +	int (*vcpu_init) (struct kvm_vcpu *vcpu);
> +	int (*vcpu_setup) (struct kvm_vcpu *vcpu);
> +	 gpa_t(*gva_to_gpa) (gva_t gva);
> +	void (*queue_timer_int) (struct kvm_vcpu *vcpu);
> +	void (*dequeue_timer_int) (struct kvm_vcpu *vcpu);
> +	void (*queue_io_int) (struct kvm_vcpu *vcpu,
> +			      struct kvm_mips_interrupt *irq);
> +	void (*dequeue_io_int) (struct kvm_vcpu *vcpu,
> +				struct kvm_mips_interrupt *irq);
> +	int (*irq_deliver) (struct kvm_vcpu *vcpu, unsigned int priority,
> +			    uint32_t cause);
> +	int (*irq_clear) (struct kvm_vcpu *vcpu, unsigned int priority,
> +			  uint32_t cause);
> +	int (*vcpu_ioctl_get_regs) (struct kvm_vcpu *vcpu,
> +				    struct kvm_regs *regs);
> +	int (*vcpu_ioctl_set_regs) (struct kvm_vcpu *vcpu,
> +				    struct kvm_regs *regs);
> +};
You haven't addressed Avi's comment about dropping the interaction and
adding it later, when other HW is supported and the best way to do the split
is known.

--
			Gleb.

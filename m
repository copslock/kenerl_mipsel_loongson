Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 May 2013 17:04:41 +0200 (CEST)
Received: from mail-qc0-f172.google.com ([209.85.216.172]:45817 "EHLO
        mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834873Ab3E1PEkBsVT0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 May 2013 17:04:40 +0200
Received: by mail-qc0-f172.google.com with SMTP id z1so4126314qcx.31
        for <multiple recipients>; Tue, 28 May 2013 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=eOhIyYxjaD4bLKDWNpHgQThqILBp+rSZmYEfdUK7hB8=;
        b=b8S+Cy/Sm3xUCA9xRiAZqELL9yztkRx2dCAQ1c7qlde5eazg7IUR6B3t+a1/a2PK+9
         9v9jmMJUgvzxPx1MOq4R7bj9V2Ehg8BveSxjC6IQQfA/KmDNkHrIPw2FLXdk0jhdhMkn
         wgqoFSRaZPOHtjX5memGdbVrovwq0uYHZEPLiwdTUSCLDvdI7bFCd4NIsqzuUHFmodb0
         MSGb3f1BN62Kc7kFDCvvDqbQfhdBCpLhPrBknJGojqmM+ft26cCyzL4avXpxvkoNMelp
         EafCnGExnUVf2sAc3vu81cvWyyJhf78Aw0TN/1SGFnwfAijnVHqTZjeWn7znooYYi8c7
         Fg3A==
X-Received: by 10.224.39.77 with SMTP id f13mr32040881qae.96.1369753474006;
        Tue, 28 May 2013 08:04:34 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-117-138-128.cust.dsl.vodafone.it. [37.117.138.128])
        by mx.google.com with ESMTPSA id ds7sm3669104qab.13.2013.05.28.08.04.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 08:04:33 -0700 (PDT)
Message-ID: <51A4C776.8070002@redhat.com>
Date:   Tue, 28 May 2013 17:04:22 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Gleb Natapov <gleb@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 06/18] KVM/MIPS32-VZ: VZ-ASE related callbacks to handle
 guest exceptions that trap to the Root context.
References: <n> <1368942460-15577-1-git-send-email-sanjayl@kymasys.com> <1368942460-15577-7-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1368942460-15577-7-git-send-email-sanjayl@kymasys.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36622
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

Il 19/05/2013 07:47, Sanjay Lal ha scritto:
> +static int kvm_vz_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> +{
> +	struct mips_coproc *cop0 = vcpu->arch.cop0;
> +
> +	/* some registers are not restored
> +	 * random, count        : read-only
> +	 * userlocal            : not implemented in qemu
> +	 * config6              : not implemented in processor variant
> +	 * compare, cause       : defer to kvm_vz_restore_guest_timer_int
> +	 */
> +
> +	kvm_write_c0_guest_index(cop0, regs->cp0reg[MIPS_CP0_TLB_INDEX][0]);
> +	kvm_write_c0_guest_entrylo0(cop0, regs->cp0reg[MIPS_CP0_TLB_LO0][0]);
> +	kvm_write_c0_guest_entrylo1(cop0, regs->cp0reg[MIPS_CP0_TLB_LO1][0]);
> +	kvm_write_c0_guest_context(cop0, regs->cp0reg[MIPS_CP0_TLB_CONTEXT][0]);
> +	kvm_write_c0_guest_pagemask(cop0,
> +				    regs->cp0reg[MIPS_CP0_TLB_PG_MASK][0]);
> +	kvm_write_c0_guest_pagegrain(cop0,
> +				     regs->cp0reg[MIPS_CP0_TLB_PG_MASK][1]);
> +	kvm_write_c0_guest_wired(cop0, regs->cp0reg[MIPS_CP0_TLB_WIRED][0]);
> +	kvm_write_c0_guest_hwrena(cop0, regs->cp0reg[MIPS_CP0_HWRENA][0]);
> +	kvm_write_c0_guest_badvaddr(cop0, regs->cp0reg[MIPS_CP0_BAD_VADDR][0]);
> +	/* skip kvm_write_c0_guest_count */
> +	kvm_write_c0_guest_entryhi(cop0, regs->cp0reg[MIPS_CP0_TLB_HI][0]);
> +	/* defer kvm_write_c0_guest_compare */
> +	kvm_write_c0_guest_status(cop0, regs->cp0reg[MIPS_CP0_STATUS][0]);
> +	kvm_write_c0_guest_intctl(cop0, regs->cp0reg[MIPS_CP0_STATUS][1]);
> +	/* defer kvm_write_c0_guest_cause */
> +	kvm_write_c0_guest_epc(cop0, regs->cp0reg[MIPS_CP0_EXC_PC][0]);
> +	kvm_write_c0_guest_prid(cop0, regs->cp0reg[MIPS_CP0_PRID][0]);
> +	kvm_write_c0_guest_ebase(cop0, regs->cp0reg[MIPS_CP0_PRID][1]);
> +
> +	/* only restore implemented config registers */
> +	kvm_write_c0_guest_config(cop0, regs->cp0reg[MIPS_CP0_CONFIG][0]);
> +
> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][0] & MIPS_CONF_M) &
> +			cpu_vz_has_config1)
> +		kvm_write_c0_guest_config1(cop0,
> +				regs->cp0reg[MIPS_CP0_CONFIG][1]);
> +
> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][1] & MIPS_CONF_M) &
> +			cpu_vz_has_config2)
> +		kvm_write_c0_guest_config2(cop0,
> +				regs->cp0reg[MIPS_CP0_CONFIG][2]);
> +
> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][2] & MIPS_CONF_M) &
> +			cpu_vz_has_config3)
> +		kvm_write_c0_guest_config3(cop0,
> +				regs->cp0reg[MIPS_CP0_CONFIG][3]);
> +
> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][3] & MIPS_CONF_M) &
> +			cpu_vz_has_config4)
> +		kvm_write_c0_guest_config4(cop0,
> +				regs->cp0reg[MIPS_CP0_CONFIG][4]);
> +
> +	if ((regs->cp0reg[MIPS_CP0_CONFIG][4] & MIPS_CONF_M) &
> +			cpu_vz_has_config5)
> +		kvm_write_c0_guest_config5(cop0,
> +				regs->cp0reg[MIPS_CP0_CONFIG][5]);
> +
> +	if (cpu_vz_has_config6)
> +		kvm_write_c0_guest_config6(cop0,
> +				regs->cp0reg[MIPS_CP0_CONFIG][6]);
> +	if (cpu_vz_has_config7)
> +		kvm_write_c0_guest_config7(cop0,
> +				regs->cp0reg[MIPS_CP0_CONFIG][7]);
> +
> +	kvm_write_c0_guest_errorepc(cop0, regs->cp0reg[MIPS_CP0_ERROR_PC][0]);
> +
> +	/* call after setting MIPS_CP0_CAUSE to avoid having it overwritten
> +	 * this will set guest compare and cause.TI if necessary
> +	 */
> +	kvm_vz_restore_guest_timer_int(vcpu, regs);
> +
> +	return 0;
> +}

All this is now obsolete after David's patches (reusing kvm_regs looked
a bit strange in fact).

Paolo

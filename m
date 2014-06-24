Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 01:14:19 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37887 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860024AbaFXXOQi7njG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 01:14:16 +0200
Received: by mail-wi0-f176.google.com with SMTP id n3so6980081wiv.15
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 16:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :organization:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type;
        bh=WFrYbpyXxJKjBFFpLXNtI5znuMuRqVS5dfi0OdMyCqE=;
        b=gEHzzru8WCHHoACjOC8OLqv1LamntmA46AkTTxPBJJlmRbeiw3TcblHBsdfSCyXT//
         jtQyjHJ6AtOHFR2OOK5M0BHBisnh6LpANBtgQOo1BoBi4I/IU66XBGCoP7scud6gAtF2
         QBAEWRwL8MhD/HQ7F+c6/GV1wsPAdwfFOjnxZ9ZgG0Wna1AT2+kHCToZdr5MP3AZxXt+
         sWDtS/WMNzp1EbGuDiL//SZdDT32j3jfqG/GQMPkVvoBzC2R9NWGpkh0+vU4QDA1Pr0G
         a7wjxdjIeg9TvDwUXhGHikHyivnMnRDoWYPyf0J2c78xwOY0WFjLI5NHEJOMje/yT5CK
         LD7g==
X-Gm-Message-State: ALoCoQmsmLF6T1ao20QwnqEEiL+vjHt/bDoyQlE/mh/rs2ZwWfUIZGhPNa4zPABqRzR6/4qKrRqF
X-Received: by 10.194.87.134 with SMTP id ay6mr4976692wjb.84.1403651651069;
        Tue, 24 Jun 2014 16:14:11 -0700 (PDT)
Received: from radagast.localnet (jahogan.plus.com. [212.159.75.221])
        by mx.google.com with ESMTPSA id cj8sm3496481wjb.5.2014.06.24.16.14.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 16:14:10 -0700 (PDT)
From:   James Hogan <james.hogan@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, pbonzini@redhat.com,
        gleb@kernel.org, kvm@vger.kernel.org, sanjayl@kymasys.com,
        ralf@linux-mips.org
Subject: Re: [PATCH v3 1/9] MIPS: KVM: Reformat code and comments
Date:   Wed, 25 Jun 2014 00:13:58 +0100
Message-ID: <2425309.IacJWOu9rB@radagast>
Organization: Imagination Technologies
User-Agent: KMail/4.12.5 (Linux/3.15.1+; KDE/4.12.5; x86_64; ; )
In-Reply-To: <1403631071-6012-2-git-send-email-dengcheng.zhu@imgtec.com>
References: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com> <1403631071-6012-2-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Deng-Cheng,

On Tuesday 24 June 2014 10:31:02 Deng-Cheng Zhu wrote:
> diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
> index cd5e4f5..821e7e8 100644
> --- a/arch/mips/kvm/kvm_mips.c
> +++ b/arch/mips/kvm/kvm_mips.c

> -#define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
> +#define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x)
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
> -	{ "wait", VCPU_STAT(wait_exits) },
> -	{ "cache", VCPU_STAT(cache_exits) },
> -	{ "signal", VCPU_STAT(signal_exits) },
> -	{ "interrupt", VCPU_STAT(int_exits) },
> -	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits) },
> -	{ "tlbmod", VCPU_STAT(tlbmod_exits) },
> -	{ "tlbmiss_ld", VCPU_STAT(tlbmiss_ld_exits) },
> -	{ "tlbmiss_st", VCPU_STAT(tlbmiss_st_exits) },
> -	{ "addrerr_st", VCPU_STAT(addrerr_st_exits) },
> -	{ "addrerr_ld", VCPU_STAT(addrerr_ld_exits) },
> -	{ "syscall", VCPU_STAT(syscall_exits) },
> -	{ "resvd_inst", VCPU_STAT(resvd_inst_exits) },
> -	{ "break_inst", VCPU_STAT(break_inst_exits) },
> -	{ "flush_dcache", VCPU_STAT(flush_dcache_exits) },
> -	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
> +	{ "wait", VCPU_STAT(wait_exits), KVM_STAT_VCPU },
> +	{ "cache", VCPU_STAT(cache_exits), KVM_STAT_VCPU },
> +	{ "signal", VCPU_STAT(signal_exits), KVM_STAT_VCPU },
> +	{ "interrupt", VCPU_STAT(int_exits), KVM_STAT_VCPU },
> +	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
> +	{ "tlbmod", VCPU_STAT(tlbmod_exits), KVM_STAT_VCPU },
> +	{ "tlbmiss_ld", VCPU_STAT(tlbmiss_ld_exits), KVM_STAT_VCPU },
> +	{ "tlbmiss_st", VCPU_STAT(tlbmiss_st_exits), KVM_STAT_VCPU },
> +	{ "addrerr_st", VCPU_STAT(addrerr_st_exits), KVM_STAT_VCPU },
> +	{ "addrerr_ld", VCPU_STAT(addrerr_ld_exits), KVM_STAT_VCPU },
> +	{ "syscall", VCPU_STAT(syscall_exits), KVM_STAT_VCPU },
> +	{ "resvd_inst", VCPU_STAT(resvd_inst_exits), KVM_STAT_VCPU },
> +	{ "break_inst", VCPU_STAT(break_inst_exits), KVM_STAT_VCPU },
> +	{ "flush_dcache", VCPU_STAT(flush_dcache_exits), KVM_STAT_VCPU },
> +	{ "halt_wakeup", VCPU_STAT(halt_wakeup), KVM_STAT_VCPU },

IMO more important than making checkpatch happy here would be to put it in 
nicely tabulated columns ;-)

> diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
> index 8d48400..993dd1c 100644
> --- a/arch/mips/kvm/kvm_mips_emul.c
> +++ b/arch/mips/kvm/kvm_mips_emul.c

>  	switch (insn.i_format.opcode) {
> -		/*
> -		 * jr and jalr are in r_format format.
> -		 */
> +		 /* jr and jalr are in r_format format. */

bad indentation.

> diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
> index 693f952..baf6577 100644
> --- a/arch/mips/kvm/kvm_trap_emul.c
> +++ b/arch/mips/kvm/kvm_trap_emul.c

> @@ -186,10 +185,12 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct
> kvm_vcpu *vcpu) vcpu->arch.pc, badvaddr);
> 
>  		/* User Address (UA) fault, this could happen if

this comment could be fixed too

Otherwise this patch looks good. Thanks for doing this!

Cheers
James

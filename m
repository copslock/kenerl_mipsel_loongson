Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 May 2013 18:15:11 +0200 (CEST)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:53762 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834828Ab3E1QPGZG2-t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 May 2013 18:15:06 +0200
Received: by mail-qa0-f49.google.com with SMTP id j11so1591170qag.8
        for <multiple recipients>; Tue, 28 May 2013 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=LxgukjB4R/L8nsnIb0qN8jPLMgwlfoW14LfuXeqSrZU=;
        b=vj7bt2fNZaeWJlW09oRmmMLicuWNr0TeDtBa2XODirBDCeW4h02OKGktudD/KAIIMA
         3q6HgRE11mVUmTVbIdV7/3IYq3GTRapIfupAqLaK/2yNY6Z1txcihICNqywwaFvgIpLP
         CI2ZxK37fKyL2SH7s/iNVtBbgVfKGHBRwy5QzRyE0DSjJ34m4cjv1OwEvFMPWgE488Cj
         38L6qHf+er/Dd6iguhALBjm4xvF9N2ztFmovByPsVnmKK5KZAcA9GtxDoQjfv+N6BlmL
         Mkfz9MYjkeDo0w2a6Y40rbPR17esYRiWbbYvRzjmOfdIrxLaH7c7EghcPucGbkFKiq6z
         BC4Q==
X-Received: by 10.229.174.70 with SMTP id s6mr1821419qcz.51.1369757700236;
        Tue, 28 May 2013 09:15:00 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-117-138-128.cust.dsl.vodafone.it. [37.117.138.128])
        by mx.google.com with ESMTPSA id y1sm28541996qad.5.2013.05.28.09.14.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 09:14:59 -0700 (PDT)
Message-ID: <51A4D7F8.3060300@redhat.com>
Date:   Tue, 28 May 2013 18:14:48 +0200
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
X-archive-position: 36624
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
> +#endif
> +		local_irq_save(flags);
> +		if (kvm_mips_handle_vz_root_tlb_fault(badvaddr, vcpu) < 0) {
> +			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> +			er = EMULATE_FAIL;
> +		}
> +		local_irq_restore(flags);
> +	}

This is introduced much later.  Please make sure that, with
CONFIG_KVM_MIPS_VZ, every patch builds.

Paolo

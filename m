Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2015 23:19:13 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33723 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007914AbbCBWTLaB3U7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Mar 2015 23:19:11 +0100
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t22MJ3T6003259
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Mar 2015 17:19:03 -0500
Received: from amt.cnet (vpn1-5-33.gru2.redhat.com [10.97.5.33])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t22MJ27A012579;
        Mon, 2 Mar 2015 17:19:02 -0500
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id AFBDF100A04;
        Mon,  2 Mar 2015 19:18:50 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id t22MInvX004464;
        Mon, 2 Mar 2015 19:18:49 -0300
Date:   Mon, 2 Mar 2015 19:18:49 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Tapasweni Pathak <tapaswenipathak@gmail.com>
Cc:     gleb@kernel.org, pbonzini@redhat.com, ralf@linux-mips.org,
        kvm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
Subject: Re: [PATCH] arch: mips: kvm: Enable after disabling interrupt
Message-ID: <20150302221849.GB4095@amt.cnet>
References: <20150222161821.GA6980@kt-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150222161821.GA6980@kt-Inspiron-3542>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <mtosatti@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mtosatti@redhat.com
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

On Sun, Feb 22, 2015 at 09:48:21PM +0530, Tapasweni Pathak wrote:
> Enable disabled interrupt, on unsuccessful operation.
> 
> Found by Coccinelle.
> 
> Signed-off-by: Tapasweni Pathak <tapaswenipathak@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  arch/mips/kvm/tlb.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
> index bbcd822..b6beb0e 100644
> --- a/arch/mips/kvm/tlb.c
> +++ b/arch/mips/kvm/tlb.c
> @@ -216,6 +216,7 @@ int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
>  	if (idx > current_cpu_data.tlbsize) {
>  		kvm_err("%s: Invalid Index: %d\n", __func__, idx);
>  		kvm_mips_dump_host_tlbs();
> +		local_irq_restore(flags);
>  		return -1;
>  	}
> 

Applied, thanks.

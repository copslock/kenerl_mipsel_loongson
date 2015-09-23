Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2015 18:44:48 +0200 (CEST)
Received: from mga14.intel.com ([192.55.52.115]:31632 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007105AbbIWQoqQh2i7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Sep 2015 18:44:46 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 23 Sep 2015 09:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,577,1437462000"; 
   d="scan'208";a="811564261"
Received: from binbinwu-mobl1.ccr.corp.intel.com (HELO [10.254.215.200]) ([10.254.215.200])
  by orsmga002.jf.intel.com with ESMTP; 23 Sep 2015 09:44:36 -0700
Subject: Re: [PATCH 2/6] irqdomain: add a new send_ipi() to irq_domain_ops
To:     Qais Yousef <qais.yousef@imgtec.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
References: <1443019758-20620-1-git-send-email-qais.yousef@imgtec.com>
 <1443019758-20620-3-git-send-email-qais.yousef@imgtec.com>
Cc:     marc.zyngier@arm.com, jason@lakedaemon.net,
        linux-mips@linux-mips.org
From:   Jiang Liu <jiang.liu@linux.intel.com>
Organization: Intel
Message-ID: <5602D6F3.7030709@linux.intel.com>
Date:   Thu, 24 Sep 2015 00:44:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1443019758-20620-3-git-send-email-qais.yousef@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <jiang.liu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.liu@linux.intel.com
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

On 2015/9/23 22:49, Qais Yousef wrote:
> For generic ipi core to use. It takes hwirq as its sole argument.
> Hopefully this is generic enough? Should we pass something more abstract?
> 
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> ---
>  include/linux/irqdomain.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 9b3dc6c2a3cc..cef9e6158be0 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -92,6 +92,7 @@ struct irq_domain_ops {
>  	void (*activate)(struct irq_domain *d, struct irq_data *irq_data);
>  	void (*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
>  #endif
> +	void (*send_ipi)(irq_hw_number_t hwirq);
Hi Qais,
	Instead of extending the irq_domain_ops, how about extending
irq_chip instead? If we treat IPI as a sort of irq controller, and
irq_chip is used to encapsulate all irq controller related operations,
and irq_domain_ops is mainly used to allocated resources instead of
operating corresponding hardware.
Thanks!
Gerry

>  };
>  
>  extern struct irq_domain_ops irq_generic_chip_ops;
> 

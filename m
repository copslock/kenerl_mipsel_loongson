Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 16:50:32 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:35564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009486AbbJNOu3vaIQs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Oct 2015 16:50:29 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14B6FAC9E;
        Wed, 14 Oct 2015 14:50:28 +0000 (UTC)
Date:   Wed, 14 Oct 2015 07:50:17 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        jiang.liu@linux.intel.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
Subject: Re: [RFC v2 PATCH 05/14] irq: add struct ipi_mask to irq_data
Message-ID: <20151014145017.GE3052@linux-uzut.site>
References: <1444731382-19313-1-git-send-email-qais.yousef@imgtec.com>
 <1444731382-19313-6-git-send-email-qais.yousef@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1444731382-19313-6-git-send-email-qais.yousef@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dave@stgolabs.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@stgolabs.net
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

On Tue, 13 Oct 2015, Qais Yousef wrote:

>It has a similar role to affinity mask, but tracks the IPI affinity instead.
>
>Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
>---
> include/linux/irq.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/linux/irq.h b/include/linux/irq.h
>index 504133671985..b000b217ea24 100644
>--- a/include/linux/irq.h
>+++ b/include/linux/irq.h
>@@ -157,6 +157,7 @@ struct irq_common_data {
> 	void			*handler_data;
> 	struct msi_desc		*msi_desc;
> 	cpumask_var_t		affinity;
>+	struct ipi_mask		ipi_mask;
> };

This should be folded into patch 3, no?

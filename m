Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 22:48:59 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46297 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493507AbZIWUsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Sep 2009 22:48:52 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8NKo5XF022204;
	Wed, 23 Sep 2009 21:50:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8NKo40q022202;
	Wed, 23 Sep 2009 21:50:04 +0100
Date:	Wed, 23 Sep 2009 21:50:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark Mason <mmason@upwardaccess.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] When complaining about attempting to set the irq
	affinity to multiple cpus,
Message-ID: <20090923205004.GA21971@linux-mips.org>
References: <1253567604-6734-1-git-send-email-mmason@upwardaccess.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1253567604-6734-1-git-send-email-mmason@upwardaccess.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 21, 2009 at 02:13:24PM -0700, Mark Mason wrote:

>  arch/mips/sibyte/bcm1480/irq.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
> index ba59839..fc87ea4 100644
> --- a/arch/mips/sibyte/bcm1480/irq.c
> +++ b/arch/mips/sibyte/bcm1480/irq.c
> @@ -118,7 +118,11 @@ static int bcm1480_set_affinity(unsigned int irq, const struct cpumask *mask)
>  	unsigned int irq_dirty;
>  
>  	if (cpumask_weight(mask) != 1) {
> -		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
> +		printk("attempted to set irq affinity for irq %d to multiple CPUs:", irq);
> +		/* Print the mask */
> +		for_each_cpu(i, mask)
> +			printk(" %d", i);
> +		printk("\n");

The whole if block is a zombie that was supposed to have been
removed by commit 14275ccdb1e4b487cca745aba994699c426a31ee but then
returned in 92241940be501f798cb21db344bbb3d1ec3c4f1c.  So I went for a
slightly different patch, see below.

Thanks,

  Ralf

MIPS: BCM1480: Re-apply patch lost due to bad resolution of merge conflict.

Patch 14275ccdb1e4b487cca745aba994699c426a31ee and
d5dedd4507d307eb3f35f21b6e16f336fdc0d82a are conflicting and the
conflict was resolved badly in merge
92241940be501f798cb21db344bbb3d1ec3c4f1c resulting in the BCM1480 changes
of 14275ccdb1e4b487cca745aba994699c426a31ee getting lost.  Sort out the
damage.

Reported and initial patch by Mark Mason <mmason@upwardaccess.com>.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/sibyte/bcm1480/irq.c b/arch/mips/sibyte/bcm1480/irq.c
index ba59839..4070268 100644
--- a/arch/mips/sibyte/bcm1480/irq.c
+++ b/arch/mips/sibyte/bcm1480/irq.c
@@ -117,10 +117,6 @@ static int bcm1480_set_affinity(unsigned int irq, const struct cpumask *mask)
 	unsigned long flags;
 	unsigned int irq_dirty;
 
-	if (cpumask_weight(mask) != 1) {
-		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", irq);
-		return -1;
-	}
 	i = cpumask_first(mask);
 
 	/* Convert logical CPU to physical CPU */

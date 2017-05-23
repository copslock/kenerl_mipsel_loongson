Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 20:56:03 +0200 (CEST)
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:49908 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994768AbdEWSz5L0kkD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 20:55:57 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 17B3A6A77A;
        Tue, 23 May 2017 18:55:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trees81_6dace2222a911
X-Filterd-Recvd-Size: 3165
Received: from XPS-9350 (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 May 2017 18:55:53 +0000 (UTC)
Message-ID: <1495565752.2093.69.camel@perches.com>
Subject: Re: [PATCH] MIPS: Octeon: Delete an error message for a failed
 memory allocation in octeon_irq_init_gpio()
From:   Joe Perches <joe@perches.com>
To:     SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-mips@linux-mips.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Daney <david.daney@cavium.com>,
        Ralf =?ISO-8859-1?Q?B=E4chle?= <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date:   Tue, 23 May 2017 11:55:52 -0700
In-Reply-To: <7995eb17-f2ec-54ad-f4d4-7b3dd8337d33@users.sourceforge.net>
References: <7995eb17-f2ec-54ad-f4d4-7b3dd8337d33@users.sourceforge.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Tue, 2017-05-23 at 20:10 +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 23 May 2017 20:00:06 +0200
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/mips/cavium-octeon/octeon-irq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index c1eb1ff7c800..050c08ece5b6 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -1615,7 +1615,6 @@ static int __init octeon_irq_init_gpio(
>  		irq_domain_add_linear(
>  			gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
>  	} else {
> -		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
>  		return -ENOMEM;
>  	}

You really should reverse the test here and
unindent the first block.

Again:  Don't be mindless.
        Take the time to improve the code.
---
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octe
index c1eb1ff7c800..2bdc750f2f2d 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1609,15 +1609,13 @@ static int __init octeon_irq_init_gpio(
 	}
 
 	gpiod = kzalloc(sizeof(*gpiod), GFP_KERNEL);
-	if (gpiod) {
-		/* gpio domain host_data is the base hwirq number. */
-		gpiod->base_hwirq = base_hwirq;
-		irq_domain_add_linear(
-			gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
-	} else {
-		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
+	if (!gpiod)
 		return -ENOMEM;
-	}
+
+	/* gpio domain host_data is the base hwirq number. */
+	gpiod->base_hwirq = base_hwirq;
+	irq_domain_add_linear(gpio_node, 16,
+			      &octeon_irq_domain_gpio_ops, gpiod);
 
 	/*
 	 * Clear the OF_POPULATED flag that was set by of_irq_init()

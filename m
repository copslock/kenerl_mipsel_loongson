Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 10:46:48 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:34406 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27042775AbcFQIqoY412u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 10:46:44 +0200
Subject: Re: [PATCH] MIPS: Lantiq: fix build failure
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1466109968-22033-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
From:   John Crispin <john@phrozen.org>
Message-ID: <224d637f-70b6-f8cc-0c68-c3e51d538906@phrozen.org>
Date:   Fri, 17 Jun 2016 10:46:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1466109968-22033-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 16/06/2016 22:46, Sudip Mukherjee wrote:
> Some configs of mips like xway_defconffig are failing with the error:
> arch/mips/lantiq/irq.c:209:2: error: initialization from incompatible
> pointer type [-Werror]
>   "icu",
>   ^
> arch/mips/lantiq/irq.c:209:2: error: (near initialization for
> 'ltq_irq_type.parent_device') [-Werror]
> arch/mips/lantiq/irq.c:219:2: error: initialization from incompatible
> pointer type [-Werror]
>   "eiu",
>   ^
> arch/mips/lantiq/irq.c:219:2: error: (near initialization for
> 'ltq_eiu_type.parent_device') [-Werror]
> 
> The first member of the "struct irq" is no longer a pointer for the
> name.
> 
> Fixes: be45beb2df69 ("genirq: Add runtime power management support for IRQ chips")
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Acked-by: John Crispin <john@phrozen.org>

> ---
> 
> build log can be seen at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/137992701
> 
>  arch/mips/lantiq/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> index ff17669e..02c0252 100644
> --- a/arch/mips/lantiq/irq.c
> +++ b/arch/mips/lantiq/irq.c
> @@ -206,7 +206,7 @@ static void ltq_shutdown_eiu_irq(struct irq_data *d)
>  }
>  
>  static struct irq_chip ltq_irq_type = {
> -	"icu",
> +	.name = "icu",
>  	.irq_enable = ltq_enable_irq,
>  	.irq_disable = ltq_disable_irq,
>  	.irq_unmask = ltq_enable_irq,
> @@ -216,7 +216,7 @@ static struct irq_chip ltq_irq_type = {
>  };
>  
>  static struct irq_chip ltq_eiu_type = {
> -	"eiu",
> +	.name = "eiu",
>  	.irq_startup = ltq_startup_eiu_irq,
>  	.irq_shutdown = ltq_shutdown_eiu_irq,
>  	.irq_enable = ltq_enable_irq,
> 

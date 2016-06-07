Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jun 2016 07:20:21 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:50284 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27042654AbcFGFUTXkm9M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Jun 2016 07:20:19 +0200
Subject: Re: [PATCH] MIPS: lantiq: register IRQ handler for virtual IRQ number
To:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org
References: <1465248513-26604-1-git-send-email-hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, thomas.langer@intel.com
From:   John Crispin <john@phrozen.org>
Message-ID: <b4f66318-d7b0-1f24-a5cc-f4208d8b91ff@phrozen.org>
Date:   Tue, 7 Jun 2016 07:20:13 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1465248513-26604-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53893
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



On 06/06/2016 23:28, Hauke Mehrtens wrote:
> We used the hardware IRQ number to register the IRQ handler and not the
> virtual one. This probably caused some problems because the hardware
> IRQ numbers are only unique for each IRQ controller and not in the
> system. The virtual IRQ number is managed by Linux and unique in the
> system. This was probably the reason there was a gab of 8 IRQ numbers added
> before the numbers used for the lantiq IRQ controller. With the current
> setup the hardware and the virtual IRQ numbers are the same.
> 
> Reported-by: Thomas Langer <thomas.langer@intel.com>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

had this identical patch in my local tree since last week :-)

there are also 2 small bugs in the ICU code, i'll post the patches the
next couple of days.

Acked-by: John Crispin <john@phrozen.org>

> ---
>  arch/mips/lantiq/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> index ff17669e..56a1703 100644
> --- a/arch/mips/lantiq/irq.c
> +++ b/arch/mips/lantiq/irq.c
> @@ -344,7 +344,7 @@ static int icu_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
>  		if (hw == ltq_eiu_irq[i].start)
>  			chip = &ltq_eiu_type;
>  
> -	irq_set_chip_and_handler(hw, chip, handle_level_irq);
> +	irq_set_chip_and_handler(irq, chip, handle_level_irq);
>  
>  	return 0;
>  }
> 

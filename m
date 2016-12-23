Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2016 06:38:56 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:40733 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990686AbcLWFisWs6Jd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Dec 2016 06:38:48 +0100
Subject: Re: [PATCH] MIPS: ralink: fix incorrect assignment on ralink_soc
To:     Colin King <colin.king@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20161222235258.5525-1-colin.king@canonical.com>
Cc:     linux-kernel@vger.kernel.org
From:   John Crispin <john@phrozen.org>
Message-ID: <7ca20b25-60d8-b439-0e30-671549d641bb@phrozen.org>
Date:   Fri, 23 Dec 2016 06:38:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161222235258.5525-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56120
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



On 23/12/2016 00:52, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> ralink_soc sould be assigned to RT3883_SOC, replace incorrect
> comparision with assignment.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: John Crispin <john@phrozen.org>

i thought i had sent this fix upstream ages ago. luckily this bug never
caused any error as none of the code checking ralink_soc checks for
rt3883. its used for the rt3x5x family.

	John


> ---
>  arch/mips/ralink/rt3883.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
> index 141c597..f869052 100644
> --- a/arch/mips/ralink/rt3883.c
> +++ b/arch/mips/ralink/rt3883.c
> @@ -157,5 +157,5 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
>  
>  	rt2880_pinmux_data = rt3883_pinmux_data;
>  
> -	ralink_soc == RT3883_SOC;
> +	ralink_soc = RT3883_SOC;
>  }
> 
his

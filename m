Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 23:40:14 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:54227 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993089AbcLMWkGwY7AG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Dec 2016 23:40:06 +0100
Subject: Re: [PATCH 1/2 v2] ralink: Introduce fw_passed_dtb to
 arch/mips/ralink
To:     Tobias Wolf <dev-NTEO@vplace.de>, linux-mips@linux-mips.org
References: <3700342.djbc9u0nWG@loki> <1602859.QGKdh4otrC@loki>
From:   John Crispin <john@phrozen.org>
Message-ID: <73c17ed0-c1a3-3afd-755c-f4bba7556a08@phrozen.org>
Date:   Tue, 13 Dec 2016 23:40:06 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1602859.QGKdh4otrC@loki>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56043
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



On 13/12/2016 11:46, Tobias Wolf wrote:
> This patch adds fw_passed_dtb to arch/mips/ralink to support 
> CONFIG_MIPS_RAW_APPENDED_DTB. Furthermore it adds a check that __dtb_start is 
> not the same address as __dtb_end.
> 
> Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
> ---

there should be a chunk here explaining the changes between v1 and v2
... anyhow

Acked-by: John Crispin <john@phrozen.org>



> --- a/arch/mips/ralink/of.c
> +++ b/arch/mips/ralink/of.c
> @@ -66,13 +66,21 @@
>  
>  void __init plat_mem_setup(void)
>  {
> +	void *dtb = NULL;
> +
>  	set_io_port_base(KSEG1);
>  
>  	/*
>  	 * Load the builtin devicetree. This causes the chosen node to be
> -	 * parsed resulting in our memory appearing
> +	 * parsed resulting in our memory appearing. fw_passed_dtb is used
> +	 * by CONFIG_MIPS_APPENDED_RAW_DTB as well.
>  	 */
> -	__dt_setup_arch(__dtb_start);
> +	if (fw_passed_dtb)
> +		dtb = (void *)fw_passed_dtb;
> +	else if (__dtb_start != __dtb_end)
> +		dtb = (void *)__dtb_start;
> +
> +	__dt_setup_arch(dtb);
>  
>  	of_scan_flat_dt(early_init_dt_find_memory, NULL);
>  	if (memory_dtb)
> 
> ---
> This version has been cleaned up based on feedback [1] of John Crispin for the 
> LEDE Project.
> 
> [1] https://github.com/lede-project/source/pull/582#discussion_r90778573
> 
> Best regards
> Tobias
> 

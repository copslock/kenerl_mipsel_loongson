Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 21:08:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55697 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6829860Ab3FETIoI2qAO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 21:08:44 +0200
Date:   Wed, 5 Jun 2013 20:08:44 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        ddaney.cavm@gmail.com
Subject: Re: [PATCH v4] MIPS: micromips: Fix improper definition of ISA
 exception bit.
In-Reply-To: <1370455529-19621-1-git-send-email-Steven.Hill@imgtec.com>
Message-ID: <alpine.LFD.2.03.1306052004030.15274@linux-mips.org>
References: <1370455529-19621-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 5 Jun 2013, Steven J. Hill wrote:

> diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
> index ff8caff..76e0205 100644
> --- a/arch/mips/mti-malta/malta-init.c
> +++ b/arch/mips/mti-malta/malta-init.c
> @@ -106,6 +106,8 @@ extern struct plat_smp_ops msmtc_smp_ops;
>  
>  void __init prom_init(void)
>  {
> +	set_micromips_exception_mode();
> +
>  	mips_display_message("LINUX");
>  
>  	/*
> diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
> index bfbd17b..9e314cb 100644
> --- a/arch/mips/mti-sead3/sead3-init.c
> +++ b/arch/mips/mti-sead3/sead3-init.c
> @@ -130,6 +130,8 @@ static void __init mips_ejtag_setup(void)
>  
>  void __init prom_init(void)
>  {
> +	set_micromips_exception_mode();
> +
>  	board_nmi_handler_setup = mips_nmi_setup;
>  	board_ejtag_handler_setup = mips_ejtag_setup;

 Shouldn't this be in a generic place such as trap_init instead?

  Maciej

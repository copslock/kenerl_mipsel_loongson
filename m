Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Aug 2013 12:07:45 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:2082 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815858Ab3HRKHm1ZmeS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 Aug 2013 12:07:42 +0200
Received: from [10.9.208.53] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 18 Aug 2013 03:03:31 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sun, 18 Aug 2013 03:07:24 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Sun, 18 Aug 2013 03:07:23 -0700
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 28136F2D72; Sun, 18
 Aug 2013 03:07:22 -0700 (PDT)
Date:   Sun, 18 Aug 2013 15:38:54 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org
cc:     "Markos Chandras" <markos.chandras@imgtec.com>
Subject: Re: [PATCH v2] MIPS: netlogic: xlr: Serial support depends on
 CONFIG_SERIAL_8250
Message-ID: <20130818100852.GB1712@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
In-Reply-To: <1376571575-29037-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7E0E447931W85396060-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

> The nlm_early_serial_setup code needs the early_serial_setup symbol
> which is only available if CONFIG_SERIAL_8250 is selected.
> Fixes the following build problem:
> 
> arch/mips/built-in.o: In function `nlm_early_serial_setup':
> setup.c:(.init.text+0x274): undefined reference to `early_serial_setup'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/netlogic/xlr/setup.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
> index 214d123..6d7d75e 100644
> --- a/arch/mips/netlogic/xlr/setup.c
> +++ b/arch/mips/netlogic/xlr/setup.c
> @@ -60,6 +60,7 @@ unsigned int  nlm_threads_per_core = 1;
>  struct nlm_soc_info nlm_nodes[NLM_NR_NODES];
>  cpumask_t nlm_cpumask = CPU_MASK_CPU0;
> 
> +#ifdef CONFIG_SERIAL_8250
>  static void __init nlm_early_serial_setup(void)
>  {
>         struct uart_port s;
> @@ -78,6 +79,9 @@ static void __init nlm_early_serial_setup(void)
>         s.membase       = (unsigned char __iomem *)uart_base;
>         early_serial_setup(&s);
>  }
> +#else
> +static inline void nlm_early_serial_setup(void) {}
> +#endif
> 

The UART device is on the SoC, so adding 'select SERIAL_8250' to the Kconfig
for NLM_XLP_BOARD may be a better option.

JC.

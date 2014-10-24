Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2014 11:47:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30593 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010490AbaJXJrLk-erz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Oct 2014 11:47:11 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8A2C1183402BF;
        Fri, 24 Oct 2014 10:47:02 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 24 Oct
 2014 10:47:04 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 24 Oct 2014 10:47:04 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 24 Oct
 2014 10:47:03 +0100
Message-ID: <544A2017.7020804@imgtec.com>
Date:   Fri, 24 Oct 2014 10:47:03 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.8.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>,
        <adi-buildroot-devel@lists.sourceforge.net>, <linux390@de.ibm.com>,
        <linux-alpha@vger.kernel.org>, <linux-am33-list@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-c6x-dev@linux-c6x.org>, <linux-cris-kernel@axis.com>,
        <linux-hexagon@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux@openrisc.net>, <linux-m68k@vger.kernel.org>,
        <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <linux-xtensa@linux-xtensa.org>, <sparclinux@vger.kernel.org>,
        <user-mode-linux-devel@lists.sourceforge.net>,
        <user-mode-linux-user@lists.sourceforge.net>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 08/47] kernel: Move pm_power_off to common code
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net> <1413864783-3271-9-git-send-email-linux@roeck-us.net>
In-Reply-To: <1413864783-3271-9-git-send-email-linux@roeck-us.net>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Guenter,

On 21/10/14 05:12, Guenter Roeck wrote:
> pm_power_off is defined for all architectures. Move it to common code.
> 
> Have all architectures call do_kernel_power_off instead of pm_power_off.
> Some architectures point pm_power_off to machine_power_off. For those,
> call do_kernel_power_off from machine_power_off instead.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Hirokazu Takata <takata@linux-m32r.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Richard Weinberger <richard@nod.at>
> Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>

For metag:
Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> diff --git a/arch/metag/kernel/process.c b/arch/metag/kernel/process.c
> index 483dff9..8d95773 100644
> --- a/arch/metag/kernel/process.c
> +++ b/arch/metag/kernel/process.c
> @@ -67,9 +67,6 @@ void arch_cpu_idle_dead(void)
>  }
>  #endif
>  
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void (*soc_restart)(char *cmd);
>  void (*soc_halt)(void);
>  
> @@ -90,8 +87,7 @@ void machine_halt(void)
>  
>  void machine_power_off(void)
>  {
> -	if (pm_power_off)
> -		pm_power_off();
> +	do_kernel_power_off();
>  	smp_send_stop();
>  	hard_processor_halt(HALT_OK);
>  }

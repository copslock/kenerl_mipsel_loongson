Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2014 11:45:51 +0200 (CEST)
Received: from smtp02.citrix.com ([66.165.176.63]:56174 "EHLO
        SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009620AbaJBJptJxLyO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Oct 2014 11:45:49 +0200
X-IronPort-AV: E=Sophos;i="5.04,638,1406592000"; 
   d="scan'208";a="178466624"
Message-ID: <542D1EC4.10100@citrix.com>
Date:   Thu, 2 Oct 2014 10:45:40 +0100
From:   David Vrabel <david.vrabel@citrix.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <linux-ia64@vger.kernel.org>,
        <linux-c6x-dev@linux-c6x.org>, <linux-parisc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <linux-metag@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Xen-devel] [RFC PATCH 14/16] x86/xen: support poweroff through
 poweroff handler call chain
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net> <1412100056-15517-15-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412100056-15517-15-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-DLP:  MIA1
Return-Path: <david.vrabel@citrix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.vrabel@citrix.com
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

On 30/09/14 19:00, Guenter Roeck wrote:
> The kernel core now supports a poweroff handler call chain
> to remove power from the system. Call it if pm_power_off
> is set to NULL.
> 
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/x86/xen/enlighten.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index c0cb11f..645d00f 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -1322,6 +1322,8 @@ static void xen_machine_power_off(void)
>  {
>  	if (pm_power_off)
>  		pm_power_off();
> +	else
> +		do_kernel_poweroff();

Why isn't this if (pm_power_off) check in do_kernel_poweroff()?

That way when you finally remove pm_power_off you need only update one
place.  A quick skim of the other archs suggest this would work for them
too.

David

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2014 12:31:16 +0200 (CEST)
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:51794 "EHLO
        foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010260AbaJCKbN6Gvak (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Oct 2014 12:31:13 +0200
Received: from foss-smtp-na-1.foss.arm.com (unknown [10.80.61.8])
        by foss-mx-na.foss.arm.com (Postfix) with ESMTP id 328915D;
        Fri,  3 Oct 2014 05:31:05 -0500 (CDT)
Received: from collaborate-mta1.arm.com (highbank-bc01-b06.austin.arm.com [10.112.81.134])
        by foss-smtp-na-1.foss.arm.com (Postfix) with ESMTP id C025C6045A;
        Fri,  3 Oct 2014 05:30:57 -0500 (CDT)
Received: from localhost (unknown [10.1.16.61])
        by collaborate-mta1.arm.com (Postfix) with ESMTP id 65C0913F77B;
        Fri,  3 Oct 2014 05:30:57 -0500 (CDT)
Received: by localhost (Postfix, from userid 1000)
        id 55B342424; Fri,  3 Oct 2014 11:30:56 +0100 (BST)
Date:   Fri, 3 Oct 2014 11:30:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Will Deacon <Will.Deacon@arm.com>
Subject: Re: [RFC PATCH 05/16] arm64: support poweroff through poweroff
 handler call chain
Message-ID: <20141003103056.GB14110@localhost>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
 <1412100056-15517-6-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412100056-15517-6-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <catalin.marinas@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: catalin.marinas@arm.com
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

On Tue, Sep 30, 2014 at 07:00:45PM +0100, Guenter Roeck wrote:
> The kernel core now supports a poweroff handler call chain
> to remove power from the system. Call it if pm_power_off
> is set to NULL.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/arm64/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 398ab05..cc0c63e 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -157,6 +157,8 @@ void machine_power_off(void)
>  	smp_send_stop();
>  	if (pm_power_off)
>  		pm_power_off();
> +	else
> +		do_kernel_poweroff();

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

As others already stated, I think we should eventually remove
pm_power_off entirely.

Catalin

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2014 15:32:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39494 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010257AbaJANcmVVts4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Oct 2014 15:32:42 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s91DWeYY028675;
        Wed, 1 Oct 2014 15:32:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s91DWdJ0028674;
        Wed, 1 Oct 2014 15:32:39 +0200
Date:   Wed, 1 Oct 2014 15:32:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH 10/16] mips: support poweroff through poweroff
 handler call chain
Message-ID: <20141001133238.GJ19854@linux-mips.org>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
 <1412100056-15517-11-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412100056-15517-11-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Sep 30, 2014 at 11:00:50AM -0700, Guenter Roeck wrote:

> The kernel core now supports a poweroff handler call chain
> to remove power from the system. Call it if pm_power_off
> is set to NULL.
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/mips/kernel/reset.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
> index 07fc524..c3391d7 100644
> --- a/arch/mips/kernel/reset.c
> +++ b/arch/mips/kernel/reset.c
> @@ -41,4 +41,6 @@ void machine_power_off(void)
>  {
>  	if (pm_power_off)
>  		pm_power_off();
> +	else
> +		do_kernel_poweroff();

I'm happy with this as long as in a later version pm_power_off indeed
goes away.

  Ralf

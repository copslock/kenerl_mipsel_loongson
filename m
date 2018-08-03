Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 07:43:18 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991947AbeHCFnORBq5k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2018 07:43:14 +0200
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B7B6D3EE;
        Fri,  3 Aug 2018 05:43:06 +0000 (UTC)
Date:   Fri, 3 Aug 2018 07:43:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v2 08/18] serial: intel: Get serial id from dts
Message-ID: <20180803054304.GA2214@kroah.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-9-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803030237.3366-9-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Fri, Aug 03, 2018 at 11:02:27AM +0800, Songjun Wu wrote:
> Get serial id from dts.
> 
> "#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
> macro is defined in lantiq_soc.h.
> lantiq_soc.h is in arch path for legacy product support.
> 
> arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> 
> If "#ifdef preprocessor" is changed to
> "if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
> code using LTQ_EARLY_ASC is compiled.
> Compilation will fail for no LTQ_EARLY_ASC defined.
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/tty/serial/lantiq.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 044128277248..836ca51460f2 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2007 Felix Fietkau <nbd@openwrt.org>
>   * Copyright (C) 2007 John Crispin <john@phrozen.org>
>   * Copyright (C) 2010 Thomas Langer, <thomas.langer@lantiq.com>
> + * Copyright (C) 2018 Intel Corporation.

Your changes here do not warrent the addition of a copyright line, don't
you agree?  If not, please get a signed-off-by from your corporate
lawyer who does this this is warrented when you resend this patch.

thanks,

greg k-h

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Mar 2013 07:58:41 +0100 (CET)
Received: from mail-pb0-f53.google.com ([209.85.160.53]:64458 "EHLO
        mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825866Ab3CEG6ii2tSU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Mar 2013 07:58:38 +0100
Received: by mail-pb0-f53.google.com with SMTP id un1so3982172pbc.40
        for <linux-mips@linux-mips.org>; Mon, 04 Mar 2013 22:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tx7Hz+2CXaL0iH79EKHYWfDbFKgUuqCaq8ZZZ9k5tr0=;
        b=Sjm4Jj6MNuhwc5azxoi3DN+3FIcqFyrFBqIjWzsE51KKAL/iHGNL/fiWGXAxTN2bkc
         mxcau2utZTbMFFuA4XSXOCRdgTwV7/p6dA9+grAkB/jP66mMwP9WQyg1p1nkeHsBIUhL
         dK0fGDMZ824c8q5OfYDUw4dK5xOZm6816pcuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=tx7Hz+2CXaL0iH79EKHYWfDbFKgUuqCaq8ZZZ9k5tr0=;
        b=nq93GZr6m2bITFB/GyyiJN0+l+aaxfkSh0wVo9BbMbuUyWHnZMglhGP/P3GXPvQqOl
         SYl3ckJCfDF2M8i5ergfa4Fxzfz9G3d1+fwNaNTNWLfnhkAUBT8/8mHhTqMut3o5ffBQ
         ANHmv8GjPLfBXrTL2k6/JIBTK7nAK37dBbitQAv6WYzxh4scpur4U9YZxROpiNUCpa7x
         0nVpR/gqPzyip+4mrpL8/uii3b1CtOAEMH+su6e5do2N6RCwRhxglbfyC2bLnfAe5Phb
         9NxMXft3kmrOoBsbKmhOgKvt2T9aynV2gbgRzfYW9nQl3x7mf4rS3daV880jPCkyjedI
         M9uQ==
X-Received: by 10.68.48.165 with SMTP id m5mr34603276pbn.40.1362466711273;
        Mon, 04 Mar 2013 22:58:31 -0800 (PST)
Received: from localhost ([118.143.64.134])
        by mx.google.com with ESMTPS id ub1sm25395627pbc.5.2013.03.04.22.58.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Mar 2013 22:58:29 -0800 (PST)
Date:   Tue, 5 Mar 2013 14:58:51 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ganesanr@broadcom.com
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Staging: Netlogic XLR/XLS GMAC driver
Message-ID: <20130305065851.GA30028@kroah.com>
References: <1362464958-8722-1-git-send-email-ganesanr@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1362464958-8722-1-git-send-email-ganesanr@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQl2VQrq6pC7Y7jhQtmVmzyPmhFJc6fz9DGJxOXnlG1wflA3D5ZOgneHWqfrZDHPi1IJFtgz
X-archive-position: 35851
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 05, 2013 at 11:59:18AM +0530, ganesanr@broadcom.com wrote:
>  This patch has to be merged via staging tree.
> 
>  This driver has been submitted to netdev tree and reviewed, the comments 
>  are list in TODO list, will be addressed in next cycle of submission, till
>  that time I wanted this driver to be in staging tree.
> 
>  This driver shall be sent to netdev@vger.kernel.org and David Miller <davem@davemloft.net>
>  for further review.

When is that going to happen?

> --- /dev/null
> +++ b/drivers/staging/netlogic/Kconfig
> @@ -0,0 +1,7 @@
> +config NETLOGIC_XLR_NET
> +	tristate "Netlogic XLR/XLS network device"
> +	depends on CPU_XLR

Why will this not build on any other platform?  It should, right?


> --- /dev/null
> +++ b/drivers/staging/netlogic/TODO
> @@ -0,0 +1,5 @@
> +* Implementing 64bit stat counter in software
> +* All memory allocation should be changed to DMA allocations
> +* All the netdev should be linked to single pdev as parent
> +* Changing comments in to linux standred format
> +

I need a name and email address for who is responsible for this driver
and will be handling patches for it.

Please fix this up and resubmit.

thanks,

greg k-h

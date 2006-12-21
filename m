Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 04:56:09 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.25]:15252 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S28640042AbWLUE4D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2006 04:56:03 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBL4tu2J028622
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Dec 2006 20:55:56 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id kBL4ttRG016043;
	Wed, 20 Dec 2006 20:55:56 -0800
Date:	Wed, 20 Dec 2006 20:55:55 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Jeff Garzik <jgarzik@pobox.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 05/10] if_fddi.h: Add a missing inclusion
Message-Id: <20061220205555.9a48c327.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0612201113410.11005@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0612201113410.11005@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Wed, 20 Dec 2006 12:01:55 +0000 (GMT)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  This is a change to include <linux/netdevice.h> in <linux/if_fddi.h> 
> which is needed for "struct fddi_statistics".
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> 
>  Please apply.
> 
>   Maciej
> 
> patch-mips-2.6.18-20060920-if_fddi-netdev-0
> diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/linux/if_fddi.h linux-mips-2.6.18-20060920/include/linux/if_fddi.h
> --- linux-mips-2.6.18-20060920.macro/include/linux/if_fddi.h	2006-09-20 20:51:20.000000000 +0000
> +++ linux-mips-2.6.18-20060920/include/linux/if_fddi.h	2006-12-14 04:36:58.000000000 +0000
> @@ -103,6 +103,8 @@ struct fddihdr
>  	} __attribute__ ((packed));
>  
>  #ifdef __KERNEL__
> +#include <linux/netdevice.h>
> +
>  /* Define FDDI statistics structure */
>  struct fddi_statistics {
>  

I'll treat this a a bugfix, unrelated to the turbochannel changes.

Which may be wrong, but I doubt it.

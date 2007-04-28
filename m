Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 08:57:43 +0100 (BST)
Received: from smtp1.linux-foundation.org ([65.172.181.25]:26528 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20021775AbXD1H5l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 28 Apr 2007 08:57:41 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3S7vTi2005713
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Apr 2007 00:57:30 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l3S7vSHj017561;
	Sat, 28 Apr 2007 00:57:28 -0700
Date:	Sat, 28 Apr 2007 00:57:27 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org, jeff@garzik.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 1/3] ne: Add platform_driver
Message-Id: <20070428005727.6414a24e.akpm@linux-foundation.org>
In-Reply-To: <20070425.015450.25909765.anemo@mba.ocn.ne.jp>
References: <20070425.015450.25909765.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 25 Apr 2007 01:54:50 +0900 (JST) Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> @@ -880,4 +964,7 @@ void __exit cleanup_module(void)
>  		}
>  	}
>  }
> +#else /* MODULE */
> +module_init(ne_init);
> +module_exit(ne_exit);
>  #endif /* MODULE */

Are we sure about this part?  It is unusual to have special treatment dependent
upon MODULE.

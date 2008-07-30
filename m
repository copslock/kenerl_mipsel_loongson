Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2008 01:38:36 +0100 (BST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:24779 "EHLO
	smtp1.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20029151AbYG3Ai2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Jul 2008 01:38:28 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6U0bk4f005918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 17:37:47 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m6U0bjjO030416;
	Tue, 29 Jul 2008 17:37:45 -0700
Date:	Tue, 29 Jul 2008 17:37:45 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	adaplas@gmail.com
Subject: Re: [REPOST PATCH] gbefb: cmap FIFO timeout
Message-Id: <20080729173745.7428ce62.akpm@linux-foundation.org>
In-Reply-To: <20080729221204.25D97C2F34@solo.franken.de>
References: <20080729221204.25D97C2F34@solo.franken.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 30 Jul 2008 00:12:04 +0200 (CEST)
Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:

> +static void gbe_loadcmap(void)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < 256; i++) {
> +		for (j = 0; j < 1000 && gbe->cm_fifo >= 63; j++)
> +			udelay(10);
> +		if (j == 1000)
> +			printk(KERN_ERR "gbefb: cmap FIFO timeout\n");
> +
> +		gbe->cmap[i] = gbe_cmap[i];
> +	}
>  }

This is polling the hardware, yes?

I'd have thought there's a terrible risk of the compiler "optimising"
the read of gbe->cm_fifo.  Shouldn't we be using readl() here?

<looks>

oh.  It's declared volatile.  ugh.

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 01:24:36 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:27319 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20023857AbXITAY2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 01:24:28 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8K0ODFH031804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Sep 2007 17:24:14 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l8K0OCDe020204;
	Wed, 19 Sep 2007 17:24:13 -0700
Date:	Wed, 19 Sep 2007 17:24:12 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Antonino Daplas <adaplas@pol.net>,
	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve diagnostics
Message-Id: <20070919172412.725508d0.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
	<Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 18 Sep 2007 13:18:34 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  Add error messages to the probe call.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
>  While they may rarely trigger, they may be useful when something weird is 
> going on.  Also this is good style.
> 
>  This is an updated version that addresses an issue raised by Mariusz 
> Kozlowski for the sibling patch.  Checked with checkpatch.pl.
> 
>  Please apply.
> 
>   Maciej
> 
> patch-mips-2.6.23-rc5-20070904-pmag-ba-err-2
> diff -up --recursive --new-file linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c
> --- linux-mips-2.6.23-rc5-20070904.macro/drivers/video/pmag-ba-fb.c	2007-02-21 05:56:47.000000000 +0000
> +++ linux-mips-2.6.23-rc5-20070904/drivers/video/pmag-ba-fb.c	2007-09-18 10:56:51.000000000 +0000
> @@ -147,16 +147,23 @@ static int __init pmagbafb_probe(struct 
>  	resource_size_t start, len;
>  	struct fb_info *info;
>  	struct pmagbafb_par *par;
> +	int err = 0;

This initialisation to zero is not good.

Because if some error-path code forgot to do `err = -EFOO' then probe()
will return zero and the driver will leave things in half-initialised state
and will then proceed as if things had succeeded.  It will crash.

So it's better to leave this local uninitialised, because we really want to
get that compiler warning if someone forgot to set the return value.

I made that change, but am too stupid to be able to work out how to create
a config which will let me compile this thing.

akpm:/usr/src/25> grep PMAG arch/arm/configs/*
akpm:/usr/src/25> 

bah.

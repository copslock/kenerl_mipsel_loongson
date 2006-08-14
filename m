Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2006 23:53:18 +0100 (BST)
Received: from p549F51CF.dip.t-dialin.net ([84.159.81.207]:44770 "EHLO
	p549F51CF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20039335AbWHNWxO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Aug 2006 23:53:14 +0100
Received: from nf-out-0910.google.com ([64.233.182.188]:3257 "EHLO
	nf-out-0910.google.com") by lappi.linux-mips.net with ESMTP
	id S1100276AbWHNR0B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Aug 2006 19:26:01 +0200
Received: by nf-out-0910.google.com with SMTP id x37so18106nfc
        for <linux-mips@linux-mips.org>; Mon, 14 Aug 2006 10:25:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=osHDrNHRdbTa/GxaC7pgtnKj9/SSvxpGOQGLTC6tsLNI1Z88NSzR9qR/dJ6iVs+I4Et+6jsP4FrT6aNtwI2M2bWnNmMznz4ttWG0EE1j+cDWogvZHmhS9nTkdCy59qH0Bw2ZV8Tcbz8tUzAhuK7+cZZQtLrLUX0Boleq/CfsuZ4=
Received: by 10.49.8.10 with SMTP id l10mr178616nfi;
        Mon, 14 Aug 2006 10:25:50 -0700 (PDT)
Received: from dreamland.darkstar.lan ( [84.222.20.209])
        by mx.gmail.com with ESMTP id b1sm116058nfe.2006.08.14.10.25.49;
        Mon, 14 Aug 2006 10:25:49 -0700 (PDT)
Received: by dreamland.darkstar.lan (Postfix, from userid 1000)
	id 5209F29B94; Mon, 14 Aug 2006 19:25:58 +0200 (CEST)
Date:	Mon, 14 Aug 2006 19:25:58 +0200
From:	Luca <kronos.it@gmail.com>
To:	thomas@koeller.dyndns.org
Cc:	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060814172558.GA15951@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608102319.13679.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.5.12-2006-07-14
Return-Path: <kronos.it@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kronos.it@gmail.com
Precedence: bulk
X-list: linux-mips

thomas@koeller.dyndns.org ha scritto:
> diff --git a/drivers/char/watchdog/rm9k_wdt.c 
> b/drivers/char/watchdog/rm9k_wdt.c
> new file mode 100644
> index 0000000..f6a9d17
> --- /dev/null
> +++ b/drivers/char/watchdog/rm9k_wdt.c
> @@ -0,0 +1,435 @@
[...]
> +/* Module arguments */
> +static int timeout = MAX_TIMEOUT_SECONDS;
> +module_param(timeout, int, 444);
> +static unsigned long resetaddr = 0xbffdc200;
> +module_param(resetaddr, ulong, 444);
> +static unsigned long flagaddr = 0xbffdc104;
> +module_param(flagaddr, ulong, 444);
> +static int powercycle = 0;
> +module_param(powercycle, bool, 444);

File permissions should be in octal ;)

Luca
-- 
Home: http://kronoz.cjb.net
"New processes are created by other processes, just like new
 humans. New humans are created by other humans, of course,
 not by processes." -- Unix System Administration Handbook

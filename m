Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 01:40:16 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:21522 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133757AbWBXBjW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Feb 2006 01:39:22 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id A59F964D3D; Fri, 24 Feb 2006 01:46:38 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 787C98DC5; Fri, 24 Feb 2006 01:46:28 +0000 (GMT)
Resent-From: tbm@cyrius.com
Resent-Date: Fri, 24 Feb 2006 01:46:28 +0000
Resent-Message-ID: <20060224014628.GB26016@deprecation.cyrius.com>
Resent-To: linux-mips@linux-mips.org
Received: by deprecation.cyrius.com (Postfix, from userid 10)
	id 4BB879069; Mon, 20 Feb 2006 23:05:50 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by sorrow.cyrius.com (Postfix) with ESMTP id 8065E64D59
	for <tbm@cyrius.com>; Mon, 20 Feb 2006 23:04:27 +0000 (UTC)
Received: from nephila.localnet (i-83-67-53-76.freedom2surf.net [83.67.53.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sorrow.cyrius.com (Postfix) with ESMTP id 6280864D3D
	for <tbm@cyrius.com>; Mon, 20 Feb 2006 23:03:58 +0000 (UTC)
Received: from pdh by nephila.localnet with local (Exim 4.50)
	id 1FBK4L-0000JB-SU
	for tbm@cyrius.com; Mon, 20 Feb 2006 23:03:49 +0000
Date:	Mon, 20 Feb 2006 23:03:49 +0000
To:	Martin Michlmayr <tbm@cyrius.com>
Subject: Re: Diff between Linus' and linux-mips git: tulip
Message-ID: <20060220230349.GB1122@colonel-panic.org>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001907.GC17967@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220001907.GC17967@deprecation.cyrius.com>
User-Agent: Mutt/1.5.9i
From:	Peter Horton <pdh@colonel-panic.org>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cyrius.com
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 12:19:07AM +0000, Martin Michlmayr wrote:
> Anyone know what this change is good for?
> 
> 
> --- linux-2.6.16-rc4/drivers/net/tulip/tulip_core.c	2006-02-19 20:09:12.000000000 +0000
> +++ mips-2.6.16-rc4/drivers/net/tulip/tulip_core.c	2006-02-19 20:15:27.000000000 +0000
> @@ -1495,8 +1495,8 @@
>                 if ((pdev->bus->number == 0) && (PCI_SLOT(pdev->devfn) == 4)) {
>                         /* DDB5477 MAC address in first EEPROM locations. */
>                         sa_offset = 0;
> -                       /* No media table either */
> -                       tp->flags &= ~HAS_MEDIA_TABLE;
> +		       /* Ensure our media table fixup get's applied */
> +		       memcpy(ee_data + 16, ee_data, 8);
>                 }
>  #endif
>  #ifdef CONFIG_MIPS_COBALT
> 

Didn't the memcpy() used to be inside the CONFIG_MIPS_COBALT section ?

Looking at tulip/eeprom.c I can't work out why it was ever there though
...

P.

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 16:16:44 +0100 (BST)
Received: from smtp239.poczta.interia.pl ([217.74.64.239]:56378 "EHLO
	smtp239.poczta.interia.pl") by ftp.linux-mips.org with ESMTP
	id S20022355AbYHEPQi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Aug 2008 16:16:38 +0100
Received: by smtp239.poczta.interia.pl (INTERIA.PL, from userid 502)
	id E65DD296F7E; Tue,  5 Aug 2008 17:16:35 +0200 (CEST)
Received: from poczta.interia.pl (mi06.poczta.interia.pl [10.217.12.6])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id EFEE6296462;
	Tue,  5 Aug 2008 17:16:32 +0200 (CEST)
Received: by poczta.interia.pl (INTERIA.PL, from userid 502)
	id AC7D51324F9; Tue,  5 Aug 2008 17:16:32 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 2147B1324E4;
	Tue,  5 Aug 2008 17:16:27 +0200 (CEST)
Date:	Tue, 5 Aug 2008 17:22:00 +0200
From:	Krzysztof Helt <krzysztof.h1@poczta.fm>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-fbdev-devel@lists.sf.net, L-M-O <linux-mips@linux-mips.org>,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] au1200fb: fixup PM support.
Message-Id: <20080805172200.4f52ca12.krzysztof.h1@poczta.fm>
In-Reply-To: <20080805124221.GA27469@roarinelk.homelinux.net>
References: <20080805124221.GA27469@roarinelk.homelinux.net>
X-Mailer: Sylpheed 2.4.3 (GTK+ 2.11.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-EMID:	8ce2b138
Return-Path: <krzysztof.h1@poczta.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: krzysztof.h1@poczta.fm
Precedence: bulk
X-list: linux-mips

On Tue, 5 Aug 2008 14:42:21 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> Remove last traces of the custom Alchemy linux-2.4 PM code, implement
> suspend/resume callbacks.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  drivers/video/au1200fb.c |  164 ++++++++++++----------------------------------
>  1 files changed, 41 insertions(+), 123 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

If you don't want to push this patch through the mips tree you may post this patch
to Andrew Morton <akpm@linux-foundation.org> with my acked-by.

Regards,
Krzysztof

----------------------------------------------------------------------
Te newsy nakreca Cie na caly dzien!
Sprawdz >>> http://link.interia.pl/f1e94

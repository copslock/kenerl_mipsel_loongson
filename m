Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Dec 2007 17:39:32 +0000 (GMT)
Received: from hellhawk.shadowen.org ([80.68.90.175]:2057 "EHLO
	hellhawk.shadowen.org") by ftp.linux-mips.org with ESMTP
	id S20029906AbXLURjW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Dec 2007 17:39:22 +0000
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1J5ln4-0005eb-Gs; Fri, 21 Dec 2007 17:36:06 +0000
Date:	Fri, 21 Dec 2007 17:36:01 +0000
From:	Andy Whitcroft <apw@shadowen.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] SC26XX: New serial driver for SC2681 uarts
Message-ID: <20071221173601.GR13186@shadowen.org>
References: <20071202194346.36E3FDE4C4@solo.franken.de> <20071203155317.772231f9.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071203155317.772231f9.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <apw@shadowen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apw@shadowen.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 03, 2007 at 03:53:17PM -0800, Andrew Morton wrote:
> > +#define READ_SC(p, r)        readb ((p)->membase + RD_##r)
> > +#define WRITE_SC(p, r, v)    writeb ((v), (p)->membase + WR_##r)
> 
> No space before the (.  checkpatch misses this.

Yep, over careful in the special case for the parameters for #define
macros, which have different spacing rules.  This will be fixed in 0.13:

WARNING: no space between function name and open parenthesis '('
#1: FILE: Z45.c:1:
+#define WRITE_SC(p, r, v)    writeb ((v), (p)->membase + WR_##r)

-apw

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2007 15:37:27 +0000 (GMT)
Received: from pentafluge.infradead.org ([213.146.154.40]:11475 "EHLO
	pentafluge.infradead.org") by ftp.linux-mips.org with ESMTP
	id S20039028AbXBKPhW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Feb 2007 15:37:22 +0000
Received: from [89.192.35.138] (helo=[10.42.195.205])
	by pentafluge.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1HGGiG-00077D-9d; Sun, 11 Feb 2007 15:34:03 +0000
Subject: Re: -mm merge plans for 2.6.21
From:	David Woodhouse <dwmw2@infradead.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <20070210213447.GB9116@linux-mips.org>
References: <20070208150710.1324f6b4.akpm@linux-foundation.org>
	 <1171042535.29713.96.camel@pmac.infradead.org>
	 <20070209134516.2367a7aa.akpm@linux-foundation.org>
	 <1171058342.29713.136.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0702091442230.2786@alien.or.mcafeemobile.com>
	 <20070210102205.GB8145@osiris.boeblingen.de.ibm.com>
	 <1171103527.29713.228.camel@pmac.infradead.org>
	 <20070210213447.GB9116@linux-mips.org>
Content-Type: text/plain
Date:	Sun, 11 Feb 2007 16:33:41 +0100
Message-Id: <1171208022.16494.5.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+bf6f6d5a4a10df2b7bef+1267+infradead.org+dwmw2@pentafluge.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwmw2@infradead.org
Precedence: bulk
X-list: linux-mips

On Sat, 2007-02-10 at 21:34 +0000, Ralf Baechle wrote:
> Unfortunately struct epoll_event contains a gap so it bets on identical
> padding rules between native and compat ABI and anyway, padding is wasted
> space so the struct members should have been swapped when this structure
> was created.  Oh well, too late. 

Indeed. That was the example I was thinking of when I suggested the "no
new syscalls without _simultaneous_ compat version" rule.

-- 
dwmw2

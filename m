Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2007 18:03:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:36588 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039062AbXBKSD0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Feb 2007 18:03:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1BI1wpw023777;
	Sun, 11 Feb 2007 18:01:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1BI1vjC023776;
	Sun, 11 Feb 2007 18:01:57 GMT
Date:	Sun, 11 Feb 2007 18:01:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:	David Woodhouse <dwmw2@infradead.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@openvz.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ulrich Drepper <drepper@redhat.com>
Subject: Re: -mm merge plans for 2.6.21
Message-ID: <20070211180157.GA21492@linux-mips.org>
References: <20070208150710.1324f6b4.akpm@linux-foundation.org> <1171042535.29713.96.camel@pmac.infradead.org> <20070209134516.2367a7aa.akpm@linux-foundation.org> <1171058342.29713.136.camel@pmac.infradead.org> <Pine.LNX.4.64.0702091442230.2786@alien.or.mcafeemobile.com> <20070210102205.GB8145@osiris.boeblingen.de.ibm.com> <1171103527.29713.228.camel@pmac.infradead.org> <20070210213447.GB9116@linux-mips.org> <20070211161446.GB11547@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070211161446.GB11547@osiris.ibm.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 11, 2007 at 05:14:46PM +0100, Heiko Carstens wrote:

> Hmm.. so you don't need to do some fancy compat conversion for the sigset_t
> that gets passed? Why is that? I don't get it...

Ah, I finally get your point.  Yes, that needs conversion.

  Ralf

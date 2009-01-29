Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2009 21:40:36 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:3521 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21365892AbZA2Vke (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2009 21:40:34 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0TLeXLb010346;
	Thu, 29 Jan 2009 21:40:33 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0TLeXMd010344;
	Thu, 29 Jan 2009 21:40:33 GMT
Date:	Thu, 29 Jan 2009 21:40:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Alchemy: time.c build fix
Message-ID: <20090129214033.GB7358@linux-mips.org>
References: <1231234492-25733-1-git-send-email-mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1231234492-25733-1-git-send-email-mano@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 06, 2009 at 10:34:52AM +0100, Manuel Lauss wrote:

> in Linus' current -git the cpumask member is now a pointer.

Applied, thanks!

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 17:11:04 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:29933 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24207671AbYLURLC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 21 Dec 2008 17:11:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mBLHB1Jd017975;
	Sun, 21 Dec 2008 17:11:01 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mBLHB1sd017973;
	Sun, 21 Dec 2008 17:11:01 GMT
Date:	Sun, 21 Dec 2008 17:11:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/14] Alchemy: devboards: consolidate files
Message-ID: <20081221171101.GB10532@linux-mips.org>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net> <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Dec 21, 2008 at 09:26:15AM +0100, Manuel Lauss wrote:

> Share some code and merge small files:
> - Extract the prom init code from all devboard files (they only differ in
>   memory configuration).
> - Merge the irq configuration into board setup code.
> - Merge smaller files into board setup code.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

Same comment as for 01/14 for this patch:

You're submitting this for 2.6.28 please ensure your patches apply
against the -queue tree.  There is already another patch in -queue touching
the Alchemy code so this patch rejects.  I fixed it up but it's avoidable
work ...

  Ralf

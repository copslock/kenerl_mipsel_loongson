Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 07:01:33 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:51948
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20025235AbYG2GBY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 07:01:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6T60K7P022475;
	Tue, 29 Jul 2008 07:00:45 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6T60JUO022473;
	Tue, 29 Jul 2008 07:00:19 +0100
Date:	Tue, 29 Jul 2008 07:00:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] minor update to the upstream-apkm tree to get pnx833x
	booting
Message-ID: <20080729060019.GB18334@linux-mips.org>
References: <64660ef00807260121g65517381m5e3af76fe2b58642@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00807260121g65517381m5e3af76fe2b58642@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 26, 2008 at 09:21:07AM +0100, Daniel Laird wrote:

> Life at last.... This patch updates the upstream-akpm stream to get
> the pnx833x actually building / booting.
> All runs well now.  Default Config file has been updated as well.
> 
>  Kconfig                          |    1
>  configs/pnx8335-stb225_defconfig |   96 ++++++++++++++++++---------------------
>  nxp/pnx833x/common/platform.c    |   11 ++++
>  3 files changed, 56 insertions(+), 52 deletions(-)

Thanks Daniel.  I folded this patch into the upstream-akpm one.

  Ralf

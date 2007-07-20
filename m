Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 18:31:38 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45724 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023030AbXGTRbg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 18:31:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6KHVX1V005383;
	Fri, 20 Jul 2007 18:31:33 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6KHVW7I005382;
	Fri, 20 Jul 2007 18:31:32 +0100
Date:	Fri, 20 Jul 2007 18:31:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [patch 3/3] scsi: wd33c93 needs <asm/irq.h>
Message-ID: <20070720173132.GB19424@linux-mips.org>
References: <20070720164043.523003359@mail.of.borg> <20070720164324.097994947@mail.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070720164324.097994947@mail.of.borg>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 20, 2007 at 06:40:46PM +0200, Geert Uytterhoeven wrote:

> --- a/drivers/scsi/wd33c93.c
> +++ b/drivers/scsi/wd33c93.c
> @@ -89,6 +89,8 @@
>  #include <scsi/scsi_device.h>
>  #include <scsi/scsi_host.h>
>  
> +#include <asm/irq.h>

These days that should probably be <linux/irq.h>.

  Ralf

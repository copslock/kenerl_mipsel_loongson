Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 17:49:09 +0100 (BST)
Received: from hancock.steeleye.com ([71.30.118.248]:23208 "EHLO
	hancock.sc.steeleye.com") by ftp.linux-mips.org with ESMTP
	id S20022993AbXGTQtH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 17:49:07 +0100
Received: from [172.17.6.40] (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (Postfix) with ESMTP id 68C6FAAA8231;
	Fri, 20 Jul 2007 12:48:58 -0400 (EDT)
Subject: Re: [patch 3/3] scsi: wd33c93 needs <asm/irq.h>
From:	James Bottomley <James.Bottomley@SteelEye.com>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <20070720164324.097994947@mail.of.borg>
References: <20070720164043.523003359@mail.of.borg>
	 <20070720164324.097994947@mail.of.borg>
Content-Type: text/plain
Date:	Fri, 20 Jul 2007 11:48:57 -0500
Message-Id: <1184950138.3455.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 (2.10.3-1.fc7) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@SteelEye.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@SteelEye.com
Precedence: bulk
X-list: linux-mips

On Fri, 2007-07-20 at 18:40 +0200, Geert Uytterhoeven wrote:
> plain text document attachment (m68k-wd33c93-needs-asm-irq.diff)
> wd33c93 SCSI needs <asm/irq.h> on m68k
> 
> drivers/scsi/wd33c93.c: In function 'wd33c93_host_reset':
> drivers/scsi/wd33c93.c:1582: error: implicit declaration of function 'disable_irq'
> drivers/scsi/wd33c93.c:1603: error: implicit declaration of function 'enable_irq'
> 
> The driver still compiles on MIPS (CONFIG_SGIWD93_SCSI=y)

That's fixed here, isn't it:

http://git.kernel.org/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commit;h=078dda95c521b1c78d1b5da69ac90d581abc9951

(sorry about the lack of descriptive subject line)

James

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 12:13:18 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:5760 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022073AbXHBLNQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 12:13:16 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l72BDFCP026538;
	Thu, 2 Aug 2007 12:13:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l72BDE9C026534;
	Thu, 2 Aug 2007 12:13:14 +0100
Date:	Thu, 2 Aug 2007 12:13:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Imre Kaloz <kaloz@openwrt.org>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Sync SiByte system code to the new DUART driver
Message-ID: <20070802111314.GA25949@linux-mips.org>
References: <op.twfh4cuw2s3iss@ecaz.afh.b-m.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.twfh4cuw2s3iss@ecaz.afh.b-m.hu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 02, 2007 at 12:58:50PM +0200, Imre Kaloz wrote:

> The new upstream SiByte DUART driver uses a different config option then
> the old one, so the SiByte target doesn't compile currently.
> This patch fixes the problem.
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

Hmm...  You just found the tip of the iceberg ...

$ git grep -w CONFIG_SIBYTE_SB1250_DUART | cat -
arch/mips/configs/bigsur_defconfig:CONFIG_SIBYTE_SB1250_DUART=y
arch/mips/configs/sb1250-swarm_defconfig:CONFIG_SIBYTE_SB1250_DUART=y
arch/mips/sibyte/bcm1480/irq.c:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/bcm1480/irq.c:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/cfe/console.c:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/sb1250/irq.c:#ifdef CONFIG_SIBYTE_SB1250_DUART
arch/mips/sibyte/sb1250/irq.c:#ifdef CONFIG_SIBYTE_SB1250_DUART

  Ralf

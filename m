Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 21:26:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:64161 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133853AbWGTU0i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Jul 2006 21:26:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k6KJIcrD022469;
	Thu, 20 Jul 2006 15:21:18 -0400
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k6KJIaiR022468;
	Thu, 20 Jul 2006 15:18:36 -0400
Date:	Thu, 20 Jul 2006 15:18:36 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Honour "panic_on_oops" sysctl on mips arch
Message-ID: <20060720191836.GA22361@linux-mips.org>
References: <1153414322.20352.268.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153414322.20352.268.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 20, 2006 at 06:52:02PM +0200, Maxime Bizon wrote:

> The panic_on_oops sysctl has no effect on mips, the following patch
> fixes it.

Applied. thanks,

  Ralf

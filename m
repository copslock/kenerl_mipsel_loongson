Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 14:37:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:63444 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037749AbXCCOg7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Mar 2007 14:36:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l23EawlF004339;
	Sat, 3 Mar 2007 14:36:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l23Eat9G004326;
	Sat, 3 Mar 2007 14:36:55 GMT
Date:	Sat, 3 Mar 2007 14:36:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@int-evry.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] MTX-1 watchdog driver
Message-ID: <20070303143655.GA3792@linux-mips.org>
References: <200703022207.26276.florian.fainelli@int-evry.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200703022207.26276.florian.fainelli@int-evry.fr>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 02, 2007 at 10:07:26PM +0100, Florian Fainelli wrote:

> This patch is required if you want to use a MTX-1 board and do not see it 
> being rebooted every 10 seconds.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@int-evry.fr>

Watchdog stuff is handled by:

WATCHDOG DEVICE DRIVERS
P:      Wim Van Sebroeck
M:      wim@iguana.be
T:      git kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
S:      Maintained

  Ralf

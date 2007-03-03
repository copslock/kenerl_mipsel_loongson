Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2007 14:38:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5590 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037732AbXCCOiI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Mar 2007 14:38:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l23Ec7P8004365;
	Sat, 3 Mar 2007 14:38:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l23Ec7Ef004355;
	Sat, 3 Mar 2007 14:38:07 GMT
Date:	Sat, 3 Mar 2007 14:38:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@int-evry.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/7] Au1000 eth : Link beat detection
Message-ID: <20070303143807.GB3792@linux-mips.org>
References: <200703022207.35218.florian.fainelli@int-evry.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200703022207.35218.florian.fainelli@int-evry.fr>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 02, 2007 at 10:07:35PM +0100, Florian Fainelli wrote:

> This patch fixes the link beat detection when the cable is not plugged at 
> startup. It is not MTX1 specific.

Network drivers are handled by:

NETWORK DEVICE DRIVERS
P:      Andrew Morton
M:      akpm@linux-foundation.org
P:      Jeff Garzik
M:      jgarzik@pobox.com
L:      netdev@vger.kernel.org
T:      git kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
S:      Maintained

  Ralf

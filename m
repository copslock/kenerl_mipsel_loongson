Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2002 02:37:22 +0000 (GMT)
Received: from p508B5BE3.dip.t-dialin.net ([IPv6:::ffff:80.139.91.227]:39614
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225511AbSLTChW>; Fri, 20 Dec 2002 02:37:22 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBK2bFJ21838;
	Fri, 20 Dec 2002 03:37:15 +0100
Date: Fri, 20 Dec 2002 03:37:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: fix type of MAXMEM
Message-ID: <20021220033715.A21801@linux-mips.org>
References: <m28yylixhm.fsf@demo.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m28yylixhm.fsf@demo.mitica>; from quintela@mandrakesoft.com on Thu, Dec 19, 2002 at 09:07:17PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 19, 2002 at 09:07:17PM +0100, Juan Quintela wrote:

>         I expect that the amount from where it is highmem to never be
>         bigger that 4Giga Megabytes :) I.e. int should be enough.

No.  The root cause of this problem is the type of the constant
HIGHMEM_START which should have been unsigned int but actually was
just int.

  Ralf

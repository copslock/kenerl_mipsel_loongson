Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 12:54:38 +0000 (GMT)
Received: from p508B4EE8.dip.t-dialin.net ([IPv6:::ffff:80.139.78.232]:51135
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225235AbTBDMyi>; Tue, 4 Feb 2003 12:54:38 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h14CsVY29834;
	Tue, 4 Feb 2003 13:54:31 +0100
Date: Tue, 4 Feb 2003 13:54:31 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.5] r4k_switch task_struct/thread_info fixes
Message-ID: <20030204135431.A29811@linux-mips.org>
References: <Pine.LNX.4.21.0302032311160.25421-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0302032311160.25421-100000@melkor>; from vivienc@nerim.net on Mon, Feb 03, 2003 at 11:21:50PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 03, 2003 at 11:21:50PM +0100, Vivien Chappelier wrote:

> 	This patch fixes an incorrect use of THREAD_FLAGS instead of
> TI_FLAGS when clearing the TIF_USEDFPU flag of the current thread info,
> and an incorrect assumption when using ST_OFF, that the stack is shared
> with task_struct, whereas it is shared with thread_info in 2.5.

Ok.  You missed r2300_switch.S though :)

  Ralf

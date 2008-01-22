Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 18:26:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:4240 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28589488AbYAVS02 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jan 2008 18:26:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0MIQSu2001795;
	Tue, 22 Jan 2008 18:26:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0MIQRYO001794;
	Tue, 22 Jan 2008 18:26:27 GMT
Date:	Tue, 22 Jan 2008 18:26:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Chris Friesen <cfriesen@nortel.com>, linux-mips@linux-mips.org
Subject: Re: quick question on 64-bit values with 32-bit inline assembly
Message-ID: <20080122182627.GA474@linux-mips.org>
References: <4794DFE1.5040805@nortel.com> <20080122175734.GA31013@linux-mips.org> <Pine.LNX.4.64.0801221901380.17593@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801221901380.17593@anakin>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 22, 2008 at 07:02:02PM +0100, Geert Uytterhoeven wrote:

> > unsigned long long gethrtime(void)
> > {
> > 	unsigned long result;
>         ^^^^^^^^^^^^^
> 	unsigned long long

Obviously, indeed.

Thanks :-)

  Ralf

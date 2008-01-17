Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2008 12:02:09 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9651 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28582501AbYAQMCH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Jan 2008 12:02:07 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0HBxdSI009488;
	Thu, 17 Jan 2008 11:59:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0HBxcVB009487;
	Thu, 17 Jan 2008 11:59:38 GMT
Date:	Thu, 17 Jan 2008 11:59:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080117115938.GB7966@linux-mips.org>
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080117004054.GA12051@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 17, 2008 at 01:40:54AM +0100, Thomas Bogendoerfer wrote:

> ----------------------------------------------------------------------
> void spin(void *a0)
> {
> 	while (1) {
> 		asm volatile(
> 		"    .set mips3       \n"
> 		"    sync             \n"
> 		"1:  ll $5, 0($4)     \n"
> 		"    sc $3, 0($4)     \n"
> 		"    beqz $3, 1b      \n"
> 		"    .word 0x7c03e83b \n" /* rdhwr */
> 		"    lw $3, 0($4)     \n"
> 		"    nop              \n"
> 		);
> 	}
> }
> 
> int main()
> {
> 	int a;
> 
> 	spin(&a);
> }
> ----------------------------------------------------------------------
> 
> this kills my IP28 after a few seconds. If I drop rdhwr or sync the
> machine hasn't locked up after running for several minutes. Looks
> like we are hiting a strange condition.

SYNC on the R10000 will only graduate if the external signal SyncGblPerf
is asserted.  A simple system could simply always set it.  I wonder if
that has any affect.  Logic analyzer time ...

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2008 00:41:34 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:52372 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28581209AbYAQAl0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2008 00:41:26 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JFIot-0003uC-00; Thu, 17 Jan 2008 01:41:23 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id A7F82C2F7F; Thu, 17 Jan 2008 01:40:54 +0100 (CET)
Date:	Thu, 17 Jan 2008 01:40:54 +0100
To:	Florian Lohoff <flo@rfc822.org>
Cc:	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080117004054.GA12051@alpha.franken.de>
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080115112719.GB7920@paradigm.rfc822.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Jan 15, 2008 at 12:27:19PM +0100, Florian Lohoff wrote:
> Simple testcase for me is:

now even simpler:

----------------------------------------------------------------------
void spin(void *a0)
{
	while (1) {
		asm volatile(
		"    .set mips3       \n"
		"    sync             \n"
		"1:  ll $5, 0($4)     \n"
		"    sc $3, 0($4)     \n"
		"    beqz $3, 1b      \n"
		"    .word 0x7c03e83b \n" /* rdhwr */
		"    lw $3, 0($4)     \n"
		"    nop              \n"
		);
	}
}

int main()
{
	int a;

	spin(&a);
}
----------------------------------------------------------------------

this kills my IP28 after a few seconds. If I drop rdhwr or sync the
machine hasn't locked up after running for several minutes. Looks
like we are hiting a strange condition.

This sort of code could be found in glibc 2.7 all over the place...

Thomas.

PS: Using rdhwr_noopt doesn't make a difference...

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

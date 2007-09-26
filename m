Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 18:09:20 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:33458 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20029811AbXIZRJL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 18:09:11 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1IaaKm-0002oJ-G4
	for linux-mips@linux-mips.org; Wed, 26 Sep 2007 10:06:00 -0700
Message-ID: <12905373.post@talk.nabble.com>
Date:	Wed, 26 Sep 2007 10:06:00 -0700 (PDT)
From:	Steve Graham <stgraham2000@yahoo.com>
To:	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
In-Reply-To: <20070924115804.GA12300@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: stgraham2000@yahoo.com
References: <4687DCE2.8070302@gentoo.org> <340C71CD25A7EB49BFA81AE8C839266757076E@BBY1EXM10.pmc_nt.nt.pmc-sierra.bc.ca> <20070921134753.GA8090@linux-mips.org> <12833079.post@talk.nabble.com> <20070924115804.GA12300@linux-mips.org>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stgraham2000@yahoo.com
Precedence: bulk
X-list: linux-mips


Yes, the reason my platform has scache_size=0 is because the sc-rm7k.c
handles this.  As a result, I found a few more issues in the current c-r4k.c
file.  In "r4k_blash_scache_page_setup",
"r4k_blash_scache_page_indexed_setup", "r4k_blash_scache_setup", and
"local_r4k_flush_icache_range", there are similar checks on "scache_size"
that need to be removed for my platform.  I was still getting the odd "seg
fault" during boots and this seems to have fixed it.

One question I have regarding this is, does anyone have a tool that I can
run to test this cache code and really exercise the cache?  The problems are
so random and infrequent that it's difficult to know if the problem is gone
or just more hidden.  Ralf, I imagine since you are the one with intimate
knowledge of this code that you may have developed a tool or have used a
tool to really test this code.
-- 
View this message in context: http://www.nabble.com/O2-RM7000-Issues-tf4008392.html#a12905373
Sent from the linux-mips main mailing list archive at Nabble.com.

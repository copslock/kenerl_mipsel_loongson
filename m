Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 02:52:20 +0100 (BST)
Received: from mail010.syd.optusnet.com.au ([IPv6:::ffff:210.49.20.138]:63117
	"EHLO mail010.syd.optusnet.com.au") by linux-mips.org with ESMTP
	id <S8225072AbTDIBwS>; Wed, 9 Apr 2003 02:52:18 +0100
Received: from localhost.karma (c17997.eburwd3.vic.optusnet.com.au [210.49.198.98])
	by mail010.syd.optusnet.com.au (8.11.6p2/8.11.6) with ESMTP id h391qFn25936
	for <linux-mips@linux-mips.org>; Wed, 9 Apr 2003 11:52:15 +1000
Received: by localhost.karma (Postfix, from userid 500)
	id 2CF2C297; Wed,  9 Apr 2003 11:52:11 +1000 (EST)
Date: Wed, 9 Apr 2003 11:52:10 +1000
From: Andrew Clausen <clausen@gnu.org>
To: linux-mips@linux-mips.org
Subject: [ANNOUNCE] Linux on Origin 200 (ip27) docs, scripts and patches
Message-ID: <20030409015210.GA1994@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Accept-Language: en,pt
Return-Path: <clausen@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@gnu.org
Precedence: bulk
X-list: linux-mips

Hi all,

I've put most of the output of my internship at SGI here:

	http://members.optusnet.com.au/clausen/sgi

Of particular interest are:

	http://members.optusnet.com.au/clausen/sgi/LINUX-IP27-HOWTO
		a document describing a few different ways to install
		Debian on an Origin 200.

	http://members.optusnet.com.au/clausen/sgi/gen-mips-cd
		a shell script for making bootable ip27 linux CDs.

	http://members.optusnet.com.au/clausen/sgi/genisovh.diff
		a patch to genisovh that allows nested partitions.
		gen-mips-cd (above) needs this patch.

Cheers,
Andrew

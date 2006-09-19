Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2006 22:09:30 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:16599 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038671AbWISVJ2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2006 22:09:28 +0100
Received: from lagash (88-106-139-84.dynamic.dsl.as9105.com [88.106.139.84])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id D21D9447C8; Tue, 19 Sep 2006 23:09:22 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GPmpk-0005OB-MK; Tue, 19 Sep 2006 22:08:48 +0100
Date:	Tue, 19 Sep 2006 22:08:48 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Eric DeVolder <edevolder@razamicroelectronics.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Differing results from cross and native compilers
Message-ID: <20060919210848.GC24864@networkno.de>
References: <2E96546B3C2C8B4CA739323C6058204A0163548E@hq-ex-mb01.razamicroelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E96546B3C2C8B4CA739323C6058204A0163548E@hq-ex-mb01.razamicroelectronics.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Eric DeVolder wrote:
> Thiemo, could you share what the native 3.4 compiler reports as
> its configuration? (e.g. the "Configured with: " statement)?

It was built by the Debian autobuilder, the buildlog at
http://buildd.debian.org/fetch.php?&pkg=gcc-3.4&ver=3.4.6-4&arch=mips&stamp=1157712260&file=log&as=raw
should show the configuration.


Thiemo

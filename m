Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 13:51:54 +0000 (GMT)
Received: from bender.bawue.de ([193.7.176.20]:35975 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133422AbWBUNvo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Feb 2006 13:51:44 +0000
Received: from lagash (unknown [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 1F62944051; Tue, 21 Feb 2006 14:58:40 +0100 (MET)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1FBY2f-0000VC-7h; Tue, 21 Feb 2006 13:59:01 +0000
Date:	Tue, 21 Feb 2006 13:59:01 +0000
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060221135901.GA30024@networkno.de>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060219165245.GD21416@linux-mips.org> <20060220181227.GA17439@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220181227.GA17439@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 06:12:27PM +0000, Martin Michlmayr wrote:
> * Ralf Baechle <ralf@linux-mips.org> [2006-02-19 16:52]:
> > > beginning, the light on the Indy is green but after about 20 seconds
> > > it turns red.  Nothing happens on the console and the machine doesn't
> > > turn off.  Seen on Indy and Indigo2.
> > > Anyone got a fix?
> > No.  Do you know when this problems started?
> 
> A long time ago, it seems.  I can trace it back to 2.6.9;
> unfortunately I don't get any older kernel to run/compile, possibily
> because my toolchain isn't old enough (I even installed the SDE that's
> based on 3.3).

ISTR my 2.6.12 works for Indy shutdown (That's with gcc-4.0).


Thiemo

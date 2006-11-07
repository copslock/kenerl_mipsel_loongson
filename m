Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2006 14:04:53 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:24265 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20037855AbWKGOEh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2006 14:04:37 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 75CFFB81C8;
	Tue,  7 Nov 2006 15:05:05 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GhRZ7-0000an-Qu; Tue, 07 Nov 2006 14:04:37 +0000
Date:	Tue, 7 Nov 2006 14:04:37 +0000
To:	Tim Bird <tim.bird@am.sony.com>
Cc:	CE Linux Developers List <celinux-dev@tree.celinuxforum.org>,
	linux-mips@linux-mips.org
Subject: Re: MIPS processors gain GNU/Linux binary prelinker
Message-ID: <20061107140437.GD19541@networkno.de>
References: <45492407.7090606@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45492407.7090606@am.sony.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Tim Bird wrote:
> FYI - For those interested in bootup time improvements on MIPS
> processors, here is some information about the recently
> developed MIPS prelinking feature, done by CodeSourcery
> and MIPS Technologies.

The patches are showing up piecemeal now on the various mailing lists,
I also dumped a debian-styleish patchset at
ftp://ftp.linux-mips.org/pub/linux/mips/people/ths/mips-prelinker-patches-debian/


Thiemo

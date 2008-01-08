Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 14:54:55 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:4531 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20031978AbYAHOyq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jan 2008 14:54:46 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 1AB4E4890B;
	Tue,  8 Jan 2008 15:54:38 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1JCFqr-0002Xz-J7; Tue, 08 Jan 2008 14:54:49 +0000
Date:	Tue, 8 Jan 2008 14:54:49 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Andi <opencode@gmx.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: memory dump on mips
Message-ID: <20080108145449.GB30298@networkno.de>
References: <4783754D.8010007@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4783754D.8010007@gmx.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Andi wrote:
> Hi list,
> 
> we are working on an embedded Linux device with a Sigma SMP8634 (MIPS
> 4KEc 300MHz CPU) mounted on it. Unfortunately we don't have access to
> the kernel running on the system.
> 
> We figured out, that the bootloader loads the kernel image to 0x90020000
> (physical address).

This sounds like you are confusing physical and virtual addresses.
Typically the kernel is loaded to the direct-mapped KSEG0 segment,
which starts at physical 0x00000000 / virtual 0x80000000.

So the physical address you are looking for would be 0x10020000.


Thiemo

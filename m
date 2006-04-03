Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Apr 2006 11:31:25 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:17803 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133644AbWDCKbQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Apr 2006 11:31:16 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k33AgI7L006132;
	Mon, 3 Apr 2006 11:42:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k33AgF1p006131;
	Mon, 3 Apr 2006 11:42:15 +0100
Date:	Mon, 3 Apr 2006 11:42:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chuck Meade <chuckmeade@mindspring.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: corruption of load instruction offset
Message-ID: <20060403104215.GA3150@linux-mips.org>
References: <IIEEICKJLNEPBBDJICNGEECHKIAA.chuckmeade@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IIEEICKJLNEPBBDJICNGEECHKIAA.chuckmeade@mindspring.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 03, 2006 at 12:12:46AM -0400, Chuck Meade wrote:

> I am seeing a very interesting/worrisome bug on an RM7965 cpu, which has
> an E9000 core.  I am running 2.6.14-rc1.  Please take a look at the
> behavior I describe and send me your thoughts.  Thanks.

Well, 2.6.14-rc1.  The -rc1 part says it already.  While the rc may stand
for release candidate, they -rc1 kernels are definatly far from ready for
a release.  All the new features for the 2.6.14 but hardly any of the fixes.
I really suggest you go either for 2.6.13 or upgrade to 2.6.14.

Talking about upgrading, 2.6.16.1 is a good vintage for MIPS so far.

Aside of this more general warning about -rc but especially -rc1 kernels
I think the remainder of your analysis is correct ...

  Ralf

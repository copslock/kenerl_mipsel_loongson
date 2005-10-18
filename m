Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 17:50:58 +0100 (BST)
Received: from eth13.com-link.com ([208.242.241.164]:61102 "EHLO
	real.realitydiluted.com") by ftp.linux-mips.org with ESMTP
	id S8133622AbVJRQun (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 17:50:43 +0100
Received: from sjhill by real.realitydiluted.com with local (Exim 4.52 #1 (Debian))
	id 1ERtjv-000353-Lg; Tue, 18 Oct 2005 10:50:59 -0500
Subject: Re: power management on mips
In-Reply-To: <a59861030510180900s6041e21u@mail.gmail.com>
To:	Ivan Korzakow <ivan.korzakow@gmail.com>
Date:	Tue, 18 Oct 2005 10:50:59 -0500 (CDT)
CC:	linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1ERtjv-000353-Lg@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> Does anyone knows what power management features are there for mips ?
> I know for example that ACPI have been porting to arm. Anything
> equivalent for mips ? Is it possible to do some power management under
> Linux if ACPI or APM is not ported to mips ? And if yes, what would be
> the work to do ?
> 
I have a sudden urge to vomit all over you, maybe because you said
ACPI and MIPS in the same sentence. ACPI is pretty x86-centric. I
doubt it will ever make its way into MIPS. Dan Malek or others may
have comments on various PM schemes used in MIPS. I am surprised
that ARM adopted it, but there's a reason I no longer do ARM kernel
development. ACPI is also a lot of code adding size to your kernel
as well as additional applications. Not really great if your are
doing an embedded system.

-Steve

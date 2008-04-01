Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 17:38:10 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:56787 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1101763AbYDAPiE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 17:38:04 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m31FaLHB004792
	for <linux-mips@linux-mips.org>; Tue, 1 Apr 2008 08:36:22 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m31Fauwh015720;
	Tue, 1 Apr 2008 16:36:56 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m31FatgQ015719;
	Tue, 1 Apr 2008 16:36:55 +0100
Date:	Tue, 1 Apr 2008 16:36:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	peter fuerst <post@pfrst.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28: fix MC GIOPAR setting
Message-ID: <20080401153655.GA15109@linux-mips.org>
References: <Pine.LNX.4.58.0803211535570.423@Indigo2.Peter> <20080321194737.GA8398@alpha.franken.de> <Pine.LNX.4.58.0803212125050.523@Indigo2.Peter> <20080321213233.GA10546@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080321213233.GA10546@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 21, 2008 at 10:32:33PM +0100, Thomas Bogendoerfer wrote:

> > Would indeed be most surprising, if this isn't appropriate for any Indigo2-
> > Impact, but don't know for sure.  And can't check, whether it at least doesn't
> > hurt Non-Impact Indigo2.  Of course, being able to avoid '#ifdef' at all would
> > be the prettiest alternative.
> 
> I'll check my IP22 machines, if they are ok with that change. Another
> solution could be to have gio_set_master() similair to pci_set_master().
> That way we only enable master, if it is requested by a driver.

That sounds like a clean solution.  Anyway where are we standing with this?
I assume it's release critical for IP28?

  Ralf

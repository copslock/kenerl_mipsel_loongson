Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 02:42:27 +0100 (BST)
Received: from p549F7A8A.dip.t-dialin.net ([84.159.122.138]:36843 "EHLO
	p549F7A8A.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20021483AbYE3BmY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 May 2008 02:42:24 +0100
Received: from kirk.serum.com.pl ([213.77.9.205]:55028 "EHLO serum.com.pl")
	by lappi.linux-mips.net with ESMTP id S1107799AbYE3Bks (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 May 2008 03:40:48 +0200
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4U1ekS6012580;
	Fri, 30 May 2008 03:40:46 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4U1eSQl012576;
	Fri, 30 May 2008 02:40:37 +0100
Date:	Fri, 30 May 2008 02:40:27 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Tomasz Chmielewski <mangoo@wpkg.org>
cc:	Nicolas Schichan <nschichan@freebox.fr>, linux-mips@linux-mips.org,
	Kexec Mailing List <kexec@lists.infradead.org>,
	openwrt-devel@lists.openwrt.org
Subject: Re: kexec on mips - anyone has it working?
In-Reply-To: <483F0EF3.3060500@wpkg.org>
Message-ID: <Pine.LNX.4.55.0805300233450.8254@cliff.in.clinika.pl>
References: <483BCB75.4050901@wpkg.org> <200805271449.45124.nschichan@freebox.fr>
 <483C4F73.4040909@wpkg.org> <200805291347.05196.nschichan@freebox.fr>
 <483F0EF3.3060500@wpkg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 29 May 2008, Tomasz Chmielewski wrote:

> I guess I'm not that lucky. Either CONFIG_MIPS_UNCACHED slowed the 
> device down so much that it didn't boot, or it didn't boot. Hey, isn't 
> it the same? So either BCM43XX doesn't work very well with certain 
> kernel options enabled/disabled, or OpenWRT patches still lack some 
> features to make ASUS WL-500gP properly (added openwrt-devel to CC:).

 LL/SC are undefined on uncached memory.  Implementers are free to keep
the instructions working the same way as on cached memory, but are not
required to do so and your chip may be an example.  Of course the reason
of the hang you see may be different, but this is one plausible
explanation.  I wouldn't trust a kernel running with CONFIG_MIPS_UNCACHED
enabled -- it is merely a debugging hack.

  Maciej

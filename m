Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 11:41:31 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:9748 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465576AbVJSKlO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 11:41:14 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9JAf1Op004463;
	Wed, 19 Oct 2005 11:41:01 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9JAex8t004462;
	Wed, 19 Oct 2005 11:40:59 +0100
Date:	Wed, 19 Oct 2005 11:40:59 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	John Levon <levon@movementarian.org>,
	David Daney <ddaney@avtrex.com>,
	oprofile-list@lists.sourceforge.net,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [Patch] Fix lookup_dcookie for MIPS o32
Message-ID: <20051019104059.GB2616@linux-mips.org>
References: <17236.6951.865559.479107@dl2.hq2.avtrex.com> <20051018114526.GC2656@linux-mips.org> <20051018232442.GA29235@trollied.org> <435586D8.4040407@avtrex.com> <20051018233653.GA1044@trollied.org> <Pine.LNX.4.62.0510191107420.25580@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510191107420.25580@numbat.sonytel.be>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 19, 2005 at 11:07:55AM +0200, Geert Uytterhoeven wrote:

> On Wed, 19 Oct 2005, John Levon wrote:
> > On Tue, Oct 18, 2005 at 04:35:52PM -0700, David Daney wrote:
> > > I just did a cvs update and see no change.  Perhaps I misunderstand. 
> > > Would you like me to make and test a patch?  I could...
> > 
> > anoncvs takes a while to update I think.
> 
> AFAIK, it's no longer updated. Use git.

This is the userspace oprofile tools, not the kernel.  Last I checked
Sourceforge was still on the cvs.

  Ralf

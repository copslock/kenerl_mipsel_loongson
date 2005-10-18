Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 17:39:13 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:18202 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133621AbVJRQi5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 17:38:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9IGcnh0022741;
	Tue, 18 Oct 2005 17:38:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9IGcmBC022725;
	Tue, 18 Oct 2005 17:38:48 +0100
Date:	Tue, 18 Oct 2005 17:38:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: OProfile cannot be loaded as module...
Message-ID: <20051018163848.GJ2656@linux-mips.org>
References: <43470BCF.1070709@avtrex.com> <20051013225520.GA3234@linux-mips.org> <43540609.4000105@avtrex.com> <20051018110355.GB2656@linux-mips.org> <435518CC.3060403@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435518CC.3060403@avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 18, 2005 at 08:46:20AM -0700, David Daney wrote:

> Given your 'yes' and 'no' answers, the behavior of a module could depend 
> on the order in which the modules are loaded, as they can be linked 
> differently depending on which modules are already present.
> 
> That doesn't seem like a good way of doing things.
> 
> If if were up to me (and I know that it is not), I would disallow 
> linking of weak symbols at module load time altogether.

The semantics were choosen by Rusty who maintains the generic part of the
module loader.  Ensuring the right load order is the job of depmod
and modprobe.

  Ralf

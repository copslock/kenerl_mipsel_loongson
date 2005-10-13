Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2005 11:51:36 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:4105 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133494AbVJNKvS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Oct 2005 11:51:18 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9EAp9iA001842;
	Fri, 14 Oct 2005 11:51:09 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9DMtLSp006759;
	Thu, 13 Oct 2005 23:55:21 +0100
Date:	Thu, 13 Oct 2005 23:55:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: OProfile cannot be loaded as module...
Message-ID: <20051013225520.GA3234@linux-mips.org>
References: <43470BCF.1070709@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43470BCF.1070709@avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 07, 2005 at 04:59:11PM -0700, David Daney wrote:

> arch/mips/oprofile/common.c defines several symbols (op_model_mipsxx and 
> op_model_rm9000) with __attribute__((weak)).  It then assumes that ELF 
> linking conventions will prevail and there will be no problems if they 
> are undefined.
> 
> The problem is if you try to load oprofile as a module.  The kernel 
> module linker evidentially does not understand weak symbols and refuses 
> to load the module because they are undefined.

Actually it contains code to handle weak symbols so this is a bit
surprising not last because STB_WEAK handling happen in the generic
module loader code and is being used by other architectures as well.

So if there's a problem with the module loader I'd prefer to solve that
instead of starting to kludge around it.

What compiler exactly are you using btw?

  Ralf

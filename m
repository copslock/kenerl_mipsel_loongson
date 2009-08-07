Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2009 17:29:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51023 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492759AbZHGP30 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2009 17:29:26 +0200
Date:	Fri, 7 Aug 2009 16:29:26 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David VomLehn <dvomlehn@cisco.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>,
	GCC Help Mailing List <gcc-help@gcc.gnu.org>,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Relocation problem with MIPS kernel modules
In-Reply-To: <20090804021800.GA14627@cuplxvomd02.corp.sa.net>
Message-ID: <alpine.LFD.2.00.0908071619340.15682@eddie.linux-mips.org>
References: <20090730184923.GA27030@cuplxvomd02.corp.sa.net> <20090803092030.GB30431@linux-mips.org> <4A773B85.6010004@caviumnetworks.com> <20090803201521.GA24691@cuplxvomd02.corp.sa.net> <20090803235536.GB22543@linux-mips.org>
 <20090804021800.GA14627@cuplxvomd02.corp.sa.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 3 Aug 2009, David VomLehn wrote:

> > The next and logical extension would be to permit multiple R_MIPS_LO16
> > records following a sequence of one or more R_MIPS_HI16 relocs as long as
> > all relate to the same symbol - which would be simple to support in the
> > kernel.
> 
> This is what the orphaned R_MIPS_LO16 entries mentioned in the psABI quote
> are all about. The existing relocation code handles this in most cases, but
> could be juiced up a bit to do the check to verify the symbols match between
> the current R_MIPS_LO16 entry and the last R_MIPS_HI16 entry.

 Note there is no need to implement Ralf's suggestion -- if multiple HI16 
and LO16 relocations referring to the same symbol and addend are scattered 
throughout an object module, then the tools should combine them into pairs 
appropriately -- it does not matter exactly which ones of each are paired.  
Now once this has been done, a number of orphaned HI16 or LO16 relocations 
may remain, but there will only ever be one kind of these left and they 
can be attached to any of the pairs previously created.  My understanding 
is this is exactly what BFD does (modulo any possible bugs of course, as 
usually).

  Maciej

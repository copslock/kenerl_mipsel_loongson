Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 21:45:05 +0100 (BST)
Received: from p508B56B7.dip.t-dialin.net ([IPv6:::ffff:80.139.86.183]:41859
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225206AbTENUpD>; Wed, 14 May 2003 21:45:03 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4EKih4P030637;
	Wed, 14 May 2003 22:44:43 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4EKihrT030636;
	Wed, 14 May 2003 22:44:43 +0200
Date: Wed, 14 May 2003 22:44:43 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Luke A. Guest" <laguest@abyss2.demon.co.uk>
Cc: Manoj Ekbote <Manoj_Ekbote@pmc-sierra.com>,
	"Linux-Mips (E-mail)" <linux-mips@linux-mips.org>
Subject: Re: mips toolchain for solaris
Message-ID: <20030514204443.GB29111@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F2590172ECC6@SJC1EXM02> <1052943962.23940.2.camel@rogue.abyss2.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052943962.23940.2.camel@rogue.abyss2.demon.co.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 14, 2003 at 09:26:02PM +0100, Luke A. Guest wrote:

> On Wed, 2003-05-14 at 20:55, Manoj Ekbote wrote:
> > I don't know if this is the right place for this question but...
> > Is there a place where I could find the latest mips cross-toolchain for the Solaris platform?
> 
> You could just build a cross compiler (gcc) for mips-elf. Depends on
> whether you require a libc. I just built this particular version of the
> compiler as I don't require anything else.

mips-elf is *NOT* a usable configuration to do anythign for Linux/MIPS
targets.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2006 13:16:10 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:32907 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133530AbWDJMP7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Apr 2006 13:15:59 +0100
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id 5F6BA445B9; Mon, 10 Apr 2006 14:27:41 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1FSvUC-0006Kg-0j; Mon, 10 Apr 2006 13:27:16 +0100
Date:	Mon, 10 Apr 2006 13:27:15 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: elf.h
Message-ID: <20060410122715.GA5868@networkno.de>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001126.GA17967@deprecation.cyrius.com> <20060220003128.GD17967@deprecation.cyrius.com> <20060220113420.GB5594@linux-mips.org> <20060407171910.GU6869@deprecation.cyrius.com> <090d01c65a6b$623f6480$10eca8c0@grendel> <20060407222142.GA26104@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060407222142.GA26104@linux-mips.org>
User-Agent: Mutt/1.5.11+cvs20060126
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Apr 07, 2006 at 07:47:40PM +0200, Kevin D. Kissell wrote:
> 
> > Arguably, whatever's used by binutils should be the tie-breaker.
> > Googling around, I see that the EM_MIPS_RS3_LE value was
> > added in the October 4, 1999 draft of the ELF spec, but inexplicably
> > the alias with EM_MIPS_RS4_BE was left in place - perhaps they
> > were supposed to be disambiguated by some 32-vs-64-bit flag
> > somewhere.  A random sampling of ELF documents on the web
> > shows the vast majority calling out RS3_LE and not RS4_BE.
> 
> No way to actually resolve this one; not even binutils oldtimer
> Ian Lance Taylor can remember the reasons for the change anymore.

FWIW, the general rule is to use EM_MIPS == 8 for MIPS with both
endiannesses and ignore EM_MIPS_*. So removing the other defines
from the linux include file seems to be the sensible thing to do.
(Binutils can't do the same due to backward compatibility concerns.)


Thiemo

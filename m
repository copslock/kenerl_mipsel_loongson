Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 23:10:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36824 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133622AbWDGWKW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 23:10:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k37MLoCT026146;
	Fri, 7 Apr 2006 23:21:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k37MLgCW026144;
	Fri, 7 Apr 2006 23:21:42 +0100
Date:	Fri, 7 Apr 2006 23:21:42 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: elf.h
Message-ID: <20060407222142.GA26104@linux-mips.org>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001126.GA17967@deprecation.cyrius.com> <20060220003128.GD17967@deprecation.cyrius.com> <20060220113420.GB5594@linux-mips.org> <20060407171910.GU6869@deprecation.cyrius.com> <090d01c65a6b$623f6480$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <090d01c65a6b$623f6480$10eca8c0@grendel>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 07, 2006 at 07:47:40PM +0200, Kevin D. Kissell wrote:

> Arguably, whatever's used by binutils should be the tie-breaker.
> Googling around, I see that the EM_MIPS_RS3_LE value was
> added in the October 4, 1999 draft of the ELF spec, but inexplicably
> the alias with EM_MIPS_RS4_BE was left in place - perhaps they
> were supposed to be disambiguated by some 32-vs-64-bit flag
> somewhere.  A random sampling of ELF documents on the web
> shows the vast majority calling out RS3_LE and not RS4_BE.

No way to actually resolve this one; not even binutils oldtimer
Ian Lance Taylor can remember the reasons for the change anymore.

  Ralf

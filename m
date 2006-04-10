Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2006 16:31:48 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25065 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133598AbWDJPbk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2006 16:31:40 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k3AFhPUF017603;
	Mon, 10 Apr 2006 17:43:25 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k3AFhKdT017601;
	Mon, 10 Apr 2006 17:43:20 +0200
Date:	Mon, 10 Apr 2006 17:43:20 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: elf.h
Message-ID: <20060410154320.GA17459@linux-mips.org>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001126.GA17967@deprecation.cyrius.com> <20060220003128.GD17967@deprecation.cyrius.com> <20060220113420.GB5594@linux-mips.org> <20060407171910.GU6869@deprecation.cyrius.com> <090d01c65a6b$623f6480$10eca8c0@grendel> <20060407222142.GA26104@linux-mips.org> <20060410122715.GA5868@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410122715.GA5868@networkno.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 10, 2006 at 01:27:15PM +0100, Thiemo Seufer wrote:

> > No way to actually resolve this one; not even binutils oldtimer
> > Ian Lance Taylor can remember the reasons for the change anymore.
> 
> FWIW, the general rule is to use EM_MIPS == 8 for MIPS with both
> endiannesses and ignore EM_MIPS_*. So removing the other defines
> from the linux include file seems to be the sensible thing to do.
> (Binutils can't do the same due to backward compatibility concerns.)

Or rather convert it into a comment so this is the last time these
constants have been discussed ...

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 12:26:51 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:51733 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133520AbWAWMYV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 12:24:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0NCRK0n005416;
	Mon, 23 Jan 2006 12:28:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0LC2SCa003830;
	Sat, 21 Jan 2006 12:02:28 GMT
Date:	Sat, 21 Jan 2006 12:02:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Chubb <peterc@gelato.unsw.edu.au>
Cc:	linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	linux-mips@linux-mips.org
Subject: Re: Include assembly entry points in TAGS
Message-ID: <20060121120228.GC3456@linux-mips.org>
References: <17360.8073.622104.500429@berry.gelato.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17360.8073.622104.500429@berry.gelato.unsw.EDU.AU>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 20, 2006 at 10:23:53AM +1100, Peter Chubb wrote:

> As it stands, etags doesn't find labels in the IA64 or i386 assembler source 
> code, because they're disguised inside a preprocessor macro. 
>  
> I propose the attached fix, which adds a regular expression to enable 
> labels disguised by ENTRY() and GLOBAL_ENTRY() macros. 
>  
> There's a similar problem for MIPS, which needs to match LEAF(entrypoint) 

There's also NESTED.  I don't use etags, so I won't try to cook a patch.

  Ralf

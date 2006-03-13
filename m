Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 20:47:36 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:4236 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133863AbWCMUr1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2006 20:47:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2DKuUrP017509;
	Mon, 13 Mar 2006 20:56:30 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2DKuUsi017508;
	Mon, 13 Mar 2006 20:56:30 GMT
Date:	Mon, 13 Mar 2006 20:56:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kurt Schwemmer <kurts@vitesse.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cross compile kernel w/ buildroot toolchain
Message-ID: <20060313205630.GA17247@linux-mips.org>
References: <389E6A416914954182ECDFCD844D8269434FBF@MX-COS.vsc.vitesse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389E6A416914954182ECDFCD844D8269434FBF@MX-COS.vsc.vitesse.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 13, 2006 at 01:39:53PM -0700, Kurt Schwemmer wrote:

> I got 2.6.15 "a while back" (>1 month). 
> 
> I'll try getting the most recent source. Sorry, I avoided this due to my
> company blocking rsync and thus making it a pain to get the sources... 

The reason your case is odd is that the kernel only uses a single
jr.hb instruction which is in the instruction_hazard() macro in
include/asm-mips/hazards.h.  This macro first of all is a gcc inline
assembler macro and also wraps the jr.hb instruction between
.set mips64r2 ... .set mips0, so you should never ever get an error
message.  And you're getting an error message for entry.S, an assembler
file.  Seems you must have done some not so kosher changes to that tree?

  Ralf

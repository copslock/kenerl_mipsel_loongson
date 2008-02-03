Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2008 16:00:34 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:57013
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20025779AbYBCQAZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 3 Feb 2008 16:00:25 +0000
Received: from router-wag54gp2 ([192.168.1.33] helo=[192.168.1.2])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JLhGS-0004Hc-J9
	for linux-mips@linux-mips.org; Sun, 03 Feb 2008 17:00:18 +0100
Subject: Re: new type of crash report?
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <5BFC57F9-7E81-4667-9D15-72F5F20FA4DD@27m.se>
References: <1202050578.7035.11.camel@scarafaggio>
	 <5BFC57F9-7E81-4667-9D15-72F5F20FA4DD@27m.se>
Content-Type: text/plain
Date:	Sun, 03 Feb 2008 17:01:05 +0100
Message-Id: <1202054465.7035.20.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Markus,

Il giorno dom, 03/02/2008 alle 16.52 +0100, Markus Gothe ha scritto:
> You can always start with running run gdb at the read address
> (ra: 0x2ac2bfdc), I'd also try listing 0x2ac2bffc.
[...]

Thanks for your reply. I will try to understand how to use gdb on this
context. (Any URI would be really appreciated.)
Anyway I now understood that a dbe is a data bus error, so probably this
is an error on the physical address, i.e. a kernel problem related to
the mapping between vertical and physical addresses. Is this correct?

Thanks,
Giuseppe

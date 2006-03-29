Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 14:29:45 +0100 (BST)
Received: from fri.itea.ntnu.no ([129.241.7.60]:46301 "EHLO fri.itea.ntnu.no")
	by ftp.linux-mips.org with ESMTP id S8133764AbWC2N32 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Mar 2006 14:29:28 +0100
Received: from localhost (localhost [127.0.0.1])
	by fri.itea.ntnu.no (Postfix) with ESMTP id 440E782AF;
	Wed, 29 Mar 2006 15:39:48 +0200 (CEST)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.205.150])
	by fri.itea.ntnu.no (Postfix) with ESMTP;
	Wed, 29 Mar 2006 15:39:47 +0200 (CEST)
Received: from invalid.ed.ntnu.no (jonah@localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.13.3/8.13.3) with ESMTP id k2TDdlWa086559
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Wed, 29 Mar 2006 15:39:47 +0200 (CEST)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.13.3/8.13.3/Submit) with ESMTP id k2TDdkls086556;
	Wed, 29 Mar 2006 15:39:46 +0200 (CEST)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date:	Wed, 29 Mar 2006 15:39:46 +0200 (CEST)
From:	Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To:	Russell King <rmk@arm.linux.org.uk>
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] serial8250: set divisor register correctly for AMD
 Alchemy SoC uart. Re-posted.
In-Reply-To: <20060327125423.GA24311@flint.arm.linux.org.uk>
Message-ID: <20060329153513.L86511@invalid.ed.ntnu.no>
References: <20060327131437.P55909@invalid.ed.ntnu.no>
 <20060327125423.GA24311@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list: linux-mips

On Mon, 27 Mar 2006, Russell King wrote:
> I'm not sure whether this is a good idea - this is used to detect
> an 16C850 UART, so probably should be kept as is.
> 
> In other words, we should use serial_dl_read() / serial_dl_write()
> when we're actually wanting to read or set the actual divisor, but
> not for the autoconfiguration stuff.

Agree.

Should I send you a updated patch?


-- 
Jon Anders Haugum

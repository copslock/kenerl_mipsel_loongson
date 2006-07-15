Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jul 2006 10:16:29 +0100 (BST)
Received: from buzzloop.caiaq.de ([212.112.241.133]:51977 "EHLO
	buzzloop.caiaq.de") by ftp.linux-mips.org with ESMTP
	id S8127229AbWGOJQU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Jul 2006 10:16:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id 309867F4028;
	Sat, 15 Jul 2006 11:16:15 +0200 (CEST)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 23703-09; Sat, 15 Jul 2006 11:16:15 +0200 (CEST)
Received: by buzzloop.caiaq.de (Postfix, from userid 1000)
	id D0ED57F4022; Sat, 15 Jul 2006 11:16:14 +0200 (CEST)
Date:	Sat, 15 Jul 2006 11:16:14 +0200
From:	Daniel Mack <daniel@caiaq.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix irq_chip struct for Pb1200/Db1200 platform
Message-ID: <20060715091614.GB21737@ipxXXXXX>
References: <2F5D781B-2119-4942-82C1-70B5037F5622@caiaq.de> <20060714161128.GB15427@linux-mips.org> <20060715005747.GA21358@ipxXXXXX> <20060715043941.GA3587@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060715043941.GA3587@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <daniel@caiaq.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@caiaq.de
Precedence: bulk
X-list: linux-mips

On Sat, Jul 15, 2006 at 05:39:41AM +0100, Ralf Baechle wrote:
> Same corrupt stuff:
> 
> $ wget http://caiaq.org/linux-mips/patches/irq_chip_pb1200.patch
> --05:36:02--  http://caiaq.org/linux-mips/patches/irq_chip_pb1200.patch

Argh, now I see what went wrong - sorry for the hazzle. Please 
try again, same link, slightly different content...

Daniel

Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Apr 2007 17:14:04 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:16328 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022689AbXDHQOD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 8 Apr 2007 17:14:03 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1HaZyf-000191-00; Sun, 08 Apr 2007 18:10:53 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 14BAFC223C; Sun,  8 Apr 2007 18:10:27 +0200 (CEST)
Date:	Sun, 8 Apr 2007 18:10:27 +0200
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Register PCI host bridge resource earlier
Message-ID: <20070408161027.GA8265@alpha.franken.de>
References: <20070408112844.GA7553@alpha.franken.de> <4618DDF0.1020604@ru.mvista.com> <20070408131228.GA7819@alpha.franken.de> <4618ED95.6040304@ru.mvista.com> <20070408135244.GA8016@alpha.franken.de> <4619008D.1030803@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4619008D.1030803@ru.mvista.com>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Apr 08, 2007 at 06:47:41PM +0400, Sergei Shtylyov wrote:
>    I'm just not seeing how using insert_resource() vs request_resource() 
>    for i8259 ports can be relevant here.

request_resource will fail, because the range is already taken by
sni_io_resource, while insert_region inserts the resource into 
sni_io_resource. The problem is that init_i8259 doesn't have the right
resource for doing the request_resource, if ioport_resource starting from
0x0000 is already taken by a PCI host bridge. I could probably write a
patch, which adds a parameter to init_i8259 for the resource, where the
request_resource is correct. No idea, whether this is worth the efford.

Opions ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]

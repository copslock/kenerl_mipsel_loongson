Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 00:53:42 +0000 (GMT)
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:44996
	"EHLO irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225241AbSLLAxl>; Thu, 12 Dec 2002 00:53:41 +0000
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id gBC1VJlQ019716;
	Thu, 12 Dec 2002 01:31:20 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id gBC1VHUr019714;
	Thu, 12 Dec 2002 01:31:17 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH 2.5] SGI O2 framebuffer driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vivien Chappelier <vivienc@nerim.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Ilya Volynets <ilya@theIlya.com>
In-Reply-To: <Pine.LNX.4.21.0212120004330.2300-100000@melkor>
References: <Pine.LNX.4.21.0212120004330.2300-100000@melkor>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 01:31:16 +0000
Message-Id: <1039656676.18587.63.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Wed, 2002-12-11 at 23:41, Vivien Chappelier wrote:
> linear framebuffer (up to 8MB with 64kB granularity). I'm then remapping
> all those pages to one virtual region obtained from get_vm_area so that
> 1. caching attributes can be set to cacheable write-through no WA

Ick. The framebuffer can't handle cached and write barriers ?

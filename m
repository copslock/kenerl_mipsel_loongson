Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Dec 2002 12:06:20 +0000 (GMT)
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:38085
	"EHLO irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225268AbSLLMGU>; Thu, 12 Dec 2002 12:06:20 +0000
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id gBCCi8lQ021350;
	Thu, 12 Dec 2002 12:44:09 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id gBCCi6qh021348;
	Thu, 12 Dec 2002 12:44:06 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH 2.5] SGI O2 framebuffer driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Vivien Chappelier <vivienc@nerim.net>, linux-mips@linux-mips.org,
	Ilya Volynets <ilya@theIlya.com>
In-Reply-To: <20021212033307.C22987@linux-mips.org>
References: <Pine.LNX.4.21.0212120004330.2300-100000@melkor>
	<1039656676.18587.63.camel@irongate.swansea.linux.org.uk> 
	<20021212033307.C22987@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 12:44:05 +0000
Message-Id: <1039697045.21231.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, 2002-12-12 at 02:33, Ralf Baechle wrote:
> The O2 is non-cache coherent.  So with the fairly large write-back second
> level caches enabled frame buffer write could potencially be delayed
> indefinately but in any case quite long.  Frame buffers are usually only

You can flush the frame buffer pages that were touched at the end of an
operation though

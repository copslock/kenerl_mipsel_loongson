Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2004 02:01:09 +0100 (BST)
Received: from p508B7511.dip.t-dialin.net ([IPv6:::ffff:80.139.117.17]:53320
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225744AbUGLBBF>; Mon, 12 Jul 2004 02:01:05 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i6C0x33h019601;
	Mon, 12 Jul 2004 02:59:03 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i6C0x2nj019600;
	Mon, 12 Jul 2004 02:59:02 +0200
Date: Mon, 12 Jul 2004 02:59:02 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: 2.6: sound/oss/swarm_cs4297a.c still required?
Message-ID: <20040712005902.GA19170@linux-mips.org>
References: <20040712001604.GH4701@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712001604.GH4701@fs.tum.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jul 12, 2004 at 02:16:04AM +0200, Adrian Bunk wrote:

> in 2.6 (I've checked 2.6.7-mm7) sound/oss/swarm_cs4297a.c is no longer 
> listed in sound/oss/Makefile. Was this accidential, or should this file 
> be removed?

Still partially merged only.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2004 18:11:50 +0000 (GMT)
Received: from p508B78D6.dip.t-dialin.net ([IPv6:::ffff:80.139.120.214]:5397
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225457AbUBESLu>; Thu, 5 Feb 2004 18:11:50 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i15IAkex023721;
	Thu, 5 Feb 2004 19:10:46 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i15IAkGQ023720;
	Thu, 5 Feb 2004 19:10:46 +0100
Date: Thu, 5 Feb 2004 19:10:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Markus Dahms <dahms@fh-brandenburg.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Indy R4000PC problems
Message-ID: <20040205181046.GA23682@linux-mips.org>
References: <20040202160729.GA5966@fh-brandenburg.de> <20040205175146.GA18162@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205175146.GA18162@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 05, 2004 at 06:51:46PM +0100, Ralf Baechle wrote:

> The PC version have become pretty rare, didn't recall anymore it was in
> use in Indys at all.  Anyway, please try the patch below and let me know.

Argh...  Famous class of bugs when one is about to run out of the door.
The CONF_SC bit is inverted so the test for it needs to be inverted.
WIll post a new patch later.

  Ralf

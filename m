Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2003 16:00:01 +0100 (BST)
Received: from p508B6977.dip.t-dialin.net ([IPv6:::ffff:80.139.105.119]:23518
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225398AbTJJO7w>; Fri, 10 Oct 2003 15:59:52 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9AExoNK010679;
	Fri, 10 Oct 2003 16:59:50 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9AExnaV010678;
	Fri, 10 Oct 2003 16:59:49 +0200
Date: Fri, 10 Oct 2003 16:59:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: exister99@velocitus.net
Cc: linux-mips@linux-mips.org
Subject: Re: mips 32 bit HIGHMEM support
Message-ID: <20031010145948.GB10373@linux-mips.org>
References: <5334.156.153.254.2.1065650433.squirrel@webmail.rmci.net> <20031009140319.GA17647@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009140319.GA17647@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 09, 2003 at 04:03:20PM +0200, Ralf Baechle wrote:

> It's got a limitation - it only works on physically indexed D-caches or
> more exactly processors that don't suffer from cache aliases.  On
> processors that have such aliases the necessary flushes are rather bad
> for performance so this currently simply isn't suported.

Small update - I changed the memory managment code to ignore highmem
on cache configuration that are not supported by the highmem code.

  Ralf

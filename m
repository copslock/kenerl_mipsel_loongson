Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jul 2004 22:57:06 +0100 (BST)
Received: from p508B6BD7.dip.t-dialin.net ([IPv6:::ffff:80.139.107.215]:28974
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225321AbUGIV5C>; Fri, 9 Jul 2004 22:57:02 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i69Lv1mr010291;
	Fri, 9 Jul 2004 23:57:01 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i69Lv0Y9010290;
	Fri, 9 Jul 2004 23:57:00 +0200
Date: Fri, 9 Jul 2004 23:57:00 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Song Wang <wsonguci@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: kbuild support to build one module with multiple separate components?
Message-ID: <20040709215700.GB4316@linux-mips.org>
References: <20040706230050.53313.qmail@web40006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706230050.53313.qmail@web40006.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 06, 2004 at 04:00:50PM -0700, Song Wang wrote:

> This is wrong, because kbuild will treat A as
> independent module. All I want is to treat
> A as component of the only module mymodule.o. It
> should be linked to mymodule.o
> 
> Any idea on how to write a kbuild Makefile to
> support such kind of single module produced
> by linking multiple components and each component
> is located in separate directory? Thanks.

That's a limitation in the current kbuild system.  You either have to put
all files into a single directory or if you don't want that split your
module into several independant modules.  What I haven't tried is using
.a libraries but they're generally deprecated in kbuild.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2004 18:33:45 +0100 (BST)
Received: from p508B5B3D.dip.t-dialin.net ([IPv6:::ffff:80.139.91.61]:42273
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226042AbUEFRdn>; Thu, 6 May 2004 18:33:43 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i46HXgxT013581;
	Thu, 6 May 2004 19:33:42 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i46HXfli013580;
	Thu, 6 May 2004 19:33:41 +0200
Date: Thu, 6 May 2004 19:33:41 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yashwant Shitoot <yshitoot@stellartec.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Strange Behavior - help
Message-ID: <20040506173341.GA23488@linux-mips.org>
References: <7F5F67B895426C40AC75B8290421C23915CE57@Exchange.stellartec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F5F67B895426C40AC75B8290421C23915CE57@Exchange.stellartec.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 06, 2004 at 10:19:43AM -0700, Yashwant Shitoot wrote:

> Hello Friends,

Allright, dinner on you ;-)

> My root file system and linux is in rom (flash). The linux itself runs
> out of ram. When I reprogram the rom, I erase and write a new image of
> the rom from a compact flash card. After the new image is programmed in
> the function fclose() hangs up, implying that fclose() is rom resident
> and loaded as needed. Does this make sense ?

Demand loading that is the binary will be paged in from backing store
(which is your ROM) as needed.

> Remember even after erasing the rom fopen() works fine.

Linux may at any time deciede to discard a page of memory.  It does so
when it think it has a better use for that memory.

Rewriting the underlying device of any filesystem is not a safe thing to
do.  A possible safe approach would be running from a ramdisk, for example.

  Ralf

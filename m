Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 22:25:47 +0100 (BST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:11225
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S20022575AbXFDVZo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 22:25:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 39B04510001;
	Mon,  4 Jun 2007 14:25:57 -0700 (PDT)
Date:	Mon, 04 Jun 2007 14:25:57 -0700 (PDT)
Message-Id: <20070604.142557.68139332.davem@davemloft.net>
To:	joseph@codesourcery.com
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-arch@vger.kernel.org
Subject: Re: 64-bit syscall ABI issue
From:	David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0706042051280.16431@digraph.polyomino.org.uk>
References: <Pine.LNX.4.64.0706042051280.16431@digraph.polyomino.org.uk>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: "Joseph S. Myers" <joseph@codesourcery.com>
Date: Mon, 4 Jun 2007 20:56:57 +0000 (UTC)

[ added linux-arch which is a great place to discuss these
  kinds of issues. ]

> What should the kernel syscall ABI be in such cases (any case where the 
> syscall implementations expect arguments narrower than registers, so 
> mainly 32-bit arguments on 64-bit platforms)?  There are two obvious 
> possibilities:

In general we've taken the stance that the syscall dispatch
should create the proper calling environment for C code
implementing the system calls, and this thus means properly
sign and zero extending the arguments as expected by the C
calling convention.

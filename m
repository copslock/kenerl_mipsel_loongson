Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 23:25:02 +0100 (BST)
Received: from p508B75A1.dip.t-dialin.net ([IPv6:::ffff:80.139.117.161]:21839
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225219AbUHQWY5>; Tue, 17 Aug 2004 23:24:57 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7HMOnkq020891;
	Wed, 18 Aug 2004 00:24:49 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7HMOlN7020890;
	Wed, 18 Aug 2004 00:24:47 +0200
Date: Wed, 18 Aug 2004 00:24:47 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Daney <ddaney@avtrex.com>
Cc: Marcus Gustafsson <marcus.gustafsson@kreatel.se>,
	linux-mips@linux-mips.org
Subject: Re: Busybox v0.60.2 insmod gives segmentation fault without any m essages when trying to load a loadable module
Message-ID: <20040817222447.GA17065@linux-mips.org>
References: <5BB336130A66D7119DEF009027463C2C0F2CDA@BERNTSSON> <20040817180806.GA14578@linux-mips.org> <41226134.7000401@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41226134.7000401@avtrex.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 17, 2004 at 12:49:08PM -0700, David Daney wrote:

> GCC 3.3 introduced several new debugging information sections.  The
> ability of insmod to handle these new sections was not added until
> around October 2003 (to my best recollection).

I know, around '97 I wrote the code that did reject the DWARF sections :-)

  Ralf

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g61Mg1nC021071
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 15:42:01 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g61Mg1Gg021070
	for linux-mips-outgoing; Mon, 1 Jul 2002 15:42:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-103.ka.dial.de.ignite.net [62.180.196.103])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g61MftnC021059
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 15:41:57 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g61Mjgm32719;
	Tue, 2 Jul 2002 00:45:42 +0200
Date: Tue, 2 Jul 2002 00:45:42 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] r4k icache flushing for mips64 CVS HEAD
Message-ID: <20020702004542.B32068@dea.linux-mips.net>
References: <Pine.LNX.4.21.0207012244400.28140-200000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0207012244400.28140-200000@melkor>; from vivien.chappelier@enst-bretagne.fr on Mon, Jul 01, 2002 at 10:46:49PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 01, 2002 at 10:46:49PM +0200, Vivien Chappelier wrote:

> 	This fixes icache flushing for the r4xx0 processor in the current
> (CVS HEAD) 2.5.1 tree. The flush_cache_all function does nothing there,
> that's why I moved it to flush_cache_l1.

Not right, I checked in a variation of it ...

  Ralf

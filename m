Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4P7QHnC029012
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 25 May 2002 00:26:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4P7QHKK029011
	for linux-mips-outgoing; Sat, 25 May 2002 00:26:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4P7QFnC029008
	for <linux-mips@oss.sgi.com>; Sat, 25 May 2002 00:26:15 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4P7RNu27344;
	Sat, 25 May 2002 00:27:23 -0700
Date: Sat, 25 May 2002 00:27:23 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Robert Rusek <rrusek@teknuts.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Executing IRIX binary ?
Message-ID: <20020525002723.A27302@dea.linux-mips.net>
References: <C0F41630CD8B9C4680F2412914C1CF070164E6@WH-EXCHANGE1.AD.WEIDERPUB.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <C0F41630CD8B9C4680F2412914C1CF070164E6@WH-EXCHANGE1.AD.WEIDERPUB.COM>; from rrusek@teknuts.com on Wed, May 22, 2002 at 04:01:07PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 22, 2002 at 04:01:07PM -0700, Robert Rusek wrote:

> Is there anyway to run/execute irix 5/6 binaries in linux mips on an
> Indy?  Good old Microsoft does not provide the source for it's frontpage
> extensions, but they do provide a binary for IRIX.

We have IRIX5 binary compatibility code in the kernel but I don't have
any reports about it's status ever since I integrated those patch in about
May '97.

  Ralf

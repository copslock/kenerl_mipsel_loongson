Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAE2iep00651
	for linux-mips-outgoing; Tue, 13 Nov 2001 18:44:40 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAE2ic000647
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 18:44:38 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAE2iZE21034;
	Wed, 14 Nov 2001 13:44:35 +1100
Date: Wed, 14 Nov 2001 13:44:35 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Steven Liu <stevenliu@psdc.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Which package rc.sysinit is in?
Message-ID: <20011114134435.D16741@dea.linux-mips.net>
References: <84CE342693F11946B9F54B18C1AB837B14AEBD@ex2k.pcs.psdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <84CE342693F11946B9F54B18C1AB837B14AEBD@ex2k.pcs.psdc.com>; from stevenliu@psdc.com on Tue, Nov 13, 2001 at 09:44:05AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 13, 2001 at 09:44:05AM -0800, Steven Liu wrote:

> With your help, I have cross-built and tested the util-linux-2.9s
> package for my mips r3000 CPU under linux-2.2.12. The system crushed in
> the program rc.sysinit with pid=8 when it was booting up.
> 
> What and where is rc.sysinit?

It's a shell script, so what actually crashed was the shell it's using,
probably /bin/sh or /bin/bash.

  Ralf

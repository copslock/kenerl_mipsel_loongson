Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACDgAp20299
	for linux-mips-outgoing; Mon, 12 Nov 2001 05:42:10 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fACDg7020296
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 05:42:07 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fACDex702940;
	Tue, 13 Nov 2001 00:40:59 +1100
Date: Tue, 13 Nov 2001 00:40:59 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: alexreil@talknet.de
Cc: linux-mips@oss.sgi.com
Subject: Re: RM200 and bootp
Message-ID: <20011113004059.A32504@dea.linux-mips.net>
References: <Pine.LNX.4.10.10111101643500.2449-100000@chef-host>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10111101643500.2449-100000@chef-host>; from master@talknet.de on Sat, Nov 10, 2001 at 05:09:47PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Nov 10, 2001 at 05:09:47PM +0100, Alexander Reil wrote:

> i try to run my rm200 with linux. I installed bootpd on my
> intel-server, but my rm200 can't find my bootp-server. 
> 
> --- schnipp ---
> Pandora> boot bootp()/vmlinux
> pandora: kernel file is `bootp()/vmlinux'
> No server for vmlinux
> Unable to open kernel file bootp()/vmlinux
> --- schnapp ---
> 
> Is the command
> boot bootp()/vmlinux
> correct?

No, the syntax is bootp()<hostname>:<filename> where each of <hostname>
and <filename> is allowed to be missing.

  Ralf

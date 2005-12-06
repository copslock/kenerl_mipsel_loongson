Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 15:54:32 +0000 (GMT)
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:1429 "EHLO
	fed1rmmtao09.cox.net") by ftp.linux-mips.org with ESMTP
	id S8133511AbVLFPyM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 15:54:12 +0000
Received: from liberty.homelinux.org ([70.190.160.125])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206155349.FECG25099.fed1rmmtao09.cox.net@liberty.homelinux.org>;
          Tue, 6 Dec 2005 10:53:49 -0500
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id IAA06907;
	Tue, 6 Dec 2005 08:53:47 -0700
Date:	Tue, 6 Dec 2005 08:53:47 -0700
From:	Matt Porter <mporter@kernel.crashing.org>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: zero copy
Message-ID: <20051206085347.A32501@cox.net>
References: <f69849430512060406x7f30a2f6k2c64f6cef383c175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <f69849430512060406x7f30a2f6k2c64f6cef383c175@mail.gmail.com>; from lhrkernelcoder@gmail.com on Tue, Dec 06, 2005 at 04:06:06AM -0800
Return-Path: <mmporter@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mporter@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 06, 2005 at 04:06:06AM -0800, kernel coder wrote:
> hi,
>     i'm trying to track the code flow of sendfile system call.Mine
> ethernet card doesn't have scatter gather and checksum calculation
> features.So stack should be making a copy of data.
> 
> Please tell me where in sendfile code flow,check for scatter gather
> and cecksum features is made so that stack can decide whether to copy
> data from user space or not.

Is your grep really that broken? :)

net/ipv4/tcp.c:tcp_sendpage() is where you find the check and
fallback to sendmsg if you follow it through.

-Matt

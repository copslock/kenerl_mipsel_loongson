Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g024lMQ00742
	for linux-mips-outgoing; Tue, 1 Jan 2002 20:47:22 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g024lIg00739
	for <linux-mips@oss.sgi.com>; Tue, 1 Jan 2002 20:47:19 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g01Nahh07815;
	Tue, 1 Jan 2002 21:36:43 -0200
Date: Tue, 1 Jan 2002 21:36:43 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: GOTO Masanori <gotom@debian.or.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: sysirix.c returns wrong error ?
Message-ID: <20020101213643.A7105@dea.linux-mips.net>
References: <wtw8zbhkgnn.wl@fe.dis.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <wtw8zbhkgnn.wl@fe.dis.titech.ac.jp>; from gotom@debian.or.jp on Wed, Jan 02, 2002 at 04:36:12AM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 02, 2002 at 04:36:12AM +0900, GOTO Masanori wrote:

> The following patch is for kernel/sysirix.c kernel vanilla 2.4.17,
> I think this routine returns wrong error... Is it ok?

Yes, it's ok.  I've applied the patch.  I should mention though that I
have not received ANY user reports about the IRIX 5 compat code since I've
put it into the kernel in June 97 so chances the code is actually working
are not so bright ;-)

Thanks anyway,

  Ralf

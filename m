Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8L3uMl11050
	for linux-mips-outgoing; Thu, 20 Sep 2001 20:56:22 -0700
Received: from dea.linux-mips.net (u-156-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.156])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8L3uJe11047
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 20:56:19 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8L3u3g25509;
	Fri, 21 Sep 2001 05:56:03 +0200
Date: Fri, 21 Sep 2001 05:56:03 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: busybox does not like 2.4.8, or the other way around?
Message-ID: <20010921055603.A25424@dea.linux-mips.net>
References: <3BAA962D.C55F2239@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAA962D.C55F2239@mvista.com>; from jsun@mvista.com on Thu, Sep 20, 2001 at 06:21:49PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 20, 2001 at 06:21:49PM -0700, Jun Sun wrote:

> I have a small busybox userland that works fine with 2.4.2 kernel, but failed
> with the latest 2.4.8 kernel.  The symptom is that it is stuck at the
> following prompt:

There was a change in 2.4.3 which also broke certain gettys that don't
set CLOCAL.

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8EKFPX04003
	for linux-mips-outgoing; Fri, 14 Sep 2001 13:15:25 -0700
Received: from dea.linux-mips.net (u-32-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.32])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8EKFIe04000
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 13:15:18 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8EKEtq03546;
	Fri, 14 Sep 2001 22:14:55 +0200
Date: Fri, 14 Sep 2001 22:14:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: setup_frame() failure
Message-ID: <20010914221455.A2272@dea.linux-mips.net>
References: <20010910.114402.41626914.nemoto@toshiba-tops.co.jp> <20010912.130914.112630116.nemoto@toshiba-tops.co.jp> <20010913031119.B27168@dea.linux-mips.net> <20010914.111632.41627160.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010914.111632.41627160.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Fri, Sep 14, 2001 at 11:16:32AM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Sep 14, 2001 at 11:16:32AM +0900, Atsushi Nemoto wrote:

> ralf> The actual fix should be skipping over the faulting instruction
> ralf> when returning from the signal handler.
> 
> Since the signal handler may want to know the faulting instruction,
> the "skipping" should be done AFTER the returning from the handler.
> On the other hand, the handler may do the "skipping" by itself...
> 
> The symptom I reported first ("the process can not be killd by
> SIGKILL") does not occur if the signal handler executed successfully
> because do_signal() will be called when returning from sys_sygreturn.
> The symptom occur if setup_frame() failed.  So I still think there is
> a point to check a failure of setup_frame().

Certain I/O models use a large number of signals so we're trying hard to
keep signal latency down.  The current code already can guarantee proper
termination in case of a stack fault, just not the shortest way.

  Ralf

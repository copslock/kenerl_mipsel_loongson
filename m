Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9NKmCQ14635
	for linux-mips-outgoing; Tue, 23 Oct 2001 13:48:12 -0700
Received: from dea.linux-mips.net (a1as16-p191.stg.tli.de [195.252.192.191])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9NKm8D14631
	for <linux-mips@oss.sgi.com>; Tue, 23 Oct 2001 13:48:09 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9NKlIT06310;
	Tue, 23 Oct 2001 22:47:18 +0200
Date: Tue, 23 Oct 2001 22:47:18 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Petko Manolov <pmanolov@Lnxw.COM>
Cc: linux-mips@oss.sgi.com
Subject: Malta probs
Message-ID: <20011023224718.A6283@dea.linux-mips.net>
References: <200110230102.f9N12kb20443@oss.sgi.com> <3BD5D236.8D0CE33C@lnxw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD5D236.8D0CE33C@lnxw.com>; from pmanolov@Lnxw.COM on Tue, Oct 23, 2001 at 01:25:26PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 23, 2001 at 01:25:26PM -0700, Petko Manolov wrote:

> The theory looks good, but in reality latest kernel crashes
> with machine check exception in local_flush_tlb_all on malta
> board.  I tried both egcs-1.1.2 and gcc-3.0.1 and both are
> crashing at the same place.

What CPU are you using; can you send me your .config file?

  Ralf

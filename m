Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAB1jlb02604
	for linux-mips-outgoing; Sat, 10 Nov 2001 17:45:47 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAB1ji002598
	for <linux-mips@oss.sgi.com>; Sat, 10 Nov 2001 17:45:45 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fA9Hfxp00938;
	Sat, 10 Nov 2001 04:41:59 +1100
Date: Sat, 10 Nov 2001 04:41:59 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: i8259.c in big endian
Message-ID: <20011110044159.A917@dea.linux-mips.net>
References: <20011108.154702.74756496.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011108.154702.74756496.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Thu, Nov 08, 2001 at 03:47:02PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 08, 2001 at 03:47:02PM +0900, Atsushi Nemoto wrote:
> Date: Thu, 08 Nov 2001 15:47:02 +0900 (JST)
> To: linux-mips@oss.sgi.com
> Cc: ralf@oss.sgi.com
> Subject: i8259.c in big endian
> From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
> 
> arch/mips/kernel/i8259.c seems not working in big endian.

Below the fix I'm going to checkin.  Highly untested as I'm sitting in a
plase 800km northeast of New Zealand :-)

  Ralf

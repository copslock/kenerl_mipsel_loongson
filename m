Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAL8E7i07410
	for linux-mips-outgoing; Wed, 21 Nov 2001 00:14:07 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAL8E4o07407
	for <linux-mips@oss.sgi.com>; Wed, 21 Nov 2001 00:14:04 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAL7Dxt12954;
	Wed, 21 Nov 2001 18:13:59 +1100
Date: Wed, 21 Nov 2001 18:13:59 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: latest checksum.h
Message-ID: <20011121181359.A12936@dea.linux-mips.net>
References: <20011121.151848.18315322.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011121.151848.18315322.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Nov 21, 2001 at 03:18:48PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 21, 2001 at 03:18:48PM +0900, Atsushi Nemoto wrote:

> Is it something wrong in latest checksum.h?
> 
> a __asm__ statement in csum_fold() has two "r" operands but there are
> no "%1" in the assembler template.  Is this OK?
> 
> # No patch because I'm not a __asm__ hacker :-)

One of the famous quick fixes that just happens to work because it was
my lucky day ...  Fix in cvs.

  Ralf

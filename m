Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBR5VAe03837
	for linux-mips-outgoing; Wed, 26 Dec 2001 21:31:10 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBR5UwX03831
	for <linux-mips@oss.sgi.com>; Wed, 26 Dec 2001 21:31:01 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBR4Tab19425;
	Thu, 27 Dec 2001 02:29:36 -0200
Date: Thu, 27 Dec 2001 02:29:36 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: dony.he@huawei.com, linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
Message-ID: <20011227022936.A19397@dea.linux-mips.net>
References: <20011226013221.A737@dea.linux-mips.net> <20011227.105518.74756316.nemoto@toshiba-tops.co.jp> <20011227011222.A16695@dea.linux-mips.net> <20011227.125122.71082554.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011227.125122.71082554.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Thu, Dec 27, 2001 at 12:51:22PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 27, 2001 at 12:51:22PM +0900, Atsushi Nemoto wrote:

> >>>>> On Thu, 27 Dec 2001 01:12:22 -0200, Ralf Baechle <ralf@oss.sgi.com> said:
> ralf> Yes, you're right as for the cache.  But there is no reason for
> ralf> the TLB flush, right?
> 
> Yes, I agree.

Ok, I'll make a patch for Marcelo.  Being in Brazil right now is useful,
I can beat him into accepting it ;-)

  Ralf

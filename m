Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8PEmni26406
	for linux-mips-outgoing; Tue, 25 Sep 2001 07:48:49 -0700
Received: from dea.linux-mips.net (u-199-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.199])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8PEmgD26403
	for <linux-mips@oss.sgi.com>; Tue, 25 Sep 2001 07:48:46 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8PElrP04160;
	Tue, 25 Sep 2001 16:47:53 +0200
Date: Tue, 25 Sep 2001 16:47:53 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Tom Appermont <tea@sonycom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: flush_cache_range
Message-ID: <20010925164753.C3789@dea.linux-mips.net>
References: <20010925093258.A16068@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010925093258.A16068@sonycom.com>; from tea@sonycom.com on Tue, Sep 25, 2001 at 09:32:58AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Sep 25, 2001 at 09:32:58AM +0200, Tom Appermont wrote:

> Can someone explain me why start and end parameters are ignored in
> r4k_flush_cache_range_d32i32() and cache range flushing operations
> for other platforms?

Afair the reason was that most invokations cover a range that is larger than
the entire cache anyway so our implementation in practice doesn't cause
any harm.

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIKVeb05035
	for linux-mips-outgoing; Tue, 18 Dec 2001 12:31:40 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBIKVao05031
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 12:31:37 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBIJVIO32468;
	Tue, 18 Dec 2001 17:31:18 -0200
Date: Tue, 18 Dec 2001 17:31:18 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: Jim Paris <jim@jtan.com>, linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218173118.C28080@dea.linux-mips.net>
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <20011218162506.A24659@dea.linux-mips.net> <3C1F9608.E4E32E18@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1F9608.E4E32E18@mvista.com>; from jsun@mvista.com on Tue, Dec 18, 2001 at 11:16:24AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 18, 2001 at 11:16:24AM -0800, Jun Sun wrote:

> I see.  So isa_slot_offset is for isa_read/isa_write, although I still don't
> see what kind of drivers would use isa_read/isa_write.

Dumb answer - ISA drivers.

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBAK79k14055
	for linux-mips-outgoing; Mon, 10 Dec 2001 12:07:09 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fBAK74o14019
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 12:07:05 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fBAJ6kl09431;
	Mon, 10 Dec 2001 17:06:46 -0200
Date: Mon, 10 Dec 2001 17:06:46 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: Why is byteorder removed from /proc/cpuinfo?
Message-ID: <20011210170646.E24680@dea.linux-mips.net>
References: <20011206093506.A6496@lucon.org> <20011206155724.A11083@dea.linux-mips.net> <15381.384.341974.133229@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15381.384.341974.133229@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Mon, Dec 10, 2001 at 06:40:00PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 10, 2001 at 06:40:00PM +0000, Dominic Sweetman wrote:

>    Dynamic endianness on a per-thread basis would require fantasy
>    hardware which operates differently from the way MIPS chips do...

I used the term thread as the c0_status register which contains the RE
bit is per process.  Keeping it a per mm thing would require more effort
for no good reason.  Anyway, inside the Linux kernel threads and processes
are basically the same thing.

  Ralf

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9RLHvj09193
	for linux-mips-outgoing; Sat, 27 Oct 2001 14:17:57 -0700
Received: from dea.linux-mips.net (a1as08-p205.stg.tli.de [195.252.188.205])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9RLHr009190
	for <linux-mips@oss.sgi.com>; Sat, 27 Oct 2001 14:17:54 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9RIjSd28039;
	Sat, 27 Oct 2001 20:45:28 +0200
Date: Sat, 27 Oct 2001 20:45:28 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Kernel 2.4.3 compile problem
Message-ID: <20011027204528.C26218@dea.linux-mips.net>
References: <86048F07C015D311864100902760F1DD01B5E29B@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E29B@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Fri, Oct 26, 2001 at 01:36:25PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Oct 26, 2001 at 01:36:25PM +0200, Andre.Messerschmidt@infineon.com wrote:

> /usr/lib/gcc-lib/mips-linux/egcs-2.91.66/include/va-mips.h:278: parse error
> at null character

If this file contains a NUL character your compiler installation got
corrupted somehow.  Say might also be memory corruption of your compiler
host.

  Ralf

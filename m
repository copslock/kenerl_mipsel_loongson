Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FCoBc16606
	for linux-mips-outgoing; Fri, 15 Feb 2002 04:50:11 -0800
Received: from dea.linux-mips.net (a1as06-p212.stg.tli.de [195.252.187.212])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FCo7916603
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 04:50:08 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1FAvBu26813;
	Fri, 15 Feb 2002 11:57:11 +0100
Date: Fri, 15 Feb 2002 11:57:11 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>, carstenl@mips.com
Cc: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020215115711.A26798@dea.linux-mips.net>
References: <3C6C6ACF.CAD2FFC@mvista.com> <006d01c1b606$21929c80$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <006d01c1b606$21929c80$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Feb 15, 2002 at 09:14:52AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Feb 15, 2002 at 09:14:52AM +0100, Kevin D. Kissell wrote:

> I submitted a series of patches a year or so ago, the
> last of which really should have been a comprehensive
> fix to the FPU context switch and signal problems.
> The last time I looked, that patch had never made it into
> the OSS repository, but neither had anyone reported
> any holes in it.

I was actually beliving that the bundle of patches I received from
Carsten maybe 3 months ago did fix all the issues?

  Ralf

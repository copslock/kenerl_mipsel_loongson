Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DJV4F25556
	for linux-mips-outgoing; Fri, 13 Jul 2001 12:31:04 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DJV1V25553;
	Fri, 13 Jul 2001 12:31:01 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 1FFE7125BA; Fri, 13 Jul 2001 12:31:00 -0700 (PDT)
Date: Fri, 13 Jul 2001 12:31:00 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Roland McGrath <roland@frob.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com,
   GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
Message-ID: <20010713123100.A27305@lucon.org>
References: <20010713112635.A32010@bacchus.dhis.org> <20010713192500.36A9199766@perdition.linnaean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010713192500.36A9199766@perdition.linnaean.org>; from roland@frob.com on Fri, Jul 13, 2001 at 03:25:00PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jul 13, 2001 at 03:25:00PM -0400, Roland McGrath wrote:
> > Afair there is no requirement for loadable segments to be sorted
> 
> PT_LOAD entries appear in ascending order, sorted on the p_vaddr member.

Thanks. I missed that one. In any case, glibc has been right on mips
for a long time. We just don't need that specical treatmeant for
DT_MIPS_BASE_ADDRESS.


H.J.

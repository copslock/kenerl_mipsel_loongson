Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6DD1kx12601
	for linux-mips-outgoing; Fri, 13 Jul 2001 06:01:46 -0700
Received: from dea.waldorf-gmbh.de (u-18-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.18])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6DD1hV12598
	for <linux-mips@oss.sgi.com>; Fri, 13 Jul 2001 06:01:43 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6D9QaB32326;
	Fri, 13 Jul 2001 11:26:36 +0200
Date: Fri, 13 Jul 2001 11:26:36 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sourceware.cygnus.com>
Subject: Re: Clean up the mips dynamic linker
Message-ID: <20010713112635.A32010@bacchus.dhis.org>
References: <20010712182402.A10768@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010712182402.A10768@lucon.org>; from hjl@lucon.org on Thu, Jul 12, 2001 at 06:24:02PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 12, 2001 at 06:24:02PM -0700, H . J . Lu wrote:

> In fact, DT_MIPS_MAP_BASE_ADDR is the same as the p_addr field of the
> first loadable segment in the program header. I think it is included
> in the MIPS ABI to give the dynamic linker easy access to it.

Afair there is no requirement for loadable segments to be sorted so you'd
have to go through all the program header table to find the one with the
lowest address which isn't necessarily the first segment.

As the ABI doesn't give any guarantee that the lowest address in the segment
table is the value of DT_MIPS_BASE_ADDR I just tried to find a binary on
my IRIX boxen that violates this rule but I didn't find any.  So please,
go ahead.

> I have tested DSOs with none-zero DT_MIPS_MAP_BASE_ADDR. It works
> fine. I think it is safe to remove MAP_BASE_ADDR and old binaries
> will work with the new glibc. If someone thinks I am wrong, please
> send me a testcase to show it.

  Ralf

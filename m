Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f77EhpY22389
	for linux-mips-outgoing; Tue, 7 Aug 2001 07:43:51 -0700
Received: from dea.waldorf-gmbh.de (u-87-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.87])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f77EhlV22376
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 07:43:47 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f77EgnO26635;
	Tue, 7 Aug 2001 16:42:49 +0200
Date: Tue, 7 Aug 2001 16:42:49 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Brandon Barker <bebarker@meginc.com>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Indy 64 or 32 bit?
Message-ID: <20010807164249.B26419@bacchus.dhis.org>
References: <01080623471400.01828@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01080623471400.01828@linux>; from bebarker@meginc.com on Mon, Aug 06, 2001 at 11:47:36PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 11:47:36PM -0400, Brandon Barker wrote:

> I will be purchasing 2 SGI Indy R5000 models from reputable.com, and was 
> curious if these are 64 bit systems or 32 bit systems (for that matter, are 
> all/any Indys 32 or 64 bit systems).  My guess is 64 because I wiould think 
> IRIX has been 64 for quite some time, but was curious.  I use Linux on x86 
> but will probably use IRIX for a few weeks on the Indy's until I become 
> familiar enough with the machines to try installing Linux.  BTW, does gcc 
> work on IRIX?

By hardwareware it's a 64-bit system - like all SGI systems we support.
The kernel is just a 32-bit one though which is a reasonable compromise
for these systems.

  Ralf

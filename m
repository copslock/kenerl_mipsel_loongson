Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2O1ONL15856
	for linux-mips-outgoing; Fri, 23 Mar 2001 17:24:23 -0800
Received: from dea.waldorf-gmbh.de (u-77-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.77])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2O1OKM15850
	for <linux-mips@oss.sgi.com>; Fri, 23 Mar 2001 17:24:20 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2O1N7515101;
	Sat, 24 Mar 2001 02:23:07 +0100
Date: Sat, 24 Mar 2001 02:23:07 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: <carlson@sibyte.com>, "Matthew Dharm" <mdharm@momenco.com>,
   <linux-mips@oss.sgi.com>
Subject: Re: Multiple processor support?
Message-ID: <20010324022307.B15044@bacchus.dhis.org>
References: <NEBBLJGMNKKEEMNLHGAIKELLCAAA.mdharm@momenco.com> <01032316143609.00779@plugh.sibyte.com> <01b801c0b3fb$1770b740$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01b801c0b3fb$1770b740$0deca8c0@Ulysses>; from kevink@mips.com on Sat, Mar 24, 2001 at 01:40:47AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Mar 24, 2001 at 01:40:47AM +0100, Kevin D. Kissell wrote:

> Well, one reason might be memory footprint...

As of now the memory footprint of the kernel is large but userspace which
is all 32-bit software has unchanged footprint.  I've got plans for 2.5
to reduce the memory footprint of the kernel by introducing a 2-level
pagetable.

  Ralf

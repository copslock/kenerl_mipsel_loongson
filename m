Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f32IFos21930
	for linux-mips-outgoing; Mon, 2 Apr 2001 11:15:50 -0700
Received: from dea.waldorf-gmbh.de (u-29-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.29])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f32IFlM21927
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 11:15:48 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f32IFcD23669;
	Mon, 2 Apr 2001 20:15:38 +0200
Date: Mon, 2 Apr 2001 20:15:38 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: RedHat7.0
Message-ID: <20010402201538.A23535@bacchus.dhis.org>
References: <3AC884AA.A0B2C595@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC884AA.A0B2C595@mips.com>; from carstenl@mips.com on Mon, Apr 02, 2001 at 03:54:51PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 02, 2001 at 03:54:51PM +0200, Carsten Langgaard wrote:

> Ralf, which compiler and tools did you use to compile the RedHat7.0
> source RPMs ?

The binutils are included in redhat 7 as on oss are not the original
binutils from Redhat 7.0 but a CVS snapshot with MIPS patches.  This
distribution does not contain a gcc rpm because I haven't yet built a
package from it.  I can however upload a tar ball of my build directory
so you can install my gcc with just ``make install'', if you want.

  Ralf

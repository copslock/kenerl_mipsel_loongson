Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3ALMbe16766
	for linux-mips-outgoing; Tue, 10 Apr 2001 14:22:37 -0700
Received: from dea.waldorf-gmbh.de (u-78-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.78])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3ALMYM16762
	for <linux-mips@oss.sgi.com>; Tue, 10 Apr 2001 14:22:34 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3AGct502267;
	Tue, 10 Apr 2001 18:38:55 +0200
Date: Tue, 10 Apr 2001 18:38:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Scott A McConnell <samcconn@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: loadaddr
Message-ID: <20010410183854.C1932@bacchus.dhis.org>
References: <3AD337DA.16570750@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD337DA.16570750@cotw.com>; from samcconn@cotw.com on Tue, Apr 10, 2001 at 09:42:02AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 10, 2001 at 09:42:02AM -0700, Scott A McConnell wrote:

> What am I doing that is causing the  leading ffffffff in the addresses?

Everything right :-)

32-bit addresses on MIPS get sign extended into 64-bit addresses.  Binutils
had related bugs; I assume you switched binutils versions between the
two builds?

  Ralf

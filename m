Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f372xRZ13360
	for linux-mips-outgoing; Fri, 6 Apr 2001 19:59:27 -0700
Received: from dea.waldorf-gmbh.de (u-131-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.131])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f372xPM13356
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 19:59:25 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f372xG926381;
	Sat, 7 Apr 2001 04:59:16 +0200
Date: Sat, 7 Apr 2001 04:59:16 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Scott A McConnell <samcconn@cotw.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: set_cp0_status (mipsregs.h)
Message-ID: <20010407045916.B26195@bacchus.dhis.org>
References: <3ACE0BA3.98823D4D@cotw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACE0BA3.98823D4D@cotw.com>; from samcconn@cotw.com on Fri, Apr 06, 2001 at 11:32:03AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 06, 2001 at 11:32:03AM -0700, Scott A McConnell wrote:

> Which is correct?
> 1 or 2 parameters ?
> The first comes from a 2.4.0 kernel and the second from a 2.4.2
> extracted from cvs a few days ago.

1 Parameter; I changed the functions since about half the calls in the
kernel code did show that whoever wrote the code didn't understand
what the function is supposed to do.

 - set_cp0_status(bits)

   Set all the bits described by the bitmask bits in the status register.
   
 - clear_cp0_status(bits)

   Clear all the bits set in the bitmask argument bits in the status register.

 - change_cp0_status(change, set)

   Set all bits which are set in the bitmask change to the value given by
   the bitmask set; all other bits stay unchanged.  This is the same as
   the old set_cp0_status function.

Most people want to use {set,clear}_cp0_status().

  Ralf

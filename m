Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 23:39:35 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30197 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225252AbTFDWjc>;
	Wed, 4 Jun 2003 23:39:32 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h54MdUV20207;
	Wed, 4 Jun 2003 15:39:30 -0700
Date: Wed, 4 Jun 2003 15:39:30 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030604153930.H19122@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


There are many benefits of having perfectly synchronized CPU
count registers on SMP machines.

I wonder if this is something which have been done before,
and if this is feasible.

Apparently, this scheme won't work if any of the following
conditions are true:

1) clocks on different CPUs don't have the same frequency
2) clocks on different CPUs drift to each other
2) some fancy power saving feature such as frequency scaling

But I think for a foreseeable future most MIPS SMP machines
don't have the above issues (true?).  And it is probably worthwile
to synchronize count registers for them.

I think some pseudo code like the below could get the 
job done:

CPU 0:
	send interrupt to all other CPUs and ask them to sync count
	wait for all other CPUs to gather at rendevous point
	flip a flag
	set count to 0

other CPUs:
	trapped by IPI
	reach the rendevous point (busy spin locking)
	wait for the flip of the flag
	set count to 0

I wonder after the above code how synchronized are the count regsiters.
Are they perfectly synchronized or still differ by a few counts?

Any comments?

Jun

Received:  by oss.sgi.com id <S554111AbRAZVEq>;
	Fri, 26 Jan 2001 13:04:46 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:33909 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S554108AbRAZVEe>;
	Fri, 26 Jan 2001 13:04:34 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA08580
	for <linux-mips@oss.sgi.com>; Fri, 26 Jan 2001 13:04:33 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869667AbRAZVAy>; Fri, 26 Jan 2001 13:00:54 -0800
Date: 	Fri, 26 Jan 2001 13:00:44 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "Carsten Langgaard" <carstenl@mips.com>,
        "Michael Shmulevich" <michaels@jungo.com>, <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
Message-ID: <20010126130044.E869@bacchus.dhis.org>
References: <3A70A356.F3CA71F1@jungo.com> <20010125141632.B2311@bacchus.dhis.org> <3A712A52.FAC574F1@mips.com> <019b01c0878d$8ac9e6c0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <019b01c0878d$8ac9e6c0$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Jan 26, 2001 at 12:45:45PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 12:45:45PM +0100, Kevin D. Kissell wrote:

> Note, however, that the Tulip driver that was part of the
> standard 2.2/2.3 repository at oss.sgi.com was both
> downrev with regard to the author's own web site and
> subobtimal if not outright buggy in it's cache management.
> The AMD PCnet driver as we found it was clean and efficient
> but had no MIPS cache hooks.   I had to put those in.
> So unless Ralf or someone at SGI that the versions
> on oss.sgi.com are the versions I cleaned up for MIPS,
> I would recommend pulling them off the MIPS site.

Linux 2.4 has a new DMA API which is documented in
Documentation/DMA-mapping.txt.  So today drivers which don't work out of
the box on a MIPS system should be considered broken.

  Ralf

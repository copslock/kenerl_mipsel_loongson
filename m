Received:  by oss.sgi.com id <S554043AbRAYWcu>;
	Thu, 25 Jan 2001 14:32:50 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:14363 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S554040AbRAYWcp>;
	Thu, 25 Jan 2001 14:32:45 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com (dhcp-163-154-5-240.engr.sgi.com [163.154.5.240]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA22746
	for <linux-mips@oss.sgi.com>; Thu, 25 Jan 2001 14:31:43 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870759AbRAYW3g>; Thu, 25 Jan 2001 14:29:36 -0800
Date: 	Thu, 25 Jan 2001 14:29:26 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Pete Popov <ppopov@mvista.com>
Cc:     Michael Shmulevich <michaels@jungo.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
Message-ID: <20010125142926.D2311@bacchus.dhis.org>
References: <3A70A356.F3CA71F1@jungo.com> <3A70A718.F0628BBB@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A70A718.F0628BBB@mvista.com>; from ppopov@mvista.com on Thu, Jan 25, 2001 at 02:22:16PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 25, 2001 at 02:22:16PM -0800, Pete Popov wrote:

> > I would like to ask if someone knows some more or less widely available
> > PCI network card that is compatible with MIPS/Linux.
> > 
> > I have heard of Tulip and AMD's PCnet. I wonder if you heard of others.
> > 
> > Thanks in advance,
> > Sorry if this mail bothered you...
> 
> Another one is the RTL8139.  It's quite cheap (I think less than $20).

In the dark past I had great success with the NE2k's.  They PIO, so no
driver hacking necessary at all.

  Ralf

Received:  by oss.sgi.com id <S554037AbRAYWUU>;
	Thu, 25 Jan 2001 14:20:20 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:40268 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S554034AbRAYWUA>;
	Thu, 25 Jan 2001 14:20:00 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA04547
	for <linux-mips@oss.sgi.com>; Thu, 25 Jan 2001 14:20:00 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870759AbRAYWQn>; Thu, 25 Jan 2001 14:16:43 -0800
Date: 	Thu, 25 Jan 2001 14:16:32 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Michael Shmulevich <michaels@jungo.com>
Cc:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/linux compatible PCI network cards
Message-ID: <20010125141632.B2311@bacchus.dhis.org>
References: <3A70A356.F3CA71F1@jungo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A70A356.F3CA71F1@jungo.com>; from michaels@jungo.com on Fri, Jan 26, 2001 at 12:06:14AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 12:06:14AM +0200, Michael Shmulevich wrote:
> Date:   Fri, 26 Jan 2001 00:06:14 +0200
> From: Michael Shmulevich <michaels@jungo.com>
> To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
> Subject: MIPS/linux compatible PCI network cards
> 
> Hello all,
> 
> I would like to ask if someone knows some more or less widely available 
> PCI network card that is compatible with MIPS/Linux.
> 
> I have heard of Tulip and AMD's PCnet. I wonder if you heard of others.

These all have already been used with Linux/MIPS.  I don't have any reports
on the current status of these drivers.  If they don't work they should
be reasonably easy to fix.

  Ralf

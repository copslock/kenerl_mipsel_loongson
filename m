Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 09:46:20 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:2692 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225241AbTFEIqR>;
	Thu, 5 Jun 2003 09:46:17 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h558k6Ue002824;
	Thu, 5 Jun 2003 01:46:06 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA28683;
	Thu, 5 Jun 2003 01:46:05 -0700 (PDT)
Message-ID: <019201c32b40$2d54cf60$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>, "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>, <jsun@mvista.com>
References: <20030604153930.H19122@mvista.com> <20030604231547.GA22410@linux-mips.org> <20030604164652.J19122@mvista.com>
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Date: Thu, 5 Jun 2003 10:55:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

----- Original Message ----- 
From: "Jun Sun" <jsun@mvista.com>
> On Thu, Jun 05, 2003 at 01:15:47AM +0200, Ralf Baechle wrote:
> > On Wed, Jun 04, 2003 at 03:39:30PM -0700, Jun Sun wrote:
> > 
> > > 1) clocks on different CPUs don't have the same frequency
> > > 2) clocks on different CPUs drift to each other
> > > 2) some fancy power saving feature such as frequency scaling
> > > 
> > > But I think for a foreseeable future most MIPS SMP machines
> > > don't have the above issues (true?).  And it is probably worthwile
> > > to synchronize count registers for them.
> > 
> > 1) and 2) affect most SGI systems.
> >
> 
> Assuming SGI systems represent the past of MIPS, we are still ok
> future-wise. :)

I personally think it would be foolish to assume that future MIPS 
MP systems will not be subject to one or more such constraint.

            Kevin K.

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 22:33:43 +0000 (GMT)
Received: from diamond.demon.co.uk ([IPv6:::ffff:158.152.18.76]:62188 "EHLO
	basil.diamond.local") by linux-mips.org with ESMTP
	id <S8224914AbUASWdm>; Mon, 19 Jan 2004 22:33:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by basil.diamond.local (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id i0JMd2tO013397;
	Mon, 19 Jan 2004 22:39:04 GMT
From: Bob Lees <bob@diamond.demon.co.uk>
Organization: Diamond Consulting Services Ltd
To: Pete Popov <ppopov@mvista.com>
Subject: Re: au1100 usb support
Date: Mon, 19 Jan 2004 22:39:02 +0000
User-Agent: KMail/1.5.4
Cc: linux-mips@linux-mips.org
References: <200401191806.27381.bob@diamond.demon.co.uk> <400BB003.8000605@mvista.com>
In-Reply-To: <400BB003.8000605@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401192239.02283.bob@diamond.demon.co.uk>
Return-Path: <bob@diamond.demon.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bob@diamond.demon.co.uk
Precedence: bulk
X-list: linux-mips

Correct assumption.  Thank you for the pointer, unfortunately both the usb 
non-pci and zboot patches for 2.4.24 are only rw by the owner, there is no 
world read access.  Can this be changed, pretty please:)

Thanks

Bob
On Monday 19 January 2004 10:22, Pete Popov wrote:
> Bob Lees wrote:
> >OK I'm missing something somewhere
> >
> >I am trying to get the usb host controller to work on an AU1100 board (the
> >Aurora board from DSP Design) and it isn't initialising the host
> > controller.
>
> From looking at the usb host code it appears that the only interface
> supported
>
> >is via pci, but this processor/board doesn't have pci.
> >
> >A previous kernel based on 2.4.17 had the concept of
> > CONFIG_USB_NON_PCI_OHCI which appears to have disappeared.  This
> > generated a pseudo pci interface.
> >
> >Help, any idea where I should be looking.
>
> I assume you're working with the linux-mips.org kernel?  Take a look at
> the readme at ftp.linux-mips.org:/pub/linux/mips/people/ppopov.  You're
> missing the usb non-pci patch.
>
> Pete

-- 
Bob Lees
Diamond Consulting Services Ltd
Aylesbury, Bucks, HP17 8UG
Phone: +44 (0) 1296 747667
Fax: +44 (0) 1296 747557
email: bob@diamond.demon.co.uk

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 18:23:06 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:24049 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225222AbUASSXF>;
	Mon, 19 Jan 2004 18:23:05 +0000
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA26461;
	Mon, 19 Jan 2004 10:22:59 -0800
Message-ID: <400BB003.8000605@mvista.com>
Date: Mon, 19 Jan 2004 02:22:59 -0800
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob Lees <bob@diamond.demon.co.uk>
CC: linux-mips@linux-mips.org
Subject: Re: au1100 usb support
References: <200401191806.27381.bob@diamond.demon.co.uk>
In-Reply-To: <200401191806.27381.bob@diamond.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

Bob Lees wrote:

>OK I'm missing something somewhere
>
>I am trying to get the usb host controller to work on an AU1100 board (the 
>Aurora board from DSP Design) and it isn't initialising the host controller.
>
>From looking at the usb host code it appears that the only interface supported 
>is via pci, but this processor/board doesn't have pci.
>
>A previous kernel based on 2.4.17 had the concept of CONFIG_USB_NON_PCI_OHCI 
>which appears to have disappeared.  This generated a pseudo pci interface.
>
>Help, any idea where I should be looking.
>  
>
I assume you're working with the linux-mips.org kernel?  Take a look at 
the readme at ftp.linux-mips.org:/pub/linux/mips/people/ppopov.  You're 
missing the usb non-pci patch.

Pete

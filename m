Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 20:55:24 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:28405 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225377AbUCRUzX>;
	Thu, 18 Mar 2004 20:55:23 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA21493;
	Thu, 18 Mar 2004 12:55:17 -0800
Subject: Re: PMON documentation
From: Pete Popov <ppopov@mvista.com>
To: erras stefan <stefan.erras@dallmeier-electronic.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <765921A8173EC145948ACBAA0480F67E2C76D5@server10.dallmeier.de>
References: <765921A8173EC145948ACBAA0480F67E2C76D5@server10.dallmeier.de>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1079643413.14003.2.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Mar 2004 12:56:53 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, 2004-03-18 at 05:09, erras stefan wrote:
> Hello,
> I'm working on a development project with a RM5231 MIPS processor.
> I have to modify some things in the PMON bootloader source-code.
> Can anybody give me an advice where I can find PMON source code
> documentation or a detailed explanation how PMON works.
> Which files do I have to look into, when I would like to modify the
> bootloader.
> Maybe I can use another bootloader. Which alternatives do I have. I do
> not need the debug functionality of PMON. Maybe there is an easier to
> understand and modify bootloader.
> 
> Thank you all in advance for your help!

I think there were too many versions of "PMON" floating out there. I'm
not sure which one you have.

If you are starting from scratch, take a look at uboot. I think that
would be a much better alternative.

Pete

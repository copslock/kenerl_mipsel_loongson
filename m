Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 17:57:13 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:34044 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225777AbUERQ5K>;
	Tue, 18 May 2004 17:57:10 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA22287;
	Tue, 18 May 2004 09:56:57 -0700
Subject: Re: epson1356fb.c Video driver obsolete
From: Pete Popov <ppopov@mvista.com>
To: Roberto Zilli <r.zilli@ingredium.it>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <40AA2EE6.1030509@ingredium.it>
References: <40AA2EE6.1030509@ingredium.it>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1084899487.29782.10.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 May 2004 09:58:07 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2004-05-18 at 08:42, Roberto Zilli wrote:
> Hi guys,
> 
> the epson1356fb.c on 2.6.6 is broken, it don't work!

Which board did you test it on?  ... not that it makes much of a
difference in this case.

> Any clues?

Yes. The 2.6 FB API is different from the 2.4 API. I don't know how many
FB drivers have been updated to the 2.6 API, but I do know that the
epson1356fb driver is not one of the updated ones. 

I don't have plans for updating that driver myself, unless there's a
compelling reason to do so, or someone else updates it.

Pete

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2003 17:29:25 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57853 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225360AbTIJQ3X>;
	Wed, 10 Sep 2003 17:29:23 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA21054;
	Wed, 10 Sep 2003 09:29:07 -0700
Message-ID: <3F5F5152.2E8B52C9@mvista.com>
Date: Wed, 10 Sep 2003 10:29:06 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Steven J. Hill" <sjhill@realitydiluted.com>
CC: linux-mips@linux-mips.org
Subject: Re: PATCH:2.4:tx4927 updates (mostly minor)
References: <3F5E0566.4E0DD26C@mvista.com> <3F5E85DD.1010700@realitydiluted.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips

> May I ask why you are using 38400 for the baud rate and not
> the maximum 57600?
The PMON f/w I use on my boards defaults to 38400.  Makes my
life easier if the kernel and firmware default to the same
baud rate.  Especially, since I need to reload the f/w often 
to switch between LE and BE.  NOTE: without the console= override,
the driver defaults to 9600.

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 16:40:03 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:2806 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225554AbTIXPj4>;
	Wed, 24 Sep 2003 16:39:56 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id IAA09183;
	Wed, 24 Sep 2003 08:39:53 -0700
Message-ID: <3F71BAC8.2B4DCC50@mvista.com>
Date: Wed, 24 Sep 2003 09:39:52 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeffrey Baitis <baitisj@evolution.com>
CC: linux-mips@linux-mips.org
Subject: Re: Toshiba TX4925 experiences wanted
References: <1064281591.25782.255.camel@powerpuff.pas.lab>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips

 > I understand that the Linux MIPS kernel has support for the TX4927. Has
> anyone tried the TX4925 as well? Does Monta Vista's BSP for the 27 work
> for the 25?
The 4927 code will not run on the 4925.  We do have support for the 4925
and one of my many todo items is to get the 4925 stuff into linux-mips
soon.

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 19:04:13 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:49052 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20038717AbYBGTEE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Feb 2008 19:04:04 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id D585E31222D;
	Thu,  7 Feb 2008 19:04:05 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu,  7 Feb 2008 19:04:05 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 7 Feb 2008 11:03:49 -0800
Message-ID: <47AB5614.5010804@avtrex.com>
Date:	Thu, 07 Feb 2008 11:03:48 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Andi <opencode@gmx.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux kernel on Sigma SMP8634
References: <47AB50DD.2050504@gmx.net>
In-Reply-To: <47AB50DD.2050504@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2008 19:03:49.0862 (UTC) FILETIME=[2C556060:01C869BC]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Andi wrote:
> Hey Folks,
> 
> we are working on a SMP8634-based box to get Linux running on it.
> Since we don't have any documentation, neither hardware nor software,
> there is a lot of re-engineering work to be done.
> However, we managed it to let the box load a Linux kernel .. but it
> still fails at a certain point.
> It's right before the kernel loads the "NET: .."-stuff. I got this from
> an other SMP8634-based box, which runs the same kernel.
> 
> Any hints about what might doesn't work?
> 

You need symbols so that you can interpret the stack trace.  It is 
impossible to tell anything without that.
.
.
.
> Determined physical RAM map:
>  memory: 05ee0000 @ 10020000 (usable)

This seems like an odd value.  I would expect either 03fe0000 or 07fe0000

David Daney

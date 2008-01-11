Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 17:22:53 +0000 (GMT)
Received: from port535.ds1-van.adsl.cybercity.dk ([217.157.140.228]:63319 "EHLO
	valis.murphy.dk") by ftp.linux-mips.org with ESMTP
	id S20023287AbYAKRWp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jan 2008 17:22:45 +0000
Received: from [10.0.0.112] (brm@[10.0.0.112])
	by valis.murphy.dk (8.13.8/8.13.8/Debian-3) with ESMTP id m0BHMTV2032480;
	Fri, 11 Jan 2008 18:22:29 +0100
Message-ID: <4787A5D4.2020100@murphy.dk>
Date:	Fri, 11 Jan 2008 18:22:28 +0100
From:	Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.13pre) Gecko/20070505 Iceape/1.0.9 (Debian-1.0.11~pre071022-0etch1+lenny1)
MIME-Version: 1.0
To:	Daniel Walker <dwalker@mvista.com>
CC:	mingo@elte.hu, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: picvue: pvc_sem semaphore to mutex
References: <20080111045348.085971795@mvista.com>
In-Reply-To: <20080111045348.085971795@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Daniel Walker wrote:
> This semaphore conforms to the new struct mutex, so I've converted it
> to use that new API.
>
> I also changed the name to pvc_mutex, and moved the define to the file
> it's used in which allows it to be static.
>
> Signed-off-by: Daniel Walker <dwalker@mvista.com>
>
>   
Thanks.

/Brian

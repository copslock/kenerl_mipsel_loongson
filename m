Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3PJWlwJ021980
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Apr 2002 12:32:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3PJWl6Z021979
	for linux-mips-outgoing; Thu, 25 Apr 2002 12:32:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3PJWhwJ021975
	for <linux-mips@oss.sgi.com>; Thu, 25 Apr 2002 12:32:43 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA05022
	for <linux-mips@oss.sgi.com>; Thu, 25 Apr 2002 12:32:57 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA17551;
	Thu, 25 Apr 2002 11:45:30 -0700
Message-ID: <3CC84EEC.8060100@mvista.com>
Date: Thu, 25 Apr 2002 11:46:04 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
CC: turcotte@broadcom.com, linux-mips@oss.sgi.com, mturc@broadcom.com
Subject: Re: Linux Shared Memory Issue
References: <NDBBKEAAOJECIDBJKLIHOEDDCDAA.turcotte@broadcom.com>	<3CC72BA3.90600@mvista.com> <20020425.142518.85417141.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Atsushi Nemoto wrote:

>>>>>>On Wed, 24 Apr 2002 15:03:15 -0700, Jun Sun <jsun@mvista.com> said:
>>>>>>
> jsun> Looks like the infamous cache aliasing problem.  Steve
> jsun> Longerbeam had a patch which may help.  Please try it and let me
> jsun> know the results.
> 
> jsun> +#define COLOUR_ALIGN(addr)    (((addr)+SHMLBA-1)&~(SHMLBA-1))
> 
> Recent sparc64's COLOUR_ALIGN macro have pgoff argument like this.
> We should do it same way for MIPS?
> 
> #define COLOUR_ALIGN(addr,pgoff)		\
> 	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
> 	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
> 


What is the purpose of adding the pgoff part?  To avoid mapping all shared 
regions into the beginning of cache?

Jun

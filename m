Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14JgYx14961
	for linux-mips-outgoing; Mon, 4 Feb 2002 11:42:34 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14JgWA14928
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 11:42:32 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g14IeOB08958;
	Mon, 4 Feb 2002 10:40:24 -0800
Message-ID: <3C5ED610.529C020E@mvista.com>
Date: Mon, 04 Feb 2002 10:42:24 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: madplay on mips
References: <1012843753.14993.106.camel@zeus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete Popov wrote:
> 
> Has anyone used madplay on mips to play mp3 files successfully? I've
> tried it on two mips boards with different sound drivers, and in both
> cases it plays the song slower and a bit muffled.  It works on x86 and
> supposedly ppc.
> 

I tried it before, and had the same results.

I looked over the system calls, and was pretty much sure that the problem was
on madplay side, and not on the driver side.  One problem suspected was the
floating point issue, but did get into it.

Jun

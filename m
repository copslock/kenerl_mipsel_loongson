Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8QHYS025796
	for linux-mips-outgoing; Wed, 26 Sep 2001 10:34:28 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8QHYRD25793
	for <linux-mips@oss.sgi.com>; Wed, 26 Sep 2001 10:34:27 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f8QHbOB11590;
	Wed, 26 Sep 2001 10:37:24 -0700
Message-ID: <3BB20FA9.79D167BA@mvista.com>
Date: Wed, 26 Sep 2001 10:26:01 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Karasek <marc_karasek@ivivity.com>
CC: "'Karsten Merker'" <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: busybox does not like 2.4.8, or the other way around?
References: <25369470B6F0D41194820002B328BDD2195AA2@ATLOPS>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Marc Karasek wrote:
> 
> Yes, there was a bug in busybox that caused this.  I helped track it down a
> few months ago and it should be fixed in the latest one.  I have attached an
> email about the bug.  What version(s) of busybox are you using?
> 

It is 0.51.  Looks like the same busybox bug to me.  Time to update busybox.

I'd appreciate if someone has already updated my little busybox ramdisk at
http://linux.junsun.net and send me a copy ...

Jun

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2MLWoL31212
	for linux-mips-outgoing; Fri, 22 Mar 2002 13:32:50 -0800
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2MLWlq31209
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 13:32:47 -0800
Received: from localhost.localdomain (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id g2MLX4923602
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 16:33:04 -0500
Received: from mx.hsv.redhat.com (IDENT:root@spot.hsv.redhat.com [172.16.16.7])
	by localhost.localdomain (8.11.6/8.11.6) with ESMTP id g2MLZAm02254
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 16:35:10 -0500
Received: from redhat.com (dhcp-166.hsv.redhat.com [172.16.17.166])
	by mx.hsv.redhat.com (8.11.6/8.11.0) with ESMTP id g2MLZGN08930
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 15:35:16 -0600
Message-ID: <3C9BA339.5030709@redhat.com>
Date: Fri, 22 Mar 2002 15:33:45 -0600
From: Lanny DeVaney <ldevaney@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: RTC setup
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm having trouble figuring out how to setup the RTC for my Linux port. 
 My board has a Dallas DS1501WE chip, and I can't figure out the rhyme 
or reason for the addr values passed to my rtc_write_data callback from 
the kernel.  I know my RTC base address, and can in fact go in and look 
and see the date/time values at that location.

It appears for the mips boards that have rtc support in the kernel (some 
do not), the actual code inside these callbacks differs, but I noted 
that the DEC references a Dallas chip, others appear to use other rtc chips.

I would have assumed that the addr value passed to my rtc_write_data 
callback would have been sequential in nature and I would simply return 
the value at the (rtc_base_addr + offset passed in as addr), but the 
addr values I see coming in are really sporadic.  

Can anybody offer any suggestions, or does anybody know what the addr 
values pased into the callback refer to?

Thanks,
Lanny DeVaney
Red Hat, Inc.

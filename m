Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3FLrv8d019133
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Apr 2002 14:53:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3FLrvFT019132
	for linux-mips-outgoing; Mon, 15 Apr 2002 14:53:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3FLrr8d019128
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 14:53:54 -0700
Received: from localhost.localdomain (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id g3FLp1M17553
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 17:51:01 -0400
Received: from mx.hsv.redhat.com (IDENT:root@spot.hsv.redhat.com [172.16.16.7])
	by localhost.localdomain (8.11.6/8.11.6) with ESMTP id g3FLsi923967
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 17:54:44 -0400
Received: from redhat.com (dhcp-166.hsv.redhat.com [172.16.17.166])
	by mx.hsv.redhat.com (8.11.6/8.11.0) with ESMTP id g3FLsl809044
	for <linux-mips@oss.sgi.com>; Mon, 15 Apr 2002 16:54:47 -0500
Message-ID: <3CBB4BA7.1010304@redhat.com>
Date: Mon, 15 Apr 2002 16:52:39 -0500
From: Lanny DeVaney <ldevaney@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: RTC question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've used the NEW_TIME_C method to implement support for the Dallas 1501 
RTC in my MIPS port .  I now successfully read the hw clock, and the 
date program works, and I can change the time.

However, the hwclock program tells me that it can't access the Hardware 
Clock and tells me that /dev/rtc doesn't exist (although it actually 
does) when running hwclock --debug.  Also, I see an oddity that may be 
related - ping reports zero (as in 0 msec) round trip times always.  I 
configured CONFIG_RTC into the kernel, and checked the major, minor of 
/dev/rtc on my embedded ramdisk.  Also, I don't see /proc/driver/rtc.  

Is this normal behavior with NEW_TIME_C  configurations?  I've checked 
my rtc_get_time and rtc_set_time, ..., like I said, the 'date' program 
works, reading and writing to the clock.

Thanks,
Lanny DeVaney

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3GHiDx30704
	for linux-mips-outgoing; Mon, 16 Apr 2001 10:44:13 -0700
Received: from stereotomy.lineo.com (stereotomy.lineo.com [64.50.107.151])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3GHi1M30700;
	Mon, 16 Apr 2001 10:44:01 -0700
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP
	id F2C034C92E; Mon, 16 Apr 2001 11:43:44 -0600 (MDT)
Message-ID: <3ADB2F50.80904@Lineo.COM>
Date: Mon, 16 Apr 2001 11:43:44 -0600
From: Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@oss.sgi.com>, Kanoj Sarcar <kanoj@oss.sgi.com>,
   linux-origin@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
References: <200104111800.LAA23131@google.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> 
> receive_chars() was updated to look at ignore_mask ... if CREAD is not
> set, around the time of opening via ioctls etc, it will not take inputs.
> I haven't figured the details out, but I believe it is more of a *getty
> config issue than anything else. 
> 
> Kanoj

Same thing happens when I bring up 2.4.3 straight
to a shell w/out any getty, as well.

Quinn

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2003 09:35:54 +0000 (GMT)
Received: from ns.prosyst.bg ([IPv6:::ffff:212.95.166.35]:57103 "HELO
	ns.prosyst.bg") by linux-mips.org with SMTP id <S8225194AbTCJJfx>;
	Mon, 10 Mar 2003 09:35:53 +0000
Received: (qmail 18975 invoked from network); 10 Mar 2003 09:35:49 -0000
Received: from gw.prosyst.bg (HELO prosyst.bg) (212.95.166.50)
  by ns.prosyst.bg with SMTP; 10 Mar 2003 09:35:49 -0000
Message-ID: <3E6C5DE2.6090403@prosyst.bg>
Date: Mon, 10 Mar 2003 11:41:54 +0200
From: Alexander Popov <s_popov@prosyst.bg>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-mips@linux-mips.org
Subject: Re: Mycable XXS board
References: <3E6C4DF1.3020304@mycable.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Return-Path: <s_popov@prosyst.bg>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: s_popov@prosyst.bg
Precedence: bulk
X-list: linux-mips

Thanks to all that helped me up with that...

I managed to compile the kernel (2.4.21). There were some problems with unresolved symbols, but when 
I fixed the support to only pb1500 and removed the MTD CFI support , the framebuffer and a few other 
things it worked.

Thanks againg guys.

Best Regards,

-- 
Alexander Popov
RTOS&JVM Team Leader
Prosyst Bulgaria, Inc.
email: s_popov@prosyst.bg
mobile: +35987663193
icq: 29207350

Received:  by oss.sgi.com id <S553696AbRAWX1C>;
	Tue, 23 Jan 2001 15:27:02 -0800
Received: from stereotomy.lineo.com ([64.50.107.151]:61452 "HELO
        stereotomy.lineo.com") by oss.sgi.com with SMTP id <S553704AbRAWX0m>;
	Tue, 23 Jan 2001 15:26:42 -0800
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP id 992BE4CC60
	for <linux-mips@oss.sgi.com>; Tue, 23 Jan 2001 16:26:35 -0700 (MST)
Message-ID: <3A6E132B.9000103@Lineo.COM>
Date:   Tue, 23 Jan 2001 16:26:35 -0700
From:   Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: CONFIG_MIPS_UNCACHED
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf,

On some machines with weird firmware (e.g. IDT 334 board)
the processor comes up with the cache already enabled for
kseg0.  In this case, the set_cp0_config() call in mips32.c
to turn off the cache (gated by CONFIG_MIPS_UNCACHED) should
probably come after the first call to flush_cache_all(),
which is safer but still not totally safe, I suppose.
Or am I totally hosed trying to turn the kseg0 cache off
after it was once on?

Quinn Jensen

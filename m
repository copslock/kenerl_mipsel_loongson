Received:  by oss.sgi.com id <S553852AbRCBXrx>;
	Fri, 2 Mar 2001 15:47:53 -0800
Received: from stereotomy.lineo.com ([64.50.107.151]:9994 "HELO
        stereotomy.lineo.com") by oss.sgi.com with SMTP id <S553847AbRCBXrc>;
	Fri, 2 Mar 2001 15:47:32 -0800
Received: from Lineo.COM (localhost.localdomain [127.0.0.1])
	by stereotomy.lineo.com (Postfix) with ESMTP
	id C6D564C92E; Fri,  2 Mar 2001 16:47:25 -0700 (MST)
Message-ID: <3AA0310D.7050206@Lineo.COM>
Date:   Fri, 02 Mar 2001 16:47:25 -0700
From:   Quinn Jensen <jensenq@Lineo.COM>
Organization: Lineo, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-9mdk i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: loopback broken in 2.4.2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

FYI - watch out for loopback problems in 2.4.2.
See http://kt.zork.net/kernel-traffic/latest.html#11

I tried the patch,

ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.2-pre4/loop-6.gz

and it does fix it at least on a mipsel build.


Quinn

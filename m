Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 16:31:10 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:26791
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225770AbVCHQay>;
	Tue, 8 Mar 2005 16:30:54 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Tue, 08 Mar 2005 08:30:52 -0800
  id 000084E8.422DD33C.0000110B
Message-ID: <422DD318.9020804@jg555.com>
Date:	Tue, 08 Mar 2005 08:30:16 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IPTables 1.3.x fails on RaQ2
References: <422C8D6A.6060904@jg555.com> <422C9142.8090007@gmx.net> <422D0D64.2080402@gentoo.org> <422D2801.2060903@jg555.com> <422D3AC9.4020601@gentoo.org> <422D4A49.9020504@gmx.net> <422D55B6.4010300@jg555.com> <20050308132408.GB9811@linux-mips.org>
In-Reply-To: <20050308132408.GB9811@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Ralf and other Linux-MIPS readers,
    I checked the linux-libc-headers for those files, and they are not 
there. I'm tried fighting this battle with netfilter before and they 
won't budge from the fact that they build iptables from the headers in 
/usr/src/linux, if you use my make KERNEL_DIR=/usr, the problem doesn't 
exist it's only when we build from the raw kernel headers. So what 
method is the proper method, building from the raw headers or santized 
ones like linux-libc?

-- 
----
Jim Gifford
maillist@jg555.com

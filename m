Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2005 07:36:12 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:23704
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225555AbVCHHf4>;
	Tue, 8 Mar 2005 07:35:56 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 07 Mar 2005 23:35:53 -0800
  id 0000803E.422D55D9.00001840
Message-ID: <422D55B6.4010300@jg555.com>
Date:	Mon, 07 Mar 2005 23:35:18 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	freshy98 <freshy98@gmx.net>
CC:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IPTables 1.3.x fails on RaQ2
References: <422C8D6A.6060904@jg555.com> <422C9142.8090007@gmx.net> <422D0D64.2080402@gentoo.org> <422D2801.2060903@jg555.com> <422D3AC9.4020601@gentoo.org> <422D4A49.9020504@gmx.net>
In-Reply-To: <422D4A49.9020504@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

I found the culprit, but don't know what the proper fix is.

File - What to remove or comment out
/usr/src/linux/include/asm/cpu-features.h - #include 
<cpu-feature-overrides.h>
/usr/src/linux/include/asm/addrspace.h -  #include <spaces.h>

But it still fails, because it looks at the headers in /usr/include and 
the ones is /usr/src/linux/include, which is what the problem is. Namely 
socket.h

What I noticed is some of the mips architectures includes have these 
files and some do not.

A workaround for those who use the linux-libc-headers to build iptables 
with the following commands, but I would still comment out those files 
to prevent other build issues later

make KERNEL_DIR=/usr

But I'm not sure of the stability and the functionality.

-- 
----
Jim Gifford
maillist@jg555.com

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 23:31:53 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:37000
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8229680AbVCYXbi>;
	Fri, 25 Mar 2005 23:31:38 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Fri, 25 Mar 2005 15:31:36 -0800
  id 0000C3D8.42449F58.00007609
Message-ID: <42449F47.8010002@jg555.com>
Date:	Fri, 25 Mar 2005 15:31:19 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Build 64bit on RaQ2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

   Has anyone had any luck compiling a 64 bit version on the RaQ2. I can 
get it to compile but, it locks up during boot up.

elf64: 00080000 - 0042fd3f (ffffffff,803e6000) (ffffffff,8000000)
elf64: ffffffff,80080000 (8008000) 3731589t + 134331t

That's all I got during bootup, no error messages or anything.

-- 
----
Jim Gifford
maillist@jg555.com

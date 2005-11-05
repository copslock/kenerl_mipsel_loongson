Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2005 18:56:19 +0000 (GMT)
Received: from Jg555.com ([64.30.195.78]:39078 "EHLO jg555.com")
	by ftp.linux-mips.org with ESMTP id S8133614AbVKES4B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Nov 2005 18:56:01 +0000
Received: from [172.16.0.55] ([::ffff:172.16.0.55])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Sat, 05 Nov 2005 10:56:50 -0800
  id 0028C43E.436D0072.000049D8
Message-ID: <436D0061.5070100@jg555.com>
Date:	Sat, 05 Nov 2005 10:56:33 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: MIPS - 64bit woes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

I've been working on getting the RaQ2 to work with the current 2.6.14 
kernel, but no luck at all. The last success I had was with 2.6.12.x 
series.

I'm looking for ideas, patches or whatever to get this working again. I 
know it has to do with the kernel using 32bit addressing instead of 64 
bit, but have no clue where to start.

Here is what I get when I attempt to boot it.

 > nfs 172.16.0.1 /nfsroot boot/vmlinux-2.6.14.gz
nfs: mounted "/nfsroot"
nfs: lookup "boot"
nfs: lookup "vmlinux-2.6.14.gz"
nfs: mode <0100755>
1349KB loaded (899KB/sec)
001512e8 1381096t
nfs: unmounted "/nfsroot"
 > execute root=/dev/nfs nfsroot=172.16.0.1:/nfsroot 
console=ttyS0,115200 ip=dhcp
elf64: 00080000 - 003b901f (ffffffff.80357000) (ffffffff.80000000)
elf64: ffffffff.80080000 (80080000) 3170438t + 208794t
net: interface down

Thanx for all your assistance.

-- 
----
Jim Gifford
maillist@jg555.com

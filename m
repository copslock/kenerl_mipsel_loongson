Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3D82Z8d008325
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 13 Apr 2002 01:02:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3D82ZlE008324
	for linux-mips-outgoing; Sat, 13 Apr 2002 01:02:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from libra.seed.net.tw (libra.seed.net.tw [192.72.81.214])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3D82S8d008318
	for <linux-mips@oss.sgi.com>; Sat, 13 Apr 2002 01:02:29 -0700
Received: from sw59-226-127.adsl.seed.net.tw ([61.59.226.127] helo=libra.seed.net.tw)
	by libra.seed.net.tw with esmtp (Seednet MTA build 20010831)
	id 16wIUo-0000P0-00; Sat, 13 Apr 2002 16:02:55 +0800
Message-ID: <3CB7E629.9060105@libra.seed.net.tw>
Date: Sat, 13 Apr 2002 16:02:49 +0800
From: Tim Wu <chtimwu@libra.seed.net.tw>
Reply-To: chtimwu@libra.seed.net.tw
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Bradley D. LaRonde" <brad@ltc.com>
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: LEXRA MIPS
References: <3CB68CC8.1050207@libra.seed.net.tw> <005901c1e217$058f7f20$4c00a8c0@prefect>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I insert a show_registers() into the begining of do_ri().
It seems that CPU runs into data section.

$0 : 00000000 1000fc00 00000014 00000000 00000001 00000000 00000000 00000000
$8 : 0000fc00 7fff7a78 00000000 00000002 00000000 00000000 00000000 00000002
$16: 00000004 7fff7e10 7fff7e18 00000000 100604b0 00000600 7fff7e28 00000010
$24: 810d6080 00000000                   1005e870 7fff7a58 7fff7db0 7fff7a68
Hi : 00000000
Lo : 00000000
epc  : 7fff7aa8    Not tainted
Status: 0000fc0c
Cause : 10000028
Process ping (pid: 24, stackpage=81ff2000)
Stack: 386d4381 31323100 00000000 00000000 24021000 00000000 00000000 0000fc0c
        2ab39a1c 00000000 00000000 00000000 2ab9f550 00000000 00000200 00000000
        00000000 00000000 00000003 00000000 7fff7d08 00000000 000000c0 00000000
        00000000 00000000 0000fc00 00000000 81ff0210 00000000 00000000 00000000
        00000003 00000000 00000000 00000000 00000000 00000000 00000000 00000000
        00000002 ...
Call Trace:
Code: 00000000  00000003  00000000 <7fff7d08> 00000000  000000c0  00000000 
00000000  00000000



Bradley D. LaRonde wrote:

> ----- Original Message -----
> From: "Tim Wu" <chtimwu@libra.seed.net.tw>
> To: "linux-mips" <linux-mips@oss.sgi.com>
> Sent: Friday, April 12, 2002 3:29 AM
> Subject: LEXRA MIPS
> 
> 
> 
>>I traced the kernel source and found SIGILL is sent by the exception
>>handler, do_ri().
>>
> 
> Can you tell what/where the reserved (illegal) instruction is that causes
> the trap?
> 
> Regards,
> Brad
> 
> 
> 

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f81KO0v19470
	for linux-mips-outgoing; Sat, 1 Sep 2001 13:24:00 -0700
Received: from mcp.csh.rit.edu (mcp.csh.rit.edu [129.21.60.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f81KNvd19464
	for <linux-mips@oss.sgi.com>; Sat, 1 Sep 2001 13:23:57 -0700
Received: from csh.rit.edu (unknown [129.21.60.133])
	by mcp.csh.rit.edu (Postfix) with ESMTP id 2D022288
	for <linux-mips@oss.sgi.com>; Sat,  1 Sep 2001 16:23:56 -0400 (EDT)
Message-ID: <3B913DF7.6040007@csh.rit.edu>
Date: Sat, 01 Sep 2001 15:58:47 -0400
From: George Gensure <werkt@csh.rit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips <linux-mips@oss.sgi.com>
Subject: xdm bus errors
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I got this lovely bit of alphanumericism whilst trying to run xdm. 
 Anyone have any idea how to fix this bus error?

Data bus error, epc == 8815e5c4, ra == 880c0eb0
Oops in traps.c:, line 310:
$0 : 00000000 80000000 7fff7668 7fff7668
$4 : 7fff5668 80090000 00002000 00002000
$8 : 00000000 00090000 00000000 00000003
$12: 000000b0 00002000 7fff5668 7fff5668
$16: 8d197520 ffffffea 00002000 7fff5668
$20: 00000001 00000010 10008778 10021550
$24: 00000040 80090000
$28: 8ccfc000 8ccfdef0 00000000 880c0eb0
epc   : 8815e5c4
Status: 9000fc03
Cause : 0000401c
Process xdm (pid: 164, stackpage=8ccfc000)
Stack: 8d197500 8804bb9c 00000001 00000000 00000004 8804b4b4 10008718 
2aac6000
       10008750 7fff7768 7fff76a0 00000004 000003b8 10007b10 8800f7c8 
8800f7c8
       00000001 7fff77a8 7fff7828 00000000 ffffffff 00000000 00000000 
9000fc00
       00000fa3 000000b0 00000004 7fff5668 00002000 00000400 0000fc00 
2b039164
       00000000 00000002 fffffffc 2b131cac 00000005 7fff76e0 10008750 
7fff7768
       00000001 ...
Call Trace [<8804bb9c>] [<8804b4b4>] [<8800f7c8>] [8800f7c8>]
Code: 24840010  13000045  30ca0040 <8ca80000> 8ca90004  8cab0008 
 8cac000c  ac880000 ac890004
Got a bus error IRQ, shouldn't happen yet
$0 : 00000000 9000fc01 00000001 00000000
$4 : 881c98c4 00000003 00000003 8ccfc100
$8 : 9000fc00 1000001f 00000001 07200720
$12: 07200720 00080000 881e70c0 885a6ea0
$16: 00000001 881b0000 fffffffe 9000fc00
$20: 00000001 00000010 10008778 10021550
$24: 00000000 00000010
$28: 8ccfc000 8ccfdce8 00000000 88011aec
epc   : 8802acd4
Status: 9000fc03
Cause : 00004000
Spinning...

Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4FKgHnC032542
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 13:42:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4FKgHLM032541
	for linux-mips-outgoing; Wed, 15 May 2002 13:42:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from lars.roch.silverbacksystems.com ([209.180.49.225])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4FKg5nC032535
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 13:42:06 -0700
Received: from silverbacksystems.com (mars.roch.silverbacksystems.com [10.0.0.15])
	by lars.roch.silverbacksystems.com (8.11.1/8.11.1) with ESMTP id g4FKgSU14382
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 15:42:28 -0500
Message-ID: <3CE2C834.2010302@silverbacksystems.com>
Date: Wed, 15 May 2002 15:42:28 -0500
From: Ken Aaker <kenaaker@silverbacksystems.com>
Organization: Silverback Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Mangled struct hd_driveid with MIPSEB.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've just run across an interesting problem building a big-endian MIPS 
kernel against the kernel source from the cvs tree. When the drive 
identity record is presented to the ide_fix_driveid() function in 
include/asm-mips/ide.h, it looks like its been byteswapped in 16 bit 
chunks. Needless to say, this causes a certain amount of confusion.  I 
tried following the process back to the point where the data is read in, 
but I failed to find anything that seemed to be explicitly swapping the 
code. The older kernel that I have 2.4.3 works Ok, so it's something 
that's happened recently.  Here's a little bit of debug information that 
I collected.. I messed around with the ide_fix_driveid function till I 
got the system to work, but I'm be embarassed to see that code escape 
into the wild.

This is a dump of the id record before the call to ide_fix_driveid() in 
the 2.4.3 kernel.
0000: 7a42ff3f 00001000 00e15802 3f001000   "zB.?......X.?..."
0010: 00000e00 4457572d 41435441 34343430   "....DWW.ACTA4440"
0020: 33340034 00000000 03000010 28003630   "34.4..........60"
0030: 302e4734 36304457 20434457 30334530   "0.G460DW.CDW03E0"
0040: 2d423030 50433046 20202020 20202020   ".B00PC0F........"
0050: 20202020 20202020 20202020 20201080   "................"
0060: 0000002f 01408002 00000700 ff3f1000   ".....@.......?.."
0070: 3f0010fc fb000001 80ac7e03 00000704   "?.........~....."
0080: 03007800 78007800 78000000 00000000   "..x.x.x.x......."
0090: 00000000 00000000 00000000 00000000   "................"
00a0: 3e000000 6b34014b 00406934 01080040   ">...k4.K.@i4...@"
00b0: 3f000000 00000000 00004b60 fe800000   "?.........K`...."
00c0: 00000000 00000000 00000000 00000000   "................"
00d0: 00000000 00000000 00000000 00000000   "................"
00e0: 00000000 00000000 00000000 00000000   "................"
00f0: 00000000 00000000 00000000 00000000   "................"
0100: 01000000 00000000 00003300 00000000   "..........3....."
0110: 00000000 00000000 00000000 00000000   "................"
0120: 00000000 00000000 00000000 00000000   "................"
0130: 00000000 00000000 00000000 00001f00   "................"
0140: 00000000 00000000 00000000 00000000   "................"
0150: 00000000 00000000 00000000 00000000   "................"
0160: 00000000 00000000 00000000 00000000   "................"
0170: 00000000 00000000 00000000 00000000   "................"
0180: 00000000 00000000 00000000 00000000   "................"
0190: 00000000 00000000 00000000 00000000   "................"
01a0: 00000000 00000000 00000000 00000000   "................"
01b0: 00000000 00000000 00000000 00000000   "................"
01c0: 00000000 00000000 00000000 00000000   "................"
01d0: 00000000 00000000 00000000 00000000   "................"
01e0: 00000000 00000000 00000000 00000000   "................"
01f0: 00000000 00000000 00000000 0000a56e   "...............n"

This is a dump of the id record before the call to ide_fix_drived() in 
the 2.4.18 kernel from cvs.

0000: 427a3fff 00000010 e1000258 003f0010   "Bz?........X.?.."
0010: 0000000e 57442d57 43414154 34343034   "....WD.WCAAT4404"
0020: 34333400 00000000 00031000 00283036   "434...........06"
0030: 2e303447 30365744 43205744 33303045   ".04G06WDC.WD300E"
0040: 422d3030 43504630 20202020 20202020   "B.00CPF0........"
0050: 20202020 20202020 20202020 20208010   "................"
0060: 00002f00 40010280 00000007 3fff0010   "....@.......?..."
0070: 003ffc10 00fb0100 ac80037e 00000407   ".?.........~...."
0080: 00030078 00780078 00780000 00000000   "...x.x.x.x......"
0090: 00000000 00000000 00000000 00000000   "................"
00a0: 003e0000 346b4b01 40003469 08014000   ".>..4kK.@.4i..@."
00b0: 003f0000 00000000 0000604b 80fe0000   ".?........`K...."
00c0: 00000000 00000000 00000000 00000000   "................"
00d0: 00000000 00000000 00000000 00000000   "................"
00e0: 00000000 00000000 00000000 00000000   "................"
00f0: 00000000 00000000 00000000 00000000   "................"
0100: 00010000 00000000 00000033 00000000   "...........3...."
0110: 00000000 00000000 00000000 00000000   "................"
0120: 00000000 00000000 00000000 00000000   "................"
0130: 00000000 00000000 00000000 0000001f   "................"
0140: 00000000 00000000 00000000 00000000   "................"
0150: 00000000 00000000 00000000 00000000   "................"
0160: 00000000 00000000 00000000 00000000   "................"
0170: 00000000 00000000 00000000 00000000   "................"
0180: 00000000 00000000 00000000 00000000   "................"
0190: 00000000 00000000 00000000 00000000   "................"
01a0: 00000000 00000000 00000000 00000000   "................"
01b0: 00000000 00000000 00000000 00000000   "................"
01c0: 00000000 00000000 00000000 00000000   "................"
01d0: 00000000 00000000 00000000 00000000   "................"
01e0: 00000000 00000000 00000000 00000000   "................"
01f0: 00000000 00000000 00000000 00006ea5   "..............n."



-- 
work -> kenaaker@silverbacksystems.com	(507) 289-6910 ext 1
home -> kenaaker@screaminet.com

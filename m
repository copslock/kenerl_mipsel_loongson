Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g492UBwJ021427
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 19:30:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g492UBiR021426
	for linux-mips-outgoing; Wed, 8 May 2002 19:30:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sentinel.sanera.net (ns1.sanera.net [208.253.254.10])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g492TvwJ021414
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 19:29:57 -0700
Received: from icarus.sanera.net (icarus [192.168.254.11])
	by sentinel.sanera.net (8.11.2/8.11.2) with ESMTP id g492VKu16288
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 19:31:20 -0700
Received: from exceed1.sanera.net (exceed1.sanera.net [172.16.2.31])
	by icarus.sanera.net (8.11.6/8.11.6) with SMTP id g492VFH01587
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 19:31:15 -0700
Message-Id: <200205090231.g492VFH01587@icarus.sanera.net>
Date: Wed, 8 May 2002 19:31:15 -0700 (PDT)
From: Krishna Kondaka <krishna@Sanera.net>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
Subject: Is this a /proc or kernel bug?
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: MlNmEPCKMcnxsokctwLjjQ==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.2 SunOS 5.8 sun4u sparc 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

	Here is an example proc read function which is part of my driver


static int
mydriver_proc_read(char *page, char **start, off_t off, int count, int *eof, 
void *d)
{
        uint32_t pos, len;
	
	/* Here I replaced the original code with some test code.
	   Basically, I want to write a SIZE number of bytes to 'page'
	 */
	len = SIZE;
        for (pos=0;pos<SIZE;pos++)
                page[pos] = ' '+ pos % 64;
        
        *start = page + off;
        len -= off;
        if (len <= count)
                *eof = 1;
        if (len > count)
                len = count;
        if (len < 0)
                len = 0; 
	return (len)
}

The above function works fine as long as the SIZE is lessthan 4K. If SIZE is
greater than 4K then some times I see the following kernel panic when
I try to do "cat /proc/<myfilename>"

Unhandled kernel unaligned access in unaligned.c:emulate_load_store_insn, line 
373:
$0 : 00000000 10009f00 8f20802c 48494a4b
$4 : 8f320988 00000001 00000000 00000116
$8 : 00000002 5c5d5e5f 00000000 20212223
$12: 24252627 00000025 10009f00 8f2fe116
$16: 4c4d4e4f 00000000 8f208024 00000001
$20: 8f320988 10009f01 80282998 00000001
$24: 00000001 2ac0ec10
$28: 8f226000 8f227ce8 8f227ce8 8019d938
epc    : 000000008011268c
Status : 10009f02
Cause  : 00800010

BadAddr: 0000000048494a4bProcess cat (pid: 72, stackpage=8f226000)
Stack: 801af260 0000003c 8f320000 00000000 8f320000 00000000 8f227e68 00001000
       00000000 10009f01 00000000 8f2ff150 10000238 8019d938 8011b7a8 00000000
       00000000 801cd818 8fdd3300 02000001 00000001 8027b880 00000000 8027b888
       8011b1b8 8011b1b8 80283a94 0000ee41 00000001 802a7420 8027b260 8fdd3300
       00000013 fffffffb 8010ec40 8010ebf4 00801400 b00a0020 80223744 63646566
       00080000 ...
Call Trace: [<801af260>] [<8019d938>] [<8011b7a8>] [<801cd818>] [<8011b1b8>] 
[<8011b1b8>]
 [<8010ec40>] [<8010ebf4>] [<80223744>] [<80223518>] [<801a1cc8>] [<8019d080>]
 [<8019f960>] [<801362c8>] [<8019f790>] [<8019a3d4>] [<8013c81c>] [<8013c6a8>]
 [<80128514>] [<80147ba0>] [<8010d924>] [<8010d924>]

Code: 00003021  8e100000  8c620000 <00571024> 1040002f  00000000  40116000  
36210001  38210001 
Unhandled kernel unaligned access in unaligned.c:emulate_load_store_insn, line 
373:
$0 : 00000000 10009f00 8f208014 30313233
$4 : 8f51bf5c 00000001 00000000 00000000
$8 : 8fa3f960 00000001 00001000 00002000
$12: 10009f00 00000000 00000000 00000000
$16: 34353637 8fa3faec 8f20800c 00000001
$20: 8f51bf5c 10009f01 80282998 00000001
$24: 00000000 00000001
$28: 80106000 80107cb0 80107cb0 801c85a4
epc    : 000000008011268c
Status : 10009f02
Cause  : 00800010

BadAddr: 0000000030313233Process swapper (pid: 0, stackpage=80106000)
Stack: 00000060 00000248 81617e91 8fd41a48 8fa3f960 8fa3faec 8fd4f460 8fa3f960
       8fd43044 ffffffff 00000000 0000012c 8027b9ac 801c85a4 8fa3fa1c 00000001
       8fd4f460 8fa3f960 8fa3fa1c 801ed86c 8fcf6064 801cb304 8fcf6000 8f227d70
       8fa3fa1c 00000014 8fd4f460 8fa3f960 8fd43044 00000000 00000000 0000012c
       801ef1a0 801ef168 8fd42660 8fd42660 00000068 8fd47044 8fd43030 8fd4f460
       8fd4f460 ...
Call Trace: [<801c85a4>] [<801ed86c>] [<801cb304>] [<801ef1a0>] [<801ef168>] 
[<801f89c4>]
 [<801f9050>] [<801dd32c>] [<801dd350>] [<801dbd5c>] [<801c89e4>] [<801dc188>]
 [<801dc2a0>] [<801cd658>] [<801af088>] [<801af07c>] [<801af088>] [<801af07c>]
 [<801cdb14>] [<801b0654>] [<80107eb8>] [<8011b1b8>] [<8010ec40>] [<8010ebf4>]
 [<80223744>] [<80223518>] [<80223518>] [<80107fe0>] [<80106000>] [<80107f68>]
 [<8010891c>] [<80108928>] [<80108030>] [<80227628>] [<80107d40>] [<8010078c>]

Code: 00003021  8e100000  8c620000 <00571024> 1040002f  00000000  40116000  
36210001  38210001 
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Some times the user level process "cat" panics with the same panic message.
Some times the "cat" process prints the proper messages but at the end
does segmentation fault.

I did some investigation and found that the value of "page", when the
function is entered multiple times, is different causing the statement

*start = page + off

meaningless because "page" is not always same as the "page" when called with 
off=0.
Here is the print log-
page = 8f209000 count = 3072 off = 0
page = 8f209000 count = 1024 off = 3072
page = 8f207000 count = 3072 off = 4096


Is this a bug in my code or in the kernel code?

Thanks
Krishna Kondaka
Sanera Systems Inc.

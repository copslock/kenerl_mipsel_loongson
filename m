Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 17:39:22 +0000 (GMT)
Received: from darwaza.gdatech.com ([IPv6:::ffff:66.237.41.98]:54137 "EHLO
	kings.gdatech.com") by linux-mips.org with ESMTP
	id <S8225195AbUKWRjI>; Tue, 23 Nov 2004 17:39:08 +0000
Received: from kings.gdatech.com (localhost.localdomain [127.0.0.1])
	by kings.gdatech.com (Postfix) with ESMTP id 406F461C14F
	for <linux-mips@linux-mips.org>; Tue, 23 Nov 2004 09:35:14 -0800 (PST)
X-Propel-Return-Path: <gmuruga@gdatech.com>
Received: from kings.gdatech.com ([192.168.200.118])
	by localhost.localdomain ([127.0.0.1]) (port 7027) (Propel SE relay 0.1.0.1557 $Rev$)
	id r4bW093514-1946-1
	for linux-mips@linux-mips.org; Tue, 23 Nov 2004 09:35:14 -0800
Received: from sierra.gdatech.com (asg_mda [192.168.200.112])
	by kings.gdatech.com (Postfix) with ESMTP id 23A6761C13E
	for <linux-mips@linux-mips.org>; Tue, 23 Nov 2004 09:35:14 -0800 (PST)
Received: (from nobody@localhost)
	by gdatech.com (8.11.6/8.11.6) id iANHZuM12372;
	Tue, 23 Nov 2004 09:35:56 -0800
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: gdatech.com
Date: Tue, 23 Nov 2004 09:35:56 -0800
Message-Id: <200411231735.iANHZuM12372@gdatech.com>
X-Authentication-Warning: sierra.gdatech.com: nobody set sender to gmuruga@gdatech.com using -f
From: "Muruga Ganapathy" <gmuruga@gdatech.com>
To: linux-mips@linux-mips.org
Cc: gmuruga@gdatech.com
Subject: MTD support in 2.6.6
X-Mailer: NeoMail 1.25
X-IPAddress: 63.111.213.196
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-Path: <gmuruga@gdatech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gmuruga@gdatech.com
Precedence: bulk
X-list: linux-mips

Hello,    
   
I am curently working on to include to MTD support for a mips based    
platform. I am using Intel Starta flash TE28F128J3 ( 16 MB ) and it  
used in 16 bit mode.  
  
Physical address of the flash = 0x1c000000  
Size = 0x1000000  
   
    
When I included the MTD support through the menuconfig and enabled the    
debug level 3, I am getting the following messages.    
   
I am able to create the device using mknod /dev/mtd0 c 90 0.   
  
Issue:  
  
Even though the debug output looks fine ( pl correct me if I am worng  
) , it looks to me that the cfi commands are not getting into the  
flash. Because the base address is 0x0. The base address is used for 
sending commands to the flash. It is referenced in the file 
 
file: cfi_cmdset0001.c 
function: cfi_cmdset_0001   
variable name: __u32 base = cfi->chips[0].start   
  
Should this base address be other than 0? 
 
Please let me know ? 
 
Also do let me know if I need to apply patches for the 2.6.6 kernel  
for the MTD support? 
 
 
Looking forward to hear from you. 
 
Regards 
G.Muruganandam 
 
  
/************** Debug console output *********************/  
  
:Alternative Vendor Command Set: 0000 (None)   
0:No Alternate Algorithm Table   
0:Vcc Minimum: 2.7 V   
0:Vcc Maximum: 3.6 V   
0:No Vpp line   
0:Typical byte/word write timeout: 256 ^[%/1Â~@Â~Liso8859-15^BÂµs   
0:Maximum byte/word write timeout: 1024 ^[%/1Â~@Â~Liso8859-15^BÂµs   
0:Typical full buffer write timeout: 256 ^[%/1Â~@Â~Liso8859-15^BÂµs   
0:Maximum full buffer write timeout: 1024 ^[%/1Â~@Â~Liso8859-15^BÂµs   
0:Typical block erase timeout: 2048 ms   
0:Maximum block erase timeout: 16384 ms   
0:Chip erase not supported   
0:Device size: 0x1000000 bytes (16 MiB)   
0:Flash Device Interface description: 0x0002   
0:  - supports x8 and x16 via BYTE# with asynchronous interface   
0:Max. bytes in buffer write: 0x20   
0:Number of Erase Block Regions: 1   
0:  Erase Region #0: BlockSize 0x20000 bytes, 128 blocks   
0:  Feature/Command Support: 00CE   
0:     - Chip Erase:         unsupported   
0:     - Suspend Erase:      supported   
0:     - Suspend Program:    supported   
0:     - Legacy Lock/Unlock: supported   
0:     - Queued Erase:       unsupported   
0:     - Instant block lock: unsupported   
0:     - Protection Bits:    supported   
0:     - Page-mode read:     supported   
0:     - Synchronous read:   unsupported   
0:  Supported functions after Suspend: 01   
0:     - Program after Erase Suspend: supported   
  Vcc Logic Supply Optimum Program/Erase Voltage: 0.3 V   
0:<5>cfi_cmdset_0001: Erase suspend on write enabled   
0:<7>number of CFI chips: 1   
0:<7>0: offset=0x0,size=0x20000,blocks=128   
0:<6>Using buffer write method   
0:<5>cmdlinepart partition parsing not available   
0:<5>RedBoot partition parsing not available   
0:<6>mtd: Giving out device 0 to Physically mapped flash   
   

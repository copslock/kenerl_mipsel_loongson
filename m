Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2N8j4207222
	for linux-mips-outgoing; Sat, 23 Mar 2002 00:45:04 -0800
Received: from ms45.hinet.net (root@ms45.hinet.net [168.95.4.45])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2N8isq07219
	for <linux-mips@oss.sgi.com>; Sat, 23 Mar 2002 00:44:55 -0800
Received: from sam (61-220-89-134.HINET-IP.hinet.net [61.220.89.134])
	by ms45.hinet.net (8.8.8/8.8.8) with SMTP id QAA04899;
	Sat, 23 Mar 2002 16:47:06 +0800 (CST)
From: "Y.H. Ku" <iskoo@ms45.hinet.net>
To: "Marc Karasek" <marc_karasek@ivivity.com>, <linux-mips@oss.sgi.com>
Subject: RE: BootLoader on MIPS
Date: Sat, 23 Mar 2002 16:42:41 +0800
Message-ID: <NGBBILOAMLLIJMLIOCADAELACCAA.iskoo@ms45.hinet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <25369470B6F0D41194820002B328BDD2195BD9@ATLOPS>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by oss.sgi.com id g2N8iuq07220
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi everybody,

I trace PMON into mips.S, and find the entry "_go".
the entry transfer control to client prog.

I am confused of what information PMON transfer to MIPS's BOOTLOADER
and transfer to which entry point of BOOTLOADER.

I found the bd_t struct of PPCBOOT.h for PPCBOOT package on POWERPC platform.
It is corresponding POWERPC-LINUX data structure bd_info in ~/include/asm/mbx.h 
(register r3~r7)

I just can not find the entry for MIPS's one. (can not find corresponding baget.h's one)

Could anybody tell me what is the information (register inforation) PMON transfer
to bootloader?

Or anybody can disscuss with me,

best regards,
--sam

-----Original Message-----
From: owner-linux-mips@oss.sgi.com
[mailto:owner-linux-mips@oss.sgi.com]On Behalf Of Marc Karasek
Sent: Friday, March 22, 2002 9:21 PM
To: 'Y.H. Ku'; linux-mips@oss.sgi.com
Subject: RE: BootLoader on MIPS


YAMON is prob the default right now.  It has support for loading a kernel
over tftp.  

I do not think it is OS though.  I maybe wrong, I will have to check the
source I have to see if it is or not.  I am currently adding  BOOTP support
to it, along with some other options.  If it is OS, then I will be providing
these back to the community.

/*******************************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
Ph: 678-990-1550 x238
Fax: 678-990-1551
email: marc_karasek@ivivity.com
/*******************************************


-----Original Message-----
From: Y.H. Ku [mailto:iskoo@ms45.hinet.net]
Sent: Friday, March 22, 2002 3:16 AM
To: linux-mips@oss.sgi.com
Subject: BootLoader on MIPS


Hello there,

I am trying to porting Prom monitor code to
appropriate MIPS bootloader for loading Linux kernel

I ever make a test sucessfully with ppcboot's to load MBXloader
for transfering control to linux kernel (hardhat).

But I can not find the entry, and make decision what kind of BOOT LOADER
to use on MIPS platform.

I have the ddb5476 board type linux from montavista,
Could anybody give me some suggestion?

--Sam

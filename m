Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2MDJbD20965
	for linux-mips-outgoing; Fri, 22 Mar 2002 05:19:37 -0800
Received: from mail.ivivity.com ([64.238.111.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2MDJTq20959
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 05:19:29 -0800
Received: by ATLOPS with Internet Mail Service (5.5.2653.19)
	id <HH5FFCP4>; Fri, 22 Mar 2002 08:21:52 -0500
Message-ID: <25369470B6F0D41194820002B328BDD2195BD9@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
To: "'Y.H. Ku'" <iskoo@ms45.hinet.net>, linux-mips@oss.sgi.com
Subject: RE: BootLoader on MIPS
Date: Fri, 22 Mar 2002 08:20:50 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1D1A4.62EAC7C0"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1D1A4.62EAC7C0
Content-Type: text/plain;
	charset="big5"

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


------_=_NextPart_000_01C1D1A4.62EAC7C0
Content-Type: application/octet-stream;
	name="Marc Karasek.vcf"
Content-Disposition: attachment;
	filename="Marc Karasek.vcf"

BEGIN:VCARD
VERSION:2.1
N:Karasek;Marc
FN:Marc Karasek
ORG:Ivivity
TITLE:Senior Software Engineer
NOTE:Senior Software Engineer
TEL;WORK;VOICE:210
ADR;WORK:;Atlanta
LABEL;WORK:Atlanta
EMAIL;PREF;INTERNET:marc_karasek@ivivity.com
REV:20011130T233616Z
END:VCARD

------_=_NextPart_000_01C1D1A4.62EAC7C0--

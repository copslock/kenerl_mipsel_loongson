Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBE1uFL09343
	for linux-mips-outgoing; Thu, 13 Dec 2001 17:56:15 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBE1u6o09340
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 17:56:08 -0800
Received: by ATLOPS with Internet Mail Service (5.5.2448.0)
	id <QMJC3F5J>; Thu, 13 Dec 2001 19:55:44 -0500
Message-ID: <25369470B6F0D41194820002B328BDD2195AE2@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
To: "'Krishna Kondaka '" <krishna@Sanera.net>,
   "'linux-mips@oss.sgi.com '"
	 <linux-mips@oss.sgi.com>
Subject: RE: No bzImage target for MIPS
Date: Thu, 13 Dec 2001 19:55:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The support for decompression of a bzImage image is not supported in the
MIPS kernel.  If you do just a "make zImage" I believe this will get you a
"zipped" image file.    

-----Original Message-----
From: Krishna Kondaka
To: linux-mips@oss.sgi.com
Sent: 12/13/01 7:47 PM
Subject: No bzImage target for MIPS

Hi,

	There is no "bzImage" target in the mips linux Makefiles. Could
	you tell me why this is missing? If I want to generate a 
	compressed image for linux on MIPS, how do I do it?

Thanks
Krishna

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6QL3S118529
	for linux-mips-outgoing; Thu, 26 Jul 2001 14:03:28 -0700
Received: from server3.toshibatv.com ([207.152.29.75])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6QL3RV18523
	for <linux-mips@oss.sgi.com>; Thu, 26 Jul 2001 14:03:27 -0700
Received: by SERVER3 with Internet Mail Service (5.5.2650.21)
	id <3MTR1R8M>; Thu, 26 Jul 2001 16:03:15 -0500
Message-ID: <7DF7BFDC95ECD411B4010090278A44CA0A3BC1@ATVX>
From: "Siders, Keith" <keith_siders@toshibatv.com>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Linux 2.4.6
Date: Thu, 26 Jul 2001 16:02:04 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've made changes to the plain vanilla Linux 2.4.6 to port to our TX49H2
core on one of our EVB's. Which version of the compiler and binutils should
I use? The binutils-xx-2.8.1-2 and egcs-xx-1.1.2-4 worked for the 2.2.19
port, but I'm getting errors in the shell scripts when I run 'make config'.
I get the same errors with the same tools with the generic 2.4.6 as well.
Looks like

bash-2.04$ cd linux
bash-2.04$ make config
rm -f include/asm
( cd include ; ln -sf asm-mips asm)
/bin/sh scripts/Configure arch/mips/config.in
: command not found
'cripts/Configure: line 68: syntax error near unexpected token `{
'cripts/Configure: line 68: `function mainmenu_option () {
make: *** [config] Error 2
bash-2.04$

Not sure where to go from here as the scripts didn't change significantly
between 2.2.19 and 2.4.6.

Keith Siders
Software Engineer
 Toshiba America Consumer Products, Inc.
Advanced Television Technology Center
801 Royal Parkway, Suite 100
Nashville, Tennessee 37214
Phone: (615) 257-4050
Fax:   (615) 453-7880

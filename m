Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0GK5cw15934
	for linux-mips-outgoing; Wed, 16 Jan 2002 12:05:38 -0800
Received: from galileo5.galileo.co.il (pop3.galileo.co.il [199.203.130.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0GK5WP15926
	for <linux-mips@oss.sgi.com>; Wed, 16 Jan 2002 12:05:33 -0800
Received: from galileo.co.il (linux2.galileo.co.il [10.2.40.2])
	by galileo.co.il (8.8.5/8.8.5) with ESMTP id VAA22281
	for <linux-mips@oss.sgi.com>; Wed, 16 Jan 2002 21:04:34 +0200 (GMT-2)
Message-ID: <3C45CE3B.6080507@galileo.co.il>
Date: Wed, 16 Jan 2002 21:02:19 +0200
From: Rabeeh Khoury <rabeeh@galileo.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Compilers question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All,

This is not MIPS Linux issue, but I couldn't find out a better place to 
post it :)

I have an application I'v compiled with certain toolchain (for MIPS and 
other targets), and I want to distribute the application in binary (no 
loadable modules or dynamic linked libraries, just plain C files with 
headers files that gives out certain API - sort of a low level driver 
for hardware access only).

What I need to know, is how I can make sure that when another person 
gets my binaries he can link them with his application and work well ?

The factors that I can identify till now are two -
1.. Distribute the binary in ELF format (are there any compilers that
don't support ELF ? )
2.. Compile the binary that it is ABI compliant

Please add more factors that should be checked, or even suggest another 
approach to overcome this problem (other than I get the other person 
tool chain and compile the sources myself).

Thank you a lot,
Rabeeh

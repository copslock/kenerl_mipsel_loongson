Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f99L37723898
	for linux-mips-outgoing; Tue, 9 Oct 2001 14:03:07 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f99L35D23895
	for <linux-mips@oss.sgi.com>; Tue, 9 Oct 2001 14:03:05 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 9 Oct 2001 21:04:31 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id OAA16648
	for <linux-mips@oss.sgi.com>; Tue, 9 Oct 2001 14:01:41 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id QAA13848; Tue, 9 Oct 2001 16:01:14 -0500
Message-ID: <3BC36684.6020609@esstech.com>
Date: Tue, 09 Oct 2001 16:05:08 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: VisionClick debugger with Linux kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Has anyone used the Wind River VisionClick debugger with the Linux kernel?
I'm using this debugger and works great except it thinks that the symbols
for some files start at address zero instead of the proper offset.  Has anyone
else seen this and were you able to get it to work?  I'm using the latest tools
from:

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/RPMS/i386/toolchain-mips-20010830-1.i386.rpm

I can't find any differences between the files that work and the files that
don't work and the symbols look correct in the System.map file.

Yeah, I'm working with Wind River, but I haven't gotten a solution yet.
You know how that 8-5 centralized corporate support is though. :)

Thanks!

Gerald

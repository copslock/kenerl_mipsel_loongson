Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8T1PXb25630
	for linux-mips-outgoing; Fri, 28 Sep 2001 18:25:33 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8T1PVD25627
	for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 18:25:31 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 29 Sep 2001 01:26:47 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id SAA01579
	for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 18:24:08 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id UAA02604; Fri, 28 Sep 2001 20:24:10 -0500
Message-ID: <3BB5237F.9080203@esstech.com>
Date: Fri, 28 Sep 2001 20:27:27 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: link error with ramdisk file
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm getting the following error when creating a ramdisk on a big endian system:

$ mips-linux-ld -T ld.script -b binary -o ramdisk.o ramdisk.gz
mips-linux-ld: ramdisk.gz: compiled for a little endian system and target is big 
endian
File in wrong format: failed to merge target specific data of file ramdisk.gz


I get the same error regardless of what I use for the input file.  I don't 
understand how this linker error can occur when the input file format is binary.
Isn't the linker just ignoring the contents of the input file with the
"-b binary" option?

Thanks!

Gerald

Received:  by oss.sgi.com id <S553830AbQKRB1h>;
	Fri, 17 Nov 2000 17:27:37 -0800
Received: from gw-us4.philips.com ([63.114.235.90]:18692 "EHLO convert rfc822-to-8bitom.com
        gw-us4.philips.com") by oss.sgi.com with ESMTP id <S553827AbQKRB1c>;
	Fri, 17 Nov 2000 17:27:32 -0800
Received: from smtprelay-us2.philips.com (localhost.philips.com [127.0.0.1])
          by gw-us4.philips.com with ESMTP id TAA10357;
          Fri, 17 Nov 2000 19:27:14 -0600 (CST)
          (envelope-from rajesh.palani@philips.com)
From:   rajesh.palani@philips.com
Received: from smtprelay-nam2.philips.com(167.81.233.16) by gw-us4.philips.com via mwrap (4.0a)
	id xma010355; Fri, 17 Nov 00 19:27:14 -0600
Received: from AMLMS01.DIAMOND.PHILIPS.COM (amlms01sv1.diamond.philips.com [161.88.79.213]) 
	by smtprelay-us2.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id TAA07906; Fri, 17 Nov 2000 19:27:13 -0600 (CST)
Received: by AMLMS01.DIAMOND.PHILIPS.COM (Soft-Switch LMS 4.0) with snapi
          via AMEC id 0056910008698539; Fri, 17 Nov 2000 19:28:50 -0600
To:     <linux-mips@oss.sgi.com>, <linux-mips@fnet.fr>
Subject: sysmips syscall
Message-ID: <0056910008698539000002L192*@MHS>
Date:   Fri, 17 Nov 2000 19:28:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; name="MEMO 11/17/00 19:26:59"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,

   The following lines appear in the linuxthreads/sysdeps/mips/pt-machine.h file in version
LinuxThreads 2.1.2:

TODO: This version makes use of MIPS ISA 2 features.  It won't
   work on ISA 1.  These machines will have to take the overhead of
   a sysmips(MIPS_ATOMIC_SET, ...) syscall which isn't implemented
   yet correctly.  There is however a better solution for R3000
   uniprocessor machines possible.

My questions are:
1.  Is the sysmips syscall implemented correctly yet?
2.  What is the better solution for R3000 uniprocessor machines?
3.  Does anyone have a patch for LinuxThreads that supports MIPS ISA 1?

   Thanks and regards,

   Rajesh 

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f79CdnE18985
	for linux-mips-outgoing; Thu, 9 Aug 2001 05:39:49 -0700
Received: from animal.pace.co.uk (gateway.pace.co.uk [195.44.197.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f79CdlV18970
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 05:39:48 -0700
Received: from exchange1.cam.pace.co.uk (exchange1.cam.pace.co.uk [136.170.131.80])
	by animal.pace.co.uk (8.10.2/8.10.2) with ESMTP id f79CdcQ10419
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 13:39:38 +0100
Received: by exchange1.cam.pace.co.uk with Internet Mail Service (5.5.2650.21)
	id <QQGSKWDL>; Thu, 9 Aug 2001 13:39:37 +0100
Message-ID: <54045BFDAD47D5118A850002A5095CC30AC570@exchange1.cam.pace.co.uk>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RM5231A Cause Register Values
Date: Thu, 9 Aug 2001 13:39:36 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In my low level assembler interrupt handler I'm detecting a Cause register
value of 0x00800000. According to "See MIPS Run", the bit that is set should
be zero - but I haven't been able to find any RM5231A documentation that
defines this bit as anything else.  Any ideas?

BTW, the exception is raised under fairly heavy network traffic and in
either disable_irq_nosync() or ei_start_xmit(). The latter is in the network
card driver and itself contains a call to disable_irq_nosync(). I don't
believe (although I may be wrong) that this was happening under the old
style interrupt code.

Thanks,
Phil

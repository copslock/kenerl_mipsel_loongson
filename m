Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9J0vaZ10382
	for linux-mips-outgoing; Thu, 18 Oct 2001 17:57:36 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9J0vXD10379
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 17:57:33 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 19 Oct 2001 00:59:07 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id RAA24872
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 17:56:05 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id TAA24559; Thu, 18 Oct 2001 19:55:18 -0500
Message-ID: <3BCF7AD2.2000000@esstech.com>
Date: Thu, 18 Oct 2001 19:58:58 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Moving kernel_entry to LOADADDR
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm planning to work with a very minimal boot loader, and I'd like
to hard-code a jump to kernel_entry in my boot loader.  I got tired
of having kernel_entry moving around, so I just moved it to the top
of head.S, just afte the ".fill 0x280".  That places kernel_entry at
the same place every time.  It's always at LOADADDR+0x280.

But wait a minute... the 0x280 is there to leave room for the exception
vectors.  Doesn't that only make sense if LOADADDR=0x80000000?  Isn't
this allocating the space for the exception vectors twice?  Why not
remove the .fill, then the kernel entry point will always be exactly
LOADADDR?  This would break any configuration that has LOADADDR=0x80000000,
but the only configuration like that is CONFIG_ALGOR_P4032, and that could
easily be modified to LOADADDR=0x80000280 to get the same effect.

I also removed the .fill, and now kernel_entry is always exactly LOADADDR,
and that makes my bootloader easier to maintain.

Is this worth changing in cvs, or did I miss something?

Thanks.

Gerald

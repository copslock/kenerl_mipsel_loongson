Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94JdBZ21222
	for linux-mips-outgoing; Thu, 4 Oct 2001 12:39:11 -0700
Received: from [64.152.86.3] (unknown.Level3.net [64.152.86.3] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94Jd8D21219
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 12:39:08 -0700
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 4 Oct 2001 19:40:29 UT
Received: from bud.austin.esstech.com ([193.5.206.3])
	by mail.esstech.com (8.8.8+Sun/8.8.8) with SMTP id MAA00203
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 12:37:45 -0700 (PDT)
Received: from esstech.com by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id OAA00565; Thu, 4 Oct 2001 14:37:31 -0500
Message-ID: <3BBCBB6B.6080809@esstech.com>
Date: Thu, 04 Oct 2001 14:41:31 -0500
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Debugging symbols from gcc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm trying to use a Wind River VisionProbe debugger with the
Linux kernel, but I can't get the compiler to generate the symbols
in the proper format.  The debugger works with an old compiler
that places the symbols in sections called ".stab" and ".stabstr".
It doesn't work with the newer compiler that places the symbols
in a section called ".mdebug" (which I think is specific to sgi).

The version that creates .stab/.stabstr sections is:
$ /usr/local/sde4/bin/gcc --version egcs-2.90.23 980102 (egcs-1.0.1 release)

The version that creates .mdebug sections is:
$ /usr/bin/mips-linux-gcc --version egcs-2.91.66

Is there a way to specify the output format of the debug symbols?  I've
seen documentation that references a -gstabs option, but that doesn't
seem to work.  Should I be using a different version of the compiler?
I'm just using the rpm's that were on the sgi site.

Thanks.

Gerald

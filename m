Received:  by oss.sgi.com id <S42327AbQFBOtQ>;
	Fri, 2 Jun 2000 07:49:16 -0700
Received: from gatekeep.ti.com ([192.94.94.61]:40943 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S42275AbQFBOtE>;
	Fri, 2 Jun 2000 07:49:04 -0700
Received: from dlep7.itg.ti.com ([157.170.134.103])
	by gatekeep.ti.com (8.10.1/8.10.1) with ESMTP id e52EnfL26965
	for <linux-mips@oss.sgi.com>; Fri, 2 Jun 2000 09:49:41 -0500 (CDT)
Received: from dlep7.itg.ti.com (localhost [127.0.0.1])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id JAA02943
	for <linux-mips@oss.sgi.com>; Fri, 2 Jun 2000 09:49:33 -0500 (CDT)
Received: from dlep4.itg.ti.com (dlep4.itg.ti.com [157.170.188.63])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id JAA02928
	for <linux-mips@oss.sgi.com>; Fri, 2 Jun 2000 09:49:33 -0500 (CDT)
Received: from ti.com (IDENT:jharrell@reddwarf.sc.ti.com [128.247.117.210])
	by dlep4.itg.ti.com (8.9.3/8.9.3) with ESMTP id JAA08682
	for <linux-mips@oss.sgi.com>; Fri, 2 Jun 2000 09:49:40 -0500 (CDT)
Message-ID: <3937C998.5CD7BE81@ti.com>
Date:   Fri, 02 Jun 2000 08:50:00 -0600
From:   Jeff Harrell <jharrell@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Symbol generation with cross compiler tools
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I would like to run a quick question past this news group. I am seeing
problems
with symbol generation on the mipsel cross compilation tools.  I am
using the XRAY debugger
with a Macgraigor EJTAG pod on a MIPS R4Kc (jade) core.  The XRAY
documentation says that it
should be able to recognize the symbols in an ELF executable.  The mips
tools (Cygnus GCC 2.9.x) that is
shipped with the development system has no problem generating symbols
that the XRAY debugger can recognize.  When I attempt to do  a similar
test with the SGI cross compiler tools, XRAY doesn't
recognize any of the symbols.  Here are the versions of the
cross-compiler tools that I am currently using...


       binutils-mipsel-linux-2.8.1-1
       egcs-mipsel-linux-1.0.3a-1
       egcs-c++-mipsel-linux-1.0.3a-1
       egcs-libstdc++-mipsel-linux-2.8.0-1
       egcs-objc-mipsel-linux-1.0.3a-1
       egcs-g77-mipsel-linux-1.0.3a-1


I am using the "-g" command to generate debugging information.

I appreciate any information that anyone might have on similar
situations.  Thank you in advance

Jeff Harrell

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jeff Harrell                    Work:  (801) 619-6104
Broadband Access group/TI
jharrell@ti.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

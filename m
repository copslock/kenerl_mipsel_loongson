Received:  by oss.sgi.com id <S42253AbQFBTba>;
	Fri, 2 Jun 2000 12:31:30 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:27920 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQFBTa4>; Fri, 2 Jun 2000 12:30:56 -0700
Received: from kilimanjaro.engr.sgi.com (kilimanjaro.engr.sgi.com [163.154.5.32]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA05377
	for <linux-mips@oss.sgi.com>; Fri, 2 Jun 2000 13:35:06 -0700 (PDT)
	mail_from (wombat@kilimanjaro.engr.sgi.com)
Received: from kilimanjaro.engr.sgi.com (localhost [127.0.0.1]) by kilimanjaro.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA65689; Fri, 2 Jun 2000 13:28:59 -0700 (PDT)
Message-Id: <200006022028.NAA65689@kilimanjaro.engr.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Symbol generation with cross compiler tools 
In-reply-to: Your message of "Fri, 02 Jun 2000 08:50:00 MDT."
Date:   Fri, 02 Jun 2000 13:28:58 -0700
From:   Joan Eslinger <wombat@kilimanjaro.engr.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I asked one of the compiler guys, and he said the "SGI cross compilers"
are also made by Cygnus. He also said

   This customer would need to know where in the executable
   the symbols are read for XRAY and then see if that section
   exists in the mips targeted executable.

In particular, some tools generate .symtab and/or .dynstr sections with
symbols, and other tools only read one or the other of those
sections. He though you were probably missing a .symtab section in your
object.

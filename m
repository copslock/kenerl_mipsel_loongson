Received:  by oss.sgi.com id <S553694AbRAZKYD>;
	Fri, 26 Jan 2001 02:24:03 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:62699 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553692AbRAZKXk>;
	Fri, 26 Jan 2001 02:23:40 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA09495;
	Fri, 26 Jan 2001 11:21:43 +0100 (MET)
Date:   Fri, 26 Jan 2001 11:21:43 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Ralf Baechle <ralf@oss.sgi.com>, Joe deBlaquiere <jadb@redhat.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
In-Reply-To: <3A70CA98.102@redhat.com>
Message-ID: <Pine.GSO.3.96.1010126111156.8903B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 25 Jan 2001, Joe deBlaquiere wrote:

> So I've got the following code which seems to work... (I can't use the 
> ll/sc ops on the Vr41xx since they are not implemeted!)
> 
> #ifdef CONFIG_CPU_VR41XX

 You are perfectly correct, with the exception you really want to make it: 

#ifndef CONFIG_CPU_HAS_LLSC

as that's the correct option -- just undef it in arch/mips/config.in for
your CPU like it's done for others already.

 Shame on me I haven't sent the patch for MIPS_ATMIC_SET for non-ll/sc
processors yet.  I have it but it needs a few minor cleanups.

 Ralf, BTW, what do you think if we send a segfault on a memory access
violation instead of returning an error?  That would make the behaviour of
MIPS_ATMIC_SET consistent for any memory contents.  Does anything actually
rely on the function to return an error in such a situation? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

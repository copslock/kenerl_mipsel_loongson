Received:  by oss.sgi.com id <S42302AbQHBXMx>;
	Wed, 2 Aug 2000 16:12:53 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:2635 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42290AbQHBXMa>;
	Wed, 2 Aug 2000 16:12:30 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA00891
	for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 16:04:25 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA93251
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Aug 2000 16:11:34 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04382
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Aug 2000 16:11:07 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id QAA30268;
	Wed, 2 Aug 2000 16:10:43 -0700
Message-ID: <3988AA72.5C342E1D@mvista.com>
Date:   Wed, 02 Aug 2000 16:10:43 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr, ralf@oss.sgi.com
Subject: Re: PROPOSAL : multi-way cache support in Linux/MIPS
References: <027f01bffcd3$3279b800$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


That certainly helps a lot.  Thanks, Kevin.


"Kevin D. Kissell" wrote:
...
> 
> So, to get back to Linux, a MIPS32 part can *almost*
> run the standard MIPS R4K kernel.  Almost.  What had

Still one more question.  If I understand correctly, the 4Km and 4Kp are
MIPS32 CPUs.  However, they don't have TLBs.  Right?  Without TLBs, I
don't suppose Linux will run ...

Jun

Received:  by oss.sgi.com id <S42290AbQHBXfY>;
	Wed, 2 Aug 2000 16:35:24 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:12370 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42245AbQHBXfG>;
	Wed, 2 Aug 2000 16:35:06 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA03693
	for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 16:27:01 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA89506 for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 16:34:03 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA99875
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Aug 2000 16:32:30 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-100.karlsruhe.ipdial.viaginterkom.de (u-100.karlsruhe.ipdial.viaginterkom.de [62.180.19.100]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA08996
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Aug 2000 16:32:25 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869096AbQHBXbz>;
        Thu, 3 Aug 2000 01:31:55 +0200
Date:   Thu, 3 Aug 2000 01:31:55 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: PROPOSAL : multi-way cache support in Linux/MIPS
Message-ID: <20000803013155.A2097@bacchus.dhis.org>
References: <027f01bffcd3$3279b800$0deca8c0@Ulysses> <3988AA72.5C342E1D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3988AA72.5C342E1D@mvista.com>; from jsun@mvista.com on Wed, Aug 02, 2000 at 04:10:43PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Aug 02, 2000 at 04:10:43PM -0700, Jun Sun wrote:

> > So, to get back to Linux, a MIPS32 part can *almost*
> > run the standard MIPS R4K kernel.  Almost.  What had
> 
> Still one more question.  If I understand correctly, the 4Km and 4Kp are
> MIPS32 CPUs.  However, they don't have TLBs.  Right?  Without TLBs, I
> don't suppose Linux will run ...

There is ``Microcontroller Linux'' aka uclinux available at www.uclinux.org.
It could be ported to TLB-less processors.  You'd loose some of the
important functionality of the standard Linux, including some source
compatibility.

  Ralf

Received:  by oss.sgi.com id <S42272AbQG1CXx>;
	Thu, 27 Jul 2000 19:23:53 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:12855 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42222AbQG1CXr>;
	Thu, 27 Jul 2000 19:23:47 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA11095
	for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 19:16:22 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id TAA49800 for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 19:23:23 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA83888
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Jul 2000 19:21:51 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-151.karlsruhe.ipdial.viaginterkom.de (u-151.karlsruhe.ipdial.viaginterkom.de [62.180.19.151]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA05564
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Jul 2000 19:21:49 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868872AbQG1CVJ>;
        Fri, 28 Jul 2000 04:21:09 +0200
Date:   Fri, 28 Jul 2000 04:21:09 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: strace on Linux/MIPS?
Message-ID: <20000728042109.C1981@bacchus.dhis.org>
References: <3980C024.8DCCA084@mvista.com> <20000727161212.B12897@chem.unr.edu> <3980C9F0.96B48253@mvista.com> <20000728021137.B1328@bacchus.dhis.org> <3980EC1C.AEF173D2@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3980EC1C.AEF173D2@mvista.com>; from jsun@mvista.com on Thu, Jul 27, 2000 at 07:12:44PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jul 27, 2000 at 07:12:44PM -0700, Jun Sun wrote:

> I just updated offset.c and scall_o32.S.  After a trial change ("nice"
> -> "priority") in offset.c, strace seems to work fine now.
> 
> However, I did notice an error message for mmap(...).
> 
> mmap(ptrace: umoven: Input/output error
> ptrace: umoven: Input/output error
> )                                  = 717291520

Looks like strace is still tryping to copy mmap_arg_struct like on Intel
but on MIPS we don't use that?

> Keith, if you want the patch for strace 4.2, I can send it to you.  

  Ralf

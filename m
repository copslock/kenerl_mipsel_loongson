Received:  by oss.sgi.com id <S554117AbRAZVS6>;
	Fri, 26 Jan 2001 13:18:58 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:28283 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S554114AbRAZVSr>;
	Fri, 26 Jan 2001 13:18:47 -0800
Received: from dhcp-163-154-5-240.engr.sgi.com ([163.154.5.240]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA05862
	for <linux-mips@oss.sgi.com>; Fri, 26 Jan 2001 13:18:45 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869667AbRAZVPN>; Fri, 26 Jan 2001 13:15:13 -0800
Date: 	Fri, 26 Jan 2001 13:15:03 -0800
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Joe deBlaquiere <jadb@redhat.com>, Florian Lohoff <flo@rfc822.org>,
        linux-mips@oss.sgi.com
Subject: Re: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
Message-ID: <20010126131503.H869@bacchus.dhis.org>
References: <3A70CA98.102@redhat.com> <Pine.GSO.3.96.1010126111156.8903B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010126111156.8903B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jan 26, 2001 at 11:21:43AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 11:21:43AM +0100, Maciej W. Rozycki wrote:

>  Ralf, BTW, what do you think if we send a segfault on a memory access
> violation instead of returning an error?  That would make the behaviour of
> MIPS_ATMIC_SET consistent for any memory contents.  Does anything actually
> rely on the function to return an error in such a situation? 

Afaik the only user of MIPS_ATOMIC_SET ever running on Linux/MIPS is the
Linuxthreads code you wrote, so no.  Aside of that the semantics of this
syscall were defined by older MIPS operating systems such as Risc/OS and
I think we should follow their example.

  Ralf

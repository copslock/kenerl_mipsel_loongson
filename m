Received:  by oss.sgi.com id <S305172AbQEPObX>;
	Tue, 16 May 2000 14:31:23 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:34630 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305161AbQEPObE>;
	Tue, 16 May 2000 14:31:04 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA03925; Tue, 16 May 2000 07:26:14 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id HAA33203; Tue, 16 May 2000 07:29:19 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA32725
	for linux-list;
	Tue, 16 May 2000 07:19:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA72490
	for <linux@engr.sgi.com>;
	Tue, 16 May 2000 07:19:34 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA03853
	for <linux@engr.sgi.com>; Tue, 16 May 2000 07:19:33 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-10.uni-koblenz.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id QAA18283;
	Tue, 16 May 2000 16:19:20 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403840AbQEPLgU>;
	Tue, 16 May 2000 13:36:20 +0200
Date:   Tue, 16 May 2000 13:36:20 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: HELP : ptrace returns puzzling results
Message-ID: <20000516133620.C4561@uni-koblenz.de>
References: <392045FC.827CACB5@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <392045FC.827CACB5@mvista.com>; from jsun@mvista.com on Mon, May 15, 2000 at 11:46:20AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 15, 2000 at 11:46:20AM -0700, Jun Sun wrote:

> I am writing a gdbserver for linux/mips.  The server can now talk with
> the gdb client, and can run to completion if you press 'c'.

Excellent.

> However, the gdb client reads some confusing register values.  I traced
> back to the gdbserver and found out that these values are returned from
> ptrace(), which seem wrong.  On the other hand, the native gdb must be
> using the same ptrace() to get register values.  I wonder why it works
> there.
> 
> Here is a sample output from gdbserver calling ptrace.  Note that PC
> value does not corresponds to the executable image.  sp also seems
> wrong.

> reg #29 ($29,sp) = 2147483120 (0x7ffffdf0)

The value of sp looks sane, it a value near the absolute top of the stack
at 0x80000000.

> reg #37 ($64,pc) = 263607008 (0x0fb652e0)

Also looks sane at first look, this value is in the typical address range
where the dynamic linker gets mapped.

Many of the registers in the dump you gave have a value of zero and that is
worrying me much more.  All the caller saved registers are zero, that
smells.

What kernel version are you using?

  Ralf

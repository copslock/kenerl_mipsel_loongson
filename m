Received:  by oss.sgi.com id <S42229AbQFTPqq>;
	Tue, 20 Jun 2000 08:46:46 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:54136 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42328AbQFTPqc>;
	Tue, 20 Jun 2000 08:46:32 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA27052
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 08:41:34 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA67480
	for <linux@engr.sgi.com>;
	Tue, 20 Jun 2000 08:46:02 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-150.karlsruhe.ipdial.viaginterkom.de (u-150.karlsruhe.ipdial.viaginterkom.de [62.180.19.150]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA05307
	for <linux@engr.sgi.com>; Tue, 20 Jun 2000 08:46:00 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S1406800AbQFTBv7>;
        Tue, 20 Jun 2000 03:51:59 +0200
Date:   Tue, 20 Jun 2000 03:51:59 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: R5000 support (specifically two-way set-associative cache...)
Message-ID: <20000620035158.F28452@bacchus.dhis.org>
References: <394EA5A0.B882F66A@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <394EA5A0.B882F66A@mvista.com>; from jsun@mvista.com on Mon, Jun 19, 2000 at 03:58:40PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jun 19, 2000 at 03:58:40PM -0700, Jun Sun wrote:

> I looked into the R5000 support and have a couple of questions:
> 
> 1. Is R5000, specifically NEC Vr5000, fully supported?  I have seen
> CONFIG_CPU_R5000 defined, but it does not appear to do much.

Indeed, the various CPU options for the R4xxx / R5xxx CPUs mostly deal
with C compiler options as a minor optimization.

> 2. Specifically, NEC Vr5000 has two-way set-associative cache.  I
> browsed through the cache code, and got concerned that I don't see any
> code that seems to take care of that.  Do I miss something?

Yes :-)

The R5000 has R4600 style caches, so also uses the same code.

> 3. I understand Geert has a port to DDB5074 (with Vr5000 CPU).  Is this
> port completed (including all interrupts, PCI related stuff).  Is this
> port reliable?

I leave the question to Geert to answer.

  Ralf

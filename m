Received:  by oss.sgi.com id <S553661AbRCMN4F>;
	Tue, 13 Mar 2001 05:56:05 -0800
Received: from u-141-10.karlsruhe.ipdial.viaginterkom.de ([62.180.10.141]:56583
        "EHLO u-141-10.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S552774AbRCMNzm>; Tue, 13 Mar 2001 05:55:42 -0800
Received: from dea ([193.98.169.28]:3968 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S867211AbRCMNza>;
	Tue, 13 Mar 2001 14:55:30 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2DDrUA02107;
	Tue, 13 Mar 2001 14:53:30 +0100
Date:	Tue, 13 Mar 2001 14:53:30 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	K.H.C.vanHouten@kpn.com
Cc:	Adrian Bunk <bunk@fs.tum.de>, linux-mips@oss.sgi.com,
        K.H.C.vanHouten@research.kpn.com
Subject: Re: Compile error with current CVS kernel
Message-ID: <20010313145330.A1208@bacchus.dhis.org>
References: <20010313001520.A20673@bacchus.dhis.org> <200103130746.IAA07580@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103130746.IAA07580@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Tue, Mar 13, 2001 at 08:46:43AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Mar 13, 2001 at 08:46:43AM +0100, Houten K.H.C. van (Karel) wrote:

> I get the same error on a native compile:
> gcc version 2.95.3 19991030 (Maciej's src)
> binutils version 2.11.90 (from CVS)
> kernel source 2.4.0-test9 (from oss CVS)
> 
> I've attached my objdump output.
> Hope this helps.

Not necessary, Adrian already sent his output.  The fix isn't difficult
either, it's just putting .modinfo into the linker script also.  The
question is still why newer ld is placing sections be default so absurdly
which is what I'm currently enquiring.

  Ralf

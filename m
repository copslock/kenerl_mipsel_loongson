Received:  by oss.sgi.com id <S305175AbPLIKtX>;
	Thu, 9 Dec 1999 02:49:23 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:45436 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbPLIKtJ>;
	Thu, 9 Dec 1999 02:49:09 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA24150; Thu, 9 Dec 1999 02:52:24 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA96352
	for linux-list;
	Thu, 9 Dec 1999 02:44:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA35095
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Dec 1999 02:44:44 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA00859
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Dec 1999 02:44:40 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407735AbPLIKoB>;
	Thu, 9 Dec 1999 08:44:01 -0200
Date:   Thu, 9 Dec 1999 08:44:01 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     sgi-mips <linux@cthulhu.engr.sgi.com>
Subject: Re: Exceptions
Message-ID: <19991209084401.B1417@uni-koblenz.de>
References: <384EDFC5.FFAE939A@ti.com> <384F62DB.8DE09E3B@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <384F62DB.8DE09E3B@mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Dec 09, 1999 at 09:05:47AM +0100, Carsten Langgaard wrote:

> > I have been working through the initialization code for the MIPS/Linux
> > kernel and have traced through to the point
> > where the MIPS exceptions are installed.  I have not been able to locate
> > the following routines
> >
> >         handle_adel
> >         handle_ades
> >         handle_sys
> >         handle_bp
> >         handle_n
> >         handle_cpu
> >         handle_ov
> >         handle_tr
> >         handle_fpe
> >
> > I see where these are defined by "extern asmlinkage" references but
> > can't locate the actual implementation of these
> > exceptions.  Any idea what files these routines might be located in?
> > Any help would be greatly appreciated
> 
> They are located in arch/mips/kernel/entry.S
> They are a little hard to find as they use the BUILD_HANDLER macro to
> extract the routines.

No wonder why I haven't ever received a patch for these routines since
the MIPS port exists :-)

They should be rewritten anyway; the current code expands the macro
SAVE_ALL quite often, so has a bad cache performance.

  Ralf

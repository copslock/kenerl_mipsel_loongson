Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2003 20:04:09 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:54027 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225428AbTJJTED>; Fri, 10 Oct 2003 20:04:03 +0100
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.3)); Fri, 10 Oct 2003 12:04:08 -0700
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id MAA08972; Fri, 10 Oct 2003 12:03:27 -0700 (PDT)
Received: from broadcom.com (ldt-sj3-158 [10.21.64.158]) by
 mail-sj1-1.sj.broadcom.com (8.12.9/8.12.4/SSM) with ESMTP id
 h9AJ3rKX003995; Fri, 10 Oct 2003 12:03:55 -0700 (PDT)
Message-ID: <3F870299.E96FCFE2@broadcom.com>
Date: Fri, 10 Oct 2003 12:03:53 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-18.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <20031009160717Z8225587-1272+7472@linux-mips.org>
 <3F8700ED.4AE74ECE@broadcom.com>
X-WSS-ID: 1399DD223300966-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

Curse the "Reply-To" from CVS commit messages.  This wasn't intended for
the list.

sorry,
Kip

Kip Walker wrote:
> 
> This doesn't compile.  Remove the commas.
> 
> Of course, "vt_check" doesn't build anymore either - I'm trying to fix
> that one.
> 
> Kip
> 
> macro@linux-mips.org wrote:
> >
> > CVSROOT:        /home/cvs
> > Module name:    linux
> > Changes by:     macro@ftp.linux-mips.org        03/10/09 17:07:12
> >
> > Modified files:
> >         arch/mips/kernel: ioctl32.c
> >
> > Log message:
> >         PIO_FONTX and KDFONTOP ioctls.

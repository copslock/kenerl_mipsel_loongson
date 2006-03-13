Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 21:55:00 +0000 (GMT)
Received: from fw-ca-1-hme0.vitesse.com ([64.215.88.90]:45997 "EHLO
	email.vitesse.com") by ftp.linux-mips.org with ESMTP
	id S8133524AbWCMVyv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2006 21:54:51 +0000
Received: from wilson.vitesse.com (wilson [10.9.72.71])
	by email.vitesse.com (8.11.0/8.11.0) with ESMTP id k2DM3h312478;
	Mon, 13 Mar 2006 14:03:43 -0800 (PST)
Received: from MX-COS.vsc.vitesse.com (mx-cs1 [10.9.72.41])
	by wilson.vitesse.com (8.11.6/8.11.6) with ESMTP id k2DM47b25026;
	Mon, 13 Mar 2006 15:04:07 -0700 (MST)
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Cross compile kernel w/ buildroot toolchain
Date:	Mon, 13 Mar 2006 15:03:42 -0700
Message-ID: <389E6A416914954182ECDFCD844D8269434FC7@MX-COS.vsc.vitesse.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cross compile kernel w/ buildroot toolchain
Thread-Index: AcZG4KOhV3wKmLqjTzKXVtkFbXC5TQACSOtA
From:	"Kurt Schwemmer" <kurts@vitesse.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <kurts@vitesse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kurts@vitesse.com
Precedence: bulk
X-list: linux-mips

Getting the _very_ latest source fixed my problem. I can now build the
kernel with the cross compiler that buildroot builds. Thanks to all who
offered advice!

Thanks,
Kurt Schwemmer 

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Sent: Monday, March 13, 2006 1:57 PM
> To: Kurt Schwemmer
> Cc: linux-mips@linux-mips.org
> Subject: Re: Cross compile kernel w/ buildroot toolchain
> 
> On Mon, Mar 13, 2006 at 01:39:53PM -0700, Kurt Schwemmer wrote:
> 
> > I got 2.6.15 "a while back" (>1 month). 
> > 
> > I'll try getting the most recent source. Sorry, I avoided 
> this due to 
> > my company blocking rsync and thus making it a pain to get 
> the sources...
> 
> The reason your case is odd is that the kernel only uses a 
> single jr.hb instruction which is in the instruction_hazard() 
> macro in include/asm-mips/hazards.h.  This macro first of all 
> is a gcc inline assembler macro and also wraps the jr.hb 
> instruction between .set mips64r2 ... .set mips0, so you 
> should never ever get an error message.  And you're getting 
> an error message for entry.S, an assembler file.  Seems you 
> must have done some not so kosher changes to that tree?
> 
>   Ralf
> 

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 14:47:18 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:41453 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122958AbSIEMrR>;
	Thu, 5 Sep 2002 14:47:17 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g85CkVXb013936;
	Thu, 5 Sep 2002 05:46:31 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA15243;
	Thu, 5 Sep 2002 05:46:24 -0700 (PDT)
Message-ID: <010301c254da$892fcc50$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Tor Arntsen" <tor@spacetec.no>
Cc: "Carsten Langgaard" <carstenl@mips.com>,
	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <Pine.GSO.3.96.1020905134606.2423G-100000@delta.ds2.pg.gda.pl>
Subject: Re: 64-bit and N32 kernel interfaces
Date: Thu, 5 Sep 2002 14:48:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
>

> On Thu, 5 Sep 2002, Tor Arntsen wrote:
> 
> > > Any reference?  AFAIK, long is 64-bit for n32 and only void * is 32-bit. 
> > >It doesn't make sense otherwise. 
> > 
> > On SGI/Irix n32 long and void* are 32-bit, only long long is 64-bit.
> > On SGI/Irix n64 long and void* are 64-bit too.
> 
>  Hmm, it looks pretty much broken if that's true (especially given long
> long was non-standard untile very recently).  I'll check the docs, yet.

n32 has the same data types as o32, an "ILP32" C integer 
model.  n64 is a pretty normal "LP64" C integer model.

What do you consider to be broken, and how would you
have preferred it to have been done?

            Regards,

            Kevin K.

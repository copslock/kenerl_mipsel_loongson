Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 10:15:59 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.134] ([IPv6:::ffff:145.253.187.134]:14806
	"EHLO mail01.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225200AbUJUJPy>; Thu, 21 Oct 2004 10:15:54 +0100
Received: from mail01.baslerweb.com (localhost.localdomain [127.0.0.1])
	by localhost.domain.tld (Basler) with ESMTP
	id 2C59513402B; Thu, 21 Oct 2004 11:15:11 +0200 (CEST)
Received: from comm1.baslerweb.com (unknown [172.16.13.2])
	by mail01.baslerweb.com (Basler) with ESMTP
	id 2850313402A; Thu, 21 Oct 2004 11:15:11 +0200 (CEST)
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 4YRPNKHP; Thu, 21 Oct 2004 11:15:51 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Date: Thu, 21 Oct 2004 11:19:50 +0200
User-Agent: KMail/1.6.2
Cc: Ralf Baechle <ralf@linux-mips.org>
References: <20041020023431Z98555-1751+175@linux-mips.org> <200410201858.40582.thomas.koeller@baslerweb.com>
In-Reply-To: <200410201858.40582.thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410211119.50747.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

I have been consulting with PMC-Sierra and received confirmation that
the problems described under errata items 2.15 and 2.16 still exist
with rev. 1.2 silicon.

Thomas



On Wednesday 20 October 2004 18:58, Thomas Koeller wrote:
> On Wednesday 20 October 2004 04:34, ralf@linux-mips.org wrote:
> > CVSROOT:	/home/cvs
> > Module name:	linux
> > Changes by:	ralf@ftp.linux-mips.org	04/10/20 03:34:25
> >
> > Modified files:
> > 	include/asm-mips: pgtable-bits.h
> >
> > Log message:
> > 	Switch RM9000 to caching mode 5.  Note this requires silicon revision
> > 	1.2 of `Titan'.  Unless somebody really needs backwards compatibility
> > 	with older versions and yells really loud I won't support backward
> > 	compatibility.
>
> Are you referring to items 2.15 and 2.16 described in the
> RM9x2x Silicon Revision Errata 1.1? In case you are, these are still
> present in the errata sheet for rev. 1.2. Could you please clarify this
> point, otherwise I cannot decide whether I need backwards compatibility or
> not.
>
> thanks,
> Thomas

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================

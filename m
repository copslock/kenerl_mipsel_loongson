Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 17:55:08 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.134] ([IPv6:::ffff:145.253.187.134]:22925
	"EHLO mail01.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225228AbUJTQzD>; Wed, 20 Oct 2004 17:55:03 +0100
Received: from mail01.baslerweb.com (localhost.localdomain [127.0.0.1])
	by localhost.domain.tld (Basler) with ESMTP
	id 83A4F13404F; Wed, 20 Oct 2004 18:54:04 +0200 (CEST)
Received: from comm1.baslerweb.com (unknown [172.16.13.2])
	by mail01.baslerweb.com (Basler) with ESMTP
	id 2718713404E; Wed, 20 Oct 2004 18:54:04 +0200 (CEST)
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 4YRPMW2T; Wed, 20 Oct 2004 18:54:41 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
Date: Wed, 20 Oct 2004 18:58:40 +0200
User-Agent: KMail/1.6.2
References: <20041020023431Z98555-1751+175@linux-mips.org>
In-Reply-To: <20041020023431Z98555-1751+175@linux-mips.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410201858.40582.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Wednesday 20 October 2004 04:34, ralf@linux-mips.org wrote:
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ralf@ftp.linux-mips.org	04/10/20 03:34:25
>
> Modified files:
> 	include/asm-mips: pgtable-bits.h
>
> Log message:
> 	Switch RM9000 to caching mode 5.  Note this requires silicon revision
> 	1.2 of `Titan'.  Unless somebody really needs backwards compatibility
> 	with older versions and yells really loud I won't support backward
> 	compatibility.

Are you referring to items 2.15 and 2.16 described in the
RM9x2x Silicon Revision Errata 1.1? In case you are, these are still present
in the errata sheet for rev. 1.2. Could you please clarify this point,
otherwise I cannot decide whether I need backwards compatibility or not.

thanks,
Thomas

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 09:50:48 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:47609 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123253AbSJDHur>;
	Fri, 4 Oct 2002 09:50:47 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g947oYNf015123;
	Fri, 4 Oct 2002 00:50:34 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA22296;
	Fri, 4 Oct 2002 00:51:05 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g947oab28640;
	Fri, 4 Oct 2002 09:50:37 +0200 (MEST)
Message-ID: <3D9D484B.4C149BD8@mips.com>
Date: Fri, 04 Oct 2002 09:50:36 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Promblem with PREF (prefetching) in memcpy
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

I think we have a problem with the PREF instructions spread out in the
memcpy function.
We are prefetching outside the area we are copying. That's usually not a
problem, but if we are prefetching outside the physical memory area
(with an unmapped kseg address), anything could happen.
We could get a bus error (which we potentially could handle), but even
worse we could have mapped the PCI space immediately following the the
RAM area and then anything could happen.

So I think, we either need to make sure not to prefetch outside a page
boundary or we make sure the last page in physical memory doesn't get
use for unmapped kernel addresses.

Any comments ?

/Carsten



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com

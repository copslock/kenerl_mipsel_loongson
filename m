Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 20:08:24 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:51195 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122958AbSIESIY>;
	Thu, 5 Sep 2002 20:08:24 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g85I78Xb015794;
	Thu, 5 Sep 2002 11:07:08 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA05080;
	Thu, 5 Sep 2002 11:07:04 -0700 (PDT)
Received: from coplin09.mips.com (IDENT:root@coplin09 [192.168.205.79])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g85I73b11054;
	Thu, 5 Sep 2002 20:07:03 +0200 (MEST)
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id g85I73W06904;
	Thu, 5 Sep 2002 20:07:03 +0200
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200209051807.g85I73W06904@coplin09.mips.com>
Subject: Re: 64-bit and N32 kernel interfaces
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Thu, 5 Sep 2002 20:07:03 +0200 (CEST)
Cc: dan@debian.org (Daniel Jacobowitz),
	hartvige@mips.com (Hartvig Ekner),
	kevink@mips.com (Kevin D. Kissell),
	tor@spacetec.no (Tor Arntsen),
	carstenl@mips.com (Carsten Langgaard),
	ralf@linux-mips.org (Ralf Baechle), linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.3.96.1020905170830.7444E-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Sep 05, 2002 05:10:51 
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvige@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvige@mips.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki writes:
> 
> On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:
> 
> > No - the point is that all data types have the same size in N32.  It
> > was created explicitly as a transitional sop for people who didn't want
> > to fix their code, but wanted a performance increase from their 64-bit
> > hardware.
> 
>  Well, what's the performance increase of n32 over o32?  The increased
> number of argument registers?  I doubt it's noticeable in most cases.

The technical benefits of n32 over o32 are:

* More argument registers => less memory traffic, less D-cache use,
	=> faster code

* 64-bit datapath of CPU can be utilized with big impact on certain
  applications

* 32 floating point registers instead of 16 (and more efficient
  parameter passing as well)

/Hartvig

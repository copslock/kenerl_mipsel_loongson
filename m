Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Aug 2003 20:32:12 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:31187 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225202AbTHKTcK>;
	Mon, 11 Aug 2003 20:32:10 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h7BJVPMO007685;
	Mon, 11 Aug 2003 12:31:25 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler-linux [192.168.65.120])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA14771;
	Mon, 11 Aug 2003 12:32:07 -0700 (PDT)
Subject: Re: C0 config reg for 5k core
From: Mike Uhler <uhler@mips.com>
To: David Kesselring <dkesselr@mmc.atmel.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.4.44.0308111422220.4449-100000@ares.mmc.atmel.com>
References: <Pine.GSO.4.44.0308111422220.4449-100000@ares.mmc.atmel.com>
Content-Type: text/plain
Organization: MIPS Technologies, Inc.
Message-Id: <1060630328.1071.20.camel@uhler-linux.mips.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Aug 2003 12:32:08 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

Bit 0 of Config1 is FPU-present.  Bit 4 is "Performance counters
present".  I guarantee you that the 5K family implements this
pattern.

/gmu


On Mon, 2003-08-11 at 11:28, David Kesselring wrote:
> Has anyone else built linux 2.4 for a 5k or 5kf core? When comparing cpu.h
> and the MIPS64 5K Processor Core Family Software Users Manual it doesn't
> look to me that the c0-config1 reg is defined the same way. Am I reading
> something wrong? For example in the spec FPU flag is bit0 while in cpu.h
> it is bit4. Seems pretty basic.
> 
> David Kesselring
> Atmel MMC
> dkesselr@mmc.atmel.com
> 919-462-6587
-- 

Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com  Pager:uhler_p@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085

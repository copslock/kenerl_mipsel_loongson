Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 23:16:55 +0000 (GMT)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:21775 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225203AbTCDXQy>; Tue, 4 Mar 2003 23:16:54 +0000
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Tue, 04 Mar 2003 15:16:30 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id PAA21401; Tue, 4 Mar 2003 15:16:35 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h24NGiER018738; Tue, 4 Mar 2003 15:16:44 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id PAA08482; Tue, 4
 Mar 2003 15:16:45 -0800
Message-ID: <3E6533DD.B72D6F10@broadcom.com>
Date: Tue, 04 Mar 2003 15:16:45 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
cc: linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] kernelsp on 64-bit kernel
References: <3E651FB7.A38AFD3B@broadcom.com>
 <01e401c2e2a2$f1866010$10eca8c0@grendel>
X-WSS-ID: 127BEC44964128-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

> For whatever it's worth, I've always maintained that stealing the Watchpoint
> registers in this way was a pretty questionable hack to be avoided.  Watchpoint
> registers are *optional* in MIPS64 and may not even exist.  And yes, someone
> might want to use them for their intended purpose some day.  However, please
> note that the EJTAG breakpoint registers are completely orthogonal to the
> watchpoint registers.

That is true, but in SB1, watchpoint registers can be used by the JTAG
debugger, and I do it all the time.  It doesn't have the EJTAG
breakpoint registers, but rather overloads (I know, I know) use of the
watchpoint registers and has a mode bit for causing a debug exception
instead of a general exception when they are tripped.

Kip

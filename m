Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 19:45:53 +0000 (GMT)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:43782 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225243AbTCCTpw>; Mon, 3 Mar 2003 19:45:52 +0000
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Mon, 03 Mar 2003 11:45:48 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA15076; Mon, 3 Mar 2003 11:45:30 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h23JjfER024540; Mon, 3 Mar 2003 11:45:41 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id LAA04061; Mon, 3
 Mar 2003 11:45:42 -0800
Message-ID: <3E63B0E6.F7A85746@broadcom.com>
Date: Mon, 03 Mar 2003 11:45:42 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] add CONFIG_DEBUG_INFO
References: <20030220113404.E7466@mvista.com>
 <3E63B047.D3BA2A2C@broadcom.com>
X-WSS-ID: 127D6F662251472-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

Kip Walker wrote:
> 
> How about adding "CONFIG_DEBUG_INFO" which simply adds '-g' to the
> CFLAGS?  REMOTE_KGDB can be left independent of this option by allowing
> either option to enable '-g'.  Patch for 2.4 attached.

My, just noticed that this patch included my local hack of using
'-gstabs+' instead of '-g' in the 32-bit Makefile, because my GDB
doesn't like DWARF2 so much yet.  I wasn't intending to advocate this
change.

Kip

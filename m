Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 18:30:00 +0000 (GMT)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:63249 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225205AbTBNS37>; Fri, 14 Feb 2003 18:29:59 +0000
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Fri, 14 Feb 2003 10:29:36 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id KAA19738; Fri, 14 Feb 2003 10:29:45 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h1EITqER009680; Fri, 14 Feb 2003 10:29:52 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id KAA12577; Fri,
 14 Feb 2003 10:29:52 -0800
Message-ID: <3E4D35A0.7BCC13C4@broadcom.com>
Date: Fri, 14 Feb 2003 10:29:52 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: shenminshi@netscape.net
cc: linux-mips@linux-mips.org
Subject: Re: when does "init" become usermode process
References: <6105D94A.6A2BDDA3.10683EB2@netscape.net>
X-WSS-ID: 1253EA1A796604-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

shenminshi@netscape.net wrote:
> 
> My question is when and how does init turn itself into usermode.

Look at 'start_thread' in arch/mips/kernel/process.c, which is called
from load_elf_binary in fs/binfmt_elf.c (as a result of the execve
syscall).

Kip

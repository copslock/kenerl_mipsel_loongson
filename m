Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2003 03:17:48 +0100 (BST)
Received: from huawei.com ([IPv6:::ffff:61.144.161.2]:20116 "EHLO
	mta0.huawei.com") by linux-mips.org with ESMTP id <S8225217AbTGKCRq>;
	Fri, 11 Jul 2003 03:17:46 +0100
Received: from r19223b (mta0.huawei.com [172.17.1.62])
 by mta0.huawei.com (iPlanet Messaging Server 5.2 HotFix 0.8 (built Jul 12
 2002)) with ESMTPA id <0HHU000FW8YO5W@mta0.huawei.com>; Fri,
 11 Jul 2003 10:16:01 +0800 (CST)
Date: Fri, 11 Jul 2003 10:14:44 +0800
From: renwei <renwei@huawei.com>
Subject: [patch]: gdb/insight 5.3 buggy   in kernel module debug
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Message-id: <000701c34752$3263d680$6efc0b0a@huawei.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <003501c34526$f5adfcc0$6efc0b0a@huawei.com>
 <20030709123657.GA30305@linux-mips.org>
Return-Path: <renwei@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: renwei@huawei.com
Precedence: bulk
X-list: linux-mips

Here's my patch to this problem, change the read pc on mips32 cpu.

Maybe someone want it.
change mips-tdep.c
///////////////////////////////////////////////////////////////////////////////////////
766c766,772
<   return read_signed_register_pid (PC_REGNUM, ptid);
---
>   /*add by renwei , if mips 32, the pc should be some positive number,
>    or the gdb can't lookup the backtrace in kernel*/
>   LONGEST lpc = read_signed_register_pid (PC_REGNUM, ptid);
>   if(REGISTER_RAW_SIZE(PC_REGNUM) < (int)sizeof(LONGEST))
>     lpc &= 0x00000000ffffffffLL;
>   
>   return lpc;
1703c1709,1714
< 
---
>   
>   /*add by renwei , if mips 32, the pc should be some positive number,
>    or the gdb can't lookup the backtrace in kernel*/
>   if(REGISTER_RAW_SIZE(PC_REGNUM) < (int)sizeof(LONGEST))
>     saved_pc &= 0x00000000ffffffffLL;
>   
/////////////////////////////////////////////////////////////////////////////////////////////




Another problem:   insight 5.3 compile error on cygwin.
fix  tclWin32Dll.c
/////////////////////////////////////////////////////////////////////////////////
121c121,122
< static Tcl_Encoding tclWinTCharEncoding;
---
> /*change this to global*/
> Tcl_Encoding tclWinTCharEncoding;
///////////////////////////////////////////////////////////////////////////////////


                                                          renc 

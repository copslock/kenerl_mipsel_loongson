Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 14:52:12 +0100 (BST)
Received: from smtp.vmb-service.ru ([IPv6:::ffff:80.73.198.33]:58282 "EHLO
	smtp.vmb-service.ru") by linux-mips.org with ESMTP
	id <S8224924AbUGNNwI>; Wed, 14 Jul 2004 14:52:08 +0100
Received: from office.vmb-service.ru ([80.73.192.47]:54286 "EHLO ALEC")
	by Altair with ESMTP id <S1161442AbUGNNwF>;
	Wed, 14 Jul 2004 17:52:05 +0400
Reply-To: <a.voropay@vmb-service.ru>
From: "Alexander Voropay" <a.voropay@vmb-service.ru>
To: <linux-mips@linux-mips.org>
Subject: MS VC++ compiler / MIPS
Date: Wed, 14 Jul 2004 17:53:11 +0400
Organization: VMB-Service
Message-ID: <07d301c469a9$e708f550$0200000a@ALEC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Return-Path: <a.voropay@vmb-service.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@vmb-service.ru
Precedence: bulk
X-list: linux-mips

Hi!

 Is it possible to use it for the something useful ??
(to compie a kernel 8-))

 As it is known, MS provides eMbedded Visual Tools 3.0
for free download. It contains a free C++ MIPS cross compiler .

evt2002web_min.exe [210485 KB]






========================
C:\...ft eMbedded Tools\EVC\WCE300\BIN>CLMIPS.EXE /help 
Microsoft (R) 32-bit/16-bit C/C++ Optimizing Compiler Version 12.01.8667
for MIPS R-Series
Copyright (C) Microsoft Corp 1984-1999. All rights reserved.

[....]
                             -CODE GENERATION-

/QMRWCE optimize for WinCE (Default)     /QMOb<n> basic block threshold
/QMR3900 optimize for r3900              /QMOu<n> unroll n loop
iterations
/QMR4100 optimize for r4100              /QMFPE[-] FP emulation
(default)
/QMR4200 optimize for r4200              /Gd __cdecl calling convention
/QMR4300 optimize for r4300              /GA optimize for Windows
Application
/QMmips16 code for MIPS16 ASE            /GD optimize for Windows DLL
/QMmips1 MIPS1 ISA                       /Gr __fastcall calling
convention
/QMmips2 MIPS2 ISA (default)             /Gf enable string pooling
/QMNoDivCheck no divide by zero check    /GF enable read-only string
pooling
/QMNoUnalign no LWL,LWR,SWL,SWR          /Gh enable hook function call
/QMNoULoad do not generate LWL,LWR       /GR[-] enable C++ RTTI
/QMNoUStore do not generate SWL,SWR      /Gy separate functions for
linker
/QMOC use old float comparison helpers

[....]


--
-=AV=-

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2004 16:20:01 +0100 (BST)
Received: from mms3.broadcom.com ([IPv6:::ffff:63.70.210.38]:40207 "EHLO
	mms3.broadcom.com") by linux-mips.org with ESMTP
	id <S8225370AbUF1PT4>; Mon, 28 Jun 2004 16:19:56 +0100
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.6.0)); Mon, 28 Jun 2004 08:19:42 -0700
X-Server-Uuid: 8D569F9F-42CF-4602-970D-AACC4BD5D310
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id IAA03384; Mon, 28 Jun 2004 08:19:05 -0700 (PDT)
From: cgd@broadcom.com
Received: from mail-sj1-2.sj.broadcom.com (mail-sj1-2 [10.16.128.232])
 by mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 i5SFJcov027982; Mon, 28 Jun 2004 08:19:38 -0700 (PDT)
Received: (from cgd@localhost) by mail-sj1-2.sj.broadcom.com (
 8.9.1/SJ8.9.1) id IAA29663; Mon, 28 Jun 2004 08:19:38 -0700 (PDT)
Date: Mon, 28 Jun 2004 08:19:38 -0700 (PDT)
Message-ID: <200406281519.IAA29663@mail-sj1-2.sj.broadcom.com>
To: cgd@broadcom.com, macro@linux-mips.org
Subject: Re: [Patch]  / 0 should send SIGFPE not SIGTRAP...
cc: binutils@sources.redhat.com, ddaney@avtrex.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org, rsandifo@redhat.com
MIME-Version: 1.0
X-WSS-ID: 6CFEE8872EC5817646-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <cgd@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cgd@broadcom.com
Precedence: bulk
X-list: linux-mips

personally, i'd make the comment on the 'break' testcase in mips32.s a bit
clearer and more explicit.  e.g. "for a while, break for mips32 
took a 20 bit code.  But that was incompatible and caused problems, so
now it's back to the old 10 bit code, or two comma-separated 10 bit codes."

Otherwise, people might look and say "huh?"


chris

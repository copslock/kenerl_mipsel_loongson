Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2003 23:07:39 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:18698 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8224827AbTDGWHi>; Mon, 7 Apr 2003 23:07:38 +0100
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.2)); Mon, 07 Apr 2003 15:04:29 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id PAA17725; Mon, 7 Apr 2003 15:07:14 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h37M7TER017598; Mon, 7 Apr 2003 15:07:29 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id PAA02138; Mon, 7
 Apr 2003 15:07:30 -0700
Message-ID: <3E91F6A1.4080AF05@broadcom.com>
Date: Mon, 07 Apr 2003 15:07:29 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hartvig Ekner" <hartvig@ekner.info>
cc: "Linux MIPS mailing list" <linux-mips@linux-mips.org>
Subject: Re: Patch to include/asm-mips/processor.h
References: <3E917AA1.13694D03@ekner.info>
X-WSS-ID: 128F2A6763771-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

Hartvig Ekner wrote:
> 
> I have no idea whether what I did was correct, but at least it is no less incorrect than the code currently
> in there, which coredumps now for some reason (I wonder why it never crashed before). The test-bit macro
> expects a bit-number, and not a mask which it is given in the current code.
> 
> So while fixing this, I also used the normal cpu_data macro for the cpu_has_watch() macro, instead of
> looking at CPU(0).
> 
> /Hartvig

The second argument to test_bit ought to have been an address, not a
value.  Why didn't this crash before?  I just ran into it too...

Kip

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2002 18:23:53 +0200 (CEST)
Received: from mms2.broadcom.com ([63.70.210.59]:1799 "HELO mms2.broadcom.com")
	by linux-mips.org with SMTP id <S1122978AbSI3QXw>;
	Mon, 30 Sep 2002 18:23:52 +0200
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 MMS-2 SMTP Relay (MMS v4.7);); Mon, 30 Sep 2002 09:21:20 -0700
X-Server-Uuid: 2a12fa22-b688-11d4-a6a1-00508bfc9626
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id JAA20416 for <linux-mips@linux-mips.org>; Mon, 30 Sep 2002 09:23:36
 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g8UGNZER019194 for <linux-mips@linux-mips.org>; Mon, 30 Sep 2002 09:23:
 36 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id JAA22138 for
 <linux-mips@linux-mips.org>; Mon, 30 Sep 2002 09:23:35 -0700
Message-ID: <3D987A87.8B855D01@broadcom.com>
Date: Mon, 30 Sep 2002 09:23:35 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: unaligned exception handling
X-WSS-ID: 1186A58A866434-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

After inspecting a strange case in the mips64 kernel with address
errors, I'm starting to think there's a problem in the do_ade()
implementation.  I think the 32-bit kernel may have a similar problem,
but I haven't really inspected it.  The issue is where the kernel's
emulation of an address error causes another address error (NOT a page
fault).

Basically, I don't see how the exception table stuff in
emulate_load_store_insn is going to work.  Consider this scenario:

- user process does a 'sw' (for example) to an illegal address
  above xuseg but below xsseg
- do_ade calls emulate_load_store_insn, which tries swl/swr
- the swl again hits an illegal address, this time in the
  kernel's context
- do_ade does NOT check the exception table for the swl
- emulate_load_store_insn goes to the 'swl' part of the switch
- die_if_kernel DOES __die before the SIGBUS is delivered.

So I don't see how the ex_table stuff is useful at all.  Shouldn't
do_ade() do the exception table grovelling before calling
emulate_load_store_insn?

Kip

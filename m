Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Nov 2009 00:57:16 +0100 (CET)
Received: from mail.codesourcery.com ([38.113.113.100]:40014 "EHLO
        mail.codesourcery.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493673AbZKYX5N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Nov 2009 00:57:13 +0100
Received: (qmail 28037 invoked from network); 25 Nov 2009 23:57:08 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 25 Nov 2009 23:57:08 -0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.69)
        (envelope-from <joseph@codesourcery.com>)
        id 1NDRjP-0002AR-2R
        for linux-mips@linux-mips.org; Wed, 25 Nov 2009 23:57:07 +0000
Date:   Wed, 25 Nov 2009 23:57:07 +0000 (UTC)
From:   "Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     linux-mips@linux-mips.org
Subject: MIPS asm/mman.h and MADV_HWPOISON
Message-ID: <Pine.LNX.4.64.0911252356300.31853@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

In the course of updating glibc ports's bits/mman.h files for new MADV_* 
definitions, I noticed that arch/mips/include/asm/mman.h does not define 
MADV_HWPOISON, although architectures using asm-generic/mman.h get that 
definition automatically.  Should I take it that this is an oversight and 
that a definition of MADV_HWPOISON will be added with value 100, or is 
there some reason for it not to be defined for MIPS or for it to have a 
different value?

-- 
Joseph S. Myers
joseph@codesourcery.com

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2011 14:32:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47548 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492099Ab1I1Mc0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Sep 2011 14:32:26 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8SCX6EO002483;
        Wed, 28 Sep 2011 14:33:06 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8SCX5s7002478;
        Wed, 28 Sep 2011 14:33:05 +0200
Date:   Wed, 28 Sep 2011 14:33:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     binutils@sourceware.org, linux-mips@linux-mips.org,
        David Kuehling <dvdkhlng@gmx.de>
Subject: $ta0 .. $ta3 registers in O32 on MIPS
Message-ID: <20110928123305.GA1971@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16507

The register names $ta0 .. $ta3 were added by SGI for N32 / N64 code.
Because these reference $8 .. $11 just like $t0 .. $t3 in the O32 ABI
their availability in O32 as well appears dangerous, if not a bug:

$ cat s.s 
	addu	$ta0, $ta0
$ mips-linux-as -o s.o s.s
$ file s.o
s.o: ELF 32-bit MSB relocatable, MIPS, MIPS-I version 1 (SYSV), not stripped
$

I was expecting an error message and I'm wondering, was this intentional?

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 05:42:44 +0200 (CEST)
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:34200 "EHLO
	sj-msg-core-1.cisco.com") by linux-mips.org with ESMTP
	id <S1121744AbSJWDmo>; Wed, 23 Oct 2002 05:42:44 +0200
Received: from bbozarth-lnx.cisco.com (bbozarth-lnx.cisco.com [128.107.165.13])
	by sj-msg-core-1.cisco.com (8.12.2/8.12.2) with ESMTP id g9N3gaIm019068
	for <linux-mips@linux-mips.org>; Tue, 22 Oct 2002 20:42:36 -0700 (PDT)
Received: from localhost (bbozarth@localhost)
	by bbozarth-lnx.cisco.com (8.11.6/8.11.6) with ESMTP id g9N3gZF21734
	for <linux-mips@linux-mips.org>; Tue, 22 Oct 2002 20:42:35 -0700
Date: Tue, 22 Oct 2002 20:42:35 -0700 (PDT)
From: Bradley Bozarth <bbozarth@cisco.com>
To: linux-mips@linux-mips.org
Subject: 64 bit jiffies
Message-ID: <Pine.LNX.4.44.0210222038460.31553-100000@bbozarth-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <bbozarth@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bbozarth@cisco.com
Precedence: bulk
X-list: linux-mips

There was a thread on lkml in May which resulted in the 32 bit jiffies 
value using the bottom of the jiffies_64 - this equivalence being done in 
linker scripts.  It was stated, however, that MIPS wasn't handled because 
it had a funky sed generated linker script for multiple endiannesses.  
So is mips currently broken in 2.5?  Has anyone looked at this - I would 
be willing to figure out a fix but thought I'd see if someone has ideas or 
has already dealt with it...

thanks,
brad

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Oct 2002 00:51:57 +0200 (CEST)
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:63898 "EHLO
	sj-msg-core-1.cisco.com") by linux-mips.org with ESMTP
	id <S1124008AbSJRWv4>; Sat, 19 Oct 2002 00:51:56 +0200
Received: from bbozarth-lnx.cisco.com (bbozarth-lnx.cisco.com [128.107.165.13])
	by sj-msg-core-1.cisco.com (8.12.2/8.12.2) with ESMTP id g9IMpkIm010307
	for <linux-mips@linux-mips.org>; Fri, 18 Oct 2002 15:51:46 -0700 (PDT)
Received: from localhost (bbozarth@localhost)
	by bbozarth-lnx.cisco.com (8.11.6/8.11.6) with ESMTP id g9IMpkT04178
	for <linux-mips@linux-mips.org>; Fri, 18 Oct 2002 15:51:46 -0700
X-Authentication-Warning: bbozarth-lnx.cisco.com: bbozarth owned process doing -bs
Date: Fri, 18 Oct 2002 15:51:46 -0700 (PDT)
From: Brad Bozarth <prettygood@cs.stanford.edu>
X-X-Sender: bbozarth@bbozarth-lnx.cisco.com
Reply-To: prettygood@cs.stanford.edu
To: linux-mips@linux-mips.org
Subject: atomic_add_negative?
Message-ID: <Pine.LNX.4.44.0210181549240.2223-100000@bbozarth-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <prettygood@cs.stanford.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prettygood@cs.stanford.edu
Precedence: bulk
X-list: linux-mips

The current atomic.h says this is not implemented for mips...  would this 
work - modeled after the rest of the atomic_blah_and_test ?

/*
 * atomic_add_negative - add and test if negative
 * @v: pointer of type atomic_t
 * @i: integer value to add
 *
 * Atomically adds @i to @v and returns true
 * if the result is negative, or false when
 * result is greater than or equal to zero.  Note that the guaranteed
 * useful range of an atomic_t is only 24 bits.
 */
#define atomic_add_negative(i,v) (atomic_add_return(i, (v)) < 0)

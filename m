Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 21:11:59 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:45328 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225472AbTISUL5>;
	Fri, 19 Sep 2003 21:11:57 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1A0RbB-0002CY-00; Fri, 19 Sep 2003 21:11:25 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1A0RbI-00021m-00; Fri, 19 Sep 2003 21:11:32 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16235.25337.917444.302915@doms-laptop.algor.co.uk>
Date: Fri, 19 Sep 2003 22:11:37 +0200
To: David Daney <ddaney@avtrex.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Will ll/sc work from user space?
In-Reply-To: <3F6A4E41.1090100@avtrex.com>
References: <3F6A4E41.1090100@avtrex.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-2.6, required 4, AWL,
	BAYES_20, QUOTED_EMAIL_TEXT, REFERENCES)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


David,

> Q:  Will ll/sc instructions work from a linux user process ?

As Maciej says, yes.

> If so What happens if there is a context switch between the two?

The sc fails.

It fails whenever any interrupt or other exception (perhaps a VM
event, for example) happens after the ll but before the sc.

> What happens if the memory location is paged out and then back into a 
> different physical page?

If that happens between the ll and the sc, then you must certainly
have got an interrupt.

--
Dominic Sweetman
MIPS Technologies

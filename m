Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 11:08:23 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:19972 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225278AbTDPKHw>;
	Wed, 16 Apr 2003 11:07:52 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 195juV-00084l-00; Wed, 16 Apr 2003 11:12:59 +0100
Received: from arsenal.algor.co.uk
	([192.168.192.197] helo=arsenal.mips.com ident=mail)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 195jpB-0007kn-00; Wed, 16 Apr 2003 11:07:29 +0100
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 195jp9-00065z-00; Wed, 16 Apr 2003 11:07:27 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16029.11103.408306.362389@arsenal.mips.com>
Date: Wed, 16 Apr 2003 11:07:27 +0100
To: Steve Taylor <godzilla1357@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Basic cache questions
In-Reply-To: <20030415221914.47873.qmail@web14503.mail.yahoo.com>
References: <20030415221914.47873.qmail@web14503.mail.yahoo.com>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-1.2, required 4.5, AWL,
	IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES, SPAM_PHRASE_00_01)
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Steve

> c) Do you think locking out, say, an entire way of a 4-way cache for
>    a dedicated frequently used routine improves or degrades overall
>    system performance?

It usually degrades performance, and is likely to go horribly wrong.

Look around and I expect you can find a better way to turn your effort
into higher performance!

--
Dominic Sweetman
dom@mips.com

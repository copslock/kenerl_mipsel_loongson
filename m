Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 09:08:04 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:57095 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225072AbUJVIH7>;
	Fri, 22 Oct 2004 09:07:59 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CKuba-00036s-00; Fri, 22 Oct 2004 09:16:58 +0100
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CKuSU-00076j-00; Fri, 22 Oct 2004 09:07:34 +0100
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1CKuSU-0002Hw-00; Fri, 22 Oct 2004 09:07:34 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16760.49094.216731.671991@arsenal.mips.com>
Date: Fri, 22 Oct 2004 09:07:34 +0100
To: thomas_blattmann@canada.com
Cc: linux-mips@linux-mips.org
Subject: Re: mips startup
In-Reply-To: <20041021165125.4960.h021.c009.wm@mail.canada.com.criticalpath.net>
References: <20041021165125.4960.h021.c009.wm@mail.canada.com.criticalpath.net>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.851, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Thomas,

> I'm searching for some startup code for a MIPS4kc (
> MIPS Malta Board ) processor. I'd like to print
> something on the malta display. It's a bare machine so
> far. Are there any tutorials or startup examples ?? How
> can I start learning ??

MIPS offer a free toolkit - GCC and friends setup for MIPS "bare
iron", with suitable libraries and build-from-the-box examples for
Malta.  You can download it from here:

http://www.mips.com/content/Products/SoftwareTools/SDE_Lite/content_html

--
Dominic Sweetman
MIPS Technologies

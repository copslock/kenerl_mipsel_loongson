Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 08:53:23 +0200 (CEST)
Received: from ni.piap.pl ([195.187.100.4]:39043 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818702Ab3JIGxVe6WMZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 08:53:21 +0200
Received: from ni.piap.pl (localhost.localdomain [127.0.0.1])
        by ni.piap.pl (Postfix) with ESMTP id 862AC4423E6;
        Wed,  9 Oct 2013 08:53:20 +0200 (CEST)
Received: by ni.piap.pl (Postfix, from userid 1015)
        id 7F8344423E7; Wed,  9 Oct 2013 08:53:20 +0200 (CEST)
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-media@vger.kernel.org
References: <m3eh82a1yo.fsf@t19.piap.pl> <m361t9a31i.fsf@t19.piap.pl>
        <20131007142429.GG3098@linux-mips.org> <m3li24891u.fsf@t19.piap.pl>
        <20131008120727.GH1615@linux-mips.org>
Date:   Wed, 09 Oct 2013 08:53:20 +0200
In-Reply-To: <20131008120727.GH1615@linux-mips.org> (Ralf Baechle's message of
        "Tue, 8 Oct 2013 14:07:27 +0200")
MIME-Version: 1.0
Message-ID: <m38uy37x5r.fsf@t19.piap.pl>
Content-Type: text/plain
Subject: Re: Suspected cache coherency problem on V4L2 and AR7100 CPU
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.44/RELEASE,
         bases: 20131009 #11180346, check: 20131009 clean
Return-Path: <khalasa@ni.piap.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khalasa@piap.pl
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> writes:

> 16K is a silver bullet solution to all cache aliasing problems.  So if
> your issue persists with 16K page size, it's not a cache aliasing issue.
> Aside there are generally performance gains from the bigger page size.

I wonder why isn't the issue present in other cases. Perhaps remapping
of a userspace address and accessing it with kseg0 isn't a frequent
operation.

Shouldn't we change the default page size (on affected CPUs) to 16 KB
then? Alternatively, we could flush/invalidate the cache when needed -
is it a viable option?

Thanks.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

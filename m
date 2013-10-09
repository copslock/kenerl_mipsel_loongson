Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 15:05:32 +0200 (CEST)
Received: from ni.piap.pl ([195.187.100.4]:48303 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817090Ab3JINF3kVOjA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Oct 2013 15:05:29 +0200
Received: from ni.piap.pl (localhost.localdomain [127.0.0.1])
        by ni.piap.pl (Postfix) with ESMTP id AD268440E26;
        Wed,  9 Oct 2013 15:05:28 +0200 (CEST)
Received: by ni.piap.pl (Postfix, from userid 1015)
        id A8164440F03; Wed,  9 Oct 2013 15:05:28 +0200 (CEST)
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-media@vger.kernel.org
References: <m3eh82a1yo.fsf@t19.piap.pl> <m361t9a31i.fsf@t19.piap.pl>
        <20131007142429.GG3098@linux-mips.org> <m3li24891u.fsf@t19.piap.pl>
        <20131008120727.GH1615@linux-mips.org> <m38uy37x5r.fsf@t19.piap.pl>
        <20131009081707.GL1615@linux-mips.org>
Date:   Wed, 09 Oct 2013 15:05:28 +0200
In-Reply-To: <20131009081707.GL1615@linux-mips.org> (Ralf Baechle's message of
        "Wed, 9 Oct 2013 10:17:07 +0200")
MIME-Version: 1.0
Message-ID: <m3y562d27b.fsf@t19.piap.pl>
Content-Type: text/plain
Subject: Re: Suspected cache coherency problem on V4L2 and AR7100 CPU
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.44/RELEASE,
         bases: 20131009 #11180346, check: 20131009 clean
Return-Path: <khalasa@ni.piap.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38289
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

> The kernel is supposed to perform the necessary cache flushing, so any
> remaining aliasing issue would be considered a bug.  But the code is
> performance sensitive, some of the problem cases are twisted and complex
> so bugs and unsolved corner cases show up every now and then.

Ok. This means I should also investigate the V4L2 and the hw driver
code, because the cache aliasing shouldn't be there in the first place.

> Does it work for you, even solve your problem?

Sure, with 16 KB page size everything works fine.

-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

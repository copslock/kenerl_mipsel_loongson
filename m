Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2013 10:06:49 +0200 (CEST)
Received: from ni.piap.pl ([195.187.100.4]:57958 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817090Ab3JDIGqevcUg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Oct 2013 10:06:46 +0200
Received: from ni.piap.pl (localhost.localdomain [127.0.0.1])
        by ni.piap.pl (Postfix) with ESMTP id A0215440234;
        Fri,  4 Oct 2013 10:06:45 +0200 (CEST)
Received: by ni.piap.pl (Postfix, from userid 1015)
        id 98950440235; Fri,  4 Oct 2013 10:06:45 +0200 (CEST)
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     linux-mips@linux-mips.org
Cc:     linux-media@vger.kernel.org
References: <m3eh82a1yo.fsf@t19.piap.pl>
Date:   Fri, 04 Oct 2013 10:06:45 +0200
In-Reply-To: <m3eh82a1yo.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of
        "Thu, 03 Oct 2013 16:00:47 +0200")
MIME-Version: 1.0
Message-ID: <m3a9ipa296.fsf@t19.piap.pl>
Content-Type: text/plain
Subject: Re: Suspected cache coherency problem on V4L2 and AR7100 CPU
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.44/RELEASE,
         bases: 20131004 #11175540, check: 20131004 clean
Return-Path: <khalasa@ni.piap.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38199
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

> I'm debugging a problem with a SOLO6110-based H.264 PCI video encoder on
> Atheros AR7100-based (MIPS, big-endian) platform.

BTW this CPU obviously has VIPT data cache, this means a physical page
with multiple virtual addresses (e.g. mapped multiple times) may and
will be cached multiple times.

AR7100 = arch/mips/ath79.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

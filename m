Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 10:38:53 +0200 (CEST)
Received: from ni.piap.pl ([195.187.100.4]:48769 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823911Ab3JGIiuqr4Gq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 10:38:50 +0200
Received: from ni.piap.pl (localhost.localdomain [127.0.0.1])
        by ni.piap.pl (Postfix) with ESMTP id AF81844219D;
        Mon,  7 Oct 2013 10:38:49 +0200 (CEST)
Received: by ni.piap.pl (Postfix, from userid 1015)
        id AA46E44219E; Mon,  7 Oct 2013 10:38:49 +0200 (CEST)
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     linux-mips@linux-mips.org
Cc:     linux-media@vger.kernel.org
References: <m3eh82a1yo.fsf@t19.piap.pl>
Date:   Mon, 07 Oct 2013 10:38:49 +0200
In-Reply-To: <m3eh82a1yo.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of
        "Thu, 03 Oct 2013 16:00:47 +0200")
MIME-Version: 1.0
Message-ID: <m361t9a31i.fsf@t19.piap.pl>
Content-Type: text/plain
Subject: Re: Suspected cache coherency problem on V4L2 and AR7100 CPU
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.44/RELEASE,
         bases: 20131007 #11164323, check: 20131007 clean
Return-Path: <khalasa@ni.piap.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38214
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

Please forgive me my MIPS TLB ignorance.

It seems there is a TLB entry pointing to the userspace buffer at the
time the kernel pointer (kseg0) is used. Is is an allowed situation on
MIPS 24K?

buffer: len 0x1000 (first page),
	userspace pointer 0x77327000,
	kernel pointer 0x867ac000 (physical address = 0x067ac000)

TLB Index: 15 pgmask=4kb va=77326000 asid=be
       [pa=01149000 c=3 d=1 v=1 g=0] [pa=067ac000 c=3 d=1 v=1 g=0]

Should the TLB entry be deleted before using the kernel pointer (which
points at the same page)?
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

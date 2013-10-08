Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 12:46:58 +0200 (CEST)
Received: from ni.piap.pl ([195.187.100.4]:48913 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823123Ab3JHKq4MAMQO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 12:46:56 +0200
Received: from ni.piap.pl (localhost.localdomain [127.0.0.1])
        by ni.piap.pl (Postfix) with ESMTP id 62915440D84;
        Tue,  8 Oct 2013 12:46:55 +0200 (CEST)
Received: by ni.piap.pl (Postfix, from userid 1015)
        id 5D5B4440D89; Tue,  8 Oct 2013 12:46:55 +0200 (CEST)
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-media@vger.kernel.org
References: <m3eh82a1yo.fsf@t19.piap.pl> <m361t9a31i.fsf@t19.piap.pl>
        <20131007142429.GG3098@linux-mips.org>
Date:   Tue, 08 Oct 2013 12:46:55 +0200
In-Reply-To: <20131007142429.GG3098@linux-mips.org> (Ralf Baechle's message of
        "Mon, 7 Oct 2013 16:24:29 +0200")
MIME-Version: 1.0
Message-ID: <m3hacs82g0.fsf@t19.piap.pl>
Content-Type: text/plain
Subject: Re: Suspected cache coherency problem on V4L2 and AR7100 CPU
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.44/RELEASE,
         bases: 20131008 #11178143, check: 20131008 clean
Return-Path: <khalasa@ni.piap.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38260
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

> That's fine.  You just need to ensure that there are no virtual aliases.
> One way to do so is to increase the page size to 16kB.

Checked, this thing works fine with 16 KB pages.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

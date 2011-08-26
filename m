Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2011 09:45:15 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:34574 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491099Ab1HZHpM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Aug 2011 09:45:12 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@not.so.argh.org>)
        id 1Qwr6F-00031L-IC; Fri, 26 Aug 2011 07:45:11 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Qwr69-0003sS-UK; Fri, 26 Aug 2011 09:45:05 +0200
Date:   Fri, 26 Aug 2011 09:45:05 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: [PATCH] mips/loongson: unify compiler flags and load location
        for Loongson 2E and 2F
Message-ID: <20110826074505.GB32219@mails.so.argh.org>
Mail-Followup-To: Andreas Barth <aba@not.so.argh.org>,
        Matt Turner <mattst88@gmail.com>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
References: <20110821010513.GZ2657@mails.so.argh.org> <20110825080054.GA10459@mails.so.argh.org> <CAEdQ38Ft-okTSUxhXXkZPhr1z46b480CtBu+LtVRcyQLACS3tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEdQ38Ft-okTSUxhXXkZPhr1z46b480CtBu+LtVRcyQLACS3tA@mail.gmail.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19665

* Matt Turner (mattst88@gmail.com) [110826 01:45]:
> I think we can simplify this a bit. How about something like what I've
> attached? (I didn't touch the load location stuff)

I thought about that as well before sending in the patch.

As I want to remove the "I'm building for this machine now"-stuff
as far as possible, a CPU_LOONGSON2_GENERIC-option needs to either
depend on exactly one machine being selected, or some way to specify
which machine should be builded for.

Not too important now, but I wanted to avoid touching this part later
on again.


Andi

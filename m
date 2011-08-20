Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Aug 2011 15:09:27 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47595 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491939Ab1HTNJX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Aug 2011 15:09:23 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7KD9L5e006640;
        Sat, 20 Aug 2011 14:09:21 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7KD9JWG006635;
        Sat, 20 Aug 2011 14:09:19 +0100
Date:   Sat, 20 Aug 2011 14:09:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hillf Danton <dhillf@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        "Steven J. Hill" <sjhill@realitydiluted.com>,
        Chris Dearman <chris@mips.com>
Subject: Re: [RFC patch] MIPS: select correct tc
Message-ID: <20110820130918.GA5097@linux-mips.org>
References: <CAJd=RBA9ihp94TtjkWbAVo1Y_2+Vp1VskJWVahN85biCEAYWtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJd=RBA9ihp94TtjkWbAVo1Y_2+Vp1VskJWVahN85biCEAYWtQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14986

On Thu, Aug 04, 2011 at 10:38:31PM +0800, Hillf Danton wrote:

> If we could find tc on the tc list for @index, the found tc should be returned.

This bug has been in the VPE code since 2009 and it pretty much proofs
that nobody is using this crap.

I've applied your patch but your finding of this bug which is around since
about two years pretty much proofs that nobody is using this code, so it
can be removed.  It's been fugly since day one..

Thanks,

  Ralf

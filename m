Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 14:48:02 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38099 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492175Ab0LANr7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Dec 2010 14:47:59 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oB1Dlpfc002872;
        Wed, 1 Dec 2010 13:47:51 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oB1DloZj002870;
        Wed, 1 Dec 2010 13:47:50 GMT
Date:   Wed, 1 Dec 2010 13:47:50 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnaud Lacombe <lacombar@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Reiser <jreiser@bitwagon.com>, linux-mips@linux-mips.org,
        wu zhangjin <wuzhangjin@gmail.com>
Subject: Re: Build failure triggered by recordmcount
Message-ID: <20101201134750.GB32555@linux-mips.org>
References: <AANLkTikjbP89qp24u1Pw6zcsyV7WcYYtmR0Yt3yCaXoh@mail.gmail.com>
 <AANLkTim-+1csKoCc7kqXERmLZRSt9LAAB=JPK+0gaYPo@mail.gmail.com>
 <AANLkTikaUxKqsqXKYpETOnWAMuCi5gp30ANux0RQuK6Z@mail.gmail.com>
 <AANLkTinr1bU+_YCTW9xyJ9H0qiSOifBMsxC6iujszMvs@mail.gmail.com>
 <4CEB37F8.1050504@bitwagon.com>
 <1290532165.30543.374.camel@gandalf.stny.rr.com>
 <AANLkTikO+MK2CCyZqXLDtVnjbfJLVa06wTdZ1bZcG-Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikO+MK2CCyZqXLDtVnjbfJLVa06wTdZ1bZcG-Vg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28581
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 23, 2010 at 03:09:43PM -0500, Arnaud Lacombe wrote:

> [0] Ralf, is there any specific reason mips keeps defining its own
> _IOC_SIZEBITS ?

History.  The ABI once upon a time was meant to be compatible the existing
commercial MIPS UNIX flavours.  Today that's just historical baggage.

  Ralf

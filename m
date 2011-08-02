Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 20:02:04 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50531 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491200Ab1HBSCA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2011 20:02:00 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p72I1uLN002661;
        Tue, 2 Aug 2011 19:01:56 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p72I1uXx002659;
        Tue, 2 Aug 2011 19:01:56 +0100
Date:   Tue, 2 Aug 2011 19:01:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 01/15] MIPS: Alchemy: fix typo in MAC0 registration
Message-ID: <20110802180156.GA1718@linux-mips.org>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
 <1312307470-6841-2-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1312307470-6841-2-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1632

On Tue, Aug 02, 2011 at 07:50:56PM +0200, Manuel Lauss wrote:

> Harmless typo which prints an error message although MAC0 was
> registered successfully.

Thanks, applied.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 15:49:32 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41499 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903563Ab1KIOt2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 15:49:28 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9EnRd6019420;
        Wed, 9 Nov 2011 14:49:27 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9EnRb8019419;
        Wed, 9 Nov 2011 14:49:27 GMT
Date:   Wed, 9 Nov 2011 14:49:27 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/18] MIPS: Alchemy: drop MIRAGE/BOSPORUS board support
Message-ID: <20111109144927.GB19187@linux-mips.org>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
 <1320174224-27305-3-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320174224-27305-3-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7761

On Tue, Nov 01, 2011 at 08:03:28PM +0100, Manuel Lauss wrote:

> No test hardware and no (apparent) users.  These boards seem very
> similar to the DB1500, so if required support can be brought back
> again (I have datasheets) but then with dedicated board code, not
> tacked on to DB1000 support.

Experience says reaction is always a release after the feature removal ;)

Queued for 3.3.  Thanks,

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2011 13:31:02 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53958 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903592Ab1KNMa6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Nov 2011 13:30:58 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAECUuDo010033;
        Mon, 14 Nov 2011 12:30:56 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAECUu9j010032;
        Mon, 14 Nov 2011 12:30:56 GMT
Date:   Mon, 14 Nov 2011 12:30:56 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH V4 8/8] MIPS: BMIPS: Add SMP support code for
 BMIPS43xx/BMIPS5000
Message-ID: <20111114123056.GA9633@linux-mips.org>
References: <36859ca538c51c6927c40ce4fe655d71@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36859ca538c51c6927c40ce4fe655d71@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11539

On Sat, Nov 12, 2011 at 01:30:30PM -0800, Kevin Cernekee wrote:

> Initial commit of BMIPS SMP support code.  Smoke-tested on a variety of
> BMIPS4350, BMIPS4380, and BMIPS5000 platforms.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Thanks, I replaced the old patch with this one.

  Ralf

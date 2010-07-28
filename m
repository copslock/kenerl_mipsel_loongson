Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jul 2010 23:33:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41035 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492154Ab0G1Vdl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jul 2010 23:33:41 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6SLXNGO012422;
        Wed, 28 Jul 2010 22:33:23 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6SLXLDo012410;
        Wed, 28 Jul 2010 22:33:21 +0100
Date:   Wed, 28 Jul 2010 22:33:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Dezhong Diao <dediao@cisco.com>,
        devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        dvomlehn@cisco.com
Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
Message-ID: <20100728213320.GA11538@linux-mips.org>
References: <20100727214948.GA29241@dediao-lnx2.corp.sa.net>
 <AANLkTi=a=tGURpMKo7g+32LMcFovx4GJk2Wid6vmvQt8@mail.gmail.com>
 <4C5082BE.5050203@caviumnetworks.com>
 <AANLkTi=74zoQziQTmAGo-cNtF9FAT77h+KZagsNEFjEf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTi=74zoQziQTmAGo-cNtF9FAT77h+KZagsNEFjEf@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 28, 2010 at 01:25:52PM -0600, Grant Likely wrote:

> It would probably be best if I at least pick up the first patch into
> my test tree to give it a spin with the latest changes.  I'd be happy
> to take the 2nd too to avoid ordering issues.

Makes sense and even though this patch applies to arch/mips it's probably
more of an DT than a MIPS patch.

That said a long standing problem is that code that is relevant to MIPS
tends to get tested only if it's in one of the MIPS trees but far less in
other trees such as -next.

  Ralf

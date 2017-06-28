Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 02:59:03 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57494 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993946AbdF1A65MigAO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 02:58:57 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5S0wsWR008691;
        Wed, 28 Jun 2017 02:58:54 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5S0wri4008690;
        Wed, 28 Jun 2017 02:58:53 +0200
Date:   Wed, 28 Jun 2017 02:58:53 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com, Raghu.Gandham@imgtec.com,
        Leonid.Yegoshin@imgtec.com, Douglas.Leung@imgtec.com,
        Petar.Jovanovic@imgtec.com, Miodrag.Dinic@imgtec.com,
        Goran.Ferenc@imgtec.com
Subject: Re: [PATCH 3/8] MIPS: R6: Fix PREF instruction usage by memcpy for
 MIPS R6
Message-ID: <20170628005853.GC6738@linux-mips.org>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1497887415-13825-4-git-send-email-aleksandar.markovic@rt-rk.com>
 <a5842e4b-a75b-2dde-d835-6a488790dbda@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5842e4b-a75b-2dde-d835-6a488790dbda@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jun 20, 2017 at 09:04:16AM +0100, Matt Redfearn wrote:

> Hi Aleksandar,
> 
> Wouldn't the more correct thing be to modify the memcpy loop such that
> prefetches do not fetch the larger offset? Just turning off prefetch
> altogether in memcpy for r6 seems like a heavy hammer to me...

It's the same heavy hammer we've been using for ages to deal with this
problem for other configurations as well.  So while you're right I don't
want to force Aleksandar to come up with The One Perfect Fix.  Though
that would be lovely :)

  Ralf

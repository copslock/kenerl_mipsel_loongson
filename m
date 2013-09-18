Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 13:11:07 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50350 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825760Ab3IRLLFM8CXd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Sep 2013 13:11:05 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8IBArIV026318;
        Wed, 18 Sep 2013 13:10:53 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8IBArbj026317;
        Wed, 18 Sep 2013 13:10:53 +0200
Date:   Wed, 18 Sep 2013 13:10:53 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Kconfig: CMP support needs to select SMP as well
Message-ID: <20130918111053.GK22468@linux-mips.org>
References: <1378460846-961-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1378460846-961-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37842
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

On Fri, Sep 06, 2013 at 10:47:26AM +0100, Markos Chandras wrote:

> The CMP code is only designed to work with SMP configurations.
> Fixes multiple build problems on certain randconfigs:

Applied - but I think the logic here may be backwards from a user's
perspective.  Shouldn't a user be asked for SMP first, then for
possible platform suboptions (CMP, VSMP, SMTC) of SMP?

  Ralf

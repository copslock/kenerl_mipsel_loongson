Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 17:36:02 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:47785 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903765Ab2FMPf6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jun 2012 17:35:58 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5DFZtec019182;
        Wed, 13 Jun 2012 16:35:55 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5DFZtC8019181;
        Wed, 13 Jun 2012 16:35:55 +0100
Date:   Wed, 13 Jun 2012 16:35:55 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/8] MIPS: BCM63XX: move flash registration out of
 board_bcm963xx.c
Message-ID: <20120613153555.GB14657@linux-mips.org>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
 <1339489425-19037-2-git-send-email-jonas.gorski@gmail.com>
 <20120613134801.GA5516@linux-mips.org>
 <2177534.JpaDVG7JnB@flexo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2177534.JpaDVG7JnB@flexo>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33627
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
Return-Path: <linux-mips-bounce@linux-mips.org>

I'm running a quick rebuild of all defconfigs before pushing it all out
to upstream-sfr.

  Ralf

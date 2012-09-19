Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2012 15:36:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57188 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903293Ab2ISNgb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Sep 2012 15:36:31 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8JDaSCi008559;
        Wed, 19 Sep 2012 15:36:28 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8JDaRZX008558;
        Wed, 19 Sep 2012 15:36:27 +0200
Date:   Wed, 19 Sep 2012 15:36:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: hide USE_OF
Message-ID: <20120919133627.GG19592@linux-mips.org>
References: <1347960534-5760-1-git-send-email-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1347960534-5760-1-git-send-email-jonas.gorski@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34529
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

On Tue, Sep 18, 2012 at 11:28:54AM +0200, Jonas Gorski wrote:

> b01da9f1 ("MIPS: Prune some target specific code out of prom.c") removed
> the generic implementation of device_tree_init, breaking the kernel
> build when manually selecting USE_OF.
> 
> Hide the config symbol so it can't be selected acidentially anymore.

I'm inclined to accept this patch but would like to wait for a little
longer for others' opinions.

  Ralf

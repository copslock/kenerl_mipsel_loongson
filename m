Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2012 09:38:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47335 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6870357Ab2JJHi2oEKp1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Oct 2012 09:38:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9A7cRVs005166;
        Wed, 10 Oct 2012 09:38:27 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9A7cQwn005163;
        Wed, 10 Oct 2012 09:38:26 +0200
Date:   Wed, 10 Oct 2012 09:38:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, Chris Dearman <chris@mips.com>,
        John Crispin <blogic@openwrt.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] MIPS: kspd: Remove kspd support.
Message-ID: <20121010073826.GB6740@linux-mips.org>
References: <1349821203-23083-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1349821203-23083-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34665
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

On Tue, Oct 09, 2012 at 05:20:03PM -0500, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> There are no users of the kspd functionality anymore.

Thanks.  I've already applied a probably identical patch.

With kspd gone, the question is if there is still any point in keeping
CONFIG_MIPS_VPE_APSP_API and MIPS_VPE_LOADER?  I've nuked those also but
I'm holding back for others to get a fair chance to speak up against.
But the fuse is now lit.

  Ralf

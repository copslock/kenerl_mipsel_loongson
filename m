Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Mar 2013 10:26:43 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:29444 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822839Ab3C1J0kZkg4D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Mar 2013 10:26:40 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 28 Mar 2013 02:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,924,1355126400"; 
   d="scan'208";a="308548761"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.160])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2013 02:26:29 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Svetoslav Neykov <svetoslav@neykov.name>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        Svetoslav Neykov <svetoslav@neykov.name>
Subject: Re: [PATCH v2 1/2] usb: chipidea: big-endian support
In-Reply-To: <1362176257-2328-2-git-send-email-svetoslav@neykov.name>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name> <1362176257-2328-2-git-send-email-svetoslav@neykov.name>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Thu, 28 Mar 2013 11:28:32 +0200
Message-ID: <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.shishkin@linux.intel.com
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

Svetoslav Neykov <svetoslav@neykov.name> writes:

> Convert between big-endian and little-endian format when accessing the usb controller structures which are little-endian by specification.
> Fix cases where the little-endian memory layout is taken for granted.
> The patch doesn't have any effect on the already supported
> little-endian architectures.

Applied to my branch of things that are aiming at v3.10. Next time
please make sure that it applies cleanly.

> (no changes since last version)

No need to mention this here, you can use cover letter and/or below the
diffstat, so that it's not part of the commit message.

Thanks,
--
Alex

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Feb 2013 14:34:19 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:16201 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823015Ab3BZNeQYEsGi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Feb 2013 14:34:16 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 26 Feb 2013 05:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,740,1355126400"; 
   d="scan'208";a="290665763"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.68])
  by orsmga002.jf.intel.com with ESMTP; 26 Feb 2013 05:34:03 -0800
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
Subject: Re: [PATCH 0/5] Chipidea driver support for the AR933x platform
In-Reply-To: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Tue, 26 Feb 2013 15:35:55 +0200
Message-ID: <87k3pvxkn8.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35822
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

> Add support for the usb controller in AR933x platform.
> The processor is big-endian so all multi-byte values of the usb 
> descriptors must be converted explicitly. Another difference is that
> the controller supports both host and device modes but not OTG.
> The patches are tested on WR703n router running OpenWRT trunk.

Svetoslav, are you working on these or do you have time to address the
issues raised in review?

Thanks,
--
Alex

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Feb 2013 12:07:14 +0100 (CET)
Received: from mga14.intel.com ([143.182.124.37]:62945 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823072Ab3BNLHLPTpip (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Feb 2013 12:07:11 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 14 Feb 2013 03:07:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,664,1355126400"; 
   d="scan'208";a="256891527"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.164])
  by azsmga001.ch.intel.com with ESMTP; 14 Feb 2013 03:06:59 -0800
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
Subject: Re: [PATCH 5/5] usb: chipidea: Fix incorrect check of function return value
In-Reply-To: <1360791538-6332-6-git-send-email-svetoslav@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name> <1360791538-6332-6-git-send-email-svetoslav@neykov.name>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Thu, 14 Feb 2013 13:08:36 +0200
Message-ID: <87a9r7b1aj.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35749
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

> Use the correct variable to check for the return value of the last function.

This one is fixed already by Julia Lawall: 5c6e9bf0

Regards,
--
Alex

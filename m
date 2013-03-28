Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Mar 2013 17:05:06 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:34627 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834885Ab3C1QFBHajJj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Mar 2013 17:05:01 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 28 Mar 2013 09:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,927,1355126400"; 
   d="scan'208";a="285848490"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.160])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2013 09:04:49 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Michael Grzeschik <mgr@pengutronix.de>
Cc:     Svetoslav Neykov <svetoslav@neykov.name>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Luis R. Rodriguez" <mcgrof@qca.qualcomm.com>,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: chipidea: big-endian support
In-Reply-To: <20130328141253.GA5079@pengutronix.de>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name> <1362176257-2328-2-git-send-email-svetoslav@neykov.name> <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com> <20130328141253.GA5079@pengutronix.de>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Thu, 28 Mar 2013 18:06:53 +0200
Message-ID: <87zjxnik4i.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35989
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

Michael Grzeschik <mgr@pengutronix.de> writes:

> On Thu, Mar 28, 2013 at 11:28:32AM +0200, Alexander Shishkin wrote:
>> Svetoslav Neykov <svetoslav@neykov.name> writes:
>> 
>> > Convert between big-endian and little-endian format when accessing the usb controller structures which are little-endian by specification.
>> > Fix cases where the little-endian memory layout is taken for granted.
>> > The patch doesn't have any effect on the already supported
>> > little-endian architectures.
>> 
>> Applied to my branch of things that are aiming at v3.10. Next time
>> please make sure that it applies cleanly.
>
> I am currently rebasing my fix/cleanup/feature patches against your
> ci-for-greg and realised that this patch missed to fix debug.c with
> cpu_le_32 action. Is someone volunteering to cook a patch?

Nice catch. If nobody beats me to it, I'll probably just amend that
patch in my branch in a couple of hours.

Regards,
--
Alex

Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Mar 2013 15:56:50 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:19675 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817088Ab3C2O4srHvEh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Mar 2013 15:56:48 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 29 Mar 2013 07:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,373,1363158000"; 
   d="scan'208";a="309157144"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.160])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2013 07:56:37 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Svetoslav Neykov <svetoslav@neykov.name>,
        'Michael Grzeschik' <mgr@pengutronix.de>
Cc:     'Ralf Baechle' <ralf@linux-mips.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Gabor Juhos' <juhosg@openwrt.org>,
        'John Crispin' <blogic@openwrt.org>,
        'Alan Stern' <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>,
        linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: RE: [PATCH v2 1/2] usb: chipidea: big-endian support
In-Reply-To: <023101ce2bfb$712ea0f0$538be2d0$@neykov.name>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name> <1362176257-2328-2-git-send-email-svetoslav@neykov.name> <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com> <20130328141253.GA5079@pengutronix.de> <023101ce2bfb$712ea0f0$538be2d0$@neykov.name>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Fri, 29 Mar 2013 16:58:40 +0200
Message-ID: <871uayqmlb.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35993
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

> Hi Michael,
>
> On Thu, March 28, 2013 4:13 PM Michael Grzeschik wrote: 
>>On Thu, Mar 28, 2013 at 11:28:32AM +0200, Alexander Shishkin wrote:
>>> Svetoslav Neykov <svetoslav@neykov.name> writes:
>>> 
>>> > Convert between big-endian and little-endian format when accessing the
> usb controller structures which are little-endian by specification.
>>> > Fix cases where the little-endian memory layout is taken for granted.
>>> > The patch doesn't have any effect on the already supported
>>> > little-endian architectures.
>>> 
>>> Applied to my branch of things that are aiming at v3.10. Next time
>>> please make sure that it applies cleanly.
>>
>>I am currently rebasing my fix/cleanup/feature patches against your
>>ci-for-greg and realised that this patch missed to fix debug.c with
>>cpu_le_32 action. Is someone volunteering to cook a patch?
>
> I will gladly make the changes, but after having a look at it I didn't spot
> any candidates. The DMA buffers are printed either as addresses in memory or
> as raw data which doesn't make sense to be cpu_le_32'ed. If Alexander hasn't
> already made the changes could you point me to the lines in question.

You're right, it's either physical addresses or raw data, no need for
conversions there.

Regards,
--
Alex

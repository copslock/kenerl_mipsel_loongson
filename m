Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Mar 2013 16:07:59 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:5375 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817088Ab3C2PH5tUXAm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Mar 2013 16:07:57 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 29 Mar 2013 08:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,373,1363158000"; 
   d="scan'208";a="310308622"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.160])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2013 08:07:46 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Svetoslav Neykov <svetoslav@neykov.name>,
        'Ralf Baechle' <ralf@linux-mips.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Gabor Juhos' <juhosg@openwrt.org>,
        'John Crispin' <blogic@openwrt.org>,
        'Alan Stern' <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: RE: [PATCH v2 1/2] usb: chipidea: big-endian support
In-Reply-To: <023c01ce2c03$1886e220$4994a660$@neykov.name>
References: <1362176257-2328-1-git-send-email-svetoslav@neykov.name> <1362176257-2328-2-git-send-email-svetoslav@neykov.name> <878v57kh4v.fsf@ashishki-desk.ger.corp.intel.com> <023c01ce2c03$1886e220$4994a660$@neykov.name>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Fri, 29 Mar 2013 17:09:50 +0200
Message-ID: <87y5d6p7i9.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35994
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

> Alexander Shishkin wrote:
>> Svetoslav Neykov <svetoslav@neykov.name> writes:
>>
>>> Convert between big-endian and little-endian format when accessing the
> usb controller structures which are little-endian by specification.
>>> Fix cases where the little-endian memory layout is taken for granted.
>>> The patch doesn't have any effect on the already supported
>>> little-endian architectures.
>>
>>Applied to my branch of things that are aiming at v3.10. Next time
>>please make sure that it applies cleanly.
>
> I am a bit confused about the workflow and which repository to base my work
> on. Should I use github/virtuoso/linux-ci for my future patches? Or
> linux-next?

It really depends on what your patches change. For chipidea driver
changes, yes it's that branch. For mips-related bits, it's most probably
something else. For gadget, otg or phy patches, it's Felipe's tree. If
you get it wrong, normally it shouldn't be too much work to rebase your
patches onto a different tree, especially for the author of the
patches. In some cases I might do it for you, but you should be aware of
possible penalties [1]. :)

For the coming merge window I'm fixing and rebasing everything for
everybody anyway, so this time it's no big deal.

[1] http://lwn.net/Articles/536546/

Regards,
--
Alex

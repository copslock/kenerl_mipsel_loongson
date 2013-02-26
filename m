Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Feb 2013 15:46:12 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:13830 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820301Ab3BZOqLDl0Oa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Feb 2013 15:46:11 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 26 Feb 2013 06:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,740,1355126400"; 
   d="scan'208";a="267863854"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.68])
  by orsmga001.jf.intel.com with ESMTP; 26 Feb 2013 06:45:59 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Svetoslav Neykov <svetoslav@neykov.name>,
        'Ralf Baechle' <ralf@linux-mips.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Gabor Juhos' <juhosg@openwrt.org>,
        'John Crispin' <blogic@openwrt.org>,
        'Alan Stern' <stern@rowland.harvard.edu>,
        "'Luis R. Rodriguez'" <mcgrof@qca.qualcomm.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org
Subject: RE: [PATCH 0/5] Chipidea driver support for the AR933x platform
In-Reply-To: <078801ce142f$0108dea0$031a9be0$@neykov.name>
References: <1360791538-6332-1-git-send-email-svetoslav@neykov.name> <87k3pvxkn8.fsf@ashishki-desk.ger.corp.intel.com> <078801ce142f$0108dea0$031a9be0$@neykov.name>
User-Agent: Notmuch/0.12+187~ga2502b0 (http://notmuchmail.org) Emacs/23.4.1 (x86_64-pc-linux-gnu)
Date:   Tue, 26 Feb 2013 16:47:50 +0200
Message-ID: <878v6bxhbd.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 35824
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

> Hi Alex,
> I am working on the incorporating all received comments - thanks to all for
> taking their time to comment.
> Apologies for not replying to the received mails, didn't want to spam with
> OK replies to each separately.

Great, thanks!
Looks like this patchset will need some synchronization with Sacha's
dr_mode/phy_mode patchset, but I presume you're aware of that.

Regards,
--
Alex

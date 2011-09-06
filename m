Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2011 14:22:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43290 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491143Ab1IFMV7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Sep 2011 14:21:59 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p86CLKCA027435;
        Tue, 6 Sep 2011 14:21:20 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p86CKea8027414;
        Tue, 6 Sep 2011 14:20:40 +0200
Date:   Tue, 6 Sep 2011 14:20:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jiri Pirko <jpirko@redhat.com>, tg@linux-mips.org
Cc:     Ben Hutchings <bhutchings@solarflare.com>, netdev@vger.kernel.org,
        fubar@us.ibm.com, andy@greyhouse.net, kaber@trash.net,
        bprakash@broadcom.com, JBottomley@parallels.com,
        robert.w.love@intel.com, davem@davemloft.net,
        shemminger@linux-foundation.org, decot@google.com,
        mirq-linux@rere.qmqm.pl, alexander.h.duyck@intel.com,
        amit.salecha@qlogic.com, eric.dumazet@gmail.com,
        therbert@google.com, paulmck@linux.vnet.ibm.com,
        laijs@cn.fujitsu.com, xiaosuo@gmail.com, greearb@candelatech.com,
        loke.chetan@gmail.com, linux-mips@linux-mips.org,
        linux-scsi@vger.kernel.org, devel@open-fcoe.org,
        bridge@lists.linux-foundation.org
Subject: Re: [patch net-next-2.6 v3] net: consolidate and fix
 ethtool_ops->get_settings calling
Message-ID: <20110906122040.GA25774@linux-mips.org>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
 <20110902122630.GC1991@minipsycho>
 <1314989161.3419.5.camel@bwh-desktop>
 <20110903133428.GA2821@minipsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110903133428.GA2821@minipsycho>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3086

On Sat, Sep 03, 2011 at 03:34:30PM +0200, Jiri Pirko wrote:

>  arch/mips/txx9/generic/setup_tx4939.c |    2 +-

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Feel free to merge this through the net tree.

  Ralf

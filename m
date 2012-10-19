Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2012 17:55:30 +0200 (CEST)
Received: from c60.cesmail.net ([216.154.195.49]:52949 "EHLO c60.cesmail.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823122Ab2JSPz3FmUsH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Oct 2012 17:55:29 +0200
Received: from unknown (HELO smtprelay1.cesmail.net) ([192.168.1.111])
  by c60.cesmail.net with ESMTP; 19 Oct 2012 11:55:22 -0400
Received: from mj (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
        by smtprelay1.cesmail.net (Postfix) with ESMTPSA id 387EE34C93;
        Fri, 19 Oct 2012 11:55:58 -0400 (EDT)
Date:   Fri, 19 Oct 2012 11:55:17 -0400
From:   Pavel Roskin <proski@gnu.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Joe Perches <joe@perches.com>, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        brcm80211-dev-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, devel@open-fcoe.org,
        dev@openvswitch.org, linux-s390@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        bridge@lists.linux-foundation.org, lvs-devel@vger.kernel.org,
        coreteam@netfilter.org, b43-dev@lists.infradead.org,
        cbe-oss-dev@lists.ozlabs.org, devel@driverdev.osuosl.org,
        wimax@linuxwimax.org, devicetree-discuss@lists.ozlabs.org,
        linux-nfs@vger.kernel.org, netfilter@vger.kernel.org,
        user-mode-linux-user@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        davinci-linux-open-source@linux.davincidsp.com,
        linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
        b.a.t.m.a.n@lists.open-mesh.org, linux-wireless@vger.kernel.org,
        users@rt2x00.serialmonkey.com, e1000-devel@lists.sourceforge.net,
        ath9k-devel@lists.ath9k.org, netfilter-devel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [ath9k-devel] [PATCH net-next 00/21] treewide: Use consistent
 api style for address testing
Message-ID: <20121019115517.7b8514a8@mj>
In-Reply-To: <1350630254.2293.183.camel@edumazet-glaptop>
References: <cover.1350618006.git.joe@perches.com>
        <1350630254.2293.183.camel@edumazet-glaptop>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.8; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 34728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: proski@gnu.org
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

On Fri, 19 Oct 2012 09:04:14 +0200
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Yes they are some names discrepancies, thats a big deal.
> 
> And we have alloc_skb() / kfree_skb() / skb_clone() 
> 
> Why not skb_alloc() / skb_free() / skb_clone() ?
> 
> Some people actually know current code by name of functions, they dont
> want to change their mind and having to grep include files and git log
> to learn the new names of an old function, especially when traveling
> and using a laptop.

I agree.

Also, it makes sense to introduce a more consistent name for a function
when it's improved in some way and the callers need to be adjusted or
re-checked.

That way, the old name can be phased out as the code is made compatible
with the new function.

-- 
Regards,
Pavel Roskin

Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2018 06:12:04 +0100 (CET)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:38564 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991082AbeKQFLmBvg8j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Nov 2018 06:11:42 +0100
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C75D213FE78BF;
        Fri, 16 Nov 2018 21:11:38 -0800 (PST)
Date:   Fri, 16 Nov 2018 21:11:35 -0800 (PST)
Message-Id: <20181116.211135.178846692709588415.davem@davemloft.net>
To:     alexei.starovoitov@gmail.com
Cc:     mirq-linux@rere.qmqm.pl, netdev@vger.kernel.org, ast@kernel.org,
        benh@kernel.crashing.org, daniel@iogearbox.net, jhogan@kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, paul.burton@mips.com, paulus@samba.org,
        ralf@linux-mips.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH net-next 0/6] Remove VLAN.CFI overload
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAADnVQKzo_85bUPXnaqds0MxzrOu_BJwnZx25CbsNrjV=DHC3w@mail.gmail.com>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
        <20181110.134758.693752342395888727.davem@davemloft.net>
        <CAADnVQKzo_85bUPXnaqds0MxzrOu_BJwnZx25CbsNrjV=DHC3w@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Nov 2018 21:11:39 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 Nov 2018 19:51:55 -0800

> Michal, could you please explain the reasoning?

By treating VLAN.CFI specially as "VLAN TAG PRESENT" we prevent
the usage of certain VLAN ID encodings.

So he's trying to get rid of VLAN_TAG_PRESENT completely and this
was the final patch series necessary to accomplish that.

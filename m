Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2014 00:31:50 +0100 (CET)
Received: from alius.ayous.org ([89.238.89.44]:41146 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822283AbaCLXbswGcMZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Mar 2014 00:31:48 +0100
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <aba@ayous.org>)
        id 1WNsch-0006N8-UM; Wed, 12 Mar 2014 23:31:44 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@ayous.org>)
        id 1WNscc-0005yX-Fr; Thu, 13 Mar 2014 00:31:38 +0100
Date:   Thu, 13 Mar 2014 00:31:38 +0100
From:   Andreas Barth <aba@ayous.org>
To:     John Crispin <john@phrozen.org>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V19 00/13] MIPS: Add Loongson-3 based machines support
Message-ID: <20140312233138.GY12772@mails.so.argh.org>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com> <20140306103017.GX16461@mails.so.argh.org> <532076A7.1040606@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <532076A7.1040606@phrozen.org>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@ayous.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@ayous.org
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

* John Crispin (john@phrozen.org) [140312 16:01]:
>    Andi,
>    can we get a reviewed-by from you ?

As discussed on IRC I don't think I fullfill the criteria for a
Reviewed-by (because I haven't done a technical review of the code;
however based on the existing reviews I'm convinved this patch series
does fullfill the criteria for inclusion into the mainline kernel, but
Reviewed-by is more than just that), but you could add
Tested-by: Andreas Barth <aba@ayous.org>
if you consider that useful.


Andi

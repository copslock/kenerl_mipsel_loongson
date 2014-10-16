Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 08:58:43 +0200 (CEST)
Received: from linux-libre.fsfla.org ([208.118.235.54]:57177 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010716AbaJPG6l20ANT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 08:58:41 +0200
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s9G6wHHt018393;
        Thu, 16 Oct 2014 06:58:21 GMT
Received: from free.home (free.home [172.31.160.1])
        by freie.home (8.14.8/8.14.8) with ESMTP id s9G6vY4s020686;
        Thu, 16 Oct 2014 03:57:34 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Yoichi Yuasa <yuasa@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: incomplete mips patch made 3.10.55, remains broken in 3.10.58
Organization: Free thinker, not speaking for FSF Latin America
Date:   Thu, 16 Oct 2014 03:57:33 -0300
Message-ID: <orppdsbixu.fsf@free.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <lxoliva@fsfla.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lxoliva@fsfla.org
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

--=-=-=

Greg,

Commit ff522058bd717506b2fa066fa564657f2b86477e was merged into 3.10.55
stable as commit 4f91cb537d2f7fa700a2b6d86a2cc77d20ee2616.

Without the complement, commit 5596b0b245fb9d2cefb5023b11061050351c1398,
included below, cache invalidation functions modified by the former
patch may return between preempt_disable() and preempt_enable(), causing
such machines as yeeloongs to go down in flames early in the boot.

The complement patch had already made v3.12-rc4, and it's quite
obviously needed and correct.  I've also tested that it fixes the
regression on the yeeloong.

So, would you please merge it into the 3.10 stable series, at your
earlier convenience, so as to fix this regression?

Thanks in advance,


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=fix-3.10.55-r4k-preempt-regression.patch

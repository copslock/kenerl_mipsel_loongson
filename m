Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 15:06:43 +0100 (CET)
Received: from linux-libre.fsfla.org ([208.118.235.54]:49724 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994676AbeCROGhJZYaj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 15:06:37 +0100
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.164])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id w2IE6QTT006802;
        Sun, 18 Mar 2018 14:06:27 GMT
Received: from livre (livre.home [172.31.160.2])
        by freie.home (8.15.2/8.15.2) with ESMTP id w2IE68wO216233;
        Sun, 18 Mar 2018 11:06:08 -0300
From:   Alexandre Oliva <lxoliva@fsfla.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: 3.16.55-stable breaks yeeloong
Organization: Free thinker, not speaking for FSF Latin America
Date:   Sun, 18 Mar 2018 11:06:04 -0300
Message-ID: <ortvtd4gxf.fsf@lxoliva.fsfla.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <lxoliva@fsfla.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63027
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

Commit 304acb717e5b67cf56f05bc5b21123758e1f7ea0 AKA
https://patchwork.linux-mips.org/patch/9705/ was backported to 3.16.55
stable as 8605aa2fea28c0485aeb60c114a9d52df1455915 and I'm afraid it
causes yeeloongs to fail to boot up.  3.16.54 was fine; bisection took
me to this patch.

The symptom is a kernel panic -- attempt to kill init.  No further info
is provided.

Is this problem already known?  Is there by any chance a known fix for
me to try, or should I investigate further?

Thanks in advance,

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer

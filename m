Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 08:00:00 +0100 (CET)
Received: from linux-libre.fsfla.org ([208.118.235.54]:51111 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27005162AbbBDG74AQEhU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 07:59:56 +0100
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t146xQQM026049;
        Wed, 4 Feb 2015 06:59:27 GMT
Received: from livre.home (livre.home [172.31.160.2])
        by freie.home (8.14.8/8.14.8) with ESMTP id t146xImS030415;
        Wed, 4 Feb 2015 04:59:18 -0200
From:   Alexandre Oliva <oliva@gnu.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: 3.19-rcs won't boot on yeeloong
Organization: Free thinker, not speaking for the GNU Project
References: <orr3u6p4ad.fsf@livre.home>
Date:   Wed, 04 Feb 2015 04:59:18 -0200
In-Reply-To: <orr3u6p4ad.fsf@livre.home> (Alexandre Oliva's message of "Wed,
        04 Feb 2015 04:41:14 -0200")
Message-ID: <ormw4up3g9.fsf@livre.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <oliva@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oliva@gnu.org
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

On Feb  4, 2015, Alexandre Oliva <oliva@gnu.org> wrote:

> Bisecting led to your commit 4227a2d4efc9c84f35826dc4d1e6dc183f6c1c05,

> Are you by any chance already aware of this regression?

Nevermind, I found in the patchwork a reference to the commit that fixes
it.  However, I'm surprised it's been known for so long and not merged
into Linus' tree yet.  Is it not going to make 3.19?

http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=5bba8dec735f18fe7a2fcd8327f28ef095337ff2
https://patchwork.linux-mips.org/patch/7683/

Thanks,

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 07:41:50 +0100 (CET)
Received: from linux-libre.fsfla.org ([208.118.235.54]:51098 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010820AbbBDGloeWSD5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 07:41:44 +0100
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t146fXk6011084;
        Wed, 4 Feb 2015 06:41:34 GMT
Received: from livre.home (livre.home [172.31.160.2])
        by freie.home (8.14.8/8.14.8) with ESMTP id t146fE8I027335;
        Wed, 4 Feb 2015 04:41:15 -0200
From:   Alexandre Oliva <oliva@gnu.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: 3.19-rcs won't boot on yeeloong
Organization: Free thinker, not speaking for the GNU Project
Date:   Wed, 04 Feb 2015 04:41:14 -0200
Message-ID: <orr3u6p4ad.fsf@livre.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <oliva@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45641
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

The symptom is an oops very early on boot, with do_cpu and
resume_userspace_check as the only two functions in the stack trace.

Bisecting led to your commit 4227a2d4efc9c84f35826dc4d1e6dc183f6c1c05,
though with linus' tree (rather than loongson-community, where I first
observed the problem) I can't really tell whether the stack trace is the
same, as there is no sm712 support there any more, and even if I patch
it in, the screen is severely garbled with the minimized config I use
for the bisection.  I need a handful of other patches to bring even 3.18
to a bootable state on yeeloongs, too, and I've applied the small
patchset throughout the bisection.

Are you by any chance already aware of this regression?  Could it be
that thte problem is elsewhere, and bisection just happened to find a
spot in the middle of a larger changeset whose intermediate steps
wouldn't work?

Thanks in advance for any advice you might be able to provide on how to
debug or work around this problem.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer

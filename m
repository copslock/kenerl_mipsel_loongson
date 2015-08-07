Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 05:37:13 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:40123 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008972AbbHGDhL4gQf5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 05:37:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date; bh=k1X7LUElT14eujAK2oZvcT8Z9fSHAL80eGrpwA8v0bI=;
        b=H4Jmvtx9sc/wiN9JJl5yx2f1/cTEGQFR7ChXf9Fdawf46+AcsHC791pY7lGCuvoMbHyBbqK4pg7cseicA0dMTMU1ODM2i3mDpxq90dLSUWDoHsPEZFCRukqEjo4c7P4s7YHJcV+JE1m0TwZX00iZ5WpWhU2T1lbdoPQgoz+YWio=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38293 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZNYSs-001Em9-A9; Fri, 07 Aug 2015 03:37:03 +0000
Date:   Thu, 6 Aug 2015 20:36:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Fuulong2e support broken since commit 3adeb2566b9 ("MIPS: Loongson:
 Improve LEFI firmware interface")
Message-ID: <20150807033659.GA26215@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Hi,

I have been playing with qemu and its fuloong2e support. Unfortunately,
it turned out that mainline support for it is broken. Maybe just the qemu
simulation, maybe for real. The breakage was introduced with commit
3adeb2566b9 ("MIPS: Loongson: Improve LEFI firmware interface").
Bisect log and the test script used to track down the commit are below.

Unfortunately the changes are too substantial for me to understand.
I'll be happy to test potential patches, but I don't think I can identify
the actual problem.

Key question though is if this is going to be fixed or not. The basic reason
for spending time on it was that I wanted to get a qemu test run to work 
with the Fuulong2e target, so it would be useful for me to know. If not, it
might make sense to drop the Fuulong2e default configuration.

Please let me know if you need additional information.

Thanks,
Guenter

---
bisect log:

# bad: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
# good: [b2776bf7149bddd1f4161f14f79520f17fc1d71d] Linux 3.18
git bisect start 'v3.19' 'v3.18'
# bad: [54850e73e86e3bc092680d1bdb84eb322f982ab1] zram: change parameter from vaild_io_request()
git bisect bad 54850e73e86e3bc092680d1bdb84eb322f982ab1
# good: [6b9e2cea428cf7af93a84bcb865e478d8bf1c165] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect good 6b9e2cea428cf7af93a84bcb865e478d8bf1c165
# good: [b5f185f33d0432cef6ff78765e033dfa8f4de068] Merge tag 'master-2014-12-08' of git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-next
git bisect good b5f185f33d0432cef6ff78765e033dfa8f4de068
# good: [bae41e45b7400496b9bf0c70c6004419d9987819] Merge tag 'sound-3.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good bae41e45b7400496b9bf0c70c6004419d9987819
# bad: [c0222ac086669a631814bbf857f8c8023452a4d7] Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus
git bisect bad c0222ac086669a631814bbf857f8c8023452a4d7
# good: [140cd7fb04a4a2bc09a30980bc8104cc89e09330] Merge tag 'powerpc-3.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux
git bisect good 140cd7fb04a4a2bc09a30980bc8104cc89e09330
# bad: [b0854514537e4e2f0a599ca05d18fe95dcd3ee42] clocksource: mips-gic: Move gic_frequency to clocksource driver
git bisect bad b0854514537e4e2f0a599ca05d18fe95dcd3ee42
# good: [432d9ecb9628bdcb20670b2cf0678f3738bd40a5] MIPS: R3000: Remove redundant parentheses
git bisect good 432d9ecb9628bdcb20670b2cf0678f3738bd40a5
# bad: [3526f74fa925e44335b94ed0c9f93648e26058ef] clk: ls1x: Update relationship among all clocks
git bisect bad 3526f74fa925e44335b94ed0c9f93648e26058ef
# bad: [d175ed2bd6544474dcc99d74f8155c2ba44e8db2] MIPS: Ensure Config5.UFE is clear on boot
git bisect bad d175ed2bd6544474dcc99d74f8155c2ba44e8db2
# bad: [e292ccde216e571faad475e4331c188f22a28182] MIPS: Loongson-3: Add RS780/SBX00 HPET support
git bisect bad e292ccde216e571faad475e4331c188f22a28182
# good: [ec0f8d3fbb7ea12cfd10083e340381b96e7c34f8] MIPS: Loongson: Allow booting from any core
git bisect good ec0f8d3fbb7ea12cfd10083e340381b96e7c34f8
# bad: [89467e73d3881a470ce4ffdcba1d5a5ed618379a] MIPS: Loongson-3: Add oprofile support
git bisect bad 89467e73d3881a470ce4ffdcba1d5a5ed618379a
# bad: [3adeb2566b9bc1dbf579ed515265c6aad756a5cd] MIPS: Loongson: Improve LEFI firmware interface
git bisect bad 3adeb2566b9bc1dbf579ed515265c6aad756a5cd
# first bad commit: [3adeb2566b9bc1dbf579ed515265c6aad756a5cd] MIPS: Loongson: Improve LEFI firmware interface

---
Test script follows. "make-mips" in the script
translates to

PATH=/opt/poky/1.3/sysroots/x86_64-pokysdk-linux/usr/bin/mips32-poky-linux:${PATH}
make -j12 ARCH=mips CROSS_COMPILE=mips-poky-linux- $*

qemu is the latest version (v2.4.0-rc3).
I'll be happy to make the root file system available if needed.
It was built with a recent version of buildroot with mips1 support
re-enabled, with some changes to reboot immediately.

---
echo -n "Configuring ... "

make-mips fuloong2e_defconfig >/dev/null 2>&1
cp .config /tmp/config.save
sed -i -e 's/# CONFIG_DEVTMPFS is not set/CONFIG_DEVTMPFS=y/' .config
echo "CONFIG_DEVTMPFS_MOUNT=y" >> .config
make-mips olddefconfig >/dev/null 2>&1

echo -n "Building ... "

make-mips >/dev/null 2>&1
if [ $? -ne 0 ]
then
    echo "Failed."
    exit 1
fi

echo -n "Running ... "

qemu-system-mips64el -machine fulong2e -cpu Loongson-2E \
	-kernel vmlinux -append 'root=/dev/hda console=ttyS0' \
	-hda rootfs.mipsel.ext3 -m 512 -nographic -serial stdio \
	-monitor null -no-reboot 2>/dev/null \
	| grep "Restarting system" >/dev/null

rv=$?

if [ ${rv} -eq 0 ]
then
	echo Passed.
else
	echo Failed.
fi

exit ${rv}

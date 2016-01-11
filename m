Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2016 12:00:29 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:45187 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009470AbcAKLA0Jj0pe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Jan 2016 12:00:26 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (Postfix) with ESMTPS id CA63D9389B;
        Mon, 11 Jan 2016 11:00:19 +0000 (UTC)
Received: from redhat.com (vpn1-6-10.ams2.redhat.com [10.36.6.10])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u0BB09mF020366;
        Mon, 11 Jan 2016 06:00:10 -0500
Date:   Mon, 11 Jan 2016 13:00:09 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Julian Calaby <julian.calaby@gmail.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v4 0/3] checkpatch: handling of memory barriers
Message-ID: <1452509968-19778-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

As part of memory barrier cleanup, this patchset
extends checkpatch to make it easier to stop
incorrect memory barrier usage.

This replaces the checkpatch patches in my series
	arch: barrier cleanup + barriers for virt
and will be included in the pull request including
the series.

changes from v3:
	rename smp_barrier_stems to barrier_stems
	as suggested by Julian Calaby.
	add (?: ... ) around a variable in regexp,
	in case we change the value later so that it matters.
changes from v2:
	address comments by Joe Perches:
	use (?: ... ) to avoid unnecessary capture groups
	rename smp_barriers to smp_barrier_stems for clarity
	add barriers before/after atomic
Changes from v1:
	catch optional\s* before () in barriers
	rewrite using qr{} instead of map

Michael S. Tsirkin (3):
  checkpatch.pl: add missing memory barriers
  checkpatch: check for __smp outside barrier.h
  checkpatch: add virt barriers

Michael S. Tsirkin (3):
  checkpatch.pl: add missing memory barriers
  checkpatch: check for __smp outside barrier.h
  checkpatch: add virt barriers

 scripts/checkpatch.pl | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

-- 
MST

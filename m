Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 14:53:52 +0200 (CEST)
Received: from ugs.tarent.de ([193.107.123.165]:57322 "EHLO ugs.tarent.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825655Ab3HUMxktAP0r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Aug 2013 14:53:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by ugs.tarent.de (Postfix) with ESMTP id 1DDEA60612D20;
        Wed, 21 Aug 2013 14:53:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by ugs.tarent.de (Postfix) with ESMTP id 7ABB260612D21;
        Wed, 21 Aug 2013 14:53:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.1 (20080629) (Debian) at tarent.de
Received: from ugs.tarent.de ([127.0.0.1])
        by localhost (ugs.tarent.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id syEjIidP+EnR; Wed, 21 Aug 2013 14:53:31 +0200 (CEST)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
        by ugs.tarent.de (Postfix) with ESMTPS id 7661460612D20;
        Wed, 21 Aug 2013 14:53:30 +0200 (CEST)
Date:   Wed, 21 Aug 2013 14:53:30 +0200 (CEST)
From:   Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To:     Richard Weinberger <richard@nod.at>
cc:     linux-arch@vger.kernel.org, mmarek@suse.cz, geert@linux-m68k.org,
        ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com,
        gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] Get rid of SUBARCH
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
Message-ID: <alpine.DEB.2.10.1308211452260.31430@tglase.lan.tarent.de>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <t.glaser@tarent.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: t.glaser@tarent.de
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

On Wed, 21 Aug 2013, Richard Weinberger wrote:

> The series touches also m68k, sh, mips and unicore32.
> These architectures magically select a cross compiler if ARCH != SUBARCH.
> Do really need that behavior?

Not precisely that, but it’s very common in m68k land
to just cross-build kernels with

$ make ARCH=m68k menuconfig
$ make ARCH=m68k

Maybe a generalising of that feature, and making it
independent of SUBARCH (which can then die)?

bye,
//mirabilos
-- 
[16:04:33] bkix: "veni vidi violini"
[16:04:45] bkix: "ich kam, sah und vergeigte"...

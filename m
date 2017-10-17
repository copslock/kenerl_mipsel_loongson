Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 15:14:17 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:34787 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990505AbdJQNOKlpBsn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Oct 2017 15:14:10 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC51CAB22;
        Tue, 17 Oct 2017 13:14:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E18D3DA8B4; Tue, 17 Oct 2017 15:12:20 +0200 (CEST)
Date:   Tue, 17 Oct 2017 15:12:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: next/master build: 214 builds: 29 failed, 185 passed, 29 errors,
 68 warnings (next-20171016)
Message-ID: <20171017131220.GX3521@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        "kernelci.org bot" <bot@kernelci.org>,
        Kernel Build Reports Mailman List <kernel-build-reports@lists.linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <59e53a9c.0a98df0a.acf5c.fc96@mx.google.com>
 <CAK8P3a1Qk+H3zp23zR=3Wsh-Yp3YOZ0bF6BNcFHjnEHd9XnCjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Qk+H3zp23zR=3Wsh-Yp3YOZ0bF6BNcFHjnEHd9XnCjA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Return-Path: <dsterba@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dsterba@suse.cz
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

On Tue, Oct 17, 2017 at 11:00:04AM +0200, Arnd Bergmann wrote:
> > 2 fs/btrfs/tree-checker.c:186:4: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Wformat=]
> > 1 fs/btrfs/tree-checker.c:186:70: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Wformat=]
> 
> I sent a patch a few days ago, Dave Sterba reviewed it, but it hasn't
> gone in yet.

The patch was picked last Friday, and is now part of linux-next tree

https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=for-next&id=6881041b521fff47c3b31269ec9b8b5ebe7d631e

There might be a few days delay, caused by testing, before my kernel.org
for-next branch is updated and then picked by linux-next.

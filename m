Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jun 2015 11:11:12 +0200 (CEST)
Received: from [195.135.220.15] ([195.135.220.15]:55605 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008605AbbFOJLJvVhix (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Jun 2015 11:11:09 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1717AAB4;
        Mon, 15 Jun 2015 09:10:58 +0000 (UTC)
Received: by sepie.suse.cz (Postfix, from userid 10020)
        id 50D4940768; Mon, 15 Jun 2015 11:10:58 +0200 (CEST)
Date:   Mon, 15 Jun 2015 11:10:58 +0200
From:   Michal Marek <mmarek@suse.cz>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gitignore: Add MIPS vmlinux.32 to the list
Message-ID: <20150615091058.GA6984@sepie.suse.cz>
References: <1429896460-15026-1-git-send-email-f.fainelli@gmail.com>
 <CAGVrzcb7oMa97=w_jSDPga6yPV50f6-QEBUnX1fhMFdQqDv1xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVrzcb7oMa97=w_jSDPga6yPV50f6-QEBUnX1fhMFdQqDv1xw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <mmarek@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmarek@suse.cz
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

On Sat, Jun 13, 2015 at 11:37:33AM -0700, Florian Fainelli wrote:
> 2015-04-24 10:27 GMT-07:00 Florian Fainelli <f.fainelli@gmail.com>:
> > MIPS64 kernels builds will produce a vmlinux.32 kernel image for
> > compatibility, ignore them.
> 
> Ralf, Michal, which one of you should take this patch?

I just applied it to kbuild.git#misc.

Michal

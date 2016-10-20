Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 20:05:06 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:60688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993016AbcJTSE7zYSqM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Oct 2016 20:04:59 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C36A20278;
        Thu, 20 Oct 2016 18:04:53 +0000 (UTC)
Received: from potion (dhcp-1-100.brq.redhat.com [10.34.1.100])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u9KI4od0002292;
        Thu, 20 Oct 2016 14:04:51 -0400
Received: by potion (sSMTP sendmail emulation); Thu, 20 Oct 2016 20:04:50 +0200
Date:   Thu, 20 Oct 2016 20:04:50 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL] MIPS KVM fix for v4.9-rc2
Message-ID: <20161020180449.GC8569@potion>
References: <1476971554-1215-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476971554-1215-1-git-send-email-james.hogan@imgtec.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 20 Oct 2016 18:04:53 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-10-20 14:52+0100, James Hogan:
> Hi Radim, Paolo,
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/kvm-mips.git tags/kvm_mips_4.9_2
> 
> for you to fetch changes up to d852b5f35e84e60c930589eeb14a6df21ea9b1cb:
> 
>   KVM: MIPS: Add missing uaccess.h include (2016-10-19 00:37:05 +0100)
> 
> I'd already based this on v4.9-rc1 rather than the kvm next branch which
> isn't up to v4.9-rc1 yet. If thats a problem I can easily rebase, or
> feel free to apply the patch directly.

Not a problem, I would have done that anyway.

Pulled, thanks.

Btw. patches for -rc2+ kernels ought to be based on kvm/master.
It doesn't matter now, but kvm/master and kvm/next will diverge at -rc3
(max 4), when patches intended for 4.10 are going to be applied to
kvm/next.  And kvm/next isn't rebased, so it will stay on -rc[34] until
Linus pulls in the 4.10 merge window.

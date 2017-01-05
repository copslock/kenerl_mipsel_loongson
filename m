Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2017 17:55:13 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:43816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992209AbdAEQzBZVTWG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jan 2017 17:55:01 +0100
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9865861BAA;
        Thu,  5 Jan 2017 16:54:55 +0000 (UTC)
Received: from potion (dhcp-1-104.brq.redhat.com [10.34.1.104])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id v05Gsq9M014206;
        Thu, 5 Jan 2017 11:54:52 -0500
Received: by potion (sSMTP sendmail emulation); Thu, 05 Jan 2017 17:54:50 +0100
Date:   Thu, 5 Jan 2017 17:54:50 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: MIPS: Misc fixes for 4.10
Message-ID: <20170105165450.GA29430@potion>
References: <cover.cdddb6fe1a787c96c57358e404931f87f547e5e5.1483464823.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.cdddb6fe1a787c96c57358e404931f87f547e5e5.1483464823.git-series.james.hogan@imgtec.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 05 Jan 2017 16:54:55 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56167
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

2017-01-03 17:42+0000, James Hogan:
> This series contains a couple of 4.10 fixes.
> 
> - Patch 1 fixes when KVM is used by a 64-bit (n64) userland program,
>   which can result in a kernel crash when a signal is delivered on the
>   way back out from the guest.
> 
> - Patch 2 fixes flushing of the entry code from the icache to take place
>   on all CPUs rather than only the local one.
> 
> Both are tagged for stable.

Applied to kvm/master, thanks.

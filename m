Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 22:03:02 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:48171 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992466AbcHRUCzhXKZk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Aug 2016 22:02:55 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id u7IK2qQ1017975;
        Thu, 18 Aug 2016 22:02:52 +0200
Date:   Thu, 18 Aug 2016 22:02:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?iso-8859-1?B?S3I/P23hPz8=?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH BACKPORT 3.10-3.15 0/4] MIPS: KVM: Fix MMU/TLB management
 issues
Message-ID: <20160818200252.GE17944@1wt.eu>
References: <cover.04bc2e89e693aeb69bf6e36d1d7b18ffb591bd31.1471021142.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.04bc2e89e693aeb69bf6e36d1d7b18ffb591bd31.1471021142.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

On Thu, Aug 18, 2016 at 10:22:51AM +0100, James Hogan wrote:
> These patches backport fixes for several issues in the management of
> MIPS KVM TLB faults to 3.15, and should apply back to 3.10 too.

queued for 3.10, thanks James!
Willy

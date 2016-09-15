Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Sep 2016 00:08:39 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:64802 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992259AbcIOWIcl0xBl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Sep 2016 00:08:32 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id u8FM8TPZ017450;
        Fri, 16 Sep 2016 00:08:29 +0200
Date:   Fri, 16 Sep 2016 00:08:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?iso-8859-1?B?S3I/P23hPz8=?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH BACKPORT 3.10-3.16] MIPS: KVM: Check for pfn noslot case
Message-ID: <20160915220829.GB17443@1wt.eu>
References: <8d00898f91834454a4daf5c4944ddace9c6866f4.1473975914.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d00898f91834454a4daf5c4944ddace9c6866f4.1473975914.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55145
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

On Thu, Sep 15, 2016 at 10:51:27PM +0100, James Hogan wrote:
> commit ba913e4f72fc9cfd03dad968dfb110eb49211d80 upstream.
(...)

Queued for 3.10, thank you James.

Willy

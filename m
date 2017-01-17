Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 17:26:24 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36128 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993895AbdAQQ0QsS9IB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 17:26:16 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0HGQGsA029421;
        Tue, 17 Jan 2017 17:26:16 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0HGQG4O029420;
        Tue, 17 Jan 2017 17:26:16 +0100
Date:   Tue, 17 Jan 2017 17:26:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH 4/30] MIPS: Export some tlbex internals for KVM to use
Message-ID: <20170117162616.GF24215@linux-mips.org>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
 <3007c32a817fa8ab6f1b20069d595d5f853c3545.1483665879.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3007c32a817fa8ab6f1b20069d595d5f853c3545.1483665879.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jan 06, 2017 at 01:32:36AM +0000, James Hogan wrote:

> Export to TLB exception code generating functions so that KVM can
> construct a fast TLB refill handler for guest context without
> reinventing the wheel quite so much.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

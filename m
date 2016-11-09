Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 18:34:57 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:57884 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992514AbcKIRevPIFQn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2016 18:34:51 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id uA9HYmJZ020459;
        Wed, 9 Nov 2016 18:34:48 +0100
Date:   Wed, 9 Nov 2016 18:34:48 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, stable@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?iso-8859-1?B?S3I/P23hPz8=?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: Re: [BACKPORT PATCH 3.10..3.16] KVM: MIPS: Drop other CPU ASIDs on
 guest MMU changes
Message-ID: <20161109173448.GE19862@1wt.eu>
References: <20161109144624.16683-1-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161109144624.16683-1-james.hogan@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55753
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

On Wed, Nov 09, 2016 at 02:46:24PM +0000, James Hogan wrote:
> commit 91e4f1b6073dd680d86cdb7e42d7cccca9db39d8 upstream.
(...)

And queued as well for 3.10, thanks James!

Willy

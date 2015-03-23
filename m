Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 14:56:25 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40427 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009567AbbCWN4XaO07F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Mar 2015 14:56:23 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2NDuMNJ008969;
        Mon, 23 Mar 2015 14:56:22 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2NDuKeL008968;
        Mon, 23 Mar 2015 14:56:20 +0100
Date:   Mon, 23 Mar 2015 14:56:20 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        Gleb Natapov <gleb@kernel.org>
Subject: Re: [PATCH 02/20] MIPS: Clear [MSA]FPE CSR.Cause after notify_die()
Message-ID: <20150323135620.GA8891@linux-mips.org>
References: <1426085096-12932-1-git-send-email-james.hogan@imgtec.com>
 <1426085096-12932-3-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426085096-12932-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46496
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

On Wed, Mar 11, 2015 at 02:44:38PM +0000, James Hogan wrote:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Feel free to merge this through the KVM tree along with the remainder of
the series.

  Ralf

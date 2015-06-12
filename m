Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jun 2015 14:07:56 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:38857 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006935AbbFLMHyPdZGu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jun 2015 14:07:54 +0200
Received: from [10.172.192.212] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1Z3NkR-0007XO-CY; Fri, 12 Jun 2015 12:07:47 +0000
Date:   Fri, 12 Jun 2015 13:07:46 +0100
From:   Luis Henriques <luis.henriques@canonical.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     stable <stable@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Gleb Natapov <gleb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: KVM: do not sign extend on unsigned MMIO load
Message-ID: <20150612120746.GB1625@ares>
References: <1431002870-30098-1-git-send-email-hofrat@osadl.org>
 <554CC530.20906@imgtec.com>
 <5575536E.8080608@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5575536E.8080608@imgtec.com>
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

On Mon, Jun 08, 2015 at 09:33:50AM +0100, James Hogan wrote:
> Hi stable folk,
> 
> On 08/05/15 15:16, James Hogan wrote:
> > On 07/05/15 13:47, Nicholas Mc Guire wrote:
> >> Fix possible unintended sign extension in unsigned MMIO loads by casting
> >> to uint16_t in the case of mmio_needed != 2.
> >>
> >> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > 
> > Looks good to me. I wrote an MMIO test to reproduce the issue, and this
> > fixes it.
> > 
> > Reviewed-by: James Hogan <james.hogan@imgtec.com>
> > Tested-by: James Hogan <james.hogan@imgtec.com>
> > 
> > It looks suitable for stable too (3.10+).
> 
> This has reached mainline, commit ed9244e6c534612d2b5ae47feab2f55a0d4b4ced
> 
> Please could it be added to stable (3.10+).
> 
> Thanks
> James

Thanks, I'm queuing it for the 3.16 as well.

Cheers,
--
Luís

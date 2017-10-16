Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 23:28:49 +0200 (CEST)
Received: from imap1.codethink.co.uk ([176.9.8.82]:41611 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990451AbdJPV2mfrGt0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 23:28:42 +0200
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1e4Cvz-0006dx-0g; Mon, 16 Oct 2017 22:28:27 +0100
Message-ID: <1508189305.22379.54.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 36/50] MIPS: IRQ Stack: Unwind IRQ stack onto task
 stack
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Date:   Mon, 16 Oct 2017 22:28:25 +0100
In-Reply-To: <20171006083711.033827562@linuxfoundation.org>
References: <20171006083705.157012217@linuxfoundation.org>
         <20171006083711.033827562@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <ben.hutchings@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben.hutchings@codethink.co.uk
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

On Fri, 2017-10-06 at 10:53 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Matt Redfearn <matt.redfearn@imgtec.com>
> 
> 
> [ Upstream commit db8466c581cca1a08b505f1319c3ecd246f16fa8 ]
[...]

There was a follow-up to this which I suspect is also needed on the 4.4
and 4.9 branches: commit 5fdc66e04620 ("MIPS: Fix minimum alignment
requirement of IRQ stack").

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 16:29:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39212 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991932AbdCOP14cj57V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Mar 2017 16:27:56 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2FD8Vac006736;
        Wed, 15 Mar 2017 14:08:31 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2FD8NFc006734;
        Wed, 15 Mar 2017 14:08:23 +0100
Date:   Wed, 15 Mar 2017 14:08:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Miller <davem@davemloft.net>, david.daney@cavium.com,
        linux-mips@linux-mips.org, james.hogan@imgtec.com, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        steven.hill@cavium.com
Subject: Re: [PATCH v2 0/5] MIPS: BPF: JIT fixes and improvements.
Message-ID: <20170315130823.GA5512@linux-mips.org>
References: <20170314212144.29988-1-david.daney@cavium.com>
 <20170314.172937.1289357366273291363.davem@davemloft.net>
 <1d09f001-aa15-e3bf-be85-a13b1132a12a@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d09f001-aa15-e3bf-be85-a13b1132a12a@caviumnetworks.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57296
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

On Tue, Mar 14, 2017 at 05:34:02PM -0700, David Daney wrote:

> > What tree are you targetting with these changes?  Do you expect
> > them to go via the MIPS or the net-next tree?
> > 
> > Please be explicit about this in the future.
> > 
> 
> Sorry I didn't mention it.
> 
> My expectation is that Ralf would merge it via the MIPS tree, as it is fully
> contained within arch/mips/*

Thanks, applied.

  Ralf

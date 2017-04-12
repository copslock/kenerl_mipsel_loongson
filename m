Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Apr 2017 13:53:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43686 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992213AbdDLLxEtK6fJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Apr 2017 13:53:04 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3CBr3bI023018;
        Wed, 12 Apr 2017 13:53:03 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3CBr3w7023017;
        Wed, 12 Apr 2017 13:53:03 +0200
Date:   Wed, 12 Apr 2017 13:53:03 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: smp-cps: add missing include
Message-ID: <20170412115303.GA23014@linux-mips.org>
References: <1491974499-28414-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491974499-28414-1-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57674
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

On Wed, Apr 12, 2017 at 07:21:39AM +0200, Marcin Nowakowski wrote:

> An earlier change ('MIPS: Use common outgoing-CPU-notification code')
> is missing a required header with cpu notification method declarations
> leading to build failures.
> 
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> ---
> 
> Ralf,
>  Could you squash this patch together with the original commit?

Done.

  Ralf

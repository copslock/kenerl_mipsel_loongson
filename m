Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2010 16:39:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58802 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492467Ab0CQPjY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Mar 2010 16:39:24 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2HFdMSJ007814;
        Wed, 17 Mar 2010 16:39:22 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2HFdJK4007807;
        Wed, 17 Mar 2010 16:39:20 +0100
Date:   Wed, 17 Mar 2010 16:39:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrea Gelmini <andrea.gelmini@gelma.net>
Cc:     linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
Message-ID: <20100317153918.GD4554@linux-mips.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
 <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 27, 2010 at 05:51:23PM +0100, Andrea Gelmini wrote:
> From: Andrea Gelmini <andrea.gelmini@gelma.net>
> Date:   Sat, 27 Feb 2010 17:51:23 +0100
> To: linux-kernel@vger.kernel.org
> Cc: Andrea Gelmini <andrea.gelmini@gelma.net>,
> 	Ralf Baechle <ralf@linux-mips.org>,
> 	Paul Mundt <lethal@linux-sh.org>, linux-mips@linux-mips.org,
> 	linux-sh@vger.kernel.org
> Subject: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
> 
> arch/mips/lib/libgcc.h:21: ERROR: open brace '{' following union go on the same line
> 
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/mips/lib/libgcc.h |    3 +--
>  arch/sh/lib/libgcc.h   |    3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

I've applied the MIPS portion of the patch, thanks.

  Ralf

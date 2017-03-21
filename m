Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2017 20:40:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37726 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993889AbdCUTkdSbTza (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Mar 2017 20:40:33 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2LJeW3j009604;
        Tue, 21 Mar 2017 20:40:32 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2LJeWoW009603;
        Tue, 21 Mar 2017 20:40:32 +0100
Date:   Tue, 21 Mar 2017 20:40:32 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: smp-cps: Fix retrieval of VPE mask on big endian
 CPUs
Message-ID: <20170321194032.GA9598@linux-mips.org>
References: <1490107159-2659-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490107159-2659-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57405
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

On Tue, Mar 21, 2017 at 02:39:19PM +0000, Matt Redfearn wrote:

Thanks, applied.

  Ralf

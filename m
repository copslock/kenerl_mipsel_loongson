Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2016 22:48:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37552 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993385AbcLUVr5dYoAk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Dec 2016 22:47:57 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id uBLLluNT023931;
        Wed, 21 Dec 2016 22:47:56 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id uBLLluUW023930;
        Wed, 21 Dec 2016 22:47:56 +0100
Date:   Wed, 21 Dec 2016 22:47:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 06/10] MIPS: Export invalid_pte_table alongside its
 definition
Message-ID: <20161221214756.GA20460@linux-mips.org>
References: <20161107111417.11486-1-paul.burton@imgtec.com>
 <20161107111417.11486-7-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161107111417.11486-7-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56115
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

On Mon, Nov 07, 2016 at 11:14:12AM +0000, Paul Burton wrote:

> It's unclear to me why this wasn't always the case, but move the
> EXPORT_SYMBOL invocation for invalid_pte_table to be alongside its
> definition.

It used to be defined in assembler, in head.S.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 12:33:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57072 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993909AbdDJKc4NxbsI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Apr 2017 12:32:56 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3AAWtkh025256;
        Mon, 10 Apr 2017 12:32:55 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3AAWtUN025255;
        Mon, 10 Apr 2017 12:32:55 +0200
Date:   Mon, 10 Apr 2017 12:32:55 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: uasm: Remove needless ISA abstraction
Message-ID: <20170410103255.GD24214@linux-mips.org>
References: <20170330215216.6872-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330215216.6872-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57627
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

On Thu, Mar 30, 2017 at 02:52:15PM -0700, Paul Burton wrote:

> We always either target MIPS32/MIPS64 or microMIPS, and always include
> one & only one of uasm-mips.c or uasm-micromips.c. Therefore the
> abstraction of the ISA in asm/uasm.h declaring functions for either ISA
> is redundant & needless. Remove it to simplify the code.
> 
> This is largely the result of the following:
> 
>   :%s/ISAOPC(\(.\{-}\))/uasm_i##\1/
>   :%s/ISAFUNC(\(.\{-}\))/\1/

Queued for 4.12.

Thanks,

  Ralf

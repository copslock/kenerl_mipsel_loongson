Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 14:57:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:43104 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27029619AbcEQM5dYRf0l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2016 14:57:33 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4HCvXc7005848;
        Tue, 17 May 2016 14:57:33 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4HCvXsg005847;
        Tue, 17 May 2016 14:57:33 +0200
Date:   Tue, 17 May 2016 14:57:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] DEC: Export `ioasic_ssr_lock' to modules
Message-ID: <20160517125733.GG14481@linux-mips.org>
References: <alpine.LFD.2.20.1605161305050.19898@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1605161305050.19898@eddie.linux-mips.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53483
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

On Mon, May 16, 2016 at 01:15:47PM +0100, Maciej W. Rozycki wrote:

> Fix a modular `declance' regression caused by LMO commit bb46bf30d13f 
> ("DECstation SCSI driver clean-ups.")

Thanks, applied.

  Ralf

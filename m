Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 16:07:49 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36189 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492615AbZK0PHq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2009 16:07:46 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nARF84Qu008145;
        Fri, 27 Nov 2009 15:08:04 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nARF83Gb008143;
        Fri, 27 Nov 2009 15:08:03 GMT
Date:   Fri, 27 Nov 2009 15:08:03 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] [loongson] Cleanups of serial port support
Message-ID: <20091127150803.GB5971@linux-mips.org>
References: <1259067244-7487-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259067244-7487-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 08:54:04PM +0800, Wu Zhangjin wrote:

> This can not be folded into the old cleanup ;)

The reason I've not applied it yet is because the patch rejects and that is
probably because I seem to be missing another patch which needs to be
applied before this one can be applied - but I have nothing left in
patchworks.

  Ralf

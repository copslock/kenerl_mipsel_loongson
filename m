Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Dec 2009 22:48:33 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54032 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1494396AbZLSVsQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Dec 2009 22:48:16 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBJLmC4v019959;
        Sat, 19 Dec 2009 21:48:13 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBJLm9AH019957;
        Sat, 19 Dec 2009 21:48:09 GMT
Date:   Sat, 19 Dec 2009 21:48:09 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Cleanup forgotten label_module_alloc in tlbex.c
Message-ID: <20091219214809.GA19780@linux-mips.org>
References: <1259891034-15086-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259891034-15086-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 03, 2009 at 05:43:54PM -0800, David Daney wrote:

> commit e0cc87f59490d7d62a8ab2a76498dc8a2b64927a left
> label_module_alloc unused.  Remove it now.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Thanks, applied.

  Ralf

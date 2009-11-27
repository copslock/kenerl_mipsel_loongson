Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 15:41:48 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36254 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492602AbZK0Olo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2009 15:41:44 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAREg0S4006014;
        Fri, 27 Nov 2009 14:42:00 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAREg0dG006012;
        Fri, 27 Nov 2009 14:42:00 GMT
Date:   Fri, 27 Nov 2009 14:42:00 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] [loongson] Lemote-2F: Suspend CS5536 MFGPT Timer
Message-ID: <20091127144200.GA5971@linux-mips.org>
References: <1259070516-18546-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1259070516-18546-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 09:48:36PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Before putting loongson2f into wait mode, suspend the MFGPT Timer, and
> after wake-up, resume it. This may save some power.

Thanks, queued for 2.6.33.

  Ralf

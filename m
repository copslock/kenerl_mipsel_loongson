Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 02:18:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47383 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492569Ab0BCBSZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2010 02:18:25 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o131IXIM012298;
        Wed, 3 Feb 2010 02:18:35 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o131IVnP012296;
        Wed, 3 Feb 2010 02:18:31 +0100
Date:   Wed, 3 Feb 2010 02:18:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Loongson: Lemote 2F: Fixup of the Makefile
Message-ID: <20100203011831.GA12263@linux-mips.org>
References: <1264927312-21390-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264927312-21390-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 31, 2010 at 04:41:52PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch removes the duplicated obj-y line.

Thanks; I've folded this patch into the existing "MIPS: Loongson: Lemote-2F:
Get the machine type from PMON_VER" patch.

  Ralf

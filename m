Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 15:57:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47187 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009775AbbGNN5AFsa-u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 15:57:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6EDuwgi032248;
        Tue, 14 Jul 2015 15:56:58 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6EDuu7R032247;
        Tue, 14 Jul 2015 15:56:56 +0200
Date:   Tue, 14 Jul 2015 15:56:56 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] MIPS: remove outdated comments in sigcontext.h
Message-ID: <20150714135656.GA30463@linux-mips.org>
References: <1436540426-10021-1-git-send-email-paul.burton@imgtec.com>
 <1436540426-10021-2-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436540426-10021-2-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48273
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

On Fri, Jul 10, 2015 at 04:00:10PM +0100, Paul Burton wrote:

> The offsets to various fields within struct sigcontext are declared
> using asm-offsets.c these days, so drop the outdated comment that talks
> about keeping in sync with a no longer present file.

What's outdated is the path but the offsets still need to be extracted
by asm-offset.c and that requires the field names to be kept in sync
in both files.

  Ralf

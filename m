Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 19:01:05 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33345 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013227AbaKKSBDYytPg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 19:01:03 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sABI12S6008669;
        Tue, 11 Nov 2014 19:01:02 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sABI12H5008668;
        Tue, 11 Nov 2014 19:01:02 +0100
Date:   Tue, 11 Nov 2014 19:01:02 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 10/10] MIPS: lantiq: refactor the falcon sysctrl code
Message-ID: <20141111180102.GE29662@linux-mips.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
 <1412978554-31344-11-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412978554-31344-11-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44010
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

On Sat, Oct 11, 2014 at 12:02:34AM +0200, John Crispin wrote:

This is the last one of the series still in patchwork.  I tried to apply it
but I'm getting rejects.  Can you respin & resend?  Thanks,

  Ralf

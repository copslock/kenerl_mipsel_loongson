Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 11:26:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35062 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903714Ab2HNJZz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 11:25:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7E9Ps8X030314;
        Tue, 14 Aug 2012 11:25:54 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7E9Pskw030313;
        Tue, 14 Aug 2012 11:25:54 +0200
Date:   Tue, 14 Aug 2012 11:25:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3 2/4] MIPS: ath79: use correct IRQ number for the OHCI
 controller on AR7240
Message-ID: <20120814092554.GB28466@linux-mips.org>
References: <1344096087-25044-1-git-send-email-juhosg@openwrt.org>
 <1344096087-25044-3-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344096087-25044-3-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34139
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Applied.  Lemme know if this one also is required for any of the -stable
branches.

  Ralf

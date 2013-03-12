Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 10:44:18 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57230 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827427Ab3CLJoQx0vi6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Mar 2013 10:44:16 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r2C9iFE4002211;
        Tue, 12 Mar 2013 10:44:16 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r2C9iFLQ002210;
        Tue, 12 Mar 2013 10:44:15 +0100
Date:   Tue, 12 Mar 2013 10:44:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: use CONFIG_CPU_MIPSR2 in csum_partial.S
Message-ID: <20130312094414.GA2207@linux-mips.org>
References: <1362314375-25925-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1362314375-25925-1-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35870
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

On Sun, Mar 03, 2013 at 01:39:35PM +0100, Gabor Juhos wrote:

Thanks, applied.

  Ralf

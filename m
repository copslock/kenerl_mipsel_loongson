Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Mar 2013 13:59:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57940 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827486Ab3CLM7gR4qos (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Mar 2013 13:59:36 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r2CCxZFm012053;
        Tue, 12 Mar 2013 13:59:35 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r2CCxZox012052;
        Tue, 12 Mar 2013 13:59:35 +0100
Date:   Tue, 12 Mar 2013 13:59:35 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: VR4133: add LL/SC support
Message-ID: <20130312125935.GB6203@linux-mips.org>
References: <20130221153819.b3e9b650d87ffea492679a86@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130221153819.b3e9b650d87ffea492679a86@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35876
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

On Thu, Feb 21, 2013 at 03:38:19PM +0900, Yoichi Yuasa wrote:

Patch is looking good, applied.  Thanks, Yoichi-San!

I noticed that there's no <asm/mach-vr41xx/cpu-feature-overrides.h> file,
so all CPU features will always be runtime tested.  This is going to be
rather slow and bloated.  You could also use this to specifically define
cpu_has_llsc to 0/1 for those platforms that are known to have not have/
have ll/sc instructions.

  Ralf

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Dec 2013 00:33:41 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:34412 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825378Ab3L3Xdj26de1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Dec 2013 00:33:39 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 0A54F56F8A2
        for <linux-mips@linux-mips.org>; Tue, 31 Dec 2013 01:33:39 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id l7ytXiEG1g38 for <linux-mips@linux-mips.org>;
        Tue, 31 Dec 2013 01:33:34 +0200 (EET)
Received: from musicnaut.iki.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with SMTP id D7D265BC005
        for <linux-mips@linux-mips.org>; Tue, 31 Dec 2013 01:33:33 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Tue, 31 Dec 2013 01:33:28 +0200
Resent-From: Aaro Koskinen <aaro.koskinen@iki.fi>
Resent-Date: Tue, 31 Dec 2013 01:33:28 +0200
Resent-Message-ID: <20131230233328.GA7429@blackmetal.musicnaut.iki.fi>
Resent-To: linux-mips@linux-mips.org
Date:   Sun, 29 Dec 2013 21:12:56 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Petr =?utf-8?B?UMOtc2HFmQ==?= <petr.pisar@atlas.cz>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Fix cache flushing on Loongson 2
Message-ID: <20131229191256.GC19462@blackmetal.musicnaut.iki.fi>
References: <1387980262-2250-1-git-send-email-petr.pisar@atlas.cz>
 <1387980262-2250-2-git-send-email-petr.pisar@atlas.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1387980262-2250-2-git-send-email-petr.pisar@atlas.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Dec 25, 2013 at 03:04:21PM +0100, Petr Písař wrote:
> This bug was introduced by an unintended branch swap in commit
> 14bd8c082016cd1f67fdfd702e4cf6367869a712 (MIPS: Loongson:
> Get rid of Loongson 2 #ifdefery all over arch/mips).

Fixes for both of these issues have been already sent earlier, see the
following patches:

http://marc.info/?l=linux-mips&m=138575576803890&w=2
http://marc.info/?l=linux-mips&m=138575575002599&w=2

A.

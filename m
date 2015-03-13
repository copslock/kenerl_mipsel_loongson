Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 19:53:04 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:44457 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008691AbbCMSxDRtuso (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 19:53:03 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 3BE2A56F888;
        Fri, 13 Mar 2015 20:53:03 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id 2EljlyiLFPxC; Fri, 13 Mar 2015 20:52:58 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 4DF7A5BC003;
        Fri, 13 Mar 2015 20:52:58 +0200 (EET)
Date:   Fri, 13 Mar 2015 20:52:58 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Paul Martin <paul.martin@codethink.co.uk>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/6] MIPS: OCTEON: Patches to enable Little Endian
Message-ID: <20150313185258.GJ587@fuloong-minipc.musicnaut.iki.fi>
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46378
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

On Fri, Mar 13, 2015 at 05:34:52PM +0000, Paul Martin wrote:
> Octeon II CPUs can switch from Big Endian to Little Endian freely
> even in kernel/supervisor mode.

You are enabling it on all OCTEONS. Is that valid? At least octeon-usb
still needs to be fixed for little-endian mode.

> These patches allow an EdgeRouterPro to boot in LE mode with no
> hardware modifications.  They have not been subjected to extensive
> testing yet and should be considered experimental.  (I have seen some
> strange memory corruption in libstdc++ which I haven't yet been able
> to trace.)

Which drivers did you test? Did you test e.g. octeon-md5?

Definitely not ready for merging.

A.

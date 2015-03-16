Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 11:39:50 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:48642 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013881AbbCPKjtCwIQn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 11:39:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 0A99D4608F5;
        Mon, 16 Mar 2015 10:39:44 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8cDLdW9its9M; Mon, 16 Mar 2015 10:39:41 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id E400546088B;
        Mon, 16 Mar 2015 10:39:40 +0000 (GMT)
Received: from localhost ([::1] helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YXSQu-0007OL-8S; Mon, 16 Mar 2015 10:39:40 +0000
Date:   Mon, 16 Mar 2015 10:39:40 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Paul Martin <paul.martin@codethink.co.uk>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 0/6] MIPS: OCTEON: Patches to enable Little Endian
Message-ID: <20150316103939.GA28205@paulmartin.codethink.co.uk>
Mail-Followup-To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Martin <paul.martin@codethink.co.uk>,
        linux-mips@linux-mips.org
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
 <20150313185258.GJ587@fuloong-minipc.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150313185258.GJ587@fuloong-minipc.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

On Fri, Mar 13, 2015 at 08:52:58PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Mar 13, 2015 at 05:34:52PM +0000, Paul Martin wrote:
> > Octeon II CPUs can switch from Big Endian to Little Endian freely
> > even in kernel/supervisor mode.
> 
> You are enabling it on all OCTEONS. Is that valid? At least octeon-usb
> still needs to be fixed for little-endian mode.

The USB works perfectly with the patches that were posted to this list
over the last couple of months.

I'm currently booting off a USB SSD and building on it!

> > These patches allow an EdgeRouterPro to boot in LE mode with no
> > hardware modifications.  They have not been subjected to extensive
> > testing yet and should be considered experimental.  (I have seen some
> > strange memory corruption in libstdc++ which I haven't yet been able
> > to trace.)
> 
> Which drivers did you test? Did you test e.g. octeon-md5?

No, I haven't tested any of the crypto functions in the kernel.  I'm
assuming that anything that doesn't access hardware has been written
in an endian-agnostic fashion.

> Definitely not ready for merging.

I know that!  I should have marked it RFC.  I did say it was
experimental and not well tested.

-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.

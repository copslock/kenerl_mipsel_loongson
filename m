Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2015 15:44:36 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:33040 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026159AbbD0NofK3x2e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2015 15:44:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 56F4B460C83;
        Mon, 27 Apr 2015 14:44:31 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CfUPmfpM1vmq; Mon, 27 Apr 2015 14:44:28 +0100 (BST)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id D8B6E4607A3;
        Mon, 27 Apr 2015 14:44:28 +0100 (BST)
Received: from localhost ([::1] helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YmjKm-0002Uz-E0; Mon, 27 Apr 2015 14:44:28 +0100
Date:   Mon, 27 Apr 2015 14:44:28 +0100
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: mips build failures due to commit 8dd928915a73 (mips: fix up
 obsolete cpu function usage)
Message-ID: <20150427134427.GA5551@paulmartin.codethink.co.uk>
Mail-Followup-To: Aaro Koskinen <aaro.koskinen@nokia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
References: <20150421154108.GA20223@roeck-us.net>
 <20150427130343.GA26951@ak-desktop.emea.nsn-net.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150427130343.GA26951@ak-desktop.emea.nsn-net.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47086
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

On Mon, Apr 27, 2015 at 04:03:48PM +0300, Aaro Koskinen wrote:
> On Tue, Apr 21, 2015 at 08:41:08AM -0700, Guenter Roeck wrote:
> > The following might do it. Note that I can not really test it since I
> > don't have a real mips system, and qemu gets rcu hangs if I enable more
> > than one CPU (I see that with older kernels as well, so it is not a new
> > problem). Someone will have to test the patch on a real multi-core system.
> 
> That works on Octeon+ EBH5600 board (8 cores) with 4.1-rc1.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>

http://patchwork.linux-mips.org/patch/9828/

I've been using this patch since 21 Apr on the 4.1 merge HEAD on
EdgeRouter Pro (Octeon II, dual core).  It's survived several
builds of gcc (using make -j3).

Tested-by: Paul Martin <paul.martin@codethink.co.uk>

-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.

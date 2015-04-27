Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2015 15:04:56 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:42569 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025564AbbD0NEzRBGWV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2015 15:04:55 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t3RD4gpv010013
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 27 Apr 2015 13:04:42 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id t3RD4doY018615;
        Mon, 27 Apr 2015 15:04:39 +0200
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Mon, 27 Apr 2015 16:03:52 +0300
Date:   Mon, 27 Apr 2015 16:03:48 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rusty Russell <rusty@rustcorp.com.au>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: mips build failures due to commit 8dd928915a73 (mips: fix up
 obsolete cpu function usage)
Message-ID: <20150427130343.GA26951@ak-desktop.emea.nsn-net.net>
References: <20150421154108.GA20223@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150421154108.GA20223@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 499
X-purgate-ID: 151667::1430139882-0000746E-945B067C/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nokia.com
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

On Tue, Apr 21, 2015 at 08:41:08AM -0700, Guenter Roeck wrote:
> The following might do it. Note that I can not really test it since I
> don't have a real mips system, and qemu gets rcu hangs if I enable more
> than one CPU (I see that with older kernels as well, so it is not a new
> problem). Someone will have to test the patch on a real multi-core system.

That works on Octeon+ EBH5600 board (8 cores) with 4.1-rc1.

Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks,

A.

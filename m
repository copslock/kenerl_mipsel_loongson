Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2014 16:50:38 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:53089 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816071AbaFDOuensHyK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jun 2014 16:50:34 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s54EoNfc005499
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 4 Jun 2014 14:50:23 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.45.49])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id s54EoLH8012530;
        Wed, 4 Jun 2014 16:50:22 +0200
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Wed, 04 Jun 2014 17:47:39 +0300
Date:   Wed, 4 Jun 2014 17:47:39 +0300
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Alex Smith <alex.smith@imgtec.com>,
        David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [1/3] MIPS: octeon: Add interface mode detection for Octeon II
Message-ID: <20140604144739.GB24816@ak-desktop.emea.nsn-net.net>
References: <1401358203-60225-2-git-send-email-alex.smith@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1401358203-60225-2-git-send-email-alex.smith@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 802
X-purgate-ID: 151667::1401893423-00001326-0039270D/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nsn.com
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

On Thu, May 29, 2014 at 11:10:01AM +0100, Alex Smith wrote:
> Add interface mode detection for Octeon II. This is necessary to detect
> the interface modes correctly on the UBNT E200 board. Code is taken
> from the UBNT GPL source release, with some alterations: SRIO, ILK and
> RXAUI interface modes are removed and instead return disabled as these
> modes are not currently supported.
> 
> Tested-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Alex Smith <alex.smith@imgtec.com>

I tried booting ebb6800 board with these patches.

It hangs somewhere in __cvmx_helper_xaui_enable() with XAUI port. Looking
at the UBNT GPL package, xaui init is quite different with 68XX specific
code paths.  Maybe those bits should be added too, or then disable XAUI
support as well?

A.

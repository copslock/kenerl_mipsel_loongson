Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2016 15:39:04 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:37030 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27031411AbcEZNjCmWo1- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 May 2016 15:39:02 +0200
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u4QDchfc013943
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 26 May 2016 13:38:43 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.36.118])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id u4QDcfKB026276;
        Thu, 26 May 2016 15:38:41 +0200
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Thu, 26 May 2016 16:36:34 +0300
Date:   Thu, 26 May 2016 16:36:34 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney.cavm@gmail.com>
Subject: Re: THP broken on OCTEON?
Message-ID: <20160526133634.GI23204@ak-desktop.emea.nsn-net.net>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <20160525134152.GG23204@ak-desktop.emea.nsn-net.net>
 <e64bac43-7524-1656-fa57-c1bd7f48c026@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64bac43-7524-1656-fa57-c1bd7f48c026@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 910
X-purgate-ID: 151667::1464269923-00004C87-27FFC147/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53664
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

Hi,

On Thu, May 26, 2016 at 05:33:13AM -0400, Joshua Kinard wrote:
> On 05/25/2016 09:41, Aaro Koskinen wrote:
> > On Mon, May 23, 2016 at 06:13:46PM +0300, Aaro Koskinen wrote:
> >> I'm getting kernel crashes (see below) reliably when building Perl in
> >> parallel (make -j16) on OCTEON EBH5600 board (8 cores, 4 GB RAM) with
> >> Linux 4.6.
> >>
> >> It seems that CONFIG_TRANSPARENT_HUGEPAGE has something to do with the
> >> issue - disabling it makes build go through fine.
> > 
> > Seems to be also reproducible on MIPS64/Malta/QEMU (UP, 2 GB RAM). This
> > happened during Perl's Configure script on the first try:
> 
> What do you have for CONFIG_FORCE_MAX_ZONEORDER?  I don't see that in your
> config?  Also, what do you have for CONFIG_PAGE_SIZE_*?

The config was generated with "savedefconfig", so those values are at
their defaults (4 KB page size, max zoneorder 11).

A.

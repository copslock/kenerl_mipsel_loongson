Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 15:12:28 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:47980 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012010AbbHNNM0Szkhx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 15:12:26 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.15.1/8.15.1) with ESMTPS id t7EDC4Io027932
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 14 Aug 2015 13:12:04 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id t7EDC2uP026228;
        Fri, 14 Aug 2015 15:12:02 +0200
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Fri, 14 Aug 2015 16:09:13 +0300
Date:   Fri, 14 Aug 2015 16:09:12 +0300
From:   Aaro Koskinen <aaro.koskinen@nokia.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Janne Huttunen <janne.huttunen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH 00/14] MIPS/staging: OCTEON: enable ethernet/xaui on
 CN68XX
Message-ID: <20150814130912.GR1199@ak-desktop.emea.nsn-net.net>
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
 <55CCED1B.6030701@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55CCED1B.6030701@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1085
X-purgate-ID: 151667::1439557927-00007F5C-41EC225E/0/0
Return-Path: <aaro.koskinen@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48893
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

On Thu, Aug 13, 2015 at 12:16:43PM -0700, David Daney wrote:
> On 08/13/2015 06:21 AM, Aaro Koskinen wrote:
> >Currently mainline Linux is unusable on OCTEON II CN68XX SOCs due to
> >issues in Ethernet driver initialization. Some boards are hanging during
> >init, and all the needed register differences compared to the older SOCs
> >are not taken into account to make interrupts and packet delivery to work.
> >
> >This patch set provides a minimal support to get octeon-ethernet going
> >on CN68XX. Tested on top of 4.2-rc6 with Cavium EBB6800 and Kontron
> >S1901 boards by sending traffic over XAUI interface with busybox.
> 
> You don't say how it was tested.
> 
> Does OCTEON and OCTEON II networking continue to function?

I tested today with EBH5600 (OCTEON+) as well and networking works
as before.

> There is no SSO provisioning, so there will be limited buffering on packet
> ingress.  For low packet rates, it should be fine though.

We are aware of limitations. However, I guess this should be added...
I will take a look.

Thanks,

A.

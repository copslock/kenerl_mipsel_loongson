Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 17:26:58 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:46354 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013227AbaKKQ0viLcjc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 17:26:51 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id sABGQavf011945
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 11 Nov 2014 16:26:37 GMT
Received: from ak-desktop.emea.nsn-net.net ([10.144.35.206])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with SMTP id sABGQZ1Z012074;
        Tue, 11 Nov 2014 17:26:35 +0100
Received: by ak-desktop.emea.nsn-net.net (sSMTP sendmail emulation); Tue, 11 Nov 2014 18:24:12 +0200
Date:   Tue, 11 Nov 2014 18:24:12 +0200
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] MIPS: cavium-octeon: fix early boot hang on EBH5600 board
Message-ID: <20141111162412.GD6632@ak-desktop.emea.nsn-net.net>
References: <1383142087-25995-1-git-send-email-aaro.koskinen@nsn.com>
 <52729302.6090505@gmail.com>
 <20141111161910.GC29662@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141111161910.GC29662@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 454
X-purgate-ID: 151667::1415723197-00001FC1-63312256/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44007
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

Hi,

On Tue, Nov 11, 2014 at 05:19:10PM +0100, Ralf Baechle wrote:
> On Thu, Oct 31, 2013 at 10:27:30AM -0700, David Daney wrote:
> > I am looking at this, but it could be a few days before I can render an
> > opinion about it.
> 
> This is still pending in http://patchwork.linux-mips.org/patch/6090/.
> 
> Drop?  Apply?  Apply carbon dating first?

This one is already applied to mainline
(b2e4f1560f7388f8157dd2c828211abbfad0e806).

A.

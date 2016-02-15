Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 19:38:43 +0100 (CET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:59259 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011948AbcBOSimarUlQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 19:38:42 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-167-245-nat.elisa-mobile.fi [85.76.167.245])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 373B2234056;
        Mon, 15 Feb 2016 20:38:39 +0200 (EET)
Date:   Mon, 15 Feb 2016 20:38:39 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MIPS: DTS: cavium-octeon: provide model attribute
Message-ID: <20160215183838.GD1640@darkstar.musicnaut.iki.fi>
References: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de>
 <56C1B3A0.4090301@cogentembedded.com>
 <56C21054.4070702@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56C21054.4070702@gmx.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52069
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

On Mon, Feb 15, 2016 at 06:52:20PM +0100, Heinrich Schuchardt wrote:
> On 02/15/2016 12:16 PM, Sergei Shtylyov wrote:
> > On 2/15/2016 8:26 AM, Heinrich Schuchardt wrote:
> >> Downstream packages like Debian flash-kernel rely on
> >> /proc/device-tree/model
> >> to determine how to install an updated kernel image.
> 
> Would you support a patch having the following strings?
> 
> model = "CAVM, Octeon 3860";
> model = "CAVM, Octeon 6880";

The built-in DTBs are shared by multiple completely different boards
(from multiple different manufacturers). How would those strings help
for cases like flash-kernel?

A.

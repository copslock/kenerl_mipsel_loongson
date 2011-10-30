Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Oct 2011 21:45:09 +0100 (CET)
Received: from qmta12.emeryville.ca.mail.comcast.net ([76.96.27.227]:46990
        "EHLO qmta12.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903677Ab1J3UpC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Oct 2011 21:45:02 +0100
Received: from omta07.emeryville.ca.mail.comcast.net ([76.96.30.59])
        by qmta12.emeryville.ca.mail.comcast.net with comcast
        id r8du1h0051GXsucAC8kn6V; Sun, 30 Oct 2011 20:44:47 +0000
Received: from [192.168.1.13] ([76.106.65.35])
        by omta07.emeryville.ca.mail.comcast.net with comcast
        id r8ci1h00T0leNgC8U8ck7M; Sun, 30 Oct 2011 20:36:45 +0000
Message-ID: <4EADB701.9040506@gentoo.org>
Date:   Sun, 30 Oct 2011 16:43:45 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
MIME-Version: 1.0
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org,
        ralf@linux-mips.org, FlorianSchandinat@gmx.de
Subject: Re: [PATCH v2] GIO bus support for SGI IP22/28
References: <20111020221928.0C2191DA27@solo.franken.de>
In-Reply-To: <20111020221928.0C2191DA27@solo.franken.de>
X-Enigmail-Version: 1.3.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21675

On 10/20/2011 18:19, Thomas Bogendoerfer wrote:

> SGI IP22/IP28 machines have GIO busses for adding graphics and other
> extension cards. This patch adds support for GIO driver/device
> handling and converts the newport console driver to a GIO driver.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>


Does this handle any glue logic for add-on NIC cards found for Indy and I2?
 I have a G130 Phobus and a rare ThunderLAN card in my Indy.  The Phobus has
an Altera GIO/PCI glue chip.  Not sure about the ThunderLAN.  Both have
normal driver support in the kernel (Phobus is just a Tulip chip).

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

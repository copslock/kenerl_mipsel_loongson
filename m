Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 17:12:52 +0100 (CET)
Received: from eusmtp01.atmel.com ([212.144.249.243]:15066 "EHLO
        eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007908AbbCIQMsdKDFX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 17:12:48 +0100
Received: from localhost (10.161.101.13) by eusmtp01.atmel.com (10.161.101.31)
 with Microsoft SMTP Server id 14.2.347.0; Mon, 9 Mar 2015 17:12:39 +0100
Date:   Mon, 9 Mar 2015 17:11:57 +0100
From:   Ludovic Desroches <ludovic.desroches@atmel.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for
 quirks
Message-ID: <20150309161157.GW9132@odux.rfo.atmel.com>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-kernel@vger.kernel.org
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
 <20150308082845.GB1904@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20150308082845.GB1904@katana>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ludovic.desroches@atmel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ludovic.desroches@atmel.com
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

Hi Wolfram,

On Sun, Mar 08, 2015 at 09:28:45AM +0100, Wolfram Sang wrote:
> On Wed, Feb 25, 2015 at 05:01:54PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Hi Ludovic,
> 
> if you have a few minutes, could you please test this series? I'd like to
> include it in 4.1. and because at91 is using the quirk infrastructure in
> a more complex way, it is a really good test candidate.

It was in the pipe. I have reviewed it, this second version seems to be
good. I am just waiting a bit more to give you my ack since I have some
issues to read an i2c eeprom (it works with a temperature sensor).
I am investigating if it doesn't come from a previous regression.

> 
> Thanks,
> 
>    Wolfram
> 

Regards

Ludovic

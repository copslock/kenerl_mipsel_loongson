Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 00:43:51 +0100 (CET)
Received: from smtp1-g21.free.fr ([212.27.42.1]:18078 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014786AbcASXntkTasx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2016 00:43:49 +0100
Received: from tock (unknown [78.50.162.29])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 667E79400EF;
        Wed, 20 Jan 2016 00:42:24 +0100 (CET)
Date:   Wed, 20 Jan 2016 00:43:36 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, David Daney <ddaney.cavm@gmail.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] MIPS: dts: tl_wr1043nd_v1: fix "aliases" node name
Message-ID: <20160120004336.2b89a5f6@tock>
In-Reply-To: <20160116080205.0b6e84c9e531b0cfd845b67b@gmail.com>
References: <1452759657-7114-1-git-send-email-antonynpavlov@gmail.com>
        <56993EF5.9040008@gmail.com>
        <20160116080205.0b6e84c9e531b0cfd845b67b@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sat, 16 Jan 2016 08:02:05 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> On Fri, 15 Jan 2016 10:48:21 -0800
> David Daney <ddaney.cavm@gmail.com> wrote:
> 
> > On 01/14/2016 12:20 AM, Antony Pavlov wrote:
> > > The correct name for aliases node is "aliases" not "alias".
> > >
> > > An overview of the "aliases" node usage can be found
> > > on the device tree usage page at devicetree.org [1].
> > >
> > > Also please see chapter 3.3 ("Aliases node") of the ePAPR 1.1 [2].
> > >
> > > [1] http://devicetree.org/Device_Tree_Usage#aliases_Node
> > > [2] https://www.power.org/documentation/epapr-version-1-1/
> > >
> > > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > > Cc: Alban Bedel <albeu@free.fr>
> > > Cc: linux-mips@linux-mips.org
> > > Cc: devicetree@vger.kernel.org
> > > ---
> > >   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> > > b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts index
> > > 003015a..4b6d38c 100644 ---
> > > a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts +++
> > > b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts @@ -9,7 +9,7 @@
> > >   	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
> > >   	model = "TP-Link TL-WR1043ND Version 1";
> > >
> > > -	alias {
> > > +	aliases {
> > >   		serial0 = "/ahb/apb/uart@18020000";
> > >   	};
> > 
> > What uses this alias?  If the answer is nothing (likely, as it was 
> > broken and nobody seems to have noticed), just remove the whole
> > thing.
> 
> I have used ar9132_tl_wr1043nd_v1.dts as a template for AR9331-based
> board dts-file. AR9331 uses it's own very special UART implementation
> (the ar933x_uart.c driver is used). ar933x_uart.c relies on alias and
> does not work if alias is not set. I have not yet runned linux on
> TL-WR1034ND, but I suppose that uart alias is not actually used for
> TL-WR1034ND and this aliases node can be safely removed.
> 
> Alban, have you any comments?

David is right, we should just remove it.

Alban

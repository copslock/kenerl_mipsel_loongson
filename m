Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 15:58:01 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34767 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009993AbcATO6AG5j5S convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2016 15:58:00 +0100
Received: by mail-lb0-f170.google.com with SMTP id cl12so6557128lbc.1
        for <linux-mips@linux-mips.org>; Wed, 20 Jan 2016 06:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L1ZuQQyflwBGax5ih6EUZ3atVIMrN+AC6gACgQYkz+E=;
        b=GPe3HacBRl3WMsmbNBQFKmzYR+XAzW9W3CDPMG9Tmo+hEd7JU+KzEXMyEeOgj+SqsJ
         eV6mRGxpEp2r5UWhmWuAcVyPSSvZa0NKVhp6XI/lkRzaD85ezUHZ/Edaok/8fJKP4tsh
         eF/Nx2R4RhanAUOxgL0u4G7aQhejjCwoP5zKGHurIpk2H57SREzJjF9NCMHGOozmEie7
         iTMb4ayMrojCGJ+2dVoI22dKjM6U4HsM9WLI94eb/AerizsosqByV1fSVbo/meBeeYEI
         qg425g6QE5boZ+yBqdowJP+S5P1CgSp6cwv8AH/n6cfne4yW/DS4QfcoN5GRvtcHE5pm
         gXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=L1ZuQQyflwBGax5ih6EUZ3atVIMrN+AC6gACgQYkz+E=;
        b=ePBlzmMeBYiR/wpDO0RFzBbwwdrGej8i7FcnWOLN7fpc3dNgY3l6Y/7JDyrFp7txdg
         Aot9CrZ7mu3SpAwebkOKcb0ZAxNUtwwfeGhfbYCys4pR8GF+ZKUXvLTGuPw4+Lz+O+MS
         cl7ThhsbFl73oLejNiz7wZHTKO+1dNNwoR6PTBNcJuyOZU8EnIB1I3PtnFpwM8sJkbV7
         SHoUh889P4YUhBP26OE7zBtGuBPzgusN75OmQeIwxAhifSzODgLcRS0uFEqHxpzxgcFG
         L/mf6ZY25IZEcIu/43lD7n1HIxxPxIQinfbkgE5ye4Y3zENKKlOHhyiqpzP0OQ6JOR4B
         L+rA==
X-Gm-Message-State: ALoCoQlYH/roDIng3DyfkoQkMe0oIGQzQBvR9ZjsPxuD4tbwXphyN/uiDGrcP9J6EXLbXCYMjdp8rPBHIjKT4tj8jUQPoWvTOA==
X-Received: by 10.112.167.161 with SMTP id zp1mr13485293lbb.2.1453301874687;
        Wed, 20 Jan 2016 06:57:54 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id p138sm4671716lfb.22.2016.01.20.06.57.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jan 2016 06:57:54 -0800 (PST)
Date:   Wed, 20 Jan 2016 18:22:59 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] MIPS: dts: tl_wr1043nd_v1: fix "aliases" node name
Message-Id: <20160120182259.914f0e9be896bd2576391e3b@gmail.com>
In-Reply-To: <20160120004336.2b89a5f6@tock>
References: <1452759657-7114-1-git-send-email-antonynpavlov@gmail.com>
        <56993EF5.9040008@gmail.com>
        <20160116080205.0b6e84c9e531b0cfd845b67b@gmail.com>
        <20160120004336.2b89a5f6@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Wed, 20 Jan 2016 00:43:36 +0100
Alban <albeu@free.fr> wrote:

> On Sat, 16 Jan 2016 08:02:05 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > On Fri, 15 Jan 2016 10:48:21 -0800
> > David Daney <ddaney.cavm@gmail.com> wrote:
> > 
> > > On 01/14/2016 12:20 AM, Antony Pavlov wrote:
> > > > The correct name for aliases node is "aliases" not "alias".
> > > >
> > > > An overview of the "aliases" node usage can be found
> > > > on the device tree usage page at devicetree.org [1].
> > > >
> > > > Also please see chapter 3.3 ("Aliases node") of the ePAPR 1.1 [2].
> > > >
> > > > [1] http://devicetree.org/Device_Tree_Usage#aliases_Node
> > > > [2] https://www.power.org/documentation/epapr-version-1-1/
> > > >
> > > > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > > > Cc: Alban Bedel <albeu@free.fr>
> > > > Cc: linux-mips@linux-mips.org
> > > > Cc: devicetree@vger.kernel.org
> > > > ---
> > > >   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> > > > b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts index
> > > > 003015a..4b6d38c 100644 ---
> > > > a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts +++
> > > > b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts @@ -9,7 +9,7 @@
> > > >   	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
> > > >   	model = "TP-Link TL-WR1043ND Version 1";
> > > >
> > > > -	alias {
> > > > +	aliases {
> > > >   		serial0 = "/ahb/apb/uart@18020000";
> > > >   	};
> > > 
> > > What uses this alias?  If the answer is nothing (likely, as it was 
> > > broken and nobody seems to have noticed), just remove the whole
> > > thing.
> > 
> > I have used ar9132_tl_wr1043nd_v1.dts as a template for AR9331-based
> > board dts-file. AR9331 uses it's own very special UART implementation
> > (the ar933x_uart.c driver is used). ar933x_uart.c relies on alias and
> > does not work if alias is not set. I have not yet runned linux on
> > TL-WR1034ND, but I suppose that uart alias is not actually used for
> > TL-WR1034ND and this aliases node can be safely removed.
> > 
> > Alban, have you any comments?
> 
> David is right, we should just remove it.

Ok.

Several days ago I have got one TP-Link WR1043ND v1.8, so I can prepare
the patch, check it on my real hardware and then send it to the maillist.

-- 
Best regards,
  Antony Pavlov

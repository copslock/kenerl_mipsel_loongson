Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jan 2016 05:37:12 +0100 (CET)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36528 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006195AbcAPEhKUvfhK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Jan 2016 05:37:10 +0100
Received: by mail-lb0-f181.google.com with SMTP id oh2so325196336lbb.3
        for <linux-mips@linux-mips.org>; Fri, 15 Jan 2016 20:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Wnx69FsewPXQlU3eF5Sm8ZwIEvI+ZFNTDUXLZsSTV44=;
        b=Vubpz6oMs/w7UfCuFH6MgFONulM8B4TVwGYCnpT36ZOB41cSAQgDOyAjWBidylqDSk
         OY/c3dW+mbkMYRXPb5VYxakjixJ+bU2J2t0NMSfDzygN92vh516+fsrITLxxi3Xk0sOl
         wRYSz6vx2ZN8lbcbVQZvGKrocTMnF7o6oSYPkD/YyAJ4QHDFeCzKHNyg1bOgA6T1+G/3
         LJAQvILX3vlIgZf8DsCT4LzmfTbz2a55eR0dNBe9ItBZ9gAlH0K3WMzUZN2t1B8T1axy
         YNsfOBeZiUnpXzTlDq912UdjXM4P0iOMntx4KaKn+kMb3JQfRZVUZrN6r47BLtNoRFxI
         aKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Wnx69FsewPXQlU3eF5Sm8ZwIEvI+ZFNTDUXLZsSTV44=;
        b=h3loDbQtgTwbVdp78Y1JIuaChSNFcxe82sBK8Yp81TD+PBgzNvDk2XPiZNh6T+PRuF
         bx8od1ss0RiTzw9YlKo2/E2UENYZW5TdTZsQfQ9Uq/JAOe0ome+XYfMx545QluHGrGfK
         hsC5Tq2ksrlJkdecvfY9P9lVP5lNYw6/fxy7vbiOPastB1XGT3ooUuAKa5L6nK9SUjba
         7S8jpS/klkIZGFMIHScFdoMI7ppcEitIRnxQRpsvCr9U1fLlytpvWobF8EmZwBAOhodu
         JS+eRXw/fNDFpaIdn0x2SErN3IQ1+nT6EultgF0Ga1Yo+TNzHtHQsmaTSU+kL/PhaPmJ
         UpdQ==
X-Gm-Message-State: AG10YOR9WAFTHUdZCGeCEI1Dq68B79c3rgAtI4eadsjD7RoiZ5kfDSfcjMpqXAKC83o61Q==
X-Received: by 10.112.13.165 with SMTP id i5mr877731lbc.79.1452919024775;
        Fri, 15 Jan 2016 20:37:04 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id r200sm1748759lfd.35.2016.01.15.20.37.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jan 2016 20:37:04 -0800 (PST)
Date:   Sat, 16 Jan 2016 08:02:05 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, Alban Bedel <albeu@free.fr>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] MIPS: dts: tl_wr1043nd_v1: fix "aliases" node name
Message-Id: <20160116080205.0b6e84c9e531b0cfd845b67b@gmail.com>
In-Reply-To: <56993EF5.9040008@gmail.com>
References: <1452759657-7114-1-git-send-email-antonynpavlov@gmail.com>
        <56993EF5.9040008@gmail.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51170
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

On Fri, 15 Jan 2016 10:48:21 -0800
David Daney <ddaney.cavm@gmail.com> wrote:

> On 01/14/2016 12:20 AM, Antony Pavlov wrote:
> > The correct name for aliases node is "aliases" not "alias".
> >
> > An overview of the "aliases" node usage can be found
> > on the device tree usage page at devicetree.org [1].
> >
> > Also please see chapter 3.3 ("Aliases node") of the ePAPR 1.1 [2].
> >
> > [1] http://devicetree.org/Device_Tree_Usage#aliases_Node
> > [2] https://www.power.org/documentation/epapr-version-1-1/
> >
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Alban Bedel <albeu@free.fr>
> > Cc: linux-mips@linux-mips.org
> > Cc: devicetree@vger.kernel.org
> > ---
> >   arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> > index 003015a..4b6d38c 100644
> > --- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> > +++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
> > @@ -9,7 +9,7 @@
> >   	compatible = "tplink,tl-wr1043nd-v1", "qca,ar9132";
> >   	model = "TP-Link TL-WR1043ND Version 1";
> >
> > -	alias {
> > +	aliases {
> >   		serial0 = "/ahb/apb/uart@18020000";
> >   	};
> 
> What uses this alias?  If the answer is nothing (likely, as it was 
> broken and nobody seems to have noticed), just remove the whole thing.

I have used ar9132_tl_wr1043nd_v1.dts as a template for AR9331-based board dts-file.
AR9331 uses it's own very special UART implementation (the ar933x_uart.c driver is used).
ar933x_uart.c relies on alias and does not work if alias is not set.
I have not yet runned linux on TL-WR1034ND, but I suppose that uart alias is not 
actually used for TL-WR1034ND and this aliases node can be safely removed.

Alban, have you any comments?

-- 
Best regards,
  Antony Pavlov

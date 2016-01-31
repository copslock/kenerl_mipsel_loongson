Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Jan 2016 21:50:31 +0100 (CET)
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34746 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011382AbcAaUu2U01h7 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Jan 2016 21:50:28 +0100
Received: by mail-lf0-f44.google.com with SMTP id j78so14833107lfb.1
        for <linux-mips@linux-mips.org>; Sun, 31 Jan 2016 12:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QBuhSF13CCjvVzc+AfOkw/1p39w+TpKiO/OySlxI5k0=;
        b=k4G5YX+LuAA2V7BH4VBj845f4ArEM9yQ4BlhoX5bJOMP4j6OuM4/kTKl4FkMIQtWJF
         +O0EC6habDILhihGD1W2sD9i7wtuluNf9whVJm0kgSkkd2WLNI8pUQgMm32d6BBLEwfd
         z5qS+1bUX60R1c7rpxiq5MPRiLNHD+Ub29rbSFFRfD+W8W0OKsO5twGG8jv+XlTC/atk
         SPEacNOKqOMeG9Zr3kq1jcv+KzAkSsOpFYYFubkpOiFbJE6GBCwb6Oj3sFxdpxAGNW3o
         Uyy0PzECCtdwO+adgBHbyJuxxCGhHLk6XzkUz2a5wOo/yM9iiF9nUmwOLgMB5w23c8cf
         S3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=QBuhSF13CCjvVzc+AfOkw/1p39w+TpKiO/OySlxI5k0=;
        b=Q4pFqtNU2rAxuxUXWbP1H24cHPr59xsOPLrTmrJtX9YWYPdPCgOJ4zruNffvVAi0zo
         vJPzLFhFeXWMwzaEew2bkWYHquVcmNqvoUG3pmmQz6b8BOIR+YvKBZJeFqYu1qC/oxdQ
         u4CxHoKs26HfPgX8OcaZ9dlEjGsOF6+I6ge1LBP6jwTr2q2r968WGSBWq0RmiGdP3gEo
         RQG2WO1DWFnPb6HeYk7cEcIF9F4IolpH5/TkEh5pB1SQsy++xUzckIpx0xY6XWFeoMlB
         xyK4gHlRzoVUQBpeXaGOXeeRbcBbt0UL9RouBURuTkSbpTYf4D186HJUgOSAPCjFUcdg
         eGdQ==
X-Gm-Message-State: AG10YOT8fTL6KmKv+1fwmIqFHX3g6vGfOP/+u9AV8Q4pEPuF3F8LWBrqvEX9KbH4Rofm4w==
X-Received: by 10.25.142.213 with SMTP id q204mr6939192lfd.46.1454273422665;
        Sun, 31 Jan 2016 12:50:22 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id ax1sm3611555lbc.20.2016.01.31.12.50.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jan 2016 12:50:22 -0800 (PST)
Date:   Mon, 1 Feb 2016 00:15:46 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC v3 07/14] MIPS: dts: qca: simplify Makefile
Message-Id: <20160201001546.8799f23399115025b84c9216@gmail.com>
In-Reply-To: <20160125234104.05857306@tock>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-8-git-send-email-antonynpavlov@gmail.com>
        <20160125234104.05857306@tock>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51557
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

On Mon, 25 Jan 2016 23:41:04 +0100
Alban <albeu@free.fr> wrote:

> On Sat, 23 Jan 2016 23:17:24 +0300
> Antony Pavlov <antonynpavlov@gmail.com> wrote:
> 
> > Do as arch/mips/boot/dts/ralink/Makefile does.
> > Without this patch adding a dtb-file leads
> > to adding __two__ lines to the Makefile.
> 
> I have some patches in my queue to allow using appended DTB and remove
> the builtin DTB support. That would also fix the problem as the second
> Makefile line wouldn't be needed anymore. I try to post them soon.

What bootloader do you use on your TP-Link WR1043ND?
Please describe you linux kernel image with appended DTB creation procedure.

> Alban
> 
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Alban Bedel <albeu@free.fr>
> > Cc: linux-mips@linux-mips.org
> > ---
> >  arch/mips/boot/dts/qca/Makefile | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
> > index 2d61455d..244329e 100644
> > --- a/arch/mips/boot/dts/qca/Makefile
> > +++ b/arch/mips/boot/dts/qca/Makefile
> > @@ -1,8 +1,7 @@
> >  # All DTBs
> > -dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
> > +dtb-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb
> >  
> > -# Select a DTB to build in the kernel
> > -obj-$(CONFIG_DTB_TL_WR1043ND_V1)	+= ar9132_tl_wr1043nd_v1.dtb.o
> > +obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> >  
> >  # Force kbuild to make empty built-in.o if necessary
> >  obj-				+= dummy.o
> 


-- 
-- 
Best regards,
  Antony Pavlov

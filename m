Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2016 13:42:24 +0200 (CEST)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36856 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030739AbcEXLmUEAMwM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 May 2016 13:42:20 +0200
Received: by mail-lf0-f67.google.com with SMTP id d132so938559lfb.3;
        Tue, 24 May 2016 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RifayYFjmLKngoKcxlr7r8CgVsm3+6S+iSIzfJnLRBo=;
        b=uSyo9s1lvSZNzFcBwyOwaX2n3SzmGYydag2hhYiTuGfh5ejT9SsTA+A1ygVltThYop
         8syrSnjyxkybO59oBF+c5/Gu9TpCXG/AGdQrdSDeTkmhIHV9E3Iq9Hi6dsZcDNzrbcHe
         27/YPrpgpJ5fFBeuAuSEF9lzbBx8dz+KKQRJQGH8cV21OcpvRfwuXnEy9hfjm4q78ZwH
         /fzkKWrqtVtMoNMYAurs0pwxVkA6XkwciOrwlLjtyhyc5MMgum+uggxhWf0DuUIIEyiS
         C61gsJifA0YPddXnVSgTMJMHnehOlWT3KTTbA66lFrhVC5RueHDT7lB9MyzfDhqrL4C7
         5omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RifayYFjmLKngoKcxlr7r8CgVsm3+6S+iSIzfJnLRBo=;
        b=aYlVZlnpmOisQOulyM9t1d2iGDGJDktrIILEgVDWDkL1jmu+edwTk+Gjw/mLx4i4QC
         zH0U5/ET0x83m/UxYzC+oYXUrg2U/Vl2iIT87/P4vJAv+9Ldt/2HxDSgcBrDGJnNAJ41
         5OE4R/bjGybT+6QWMqQuTIm78FiaPT1wVLjIZ9SGXc/SNjHuLOCV2+cmtaDuD5JLK8yA
         2Yso3UMyU4Qaoc/XxSy9eYWIAIaOT8acPFyh2jWD/vsgBnkL+r2b8PAgspvzQxJde2gj
         Fdp089oIbJeiRRPZpaHlVxFUYTdZM3YKo3BNcAxKo7st3ugcOKGjjo3D7AvYetXH/3Nw
         jPvA==
X-Gm-Message-State: AOPr4FXrq/hK1j2E4doxDdPeBJQftQ9kzxTGsiNCMjGER5/F/u2s0DhPW+zQsoCh025BbQ==
X-Received: by 10.25.22.89 with SMTP id m86mr7848007lfi.25.1464090134595;
        Tue, 24 May 2016 04:42:14 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id tg1sm443371lbb.7.2016.05.24.04.42.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 04:42:13 -0700 (PDT)
Date:   Tue, 24 May 2016 14:43:17 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: devicetree: fix cpu interrupt controller
 node-names
Message-Id: <20160524144317.53614ee26334019774c3ea99@gmail.com>
In-Reply-To: <CAL_Jsq+CC3p0hPTtPB=RsL9O7sqX1ZXKkoFk0dOj0gvvKifAkw@mail.gmail.com>
References: <1464003540-13009-1-git-send-email-antonynpavlov@gmail.com>
        <CAL_Jsq+CC3p0hPTtPB=RsL9O7sqX1ZXKkoFk0dOj0gvvKifAkw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53637
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

On Mon, 23 May 2016 10:47:16 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, May 23, 2016 at 6:39 AM, Antony Pavlov <antonynpavlov@gmail.com> wrote:
> > Here is the quote from [1]:
> >
> >     The unit-address must match the first address specified
> >     in the reg property of the node. If the node has no reg property,
> >     the @ and unit-address must be omitted and the node-name alone
> >     differentiates the node from other nodes at the same level
> >
> > This patch adjusts MIPS dts-files and devicetree binding
> > documentation in accordance with [1].
> >
> >     [1] Power.org(tm) Standard for Embedded Power Architecture(tm)
> >         Platform Requirements (ePAPR). Version 1.1 – 08 April 2011.
> >         Chapter 2.2.1.1 Node Name Requirements
> 
> FYI, you can reference "the Devicetree Spec" now: devicetree.org

Thanks for your note! Last time I visited devicetree.org in Jan 2015.
Now I see that the devicetree.org site has changed dramaticaly,
e.g. it does not use Mediawiki anymore.

Alas some important links from the http://www.devicetree.org/specifications/ page are broken:

   * http://www.devicetree.org/specifications-pdf
   * https://github.com/devicetree-org/devicetree-specification-released

Anyway I have got a prerelease specification version from github:

    https://raw.githubusercontent.com/devicetree-org/devicetree-specification-released/master/prerelease/devicetree-specification-v0.1-pre1-20160429.pdf


> Acked-by: Rob Herring <robh@kernel.org>
> 
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/mips/cpu_irq.txt | 2 +-
> >  arch/mips/boot/dts/ingenic/jz4740.dtsi             | 2 +-
> >  arch/mips/boot/dts/ralink/mt7620a.dtsi             | 2 +-
> >  arch/mips/boot/dts/ralink/rt2880.dtsi              | 2 +-
> >  arch/mips/boot/dts/ralink/rt3050.dtsi              | 2 +-
> >  arch/mips/boot/dts/ralink/rt3883.dtsi              | 2 +-
> >  arch/mips/boot/dts/xilfpga/nexys4ddr.dts           | 2 +-
> >  7 files changed, 7 insertions(+), 7 deletions(-)


-- 
-- 
Best regards,
  Antony Pavlov

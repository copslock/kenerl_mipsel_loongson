Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 12:51:57 +0200 (CEST)
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34595 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993207AbcHLKvvWqtS5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 12:51:51 +0200
Received: by mail-ua0-f195.google.com with SMTP id d97so1751198uad.1;
        Fri, 12 Aug 2016 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lx6y/sQJiVRGHDDVo9Q3TwFCCW38cEPZ8ZHcg5fZQvk=;
        b=VoLThP6FZ4x/wVajCLwoSVS2mcaOOB2qdO6+i/4tq7QYBzSGlqJBuL5dFAbXy0JMGr
         avmCbaONf+4x6Tj0uLokgyOAe4H7WQQjrz79Qpp+1aixPjEtLwB9faosuCbX7PwV2gAH
         wg+tzidNqYmErrhhmYCyV5ecruxNGyvWEulPN+1tiW+NVbEz2RWmIjG+KuVNfiOIYsF1
         IHVKrbk8AF82MFpPMZUBUdhvtX81k81OJgNDKhye9soQi0m2xSXOM2I/iR0UPgxag817
         lHjOaEpc16uHLPgNYjihnWIz3AH4XqEeeAO22vQDygCr5L695gcRifFEs2mNkZOvkCOl
         DLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lx6y/sQJiVRGHDDVo9Q3TwFCCW38cEPZ8ZHcg5fZQvk=;
        b=mdBViHiW5Rw1TLMJhpKtgJK50/0CYlBotpEOtZoP+o/wbVMGbr+A+9jj2DtwRpNb5U
         3D/0yJwmAQPhjYS1nzAN3+nSNJcpq7Jwv/6eJIq3rLnaUoPs7cQb0VTwwK6SCowbg3cA
         F/es9wszZMlPiNCUtvLvI2gX0TMbt53jfbR8Oj4DjaPlqHr07syBctDPxl8a6M998XGW
         9HoVvWYNB+t7dejYRqKiD7eE/pM8gU4fVHI7nOXsy1gkK5XTQ+8tatsWMVbQNWfaLhlL
         FFwddNRUIJEsQQkNXs99ylqnYpelUsZ2QOYDkOVS2tJ11crVK2wq8doh5y1TootIWzjc
         7NeA==
X-Gm-Message-State: AEkoousnNH514ZldWQIxPkZ95pFzDJGLIDewH6cHQSkL46cVGN4NVE762TYHFMa9H5R60wLoFNkjV3rDOcnzfg==
X-Received: by 10.31.248.9 with SMTP id w9mr723467vkh.64.1470999105400; Fri,
 12 Aug 2016 03:51:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.129 with HTTP; Fri, 12 Aug 2016 03:51:25 -0700 (PDT)
In-Reply-To: <20160812085231.53290-1-jaedon.shin@gmail.com>
References: <20160812085231.53290-1-jaedon.shin@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Fri, 12 Aug 2016 12:51:25 +0200
Message-ID: <CAOiHx=ke2CC9tm6Rn01A5UAGRscb1QJGWq-som74r5UO5_g9EA@mail.gmail.com>
Subject: Re: [v3 0/5] Add device nodes for BCM7xxx SoCs
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 12 August 2016 at 10:52, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> This patch series adds support for Broadcom BCM7xxx MIPS based SoCs.
>
> The NAND device nodes have common file including chip select, BCH
> and partitions for the reference board with the same properties.
>
> Changes in v3:
> - Fixed incorrect interrupt number in aon_pm_l2_intc.
>
> Changes in v2:
> - Removed status properties in always enabled GPIO nodes.
> - Removed NAND nodes for v3.3 brcmnand controller.
> - Renamed interrupt-controller instead of lable string.
> - Renamed bcm97xxx-nand-cs1-bch8.dtsi
>
> Jaedon Shin (5):
>   MIPS: BMIPS: Add support PWM device nodes
>   MIPS: BMIPS: Add support GPIO device nodes
>   MIPS: BMIPS: Add support SDHCI device nodes
>   MIPS: BMIPS: Add support NAND device nodes
>   MIPS: BMIPS: Use interrupt-controller node name

Please directly add the interrupt controller names with the correct
name instead of fixing them up later.

Also please CC devicetree@vger for device tree related patches.


Regards
Jonas

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2016 13:22:22 +0200 (CEST)
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32963 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992181AbcJDLWPm7OiR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Oct 2016 13:22:15 +0200
Received: by mail-lf0-f65.google.com with SMTP id l131so10145422lfl.0;
        Tue, 04 Oct 2016 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZSPF8CH1YLfpQoOCv3yfP+l5XRgjmLT2GcM5I7YC/Q=;
        b=dNrNffhWllDQ7rr7iQ1U0pDQjLafx5/F8WhufGtyHDtClj2FwT1Wn64S1uGM1ceYOj
         PuxzBOtP1fyipqwdR1ex9WkLs9B7yIIrDbFrYTynjZkbTeA5GApfC2iOX/HHyT47T7N8
         4SDQYS0Sc+DwNEzDrv38Og28NGWAwcZgBMO2tWq1wymFuTgN9ephvxZUojkVSRYVZB7x
         D9u9CYof6zeY/auEj73qjgdZuKb487qfFNxkmgi6PGw1lfhAy9BXC5XD2M8B/vylhW4W
         URzpZs9GlGIWuhdXs1j7IeBHHxP0AasD7x8LxRm21juC63m2a+5VsFXHhjL0E4+jGgcK
         74EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZSPF8CH1YLfpQoOCv3yfP+l5XRgjmLT2GcM5I7YC/Q=;
        b=j/T/UuC3B1yAj/zGMODA16Xrft1F8QmlwDVTuDLzJyPTG9UC68P6Wt4mFGQo8IAPXD
         8PphDXNgshTTnppV1UpysgXmF8S4BljUeek+GlwuYNdF7ZmczmnTI4gi0Q6lSK9/mSpS
         pLJTxDEUxLdMqAatLMDuwehkXkVXHlL918/3h7ZOq2ecRvmamL8DKmiydx8611qtZecz
         VOmmsaStZiVvD8Ru5esaxcxdrMl3Q8oVqcsxIRDL6ZwJrwuDjhe3bNgshvttUOM66VU4
         7Jb7g38lwLjn7YqstqAiJ1O7OcTKySX8DenTpN+05Y8seOWFV2OgRe75S54rO0IZz8Q9
         tIfQ==
X-Gm-Message-State: AA6/9RlYEkbSRIiMo0ViWpgHBwO7RguXuSSeJrS3aIGu+uiEwiLkJ0zb+Z1hyip4ZXqeGQ==
X-Received: by 10.25.165.144 with SMTP id o138mr1231711lfe.66.1475580127614;
        Tue, 04 Oct 2016 04:22:07 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id f27sm606826lji.24.2016.10.04.04.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 04:22:06 -0700 (PDT)
Date:   Tue, 4 Oct 2016 14:26:14 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yegor Yefremov <yegorslists@googlemail.com>, Alban <albeu@free.fr>,
        ralf@linux-mips.org, linux-mips <linux-mips@linux-mips.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: ath79: Add initial support for the HAPROXY Aloha
 Pocket board
Message-Id: <20161004142614.4983d133078b4908e43efa3a@gmail.com>
In-Reply-To: <154dc5c8-0d40-9cd7-5997-0ede70605510@baylibre.com>
References: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
        <20161004110940.57d112df@tock>
        <3b41a114-7ec7-cd50-6967-9a1be96e2c2f@baylibre.com>
        <CAGm1_ktvXYY5r2nWk3GneERmcMV+YwNa=-4arSmJjC_kNjPpSQ@mail.gmail.com>
        <154dc5c8-0d40-9cd7-5997-0ede70605510@baylibre.com>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55321
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

On Tue, 4 Oct 2016 12:11:11 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 10/04/2016 12:09 PM, Yegor Yefremov wrote:
> > Hi Neil,
> > 
> > On Tue, Oct 4, 2016 at 11:40 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >> On 10/04/2016 11:09 AM, Alban wrote:
> >>> On Mon,  3 Oct 2016 17:35:31 +0200
> >>> Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>
> >>>> The HAPROXY Aloha pocket board is a Load Balancer demo board based on the
> >>>> Atheros AR9331 SoC with 64Mbytes DDR and 16Mbytes on-board SPI Flash.
> >>>>
> >>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>>
> >>> Please use device tree instead of adding another board file.
> >>>
> >>> Alban
> >>>
> >>
> >> Hi Alban,
> >>
> >> I'm quite surprised since it seems no device tree support is available for ath79,
> >> I would really like to have device tree for this board, but this is only a copy/paste of
> >> the mach-ap121 with button/leds gpio differences.
> >>
> >> Could it be possible to merge it ? I would be happy to support this board once device tree
> >> support is landed on the mips tree !
> > 
> > Take a look at these DTS files from the current Linux tree:
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
> > 
> > etc.
> > 
> > Regards,
> > Yegor
> > 
> 
> My bad, the qca naming is really disturbing.
> 
> I will push a dts instead.

Please note that currently some led's names in device tree files are wrong
(e.g. dragino2 device tree https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts .
My bad! I have just copied led's names from OpenWRT platform files).

Please see the 'LED Device Naming' chapter for correct led naming scheme:

  http://lxr.free-electrons.com/source/Documentation/leds/leds-class.txt#L41
 
-- 
Best regards,
  Antony Pavlov

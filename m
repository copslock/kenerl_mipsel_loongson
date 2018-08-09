Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 23:44:50 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:41034 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994553AbeHIVosKUtiJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 23:44:48 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v6 00/24] Ingenic TCU patchset v6
Date:   Thu,  9 Aug 2018 23:43:50 +0200
Message-Id: <20180809214414.20905-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1533851085; bh=3JuVblcCRV9q6BAHQO0TVg2MSFYg18n+QUkAOiJzjaw=; h=From:To:Cc:Subject:Date:Message-Id; b=qTNJ6qHnSGirEeuHSOt1QfAmBB8T8PJjBtAUQUA26rpWXI0SKDxX50QqYo95x1nLyGhWETm9VjrU73beTjetkG36oa56UsC9D/b7kIkQFbkG8kd8UIHJecKDsuLvpNpgfbFt+FHn2vDE743MMPqZoFoIqsgsFu23ZhxLEaMSd7A=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

This is the V6 of my Ingenic Timer/Counter Unit (TCU) patchset.

Major changes since V5:

- ingenic,timer-channel / ingenic,clocksource-channel devicetree
  properties for the ingenic-timer driver are gone. The system timer
  will default to use TCU channel #0, the clocksource will default to
  use TCU channel #1. When a client driver requests one of these TCU
  channels (e.g. the PWM driver), the ingenic-timer driver will
  dynamically switch the system timer or clocksource to a new TCU
  channel.

- The big watchdog commit in v5 was split into multiple smaller commits.

- The watchdog driver now just sets its clock to the lowest rate
  possible, and calculate the maximum timeout from that.

- The PWM driver now requests the TCU channels it wants to use using the
  API functions provided by ingenic-timer. Channels 0 and 1 can now be
  used.

- The register lengths in the pwm/watchdog nodes were fixed. They no
  longer overlap.

- Small fixes here and there, see each patch's changelog for more info.

Regards,
-Paul Cercueil

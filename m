Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Aug 2015 14:39:31 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44008 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007225AbbHXMjaJ03Or (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Aug 2015 14:39:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6B187DC155A24;
        Mon, 24 Aug 2015 13:39:21 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 24 Aug 2015 13:39:23 +0100
Received: from qyousef-linux.le.imgtec.org (192.168.154.94) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 24 Aug 2015 13:39:22 +0100
From:   Qais Yousef <qais.yousef@imgtec.com>
To:     <alsa-devel@alsa-project.org>
CC:     Qais Yousef <qais.yousef@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 00/10] Add support for img AXD audio hardware decoder
Date:   Mon, 24 Aug 2015 13:39:09 +0100
Message-ID: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.94]
Return-Path: <Qais.Yousef@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qais.yousef@imgtec.com
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

This patch series adds AXD Alsa Compress Offload SoC driver.

AXD is an audio hardware based on MIPS architecture that supports decoding,
encoding, GEQ, resampling, mixing and synchronisation. At the moment only
decoding support is added in hope to add the rest of the functionality on
top of that once this is accepted.

I divided the files into separate patches by functionality in hope it'll
make the reviewing process easier. Worth noting that a lot of the cmd interface
helper funtions in patch 7 are not used yet but will be as support for more
functionality is added later.

At the moment this code has been tested on Pistachio SoC using gstreamer patched
with the code in this link

	https://bugzilla.gnome.org/show_bug.cgi?id=743192

Qais Yousef (10):
  irqchip: irq-mips-gic: export gic_send_ipi
  dt: add img,axd.txt device tree binding document
  ALSA: add AXD Audio Processing IP alsa driver
  ALSA: axd: add fw binary header manipulation files
  ALSA: axd: add buffers manipulation files
  ALSA: axd: add basic files for sending/receiving axd cmds
  ALSA: axd: add cmd interface helper functions
  ALSA: axd: add low level AXD platform setup files
  ALSA: axd: add alsa compress offload operations
  ALSA: axd: add Makefile

 .../devicetree/bindings/sound/img,axd.txt          |   34 +
 drivers/irqchip/irq-mips-gic.c                     |    1 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/img/Kconfig                              |   11 +
 sound/soc/img/Makefile                             |    1 +
 sound/soc/img/axd/Makefile                         |   13 +
 sound/soc/img/axd/axd_alsa_ops.c                   |  211 ++
 sound/soc/img/axd/axd_api.h                        |  649 ++++
 sound/soc/img/axd/axd_buffers.c                    |  243 ++
 sound/soc/img/axd/axd_buffers.h                    |   74 +
 sound/soc/img/axd/axd_cmds.c                       |  102 +
 sound/soc/img/axd/axd_cmds.h                       |  532 ++++
 sound/soc/img/axd/axd_cmds_config.c                | 1235 ++++++++
 sound/soc/img/axd/axd_cmds_decoder_config.c        |  422 +++
 sound/soc/img/axd/axd_cmds_info.c                  | 1249 ++++++++
 sound/soc/img/axd/axd_cmds_internal.c              | 3264 ++++++++++++++++++++
 sound/soc/img/axd/axd_cmds_internal.h              |  317 ++
 sound/soc/img/axd/axd_cmds_pipes.c                 | 1387 +++++++++
 sound/soc/img/axd/axd_hdr.c                        |   64 +
 sound/soc/img/axd/axd_hdr.h                        |   24 +
 sound/soc/img/axd/axd_module.c                     |  742 +++++
 sound/soc/img/axd/axd_module.h                     |   83 +
 sound/soc/img/axd/axd_platform.h                   |   35 +
 sound/soc/img/axd/axd_platform_mips.c              |  416 +++
 25 files changed, 11111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,axd.txt
 create mode 100644 sound/soc/img/Kconfig
 create mode 100644 sound/soc/img/Makefile
 create mode 100644 sound/soc/img/axd/Makefile
 create mode 100644 sound/soc/img/axd/axd_alsa_ops.c
 create mode 100644 sound/soc/img/axd/axd_api.h
 create mode 100644 sound/soc/img/axd/axd_buffers.c
 create mode 100644 sound/soc/img/axd/axd_buffers.h
 create mode 100644 sound/soc/img/axd/axd_cmds.c
 create mode 100644 sound/soc/img/axd/axd_cmds.h
 create mode 100644 sound/soc/img/axd/axd_cmds_config.c
 create mode 100644 sound/soc/img/axd/axd_cmds_decoder_config.c
 create mode 100644 sound/soc/img/axd/axd_cmds_info.c
 create mode 100644 sound/soc/img/axd/axd_cmds_internal.c
 create mode 100644 sound/soc/img/axd/axd_cmds_internal.h
 create mode 100644 sound/soc/img/axd/axd_cmds_pipes.c
 create mode 100644 sound/soc/img/axd/axd_hdr.c
 create mode 100644 sound/soc/img/axd/axd_hdr.h
 create mode 100644 sound/soc/img/axd/axd_module.c
 create mode 100644 sound/soc/img/axd/axd_module.h
 create mode 100644 sound/soc/img/axd/axd_platform.h
 create mode 100644 sound/soc/img/axd/axd_platform_mips.c

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
-- 
2.1.0

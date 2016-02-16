Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Feb 2016 16:38:48 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:52535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011979AbcBPPiqhS33n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Feb 2016 16:38:46 +0100
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPA (Nemesis) id 0M5qIb-1ZlKO313eb-00xtm6; Tue, 16 Feb
 2016 16:38:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH v2 0/5] gpio: clean up irq_to_gpio and ARCH_NR_GPIOS
Date:   Tue, 16 Feb 2016 16:37:59 +0100
Message-Id: <1455637086-2794174-1-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
X-Provags-ID: V03:K0:JFzbTPFeKRdnhHmikA96klwWmUpSvhV65sgxC4YgpbHpv0xerOU
 CExuMFulT5gUe9q0rLJWpJ3b3RtGATT40yQKK5B3L1ICv5HJ2UmmHnJ/AsnDL/H7w0BxxYe
 mRmbqXGtoGFnK4L17v8v6dGPDWC88EMl4H9WP6bStTg8FOS8PbwnPoSdU6xu5SoOReEgwfF
 n43ZQ2kyB8kAuF5Uo3Tig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dCPvDnFK6YE=:G65Mn4XQJe6A3zY4R6jvTC
 D+cwCFCg8yjW/WNrcH2go2/MtIsenfNfHXZWSdBvJdlVHo/nL98NFC1d0doq2WfKA1BMCyAUW
 GBT+vdTOuYmtc+IaiNizz0uwn37l5Jan41CLHNqhVKz3DcolQAveY1toS6Kc14a6K5lHqpO6V
 73hlBBJt3AdNECpK0GiFt/T94SUAWbAEwbPv8t8HU7eOQvBxOBn175Gh01FdSMui+W/hK4Dsk
 8ob4ufrIBJQ4NnRRZ8cKgzouJ0Mu62+VOBvMZEOEGjoJrxNTgc9QMCxu7K8sXNs48W5uxDLWV
 Suz1OedTLK1jds0TBvdi/9ULJZDy4eEbeGE4Yr2hBGdnUfsjfOhtW5ElbX7t6eGf3s0st0hbW
 QLPpyI3nAO5/CPAMh506Ak50zu7MubbqIHUhm8QoQgRaRB1YU7FK8rGggW0QpZiydvZkFkDzy
 3MTHXfAWfegAMj7oHObSeyo7/JcbEuspS4S9LHvXZp8MFXYNwQdDYkQHztgXM8As68Mv7Ef21
 86ptamT/CicZsR+kuE8WSO430azcuyD3zrCDXfu7Bmuw2ScKqK118H+MrvyRIUWrNx/GCZ+NB
 L0+Is66prhFkCvgMnWEGsXIV4ET6y0/BF5FBq8vabx/xVa+yk11mcRJM532l3b3XENS5CCfWz
 fPZ02Fkd1tgviowhqfD6gbYXcUeE8tPPSZZGQnG0MN0nJHUT07ASidiO2x+IbxG20DQg=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

I noticed that arch/arm/include/asm/gpio.h can almost be removed,
after we have already removed the file for most other architectures
now.

When I removed it, I ran into problems with irq_to_gpio(), which
we had already killed off in ARM, but it survived (barely) in the
global headers and accidentally gained an invalid user

This kills it off some more.

The first patch should go as a bugfix into the MIPS tree, the
other ones should only get merged later, but I think that's fine
if they get submitted for 4.6. I left them as a series of five
patches to clarify the build-time dependency. Merging patch
2 before 1 turns the MIPS runtime error into a compiletime
error.

changes in v2:

* the MIPS change should now correctly fix the bug, thanks
  to Lars-Peter.

* I left out the ARM specific change for now, and just adapted
  the generic file so we don't need that any more.

*  Fixed the bug that Russell pointed out

	Arnd

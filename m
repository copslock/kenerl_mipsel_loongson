Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 09:53:53 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:50908 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007509AbaH3HxvqO2De (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 09:53:51 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue005) with ESMTP (Nemesis)
        id 0MM2cS-1XVMhh3ZF6-007iZV; Sat, 30 Aug 2014 09:53:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] of: Add binding document for MIPS GIC
Date:   Sat, 30 Aug 2014 09:53:26 +0200
Message-ID: <6798670.9zbxUzsGyC@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1409350479-19108-4-git-send-email-abrestic@chromium.org>
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org> <1409350479-19108-4-git-send-email-abrestic@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:jVNMh6xihCgzQkoD4epNPg7b+gFqsQhkoV0GrU1QY14
 PQobtHfmAr3Plcn1zOSQNPQnD52EqUIa7MEhfUzli35VB/bOde
 eB4jfa4EBL+8Fo2ohcZvB2XwGNah50l1vW7hwjlrf4nUOfReXE
 07LG4SjKyFRMb0VH+1SkL9YrXG41LNoTwGVOeWjrL8oGCnx5ca
 zq4pBESDQC+eJhy+LUncqUrbtm7X0x4stESFMgB1fIl5WsDwEJ
 wUO9ishDX0o4denHRRe1+YwJrykl/lu18SQIpxHzegmmC394aQ
 sZoON7E1y/AUQeS5RmHObUsAotWAqZdiHljcJ6qTefraoM5Azb
 a8tam8PBjBFKqrpMweYo=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42343
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

On Friday 29 August 2014 15:14:30 Andrew Bresticker wrote:
> The Global Interrupt Controller (GIC) present on certain MIPS systems
> can be used to route external interrupts to individual VPEs and CPU
> interrupt vectors.  It also supports a timer and software-generated
> interrupts.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  Documentation/devicetree/bindings/mips/gic.txt | 50 ++++++++++++++++++++++++++
> 

This may be a stupid question, but is this related to the ARM GIC
in any way or does it just share the name?

In either case the binding belongs into
Documentation/devicetree/bindings/interrupt-controller/.

The ARM one should be moved there as well, and then we have
to come up with a new name for the files when there is a conflict.


	Arnd

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 11:18:04 +0100 (CET)
Received: from Galois.linutronix.de ([146.0.238.70]:51829 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992309AbcKIKR5Wo8Vp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 11:17:57 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1c4Pv5-0008KD-Vc; Wed, 09 Nov 2016 11:15:52 +0100
Date:   Wed, 9 Nov 2016 11:15:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, linux-mips@linux-mips.org,
        linux-remoteproc@vger.kernel.org,
        Lisa Parratt <lisa.parratt@imgtec.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Qais Yousef <qsyousef@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Lisa Parratt <Lisa.Parratt@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jason Cooper <jason@lakedaemon.net>,
        James Hogan <james.hogan@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 0/4] MIPS: Remote processor driver
In-Reply-To: <1478103063-17653-1-git-send-email-matt.redfearn@imgtec.com>
Message-ID: <alpine.DEB.2.20.1611091111041.3501@nanos>
References: <1478103063-17653-1-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Wed, 2 Nov 2016, Matt Redfearn wrote:
> The MIPS remote processor driver allows non-Linux firmware to take
> control of and execute on one of the systems VPEs. The CPU must be
> offlined from Linux first. A sysfs interface is created which allows
> firmware to be loaded and changed at runtime. A full description is
> available at [1]. An example firmware that can be used with this driver
> is available at [2].
> 
> This is useful to allow running bare metal code, or an RTOS, on one or
> more CPUs while allowing Linux to continue running on those remaining.

And how is actually guaranteed that these two things are properly seperated
(memory, devices, interrupts etc.) ?

We have rejected attempts to do exactly the same thing on x86 in the
past. There is virtualization and NOHZ_FULL to do it proper and not just
with a horrible hackery.

Thanks,

	tglx

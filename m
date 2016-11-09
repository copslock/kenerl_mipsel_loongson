Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 15:19:16 +0100 (CET)
Received: from Galois.linutronix.de ([146.0.238.70]:52678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993004AbcKIOTJfQ7I0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 15:19:09 +0100
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1c4TgW-00045s-S8; Wed, 09 Nov 2016 15:17:05 +0100
Date:   Wed, 9 Nov 2016 15:16:33 +0100 (CET)
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
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jason Cooper <jason@lakedaemon.net>,
        James Hogan <james.hogan@imgtec.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/4] MIPS: Remote processor driver
In-Reply-To: <b06e60b3-6175-db52-1cc8-706a4d3a04f0@imgtec.com>
Message-ID: <alpine.DEB.2.20.1611091504440.3501@nanos>
References: <1478103063-17653-1-git-send-email-matt.redfearn@imgtec.com> <alpine.DEB.2.20.1611091111041.3501@nanos> <b06e60b3-6175-db52-1cc8-706a4d3a04f0@imgtec.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55743
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

On Wed, 9 Nov 2016, Matt Redfearn wrote:
> On 09/11/16 10:15, Thomas Gleixner wrote:
> > On Wed, 2 Nov 2016, Matt Redfearn wrote:
> > > The MIPS remote processor driver allows non-Linux firmware to take
> > > control of and execute on one of the systems VPEs. The CPU must be
> > > offlined from Linux first. A sysfs interface is created which allows
> > > firmware to be loaded and changed at runtime. A full description is
> > > available at [1]. An example firmware that can be used with this driver
> > > is available at [2].
> > > 
> > > This is useful to allow running bare metal code, or an RTOS, on one or
> > > more CPUs while allowing Linux to continue running on those remaining.
> > And how is actually guaranteed that these two things are properly seperated
> > (memory, devices, interrupts etc.) ?
> 
> Memory separation is primarily handled by the remoteproc subsystem, which will
> allocate and map memory as required by the firmware, though because the CPU is
> executing in kernel mode there is nothing preventing it accessing anything in
> the system. But that is of course the same as any root process which could do
> the same thing via /dev/mem. One must be root to offline the CPU from Linux
> and load firmware to it, so there is no greater hazard to the system than that
> firmware running as a root process within userland.

Oh yes, there is. You can deny access to /dev/mem even for root, which is a
sensible thing to do. And even a process running as root has restrictions
which the kernel can enforce.

> Separation of devices and interrupts is a system design issue, as this feature
> will find use in embedded systems where the system will be partitioned into
> Linux and bare metal components. This is done where there are requirements
> such as needing to run real time code as well as Linux, or enforce separation
> through firmware binaries running separately to Linux.
> This would be useful, for example, for a modem driver running as bare metal
> code within one of the system VPEs and providing a virtio-net interface to the
> kernel. There would be no kernel driver present for such a device, therefore
> there would be no resource conflicts.

In theory.
 
> There only different thing about the MIPS implementation of remoteproc is that
> it turns one of the general purpose Linux CPUs into a remote processor, rather
> than there being a separate remote CPU within the SoC, as is the case with
> most remoteproc drivers. But unless there is some form of MMU between that CPU
> and the system bus, then it will have the same ability to access all system
> resources as is the case with this driver.

That's true, but that's a design issue on the SoC level where we cannot do
anything about.

> Again I don't think there is any greater risk to the system here as
> there would be with any other remoteproc based system.

Well. The whole thing is just a proliferation of a really bad mechanism,
which was rejected several times in the past. Surely MIPS as being MIPS has
this mechanism already, but that does not make it any better.

> There is already a mechanism to do this in the upstream MIPS kernel - the VPE
> loader, which has been there 2005 (commit
> e01402b115cccb6357f956649487aca2c6f7fbba). One user of the VPE loader was
> Lantiq, who used it to load a proprietary modem driver, for which there is no
> GPL driver.
> What we are proposing here is to move from that MIPS specific mechanism of
> running bare metal code to the standardized remoteproc subsystem such that
> people wanting to design a MIPS based system with both real time firmware and
> general Linux processing tasks may do so using standardized kernel interfaces.

Again, you should either use NOHZ_FULL (and you can implement a proprietary
user space driver w/o using /dev/mem) or seperate the CPUs in the boot
loader already and have some tiny piece of firmware which lets you load the
real firmware blob and control it. Ideally you use hw-virtualization, but
in absence of that you can do a halfways sane paritioning w/o abusing CPU
hotplug for this.

Thanks,

	tglx

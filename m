Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2016 18:22:17 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:56895 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992104AbcJEQWJRVIkM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Oct 2016 18:22:09 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 3C5FAD167C9FA;
        Wed,  5 Oct 2016 17:22:00 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct 2016
 17:22:01 +0100
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 5 Oct
 2016 17:22:00 +0100
Subject: Re: [PATCH v2 5/6] remoteproc/MIPS: Add a remoteproc driver for MIPS
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com>
 <1474361249-31064-6-git-send-email-matt.redfearn@imgtec.com>
 <20161003221636.GI7509@tuxbot>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-remoteproc@vger.kernel.org>,
        <lisa.parratt@imgtec.com>, <linux-kernel@vger.kernel.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <3a3e506d-b40f-a407-27a9-c2e0bfdda97c@imgtec.com>
Date:   Wed, 5 Oct 2016 17:22:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161003221636.GI7509@tuxbot>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Bjorn,

Thanks for the review and comments, much appreciated :-)


On 03/10/16 23:16, Bjorn Andersson wrote:
> On Tue 20 Sep 01:47 PDT 2016, Matt Redfearn wrote:
>
>> Add a remoteproc driver to steal, load the firmware, and boot an offline
>> MIPS core, turning it into a coprocessor.
>>
>> This driver provides a sysfs to allow arbitrary firmware to be loaded
>> onto a core, which may expose virtio devices. Coprocessor firmware must
>> abide by the UHI coprocessor boot protocol.
> Hi Matt,
>
> Sorry for my very slow response, I kept getting side tracked on the
> sysfs part every time I attempted to review this. After discussing with
> others it's obvious that being able to boot a remoteproc with a specific
> firmware image for some amount of time is a very common request.
>
> Rather than adding a MIPS specific interface for controlling this rproc
> I would like for us to bring this to the core.

Yes, makes perfect sense. I had a bit of fun allowing for the firmware 
name / information to be changed in an allocated struct rproc, but I 
have a proof of concept working now and will post it soon. The main 
issue remaining is that when the virtio devices are removed in the 
context of the sysfs write, a warning from dma-mapping.h is triggered 
because interrupts are disabled:

[   28.413958] WARNING: CPU: 0 PID: 121 at 
./include/linux/dma-mapping.h:433 free_buf+0x1a8/0x288
[   28.423542] Modules linked in:
[   28.426951] CPU: 0 PID: 121 Comm: sh Tainted: G        W 4.8.0+ #729
[   28.434600] Stack : 00000000 00000000 00000000 00000000 80d26cea 
0000003e 80c50000 00000000
       00000000 80c50000 80c50000 00040800 80c50000 8f658bc8 80b992dc 
00000079
       00000000 80d23824 00000000 0067544c 0067542c 8048af58 80c50000 
00000001
       80c50000 00000000 80b9fcd0 8f7c7b74 80d23824 8051d8bc 00000000 
0067544c
       00000007 80c50000 8f7c7b74 00040800 00000000 00000000 00000000 
00000000
       ...
[   28.474274] Call Trace:
[   28.477005] [<8040c538>] show_stack+0x74/0xc0
[   28.481860] [<80757240>] dump_stack+0xd0/0x110
[   28.486813] [<80430d98>] __warn+0xfc/0x130
[   28.491379] [<80430ee0>] warn_slowpath_null+0x2c/0x3c
[   28.497007] [<807e7c6c>] free_buf+0x1a8/0x288
[   28.501862] [<807ea590>] remove_port_data+0x50/0xac
[   28.507298] [<807ea6a0>] unplug_port+0xb4/0x1bc
[   28.512346] [<807ea858>] virtcons_remove+0xb0/0xfc
[   28.517689] [<807b6734>] virtio_dev_remove+0x58/0xc0
[   28.523223] [<807f918c>] __device_release_driver+0xac/0x134
[   28.529433] [<807f924c>] device_release_driver+0x38/0x50
[   28.535352] [<807f7edc>] bus_remove_device+0xfc/0x130
[   28.540980] [<807f4b74>] device_del+0x17c/0x21c
[   28.546027] [<807f4c38>] device_unregister+0x24/0x38
[   28.551562] [<807b6b50>] unregister_virtio_device+0x28/0x44
[   28.557777] [<80948ab0>] rproc_change_firmware+0xb4/0x114
[   28.563795] [<80949464>] firmware_store+0x2c/0x40
[   28.569039] [<8060186c>] kernfs_fop_write+0x154/0x1dc
[   28.574669] [<805823f0>] __vfs_write+0x5c/0x17c
[   28.579719] [<805834ac>] vfs_write+0xe0/0x190
[   28.584574] [<80584520>] SyS_write+0x80/0xf4
[   28.589336] [<80415908>] syscall_common+0x34/0x58
[   28.594570]
[   28.596228] ---[ end trace 3f6cae675f2fcee9 ]---


I'm still investigating how to decouple removal of the virtio devices 
from interrupts being disabled.


>
>
> I would also appreciate if Ralf had some input on the MIPS specifics.
>
>
> Also regarding the 32-bit requirement, have you investigated what is
> needed to support 64-bit ELFs?

Not yet - I wanted to get the 32bit version accepted first, then we can 
look at the required changes to support 64bit since no doubt that will 
necessitate quite a few changes to the core code.

>
> [..]
>> diff --git a/drivers/remoteproc/mips_remoteproc.c b/drivers/remoteproc/mips_remoteproc.c
> [..]
>> +int mips_rproc_op_start(struct rproc *rproc)
>> +{
>> +	struct mips_rproc *mproc = *(struct mips_rproc **)rproc->priv;
>> +	int err;
>> +	int cpu = mproc->cpu;
>> +
>> +	if (mips_rprocs[cpu]) {
>> +		dev_err(&rproc->dev, "CPU%d in use\n", cpu);
>> +		return -EBUSY;
>> +	}
>> +	mips_rprocs[cpu] = rproc;
>> +
>> +	/* Create task for the CPU to use before handing off to firmware */
>> +	mproc->tsk = fork_idle(cpu);
>> +	if (IS_ERR(mproc->tsk)) {
>> +		dev_err(&rproc->dev, "fork_idle() failed for CPU%d\n", cpu);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* We won't be needing the Linux IPIs anymore */
>> +	if (mips_smp_ipi_free(get_cpu_mask(cpu)))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Direct IPIs from the remote processor to CPU0 since that can't be
>> +	 * offlined while the remote CPU is running.
>> +	 */
>> +	mproc->ipi_linux = irq_reserve_ipi(ipi_domain(), get_cpu_mask(0));
>> +	if (!mproc->ipi_linux) {
>> +		dev_err(&mproc->dev, "Failed to reserve incoming kick\n");
>> +		goto exit_rproc_nofrom;
>> +	}
>> +
>> +	mproc->ipi_remote = irq_reserve_ipi(ipi_domain(), get_cpu_mask(cpu));
>> +	if (!mproc->ipi_remote) {
>> +		dev_err(&mproc->dev, "Failed to reserve outgoing kick\n");
>> +		goto exit_rproc_noto;
>> +	}
>> +
>> +	/* register incoming ipi */
>> +	err = devm_request_threaded_irq(&mproc->dev, mproc->ipi_linux,
>> +					mips_rproc_ipi_handler,
>> +					mips_rproc_vq_int, 0,
>> +					"mips-rproc IPI in", mproc->rproc);
> Based on how you've designed this I think it makes sense to just depend
> on the fact that stop() will always be called and hence you do not
> benefit from the devm_ version of this api.

Yeah, makes sense.

>
>> +	if (err) {
>> +		dev_err(&mproc->dev, "Failed to register incoming kick: %d\n",
>> +			err);
>> +		goto exit_rproc_noint;
>> +	}
>> +
>> +	if (!mips_cps_steal_cpu_and_execute(cpu, &mips_rproc_cpu_entry,
>> +						mproc->tsk))
>> +		return 0;
> Please flip this around, to follow the pattern of the others, like:
>
> 	if (mips_cps_steal_cpu_and_execute()) {
> 		dev_err()
> 		goto exit_free_irq;
> 	}
>
> 	return 0;
>
> exit_free_irq:

OK.

>
>> +
>> +	dev_err(&mproc->dev, "Failed to steal CPU%d for remote\n", cpu);
>> +	devm_free_irq(&mproc->dev, mproc->ipi_linux, mproc->rproc);
>> +exit_rproc_noint:
>> +	irq_destroy_ipi(mproc->ipi_remote, get_cpu_mask(cpu));
>> +exit_rproc_noto:
>> +	irq_destroy_ipi(mproc->ipi_linux, get_cpu_mask(0));
>> +exit_rproc_nofrom:
>> +	free_task(mproc->tsk);
>> +	mips_rprocs[cpu] = NULL;
>> +
>> +	/* Set up the Linux IPIs again */
>> +	mips_smp_ipi_allocate(get_cpu_mask(cpu));
>> +	return -EINVAL;
>> +}
>> +
>> +int mips_rproc_op_stop(struct rproc *rproc)
>> +{
>> +	struct mips_rproc *mproc = *(struct mips_rproc **)rproc->priv;
>> +
>> +	if (mproc->ipi_linux)
> stop() should not be called unless start() succeeded, so ipi_linux
> should not be able to be 0.

True.

>
>> +		devm_free_irq(&mproc->dev, mproc->ipi_linux, mproc->rproc);
>> +
>> +	irq_destroy_ipi(mproc->ipi_linux, get_cpu_mask(0));
>> +	irq_destroy_ipi(mproc->ipi_remote, get_cpu_mask(mproc->cpu));
>> +
>> +	/* Set up the Linux IPIs again */
>> +	mips_smp_ipi_allocate(get_cpu_mask(mproc->cpu));
>> +
>> +	free_task(mproc->tsk);
>> +
>> +	mips_rprocs[mproc->cpu] = NULL;
>> +
>> +	return mips_cps_halt_and_return_cpu(mproc->cpu);
>> +}
>> +
>> +
> [..]
>> +
>> +/* Steal a core and run some firmware on it */
>> +int mips_rproc_start(struct mips_rproc *mproc, const char *firmware, size_t len)
>> +{
>> +	int err = -EINVAL;
>> +	struct mips_rproc **priv;
>> +
>> +	/* Duplicate the filename, dropping whitespace from the end via len */
>> +	mproc->firmware = kstrndup(firmware, len, GFP_KERNEL);
>> +	if (!mproc->firmware)
>> +		return -ENOMEM;
>> +
>> +	mproc->rproc = rproc_alloc(&mproc->dev, "mips", &mips_rproc_proc_ops,
>> +				   mproc->firmware,
>> +				   sizeof(struct mips_rproc *));
>> +	if (!mproc->rproc)
>> +		return -ENOMEM;
>> +
>> +	priv = mproc->rproc->priv;
>> +	*priv = mproc;
> If we move the class into the core, everyone will share the same
> interface for setting firmware, booting and shutting down remoteproc.

Yes, that sounds like the best way forward.

>
> I think you should set rproc->auto_boot to false and move this code into
> the probe function above. It would make there be an remoteproc instance
> whenever the cpu is offlined, do you see any problems with this?

No problem with it being available any time the CPU is offline.


>
>> +
>> +	/* go live! */
>> +	err = rproc_add(mproc->rproc);
>> +	if (err) {
>> +		dev_err(&mproc->dev, "Failed to add rproc: %d\n", err);
>> +		rproc_put(mproc->rproc);
>> +		kfree(mproc->firmware);
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* Stop a core, and return it to being offline */
>> +int mips_rproc_stop(struct mips_rproc *mproc)
>> +{
>> +	rproc_shutdown(mproc->rproc);
> I presume this shutdown is related to the implicit boot happening in
> rproc_add() if you have virtio devices; I've changed this for v4.9 so
> that rproc_del() shuts down the core if rproc_add() booted it.

Yeah it is, ok great.

>
> There needs to be some more work done in this area though, because there
> are plenty of corner cases that we don't handle properly today...
>
>> +	rproc_del(mproc->rproc);
>> +	rproc_put(mproc->rproc);
>> +	mproc->rproc = NULL;
>> +	return 0;
>> +}
>> +
> [..]
>> +
>> +/* sysfs interface to mips_rproc_stop */
>> +static ssize_t stop_store(struct device *dev,
>> +			      struct device_attribute *attr,
>> +			      const char *buf, size_t count)
>> +{
>> +	struct mips_rproc *mproc = to_mips_rproc(dev);
>> +	int err = -EINVAL;
>> +
>> +
>> +	if (mproc->rproc)
>> +		err = mips_rproc_stop(mproc);
>> +	else
>> +		err = -EBUSY;
>> +
>> +	return err ? err : count;
>> +}
>> +static DEVICE_ATTR_WO(stop);
> Please move this control into the core, preferably as "state" which can
> be passed "boot" or "shutdown" - i.e. what we today have in debugfs.

OK, though I've stuck with "start" and "stop" as are in the debugfs version.

Thanks,
Matt


>
>> +
>> +/* Boiler plate for devclarng mips-rproc sysfs devices */
>> +static struct attribute *mips_rproc_attrs[] = {
>> +	&dev_attr_firmware.attr,
>> +	&dev_attr_stop.attr,
>> +	NULL
>> +};
>> +
> Regards,
> Bjorn

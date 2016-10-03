Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2016 00:16:53 +0200 (CEST)
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32814 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991129AbcJCWQqVQiAU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Oct 2016 00:16:46 +0200
Received: by mail-pf0-f178.google.com with SMTP id 190so21139442pfv.0
        for <linux-mips@linux-mips.org>; Mon, 03 Oct 2016 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xqJSyCcOt0T8uhqy07Q/ouTOSafxc7/yP5LdngEFFmw=;
        b=S2q9MkWcB6SNpifitYwSmRZe8Er7qpT0pRD2Yol4zq0f1FoRyY5IBsgXd1I+yxqOZT
         fkpeiYw4Cp9bEzvPMpUOPbQu4eRYCEkf7ovv08kpJgDjcX/KmpKL67ICBhKoFFa3SmNa
         q9lI1/+1YADEeXk2aLsUia++tB/cMLFLs8B58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xqJSyCcOt0T8uhqy07Q/ouTOSafxc7/yP5LdngEFFmw=;
        b=ZRsd6+ldI+bHZTbB8DX92td4P718CideMYy0e3LMGWzqUiFvokAo2q/TOoqscuXJ/c
         q2NWX8eWJrj4xvw3h1D/88GJfyYrjIl8kULZL6f+YiTrt2vKWCigMZmACJvhOB2c4BhW
         0L+EWuwnzDwlFYMmII4hqkIXFWvg6t282ECGUPGiccJENahckkqHt4xhZMBWAZlmy9cJ
         UGu3QVUsbxLtkbHVgBD+xG3TsZ38Sh7QvS/LkyRKwOzsKzpie8Wqzcv9yJMDM6R4LeEH
         7EoS4QhSXlISIjnnhKKfp4A3NNArd5NqjDnJGxdKNon7kN2f5wF2qTYkSXlGz9Rg1+eh
         UDEw==
X-Gm-Message-State: AA6/9RmxcZAqzz3Ge3739dUmObmrSvmp84PG5hALxz9B4dMlfkEA82dPREKLZO7ODN8pAAFb
X-Received: by 10.98.193.193 with SMTP id i184mr610776pfg.56.1475532999964;
        Mon, 03 Oct 2016 15:16:39 -0700 (PDT)
Received: from tuxbot (ip68-111-223-48.sd.sd.cox.net. [68.111.223.48])
        by smtp.gmail.com with ESMTPSA id yg10sm211378pab.8.2016.10.03.15.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2016 15:16:38 -0700 (PDT)
Date:   Mon, 3 Oct 2016 15:16:36 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-remoteproc@vger.kernel.org,
        lisa.parratt@imgtec.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] remoteproc/MIPS: Add a remoteproc driver for MIPS
Message-ID: <20161003221636.GI7509@tuxbot>
References: <1474361249-31064-1-git-send-email-matt.redfearn@imgtec.com>
 <1474361249-31064-6-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474361249-31064-6-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <bjorn.andersson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bjorn.andersson@linaro.org
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

On Tue 20 Sep 01:47 PDT 2016, Matt Redfearn wrote:

> Add a remoteproc driver to steal, load the firmware, and boot an offline
> MIPS core, turning it into a coprocessor.
> 
> This driver provides a sysfs to allow arbitrary firmware to be loaded
> onto a core, which may expose virtio devices. Coprocessor firmware must
> abide by the UHI coprocessor boot protocol.

Hi Matt,

Sorry for my very slow response, I kept getting side tracked on the
sysfs part every time I attempted to review this. After discussing with
others it's obvious that being able to boot a remoteproc with a specific
firmware image for some amount of time is a very common request.

Rather than adding a MIPS specific interface for controlling this rproc
I would like for us to bring this to the core.


I would also appreciate if Ralf had some input on the MIPS specifics.


Also regarding the 32-bit requirement, have you investigated what is
needed to support 64-bit ELFs?

[..]
> diff --git a/drivers/remoteproc/mips_remoteproc.c b/drivers/remoteproc/mips_remoteproc.c
[..]
> +int mips_rproc_op_start(struct rproc *rproc)
> +{
> +	struct mips_rproc *mproc = *(struct mips_rproc **)rproc->priv;
> +	int err;
> +	int cpu = mproc->cpu;
> +
> +	if (mips_rprocs[cpu]) {
> +		dev_err(&rproc->dev, "CPU%d in use\n", cpu);
> +		return -EBUSY;
> +	}
> +	mips_rprocs[cpu] = rproc;
> +
> +	/* Create task for the CPU to use before handing off to firmware */
> +	mproc->tsk = fork_idle(cpu);
> +	if (IS_ERR(mproc->tsk)) {
> +		dev_err(&rproc->dev, "fork_idle() failed for CPU%d\n", cpu);
> +		return -ENOMEM;
> +	}
> +
> +	/* We won't be needing the Linux IPIs anymore */
> +	if (mips_smp_ipi_free(get_cpu_mask(cpu)))
> +		return -EINVAL;
> +
> +	/*
> +	 * Direct IPIs from the remote processor to CPU0 since that can't be
> +	 * offlined while the remote CPU is running.
> +	 */
> +	mproc->ipi_linux = irq_reserve_ipi(ipi_domain(), get_cpu_mask(0));
> +	if (!mproc->ipi_linux) {
> +		dev_err(&mproc->dev, "Failed to reserve incoming kick\n");
> +		goto exit_rproc_nofrom;
> +	}
> +
> +	mproc->ipi_remote = irq_reserve_ipi(ipi_domain(), get_cpu_mask(cpu));
> +	if (!mproc->ipi_remote) {
> +		dev_err(&mproc->dev, "Failed to reserve outgoing kick\n");
> +		goto exit_rproc_noto;
> +	}
> +
> +	/* register incoming ipi */
> +	err = devm_request_threaded_irq(&mproc->dev, mproc->ipi_linux,
> +					mips_rproc_ipi_handler,
> +					mips_rproc_vq_int, 0,
> +					"mips-rproc IPI in", mproc->rproc);

Based on how you've designed this I think it makes sense to just depend
on the fact that stop() will always be called and hence you do not
benefit from the devm_ version of this api.

> +	if (err) {
> +		dev_err(&mproc->dev, "Failed to register incoming kick: %d\n",
> +			err);
> +		goto exit_rproc_noint;
> +	}
> +
> +	if (!mips_cps_steal_cpu_and_execute(cpu, &mips_rproc_cpu_entry,
> +						mproc->tsk))
> +		return 0;

Please flip this around, to follow the pattern of the others, like:

	if (mips_cps_steal_cpu_and_execute()) {
		dev_err()
		goto exit_free_irq;
	}

	return 0;

exit_free_irq:

> +
> +	dev_err(&mproc->dev, "Failed to steal CPU%d for remote\n", cpu);
> +	devm_free_irq(&mproc->dev, mproc->ipi_linux, mproc->rproc);
> +exit_rproc_noint:
> +	irq_destroy_ipi(mproc->ipi_remote, get_cpu_mask(cpu));
> +exit_rproc_noto:
> +	irq_destroy_ipi(mproc->ipi_linux, get_cpu_mask(0));
> +exit_rproc_nofrom:
> +	free_task(mproc->tsk);
> +	mips_rprocs[cpu] = NULL;
> +
> +	/* Set up the Linux IPIs again */
> +	mips_smp_ipi_allocate(get_cpu_mask(cpu));
> +	return -EINVAL;
> +}
> +
> +int mips_rproc_op_stop(struct rproc *rproc)
> +{
> +	struct mips_rproc *mproc = *(struct mips_rproc **)rproc->priv;
> +
> +	if (mproc->ipi_linux)

stop() should not be called unless start() succeeded, so ipi_linux
should not be able to be 0.

> +		devm_free_irq(&mproc->dev, mproc->ipi_linux, mproc->rproc);
> +
> +	irq_destroy_ipi(mproc->ipi_linux, get_cpu_mask(0));
> +	irq_destroy_ipi(mproc->ipi_remote, get_cpu_mask(mproc->cpu));
> +
> +	/* Set up the Linux IPIs again */
> +	mips_smp_ipi_allocate(get_cpu_mask(mproc->cpu));
> +
> +	free_task(mproc->tsk);
> +
> +	mips_rprocs[mproc->cpu] = NULL;
> +
> +	return mips_cps_halt_and_return_cpu(mproc->cpu);
> +}
> +
> +
[..]
> +
> +/* Steal a core and run some firmware on it */
> +int mips_rproc_start(struct mips_rproc *mproc, const char *firmware, size_t len)
> +{
> +	int err = -EINVAL;
> +	struct mips_rproc **priv;
> +
> +	/* Duplicate the filename, dropping whitespace from the end via len */
> +	mproc->firmware = kstrndup(firmware, len, GFP_KERNEL);
> +	if (!mproc->firmware)
> +		return -ENOMEM;
> +
> +	mproc->rproc = rproc_alloc(&mproc->dev, "mips", &mips_rproc_proc_ops,
> +				   mproc->firmware,
> +				   sizeof(struct mips_rproc *));
> +	if (!mproc->rproc)
> +		return -ENOMEM;
> +
> +	priv = mproc->rproc->priv;
> +	*priv = mproc;

If we move the class into the core, everyone will share the same
interface for setting firmware, booting and shutting down remoteproc.

I think you should set rproc->auto_boot to false and move this code into
the probe function above. It would make there be an remoteproc instance
whenever the cpu is offlined, do you see any problems with this?

> +
> +	/* go live! */
> +	err = rproc_add(mproc->rproc);
> +	if (err) {
> +		dev_err(&mproc->dev, "Failed to add rproc: %d\n", err);
> +		rproc_put(mproc->rproc);
> +		kfree(mproc->firmware);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Stop a core, and return it to being offline */
> +int mips_rproc_stop(struct mips_rproc *mproc)
> +{
> +	rproc_shutdown(mproc->rproc);

I presume this shutdown is related to the implicit boot happening in
rproc_add() if you have virtio devices; I've changed this for v4.9 so
that rproc_del() shuts down the core if rproc_add() booted it.

There needs to be some more work done in this area though, because there
are plenty of corner cases that we don't handle properly today...

> +	rproc_del(mproc->rproc);
> +	rproc_put(mproc->rproc);
> +	mproc->rproc = NULL;
> +	return 0;
> +}
> +
[..]
> +
> +/* sysfs interface to mips_rproc_stop */
> +static ssize_t stop_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct mips_rproc *mproc = to_mips_rproc(dev);
> +	int err = -EINVAL;
> +
> +
> +	if (mproc->rproc)
> +		err = mips_rproc_stop(mproc);
> +	else
> +		err = -EBUSY;
> +
> +	return err ? err : count;
> +}
> +static DEVICE_ATTR_WO(stop);

Please move this control into the core, preferably as "state" which can
be passed "boot" or "shutdown" - i.e. what we today have in debugfs.

> +
> +/* Boiler plate for devclarng mips-rproc sysfs devices */
> +static struct attribute *mips_rproc_attrs[] = {
> +	&dev_attr_firmware.attr,
> +	&dev_attr_stop.attr,
> +	NULL
> +};
> +

Regards,
Bjorn

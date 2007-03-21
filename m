Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 00:51:08 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:7609 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022998AbXCUAvG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Mar 2007 00:51:06 +0000
Received: (qmail 17636 invoked by uid 101); 21 Mar 2007 00:49:55 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 21 Mar 2007 00:49:55 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l2L0nteb006910;
	Tue, 20 Mar 2007 16:49:55 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCP6HRN>; Tue, 20 Mar 2007 17:49:52 -0800
Message-ID: <4600812E.7070200@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Jean Delvare <khali@linux-fr.org>
Cc:	linux-mips@linux-mips.org, i2c@lm-sensors.org
Subject: Re: [PATCH 9/12] drivers: PMC MSP71xx LED driver
Date:	Tue, 20 Mar 2007 16:49:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 21 Mar 2007 01:49:44.0843 (UTC) FILETIME=[33318DB0:01C76B5B]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Jean Delvare wrote:
> Hi Marc,
> 
> On Sat, 17 Mar 2007 12:29:24 +0000, Ralf Baechle wrote:
>  > ----- Forwarded message from Marc St-Jean <stjeanma@pmc-sierra.com> 
> -----
>  >
>  > On Fri, Mar 16, 2007 at 03:40:41PM -0600, Marc St-Jean wrote:
>  > From: Marc St-Jean <stjeanma@pmc-sierra.com>
>  > Date: Fri, 16 Mar 2007 15:40:41 -0600
>  > To:   akpm@linux-foundation.org
>  > Subject: [PATCH 9/12] drivers: PMC MSP71xx LED driver
>  > Cc:   linux-mips@linux-mips.org
>  >
>  > [PATCH 9/12] drivers: PMC MSP71xx LED driver
>  >
>  > Patch to add LED driver for the PMC-Sierra MSP71xx devices.
>  >
>  > Reposting patches as a single set at the request of akpm.
>  > Only 9 of 12 will be posted at this time, 3 more to follow
>  > when cleanups are complete.
>  >
>  > CCing linux-mips.org since minor changes have occured
>  > during cleanup of driver patches for other lists.
> 
> I don't have the time for a complete review, sorry, somebody else will
> have to do it. A few comments though:
> 
>  > diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
>  > index 87ee3ce..3bef46b 100644
>  > --- a/drivers/i2c/chips/Kconfig
>  > +++ b/drivers/i2c/chips/Kconfig
>  > @@ -50,6 +50,15 @@ config SENSORS_PCF8574
>  >         These devices are hard to detect and rarely found on mainstream
>  >         hardware.  If unsure, say N.
>  > 
>  > +config SENSORS_PMCTWILED
> 
> Please don't include "SENSORS" in the configuration option name, as the
> device doesn't include any sensors.

It will be in the next patch update.

>  > +     tristate "PMC Led-over-TWI driver"
>  > +     depends on I2C && PMC_MSP
>  > +     help
>  > +       The new VPE-safe backend driver for all the LEDs on the 7120 
> platform.
>  > +
>  > +       While you may build this as a module, it is recommended you 
> build it
>  > +       into the kernel monolithic so all drivers may access it at 
> all times.
> 
>  > diff --git a/drivers/i2c/chips/pmctwiled.c 
> b/drivers/i2c/chips/pmctwiled.c
>  > new file mode 100644
>  > index 0000000..69845a5
>  > --- /dev/null
>  > +++ b/drivers/i2c/chips/pmctwiled.c
>  > @@ -0,0 +1,524 @@
>  > +/*
>  > + * Special LED-over-TWI-PCA9554 driver for the PMC Sierra
>  > + * Residential Gateway demo board (and potentially others).
>  > (...)
>  > +/* This function is called by i2c_probe */
>  > +static int pmctwiled_detect(struct i2c_adapter *adapter,
>  > +                             int address, int kind)
>  > +{
>  > +     struct i2c_client *new_client = NULL;   /* client structure */
> 
> Please rename to just "client".

Ditto.

>  > +     struct pmctwiled_data *data = NULL;     /* local data structure */
>  > +     int err = 0;
>  > +     int dev_id = address - PMCTWILED_BASEADDRESS;
>  > +
>  > +     if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  > +             goto exit;
>  > +
>  > +     /*
>  > +      * For now, we presume we have a valid client. We now create the
>  > +      * client structure, even though we cannot fill it completely yet.
>  > +      */
>  > +     data = kzalloc(sizeof(*data), GFP_KERNEL);
>  > +     if (!data) {
>  > +             err = -ENOMEM;
>  > +             goto exit;
>  > +     }
>  > +
>  > +     new_client = &data->client;
>  > +     i2c_set_clientdata(new_client, data);
>  > +     new_client->addr = address;
>  > +     new_client->adapter = adapter;
>  > +     new_client->driver = &pmctwiled_driver;
>  > +     new_client->flags = 0;
> 
> Not needed, kzalloc above did it for you.

Ditto.

>  > +
>  > +     /*
>  > +      * Detection:
>  > +      *   The pca9554 only has 4 registers (0-3).
>  > +      * All other reads should fail.
>  > +      */
>  > +     if (i2c_smbus_read_byte_data(new_client, 3) < 0 ||
>  > +         i2c_smbus_read_byte_data(new_client, 4) >= 0)
>  > +             goto exit_kfree;
>  > +
>  > +     /* Found PCA9554 (probably) */
>  > +     strlcpy(new_client->name, "pca9554", I2C_NAME_SIZE);
>  > +     printk(KERN_WARNING
>  > +             "Detected PCA9554 I/O chip (device %d) at 0x%02x\n",
>  > +             dev_id, address);
> 
> This is confusing. First you write a dedicated driver, then you use the
> generic name for the device name. This raises a question:
> 
> Would it make sense to have generic PCA9554 driver, possibly
> implementing the new GPIO infrastructure, and have dedicated drivers
> such as this one build on top of that?
> 
> Either way you have to be consistent, if you go with dedicated code,
> the i2c client name should not be generic.

I have renamed the driver "pmctwiled" and the client "pmctwiled_pca9554"
to help avoid confusion.

>  > +
>  > +     /* Tell the I2C layer a new client has arrived */
>  > +     err = i2c_attach_client(new_client);
>  > +     if (err)
>  > +             goto exit_kfree;
>  > +
>  > +     /*
>  > +      * Register this in the list of available devices, and set up the
>  > +      * initial state
>  > +      */
>  > +     i2c_smbus_write_byte_data(new_client, PCA9554_OUTPUT,
>  > +                     i2c_smbus_read_byte_data(new_client, 
> PCA9554_INPUT));
>  > +     i2c_smbus_write_byte_data(new_client, PCA9554_DIRECTION,
>  > +                     msp_led_initial_input_state[dev_id]);
>  > +     pmctwiled_device[dev_id] = new_client;
> 
> Here you assume that the PCA9554 devices can only live on one I2C bus,
> otherwise you could have two devices with the same address. But you do
> not check that this is actually the case anywhere in your code.

I've added code to verify it is our SoC the adapter in
pmctwiled_attach_adapter() before calling i2c_probe().


> This driver appears to be a good candidate to become a new-style i2c
> driver, where devices are instantiated explicitely by the platform code
> rather than probed for afterwards. The i2c-core changes allowing that
> will be in the next -mm kernel and will be merged in 2.6.22-rc1.

OK, I will look at it when it reaches l-m.o. Although the probe still
allows us to support several demo boards on the same device family
which could have a different number of clients.

Thanks,
Marc

>  > +
>  > +     return 0;
>  > +
>  > +exit_kfree:
>  > +     kfree(data);
>  > +exit:
>  > +     return err;
>  > +}
> 
> -- 
> Jean Delvare
> 

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2UDU2V16155
	for linux-mips-outgoing; Sat, 30 Mar 2002 05:30:02 -0800
Received: from bunny.shuttle.de (bunny.shuttle.de [193.174.247.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2UDTav16138;
	Sat, 30 Mar 2002 05:29:36 -0800
Received: by bunny.shuttle.de (Postfix, from userid 112)
	id 436994E567; Sat, 30 Mar 2002 14:28:56 +0100 (CET)
Date: Sat, 30 Mar 2002 14:28:56 +0100
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Raoul Borenius <raoul@shuttle.de>, linux-mips@oss.sgi.com,
   devfs@oss.sgi.com
Subject: Re: broken devfs-support in SGI Zilog8530 serial driver
Message-ID: <20020330132856.GA24305@bunny.shuttle.de>
References: <20020329103244.GA15765@bunny.shuttle.de> <20020329233559.A31160@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020329233559.A31160@dea.linux-mips.net>
User-Agent: Mutt/1.3.28i
From: raoul@shuttle.de (Raoul Borenius)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Ralf,

On Fri, Mar 29, 2002 at 11:35:59PM -0800, Ralf Baechle wrote:
> On Fri, Mar 29, 2002 at 11:32:44AM +0100, Raoul Borenius wrote:
> 
> > I'm not sure if this is a devfs or mips problem so I'm sending it
> > to both lists.
> > 
> > I just compiled my own mips-kernel from oss.sgi.com:/cvs to get
> > devfs-support. Unfortunately there seems to be a problem with the
> > serial-driver at least in the linux_2_4 branch:
> > 
> > SGI Zilog8530 serial driver version 1.00
> > devfs_register(ttyS): could not append to parent, err: -17
> > devfs_register(cua): could not append to parent, err: -17
> 
> At this time we don't even claim to have proper devfs support in the
> Indy serial drivers ...

But it would be nice to have ;-)

Especially because you only need the small change pointed out by
Russell Coker:

--- sgiserial.c.orig    Sat Mar 30 10:51:03 2002
+++ sgiserial.c Sat Mar 30 10:54:28 2002
@@ -1875,7 +1875,11 @@
        
        memset(&serial_driver, 0, sizeof(struct tty_driver));
        serial_driver.magic = TTY_DRIVER_MAGIC;
+#ifdef CONFIG_DEVFS_FS
+       serial_driver.name = "tts/%d";
+#else
        serial_driver.name = "ttyS";
+#endif
        serial_driver.major = TTY_MAJOR;
        serial_driver.minor_start = 64;
        serial_driver.num = NUM_CHANNELS;
@@ -1911,7 +1915,11 @@
         * major number and the subtype code.
         */
        callout_driver = serial_driver;
+#ifdef CONFIG_DEVFS_FS
+       callout_driver.name = "cua/%d";
+#else
        callout_driver.name = "cua";
+#endif
        callout_driver.major = TTYAUX_MAJOR;
        callout_driver.subtype = SERIAL_TYPE_CALLOUT;

It works for my Indy and I just love devfs. All other drivers used
on my box also work fine with devfs (sound, watchdog, rtc etc.).

Regards

Raoul

Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2VF1Ia03263
	for linux-mips-outgoing; Sun, 31 Mar 2002 07:01:18 -0800
Received: from bunny.shuttle.de (bunny.shuttle.de [193.174.247.132])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2VF14v03238;
	Sun, 31 Mar 2002 07:01:04 -0800
Received: by bunny.shuttle.de (Postfix, from userid 112)
	id B90384E567; Sun, 31 Mar 2002 17:00:23 +0200 (CEST)
Date: Sun, 31 Mar 2002 17:00:23 +0200
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com, devfs@oss.sgi.com
Subject: Re: broken devfs-support in SGI Zilog8530 serial driver
Message-ID: <20020331150023.GA30224@bunny.shuttle.de>
References: <20020329103244.GA15765@bunny.shuttle.de> <20020329233559.A31160@dea.linux-mips.net> <20020330132856.GA24305@bunny.shuttle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020330132856.GA24305@bunny.shuttle.de>
User-Agent: Mutt/1.3.28i
From: raoul@shuttle.de (Raoul Borenius)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Ralf,

On Sat, Mar 30, 2002 at 02:28:56PM +0100, raoul wrote:
> Especially because you only need the small change pointed out by
> Russell Coker:
> 
> --- sgiserial.c.orig    Sat Mar 30 10:51:03 2002
> +++ sgiserial.c Sat Mar 30 10:54:28 2002
> @@ -1875,7 +1875,11 @@
>         
>         memset(&serial_driver, 0, sizeof(struct tty_driver));
>         serial_driver.magic = TTY_DRIVER_MAGIC;
> +#ifdef CONFIG_DEVFS_FS
> +       serial_driver.name = "tts/%d";
> +#else
>         serial_driver.name = "ttyS";
> +#endif
>         serial_driver.major = TTY_MAJOR;
>         serial_driver.minor_start = 64;
>         serial_driver.num = NUM_CHANNELS;

Thanks for including the changes fr the ttyS's. But it seems you forgot the
callout-devices:

> @@ -1911,7 +1915,11 @@
>          * major number and the subtype code.
>          */
>         callout_driver = serial_driver;
> +#ifdef CONFIG_DEVFS_FS
> +       callout_driver.name = "cua/%d";
> +#else
>         callout_driver.name = "cua";
> +#endif
>         callout_driver.major = TTYAUX_MAJOR;
>         callout_driver.subtype = SERIAL_TYPE_CALLOUT;
> 

Could you commit that too?

Thanx

Raoul

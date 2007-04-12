Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Apr 2007 15:49:43 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:63934 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S20023158AbXDLOtk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Apr 2007 15:49:40 +0100
Received: (qmail 29266 invoked from network); 12 Apr 2007 14:48:19 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 12 Apr 2007 14:48:19 -0000
Message-ID: <461E46EF.4060004@ru.mvista.com>
Date:	Thu, 12 Apr 2007 18:49:19 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Markus Gothe <markus.gothe@27m.se>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] EMMA2RH I2C driver
References: <461DF11F.404@27m.se>
In-Reply-To: <461DF11F.404@27m.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Markus Gothe wrote:

> As Ralf pointed out in march I've been polishing the IIC-driver for
> EMMA2RH.

> I've shaped up the I2C-driver to be a platform-device-driver and added
> accurately memory-mapping/unmapping and irq-request/free.

> There was a datastructure missing which was pretty straight forward to
> figure out how to rebuild (i.e. i2c_algo_emma_data).

   Below are a few comments...

> --- drivers/i2c/algos/i2c-algo-emma2rh.c.orig	2007-03-15 13:32:35.000000000 +0100
> +++ drivers/i2c/algos/i2c-algo-emma2rh.c	2007-04-12 10:08:58.000000000 +0200
[...]
> @@ -73,13 +71,15 @@
>  #define EMMA2RH_I2C_RETRIES 3
>  #define EMMA2RH_I2C_TIMEOUT 100
>  
> -/* --- setting states on the bus with the right timing: --------------- */
> +/* --- setting states on the bus with the right timing: ---------------        
> +*/
>  #define set_emma(adap, ctl, val) adap->setemma(adap->data, ctl, val)
>  #define get_emma(adap, ctl) adap->getemma(adap->data, ctl)
>  #define get_own(adap) adap->getown(adap->data)
>  #define get_clock(adap) adap->getclock(adap->data)
>  
> -/* --- other auxiliary functions -------------------------------------- */
> +/* --- other auxiliary functions --------------------------------------        
> +*/
>  
>  static void i2c_start(struct i2c_algo_emma_data *adap)
>  {
> @@ -168,7 +168,8 @@
>                 udelay(adap->udelay);
>         }
>         DEB2(if (i)
> -            printk(KERN_DEBUG "%s: needed %d retries for %d\n", __FUNCTION__, i, addr)) ;
> +            printk(KERN_DEBUG "%s: needed %d retries for %d\n", __FUNCTION__, 
> +i, addr)) ;

   Please don't "uglify" the code. If you intend to carry it to the new line indent properlu (by starting it under paren).

> --- drivers/i2c/algos/i2c-algo-emma2rh.h.orig	2007-03-15 13:32:50.000000000 +0100
> +++ drivers/i2c/algos/i2c-algo-emma2rh.h	2007-04-12 10:08:18.000000000 +0200
> @@ -17,7 +17,8 @@
>      You should have received a copy of the GNU General Public License
>      along with this program; if not, write to the Free Software
>      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA*/
> -/* -------------------------------------------------------------------- */
> +/* --------------------------------------------------------------------        
> +*/

   No need to make the comment more ugly too.
 
>  #ifndef I2C_EMMA2RH_H
>  #define I2C_EMMA2RH_H
> @@ -102,4 +103,19 @@
>  #define I2C_EMMA_SHR            0x40
>  #define I2C_EMMA_INT            0x50
>  #define I2C_EMMA_INTM           0x60
> +
> +struct i2c_algo_emma_data {
> +        void *data;             /* private data for lolevel routines    */
> +        void (*setemma) (void *data, int ctl, int val);
> +        int  (*getemma) (void *data, int ctl);
> +        int  (*getown) (void *data);
> +        int  (*getclock) (void *data);
> +        void (*waitforpin) (void *data);
> +
> +        /* local settings */
> +        int udelay;
> +        int timeout;
> +
> +};
> +
>  #endif                         /* I2C_EMMA2RH_H */
> --- drivers/i2c/busses/i2c-emma2rh.c.orig	2007-03-15 13:33:45.000000000 +0100
> +++ drivers/i2c/busses/i2c-emma2rh.c	2007-04-12 10:06:48.000000000 +0200
> @@ -14,7 +14,7 @@
>       Copyright (C) 1995-97 Simon G. Vogl
>                     1998-99 Hans Berglund
>  
> -    With some changes from KyУЖsti MУЄlkki <kmalkki@cc.hut.fi> and even
> +    With some changes from Kyіsti Mфlkki <kmalkki@cc.hut.fi> and even
>      Frodo Looijaard <frodol@dds.nl>

  I'm not sure what that change is.
 
> @@ -167,81 +167,108 @@
>         dd->alg.getclock = i2c_emma_getclock;
>         dd->alg.waitforpin = i2c_emma_waitforpin;
>         dd->alg.udelay = 80;
> -       dd->alg.mdelay = 80;
>         dd->alg.timeout = 200;
>  
> -       strcpy(dd->adap.name, dev->bus_id);
> +       strcpy(dd->adap.name, pdev->name);
>         dd->adap.id = 0x00;
>         dd->adap.algo = NULL;
>         dd->adap.algo_data = &dd->alg;
>         dd->adap.client_register = i2c_emma_reg;
>         dd->adap.client_unregister = i2c_emma_unreg;
>  
> -       spin_lock_init(&dd->lock);
> -
> -       atomic_set(&dd->pending,0);
> -       init_waitqueue_head(&dd->wait);
> -
> -       dev_set_drvdata(dev, dd);
> -
> -       r = platform_get_resource(pdev, 0, 0);
> -       /* get resource of type '0' with #0 */
>  
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);/* get resource of type '0' with #0 */
> +       

   Put at least one space between ; and comment, and no trailing whitespace, please.

>         if (!r) {
>                 printk("Cannot get resource\n");
>                 err = -ENODEV;
>                 goto out_free;
> -       }
> -       dd->base = r->start;
> -
> +	}
> +	
> +	if (!request_mem_region(r->start, r->end - r->start + 1, pdev->name)) {
> +		printk("Memory region busy\n");
> +		err = -EBUSY;
> +		goto out_mem_region;

   You've already failed to request region, why then free it?

> +	}
> +	
> +	dd->base = ioremap_nocache(r->start, r->end - r->start);
> +	if (!dd->base) {
> +		printk("Unable to map registers\n");
> +		err = -EIO;
> +		goto out_ioremap;

   You've already failed to ioremap() it, why call iounmap()?

> +	}
> +	
>         dd->irq = platform_get_irq(pdev,0);
>         dd->clock = FAST397;
>         dd->own = 0x40 + pdev->id * 4;
>  
> -       err = request_irq(dd->irq, i2c_emma_handler, 0, dev->bus_id, dd);
> +       err = request_irq(dd->irq, i2c_emma_handler, 0, pdev->name, dd);
>         if (err < 0)
>                 goto out_free;

   And you've forgetten to call iounmap() and release_mem_region() in this case...

> +       
> +       spin_lock_init(&dd->lock);
>  
> +       atomic_set(&dd->pending,0);
> +       init_waitqueue_head(&dd->wait);
> +
> +       platform_set_drvdata(pdev, dd);
> +       
>         if ((err = i2c_emma_add_bus(&dd->adap)) < 0)
>                 goto out_irq;
>  
>         return 0;
> +
>  out_irq:
> -       free_irq(dd->irq, dev->bus_id);
> +	free_irq(dd->irq, dd);
> +out_ioremap:
> +	iounmap(dd->base);
> +out_mem_region:
> +	release_mem_region(r->start, r->end - r->start + 1);
>  out_free:
> -       kfree(dd);
> +	kfree(dd);
>  out:
> -       return err;
> +	return err;
>  }

   The cleanup code needs fixing, as you can see...


WBR, Sergei

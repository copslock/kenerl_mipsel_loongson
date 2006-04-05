Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 16:35:53 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:10626 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133363AbWDEPfo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 16:35:44 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FRABM-0002VX-7z; Wed, 05 Apr 2006 17:44:32 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FRADv-0000cv-LM; Wed, 05 Apr 2006 17:47:11 +0200
Date:	Wed, 5 Apr 2006 17:47:11 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Linux MIPS <linux-mips@linux-mips.org>
Cc:	ppopov@mvista.com
Message-ID: <20060405154711.GL7029@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Power management for au1000_eth.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

Hello,

I'm trying to add power management support to au1000_eth.c driver.

In order to to it I 've added these two functions:

   static int au1000_eth_suspend(struct device *dev, pm_message_t state, u32 level)
   {
   	struct net_device *ndev = dev_get_drvdata(dev);
   	struct au1000_private *aup = (struct au1000_private *) ndev->priv;

   	if (!ndev)
   		return 0;

   	switch (level) {
   	case SUSPEND_DISABLE :
   		if (netif_running(ndev))
   			netif_device_detach(ndev);

   		break;
   	
   	case SUSPEND_SAVE_STATE :
   		/* bring the device out of reset, otherwise accessing to mii
   	 	 * will hang */
   		*aup->enable = MAC_EN_CLOCK_ENABLE;
   		au_sync_delay(2);
   		*aup->enable = MAC_EN_RESET0 | MAC_EN_RESET1 | 
   				MAC_EN_RESET2 | MAC_EN_CLOCK_ENABLE;
   		au_sync_delay(2);

   		if (aup->phy_ops->phy_suspend)
   			aup->phy_ops->phy_suspend(ndev, aup->phy_addr, level);

   		del_timer_sync(&aup->timer); /* FIXME: REMOVED??? */
   		reset_mac(ndev);

   		netif_stop_queue(ndev);

   		free_irq(ndev->irq, dev);

   		break;

   	case SUSPEND_POWER_DOWN :

   		break;
   	}

   	return 0;
   }

   static int au1000_eth_resume(struct device *dev, u32 level)
   {
   	struct net_device *ndev = dev_get_drvdata(dev);
   	struct au1000_private *aup = (struct au1000_private *) ndev->priv;
           u32 flags;
   	int ret;

   	if (!ndev)
   		return 0;

   	switch (level) {
   	case RESUME_RESTORE_STATE :
   		/* bring the device out of reset, otherwise accessing to mii
   	 	 * will hang */
   		*aup->enable = MAC_EN_CLOCK_ENABLE;
   		au_sync_delay(2);
   		*aup->enable = MAC_EN_RESET0 | MAC_EN_RESET1 | 
   				MAC_EN_RESET2 | MAC_EN_CLOCK_ENABLE;
   		au_sync_delay(2);

   		if (aup->phy_ops->phy_resume)
   			aup->phy_ops->phy_resume(ndev, aup->phy_addr, level);
   		aup->phy_ops->phy_init(ndev, aup->phy_addr);

   		/* au1000_init() expects that the device is in reset state.
   		 */
   		reset_mac(ndev); /* au1000_init() expects the device in reset */
   		au1000_init(ndev);

   	        ret = request_irq(ndev->irq, &au1000_interrupt, 0, ndev->name, ndev);
   	        if (ret) {
   			printk(KERN_ERR "%s: unable to get IRQ %d\n",
   	                                 ndev->name, ndev->irq);
   			return ret; //FIXME
   		}

   		init_timer(&aup->timer); /* used in ioctl() */
   		aup->timer.expires = RUN_AT((3*HZ));
   		aup->timer.data = (unsigned long) ndev;
   		aup->timer.function = &au1000_timer; /* timer handler */
   		add_timer(&aup->timer);

   		break;

   	case RESUME_ENABLE :
   		if (netif_running(ndev))
   			netif_device_attach(ndev);

   		break;
   	}

   	return 0;
   }

The problem is that after wakeup the system hangs or returns lots of
errors like:

   Reserved instruction in kernel code in arch/mips/kernel/traps.c::do_ri, line 706[#169]:

Note that if I compile the driver as a module and removing it before
sleeping and reinstalling it after wake up the system (and the
ethernet) works correctly...

Suggestions? :)

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

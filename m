Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2011 15:36:07 +0100 (CET)
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:35024
        "EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903728Ab1LROgD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Dec 2011 15:36:03 +0100
Received: from omta20.westchester.pa.mail.comcast.net ([76.96.62.71])
        by qmta09.westchester.pa.mail.comcast.net with comcast
        id Adwz1i0061YDfWL59ebwDv; Sun, 18 Dec 2011 14:35:56 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta20.westchester.pa.mail.comcast.net with comcast
        id Aebu1i00t1rgsis3gebvk8; Sun, 18 Dec 2011 14:35:56 +0000
Message-ID: <4EEDFA3B.9040701@gentoo.org>
Date:   Sun, 18 Dec 2011 09:35:39 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     netdev@vger.kernel.org, Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
References: <4EED3A3D.9080503@gentoo.org> <4EEDEA17.4040006@mvista.com>
In-Reply-To: <4EEDEA17.4040006@mvista.com>
X-Enigmail-Version: 1.3.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14461

On 12/18/2011 08:26, Sergei Shtylyov wrote:

>> @@ -57,6 +58,12 @@ static const char *meth_str="SGI O2 Fast
>>   static int timeout = TX_TIMEOUT;
>>   module_param(timeout, int, 0);
>>
>> +/* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
>> + * MACE Ethernet uses a 64 element hash table based on the Ethernet CRC.
>> + */
>> +static int multicast_filter_limit = 32;
>> +
>> +
> 
>    On empty oine would be enough...
> 


Fixed, as Dave pointed out.  I converted it and the driver name to a macro
anyways.


>>   /*
>>    * This structure is private to each device. It is used to pass
>>    * packets in and out, so there is place for a packet
>> @@ -765,15 +775,51 @@ static int meth_ioctl(struct net_device
>>       }
>>   }
>>
>> +static void meth_set_rx_mode(struct net_device *dev)
>> +{
>> +    struct meth_private *priv = netdev_priv(dev);
>> +    unsigned long flags;
>> +
>> +    netif_stop_queue(dev);
>> +    spin_lock_irqsave(&priv->meth_lock, flags);
>> +    priv->mac_ctrl&= ~(METH_PROMISC);
> 
>    Parens not needed here.
> 


Yeah, I am a habitual parenthesis abuser.  You should see the RTC driver I
re-wrote :)


>> +
>> +    if (dev->flags & IFF_PROMISC) {
>> +        priv->mac_ctrl |= METH_PROMISC;
>> +        priv->mcast_filter = 0xffffffffffffffffUL;
>> +        mace->eth.mac_ctrl = priv->mac_ctrl;
>> +        mace->eth.mcast_filter = priv->mcast_filter;
>> +    } else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
>> +               (dev->flags & IFF_ALLMULTI)) {
>> +            priv->mac_ctrl |= METH_ACCEPT_AMCAST;
>> +            priv->mcast_filter = 0xffffffffffffffffUL;
>> +            mace->eth.mac_ctrl = priv->mac_ctrl;
>> +            mace->eth.mcast_filter = priv->mcast_filter;
> 
>     This block is over-indented.
> 


Weird.  The editor I was using had the tabs set to an equivalent of 4
spaces, so it lined up for me *originally*, but after the patch was applied,
it was out of alignment, too.  I think I got it fixed this time, though.
Not sure what was causing that.


>> +    } else {
>> +        struct netdev_hw_addr *ha;
>> +        priv->mac_ctrl |= METH_ACCEPT_MCAST;
>> +
>> +        netdev_for_each_mc_addr(ha, dev)
>> +            set_bit((ether_crc(ETH_ALEN, ha->addr) >> 26),
>> +                    (volatile long unsigned int *)&priv->mcast_filter);
>> +
>> +        mace->eth.mcast_filter = priv->mcast_filter;
> 
>    This last statement is common between all branches, so could be moved out
> of *if*...
> 


Done.


>> +    }
>> +
>> +    spin_unlock_irqrestore(&priv->meth_lock, flags);
>> +    netif_wake_queue(dev);
>> +}
>> +
>>   static const struct net_device_ops meth_netdev_ops = {
>> -    .ndo_open        = meth_open,
>> -    .ndo_stop        = meth_release,
>> -    .ndo_start_xmit        = meth_tx,
>> -    .ndo_do_ioctl        = meth_ioctl,
>> -    .ndo_tx_timeout        = meth_tx_timeout,
>> -    .ndo_change_mtu        = eth_change_mtu,
>> -    .ndo_validate_addr    = eth_validate_addr,
>> +    .ndo_open                = meth_open,
>> +    .ndo_stop                = meth_release,
>> +    .ndo_start_xmit            = meth_tx,
>> +    .ndo_do_ioctl            = meth_ioctl,
>> +    .ndo_tx_timeout            = meth_tx_timeout,
>> +    .ndo_change_mtu            = eth_change_mtu,
>> +    .ndo_validate_addr        = eth_validate_addr,
>>       .ndo_set_mac_address    = eth_mac_addr,
>> +    .ndo_set_rx_mode        = meth_set_rx_mode,
> 
>    The intializer values are not aligned now, and they were before the patch.


Yeah, same problem as above.  Not sure how my tabs got mangled.  Should be
fixed in the next revision once I test it.


Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

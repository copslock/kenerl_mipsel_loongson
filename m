Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 21:37:02 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41800 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993376AbcLGUgyXKO49 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Dec 2016 21:36:54 +0100
Subject: Re: [bug report] MIPS: lantiq: implement support for FALCON soc
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20161207200455.GA25376@elgon.mountain>
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
From:   John Crispin <john@phrozen.org>
Message-ID: <7aa544d1-c1f6-3f52-3d25-a2cbd4ab4635@phrozen.org>
Date:   Wed, 7 Dec 2016 21:35:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161207200455.GA25376@elgon.mountain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 07/12/2016 21:04, Dan Carpenter wrote:
> Hello John Crispin,
> 
> The patch d41ced01f21d: "MIPS: lantiq: implement support for FALCON
> soc" from Apr 19, 2012, leads to the following static checker warning:
> 
> 	arch/mips/lantiq/falcon/sysctrl.c:152 falcon_gpe_enable()
> 	warn: mask and shift to zero
> 
> arch/mips/lantiq/falcon/sysctrl.c
>    140  /* enable the ONU core */
>    141  static void falcon_gpe_enable(void)
>    142  {
>    143          unsigned int freq;
>    144          unsigned int status;
>    145  
>    146          /* if if the clock is already enabled */
>    147          status = sysctl_r32(SYSCTL_SYS1, SYS1_INFRAC);
>    148          if (status & (1 << (GPPC_OFFSET + 1)))
>    149                  return;
>    150  
>    151          freq = (status_r32(STATUS_CONFIG) &
>    152                  GPEFREQ_MASK) >>
>    153                  GPEFREQ_OFFSET;
> 
> The mask is 0xC0 and we >> 10 which means that freq is always zero.
> 
>    154          if (freq == 0)
>    155                  freq = 1; /* use 625MHz on unfused chip */
> 
> So we always use 625MHz.
> 
>    156  
>    157          /* apply new frequency */
>    158          sysctl_w32_mask(SYSCTL_SYS1, 7 << (GPPC_OFFSET + 1),
>    159                  freq << (GPPC_OFFSET + 2) , SYS1_INFRAC);
>    160          udelay(1);
>    161  
>    162          /* enable new frequency */
>    163          sysctl_w32_mask(SYSCTL_SYS1, 0, 1 << (GPPC_OFFSET + 1), SYS1_INFRAC);
>    164          udelay(1);
>    165  }
> 
> regards,
> dan carpenter
> 


Hi Dan,

thanks, I've added Hauke in CC. he works for Lantiq and has been taking
care of the code recently.

	John

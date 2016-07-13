Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2016 17:51:48 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:26339 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993243AbcGMPvl6jKoQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2016 17:51:41 +0200
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u6DFpVDs014654
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 13 Jul 2016 15:51:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u6DFpUm6020004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 13 Jul 2016 15:51:31 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id u6DFpPbX015345;
        Wed, 13 Jul 2016 15:51:28 GMT
Received: from mwanda (/154.0.139.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jul 2016 08:51:25 -0700
Date:   Wed, 13 Jul 2016 18:51:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     blogic@openwrt.org
Cc:     linux-mips@linux-mips.org
Subject: [bug report] MIPS: lantiq: implement support for FALCON soc
Message-ID: <20160713155114.GA31747@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
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

Hello John Crispin,

The patch d41ced01f21d: "MIPS: lantiq: implement support for FALCON
soc" from Apr 19, 2012, leads to the following static checker warning:

	arch/mips/lantiq/falcon/sysctrl.c:152 falcon_gpe_enable()
	warn: mask and shift to zero

arch/mips/lantiq/falcon/sysctrl.c
   140  /* enable the ONU core */
   141  static void falcon_gpe_enable(void)
   142  {
   143          unsigned int freq;
   144          unsigned int status;
   145  
   146          /* if if the clock is already enabled */
   147          status = sysctl_r32(SYSCTL_SYS1, SYS1_INFRAC);
   148          if (status & (1 << (GPPC_OFFSET + 1)))
   149                  return;
   150  
   151          freq = (status_r32(STATUS_CONFIG) &
   152                  GPEFREQ_MASK) >>
   153                  GPEFREQ_OFFSET;

This is 0xC0 >> 10 which is always zero.

   154          if (freq == 0)
   155                  freq = 1; /* use 625MHz on unfused chip */
   156  
   157          /* apply new frequency */
   158          sysctl_w32_mask(SYSCTL_SYS1, 7 << (GPPC_OFFSET + 1),
   159                  freq << (GPPC_OFFSET + 2) , SYS1_INFRAC);
   160          udelay(1);
   161  
   162          /* enable new frequency */
   163          sysctl_w32_mask(SYSCTL_SYS1, 0, 1 << (GPPC_OFFSET + 1), SYS1_INFRAC);
   164          udelay(1);
   165  }

regards,
dan carpenter

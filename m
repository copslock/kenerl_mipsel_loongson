Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Aug 2017 21:10:35 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:27936 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994745AbdHXTK2RDMU0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Aug 2017 21:10:28 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v7OJAGql004926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2017 19:10:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v7OJAFSo011390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2017 19:10:16 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v7OJAD6l031911;
        Thu, 24 Aug 2017 19:10:15 GMT
Received: from mwanda (/197.157.34.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Aug 2017 12:10:12 -0700
Date:   Thu, 24 Aug 2017 22:10:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     wuzhangjin@gmail.com
Cc:     linux-mips@linux-mips.org
Subject: [bug report] MIPS: Lemote 2F: Add basic CS5536 VSM support
Message-ID: <20170824190959.cycywo6pcmtkf45a@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59794
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

[ This code is 8 years old, so it's possible no one has this hardware
  any more.  -dan ]

Hello Wu Zhangjin,

The patch 22c21003a91b: "MIPS: Lemote 2F: Add basic CS5536 VSM
support" from Nov 10, 2009, leads to the following static checker
warning:

	./arch/mips/loongson64/common/cs5536/cs5536_ohci.c:141 (null)()
	warn: masked condition '(lo & 3840) == 11' is always false.

arch/mips/loongson64/common/cs5536/cs5536_ohci.c
   135          case PCI_INTERRUPT_LINE:
   136                  conf_data =
   137                      CFG_PCI_INTERRUPT_LINE(PCI_DEFAULT_PIN, CS5536_USB_INTR);
   138                  break;
   139          case PCI_OHCI_INT_REG:
   140                  _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
   141                  if ((lo & 0x00000f00) == CS5536_USB_INTR)

CS5536_USB_INTR is 11 so this condition can't possibly be true.  I'm not
sure what was intended.

   142                          conf_data = 1;
   143                  break;
   144          default:
   145                  break;
   146          }
   147  
   148          return conf_data;

regards,
dan carpenter

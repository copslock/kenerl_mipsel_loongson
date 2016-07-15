Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2016 22:04:29 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:29198 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992722AbcGOUEXELLcU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jul 2016 22:04:23 +0200
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u6FK4Bl2029420
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 15 Jul 2016 20:04:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id u6FK4AKR004380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 15 Jul 2016 20:04:10 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id u6FK459f021821;
        Fri, 15 Jul 2016 20:04:08 GMT
Received: from mwanda (/154.0.139.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jul 2016 13:04:05 -0700
Date:   Fri, 15 Jul 2016 23:03:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     wuzhangjin@gmail.com
Cc:     linux-mips@linux-mips.org
Subject: [bug report] MIPS: Lemote 2F: Add basic CS5536 VSM support
Message-ID: <20160715200359.GA31809@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54339
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

Hello Wu Zhangjin,

The patch 22c21003a91b: "MIPS: Lemote 2F: Add basic CS5536 VSM
support" from Nov 10, 2009, leads to the following static checker
warning:

	arch/mips/loongson64/common/cs5536/cs5536_ohci.c:141 pci_ohci_read_reg()
	warn: masked condition '(lo & 3840) == 11' is always false.

arch/mips/loongson64/common/cs5536/cs5536_ohci.c
   135          case PCI_INTERRUPT_LINE:
   136                  conf_data =
   137                      CFG_PCI_INTERRUPT_LINE(PCI_DEFAULT_PIN, CS5536_USB_INTR);
   138                  break;
   139          case PCI_OHCI_INT_REG:
   140                  _rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
   141                  if ((lo & 0x00000f00) == CS5536_USB_INTR)
                                                 ^^^^^^^^^^^^^^^
This is 11 so the condition can't be true.  I don't know what was
intended.

   142                          conf_data = 1;
   143                  break;
   144          default:
   145                  break;
   146          }

regards,
dan carpenter

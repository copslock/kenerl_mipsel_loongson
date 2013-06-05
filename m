Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 10:37:25 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:37457 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822997Ab3FEIhUTaLig (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 10:37:20 +0200
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
        by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with ESMTP id r558asPQ010710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 5 Jun 2013 08:36:55 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
        by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id r558asQe017558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 5 Jun 2013 08:36:55 GMT
Received: from abhmt105.oracle.com (abhmt105.oracle.com [141.146.116.57])
        by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id r558as2Q025428;
        Wed, 5 Jun 2013 08:36:54 GMT
Received: from mwanda (/41.202.233.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Jun 2013 01:36:52 -0700
Date:   Wed, 5 Jun 2013 11:36:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/6] staging: octeon-usb: cvmx-usbcx-defs.h: avoid long
 lines in CVMX_USBCX macros
Message-ID: <20130605083646.GN28112@mwanda>
References: <1370381495-3358-1-git-send-email-aaro.koskinen@iki.fi>
 <1370381495-3358-4-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370381495-3358-4-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet21.oracle.com [141.146.126.237]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36692
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

On Wed, Jun 05, 2013 at 12:31:32AM +0300, Aaro Koskinen wrote:
> -#define CVMX_USBCX_DAINT(block_id) (CVMX_ADD_IO_SEG(0x00016F0010000818ull) + ((block_id) & 1) * 0x100000000000ull)

There should be a few helper macros.  I don't know the names for
these:
#define bid_to_xxx1(block_id) ((block_id) & 1) ? 0x100000000000ull : 0)
#define bid_to_xxx4(block_id) ((block_id) & 1) ? 0x40000000000ull : 0)
#define bid_to_xxx8(block_id) ((block_id) & 1) ? 0x8000000000ull : 0)

#define SEG_PREFIX 0x00016F001000ull << 15
#define CVMX_ADD(addr) CVMX_ADD_IO_SEG(SEG_PREFIX | (addr))

Then CVMX_USBCX_DAINTMSK() becomes:

#define CVMX_USBCX_DAINT(block_id) (CVMX_ADD(0x0818) + bid_to_xxx1(block_id))

It fits on one line and it uses words instead of magic numbers.

regards,
dan carpenter

Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 19:55:22 +0100 (CET)
Received: from mail-by2on0096.outbound.protection.outlook.com ([207.46.100.96]:39520
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006899AbaKXSzUHVsQi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Nov 2014 19:55:20 +0100
Received: from alberich (2.164.211.155) by
 CO1PR07MB395.namprd07.prod.outlook.com (10.141.74.22) with Microsoft SMTP
 Server (TLS) id 15.1.26.15; Mon, 24 Nov 2014 18:55:09 +0000
Date:   Mon, 24 Nov 2014 19:54:54 +0100
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     James Cowgill <James.Cowgill@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <david.daney@cavium.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
Message-ID: <20141124185454.GA12164@alberich>
References: <1416837096-52243-1-git-send-email-James.Cowgill@imgtec.com>
 <54736A06.9070206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <54736A06.9070206@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.164.211.155]
X-ClientProxiedBy: AM2PR03CA0011.eurprd03.prod.outlook.com (25.160.207.21) To
 CO1PR07MB395.namprd07.prod.outlook.com (10.141.74.22)
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:CO1PR07MB395;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:CO1PR07MB395;
X-Forefront-PRVS: 040513D301
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(51704005)(24454002)(164054003)(199003)(377454003)(479174003)(189002)(19580405001)(19580395003)(4396001)(33716001)(54356999)(62966003)(50986999)(21056001)(77096003)(77156002)(31966008)(92566001)(86362001)(107046002)(42186005)(92726001)(76176999)(33656002)(97736003)(102836001)(101416001)(23676002)(83506001)(46102003)(105586002)(106356001)(87976001)(20776003)(122386002)(95666004)(66066001)(47776003)(120916001)(99396003)(50466002)(64706001)(40100003)(110136001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR07MB395;H:alberich;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:CO1PR07MB395;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

On Mon, Nov 24, 2014 at 09:25:26AM -0800, David Daney wrote:
> On 11/24/2014 05:51 AM, James Cowgill wrote:
> >From: Markos Chandras <markos.chandras@imgtec.com>
> >
> >Add support for the UBNT E200 board (EdgeRouter/EdgeRouter Pro 8 port).
> >
> >Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> >Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
> 
> NACK.
> 
> As far as I know, these boards have a boot loader that supplies a
> correct device tree, there should be no need to hack up the kernel
> like this.
> 
> As far as I know, Andreas is running a kernel.org kernel on these
> boards without anything like this.
> 
> Andreas, can you confirm this?

Yes, a device tree is supported and most stuff works with mainline and
the USB patches posted recently.


Andreas


> Thanks,
> David Daney
> 
> >---
> >  arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 3 +++
> >  arch/mips/include/asm/octeon/cvmx-bootinfo.h          | 2 ++
> >  2 files changed, 5 insertions(+)
> >
> >diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> >index 5dfef84..69ba6fb 100644
> >--- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> >+++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> >@@ -186,6 +186,8 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
> >  			return 7 - ipd_port;
> >  		else
> >  			return -1;
> >+	case CVMX_BOARD_TYPE_UBNT_E200:
> >+		return -1;
> >  	case CVMX_BOARD_TYPE_CUST_DSR1000N:
> >  		/*
> >  		 * Port 2 connects to Broadcom PHY (B5081). Other ports (0-1)
> >@@ -759,6 +761,7 @@ enum cvmx_helper_board_usb_clock_types __cvmx_helper_board_usb_get_clock_type(vo
> >  	case CVMX_BOARD_TYPE_LANAI2_G:
> >  	case CVMX_BOARD_TYPE_NIC10E_66:
> >  	case CVMX_BOARD_TYPE_UBNT_E100:
> >+	case CVMX_BOARD_TYPE_UBNT_E200:
> >  	case CVMX_BOARD_TYPE_CUST_DSR1000N:
> >  		return USB_CLOCK_TYPE_CRYSTAL_12;
> >  	case CVMX_BOARD_TYPE_NIC10E:
> >diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> >index 2298199..0567847 100644
> >--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> >+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> >@@ -228,6 +228,7 @@ enum cvmx_board_types_enum {
> >  	 */
> >  	CVMX_BOARD_TYPE_CUST_PRIVATE_MIN = 20001,
> >  	CVMX_BOARD_TYPE_UBNT_E100 = 20002,
> >+	CVMX_BOARD_TYPE_UBNT_E200 = 20003,
> >  	CVMX_BOARD_TYPE_CUST_DSR1000N = 20006,
> >  	CVMX_BOARD_TYPE_CUST_PRIVATE_MAX = 30000,
> >
> >@@ -328,6 +329,7 @@ static inline const char *cvmx_board_type_to_string(enum
> >  		    /* Customer private range */
> >  		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
> >  		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
> >+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E200)
> >  		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DSR1000N)
> >  		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
> >  	}
> >
> 

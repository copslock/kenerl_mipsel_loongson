Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 21:17:20 +0200 (CEST)
Received: from mail-bl2on0062.outbound.protection.outlook.com ([65.55.169.62]:48969
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012480AbbHMTRSw6ckD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 21:17:18 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BLUPR0701MB1713.namprd07.prod.outlook.com (10.163.85.14) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Thu, 13 Aug 2015 19:16:46 +0000
Message-ID: <55CCED1B.6030701@caviumnetworks.com>
Date:   Thu, 13 Aug 2015 12:16:43 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Janne Huttunen <janne.huttunen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
Subject: Re: [PATCH 00/14] MIPS/staging: OCTEON: enable ethernet/xaui on CN68XX
References: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
In-Reply-To: <1439472106-7750-1-git-send-email-aaro.koskinen@nokia.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: DM2PR07CA0019.namprd07.prod.outlook.com (10.141.52.147) To
 BLUPR0701MB1713.namprd07.prod.outlook.com (25.163.85.14)
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1713;2:3bIAKgP4NqWSj9jnsLYjM5ZZKilh7Eu5vaHZBBqtvAo501btBV03HwNjBPtQgVm9WNnfVFCBZUB3sX5kxng3AEtU7PIiZIdM9VwpIAFIks4oTfXcNfWISU2IofJz8Tcr/dJ+1gS804qNeJRtW6cX+oO3Mdx1NPxtiU301sHE3+E=;3:K8J2rF8b/J+cTnJWWFKO8PF+d05dJ30fsodR77dXZ0xiwkwk+gP7oVTa2nikRCXT3qmg7WpHftHCVg9JeGNEXtX+is0FWWjOzmagqZ1AKaAWThZ0BtM8/pFLbjdVyQirh9ng9nGD6zuOAyz5QN4pTg==;25:nj7prdzG5eZVqqxFs+7t4JLyOkPjeRd7XywivOFW798CsWZEBMEOl9za50MoUw1H4h4I8LUHytzgR3aYtjkGmxRHlG4bEwgRHhzLN1JVExhg4eEEoZIxNF4ZKCpOKlBa4ks0iyrk4DBfSZ0DNZojQKNfWJHzR4PXue3XH9YD95TIHqQ2LQtxNiPhMEjkSq2hb908DjWa7mKjVZQg4lfylpfWNBZ+7cd3D9ODNlBCAj0nvj6/SvN5aN3Oganp5B+Trt2weWju73amR96Jhq/O6w==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1713;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1713;20:FowtNM7OLE2WmTrMeUJA+NTPjSDKFqIBVRvDV3SZql5+V9tCrFGf2yvk2NqXYgKPpsQOC2kY3xj8ii7Hz36FsJXzMvmkhrZMl0CMnoV4e45yo7vCcuIYnFFDFWDP8KJ116ehagmSyD0Is3WgwV3CeHHqq5SaScNWUsxmi6zbt4II/ZJb3hj+MLl3LCIuQElN7mzkwcidlnLQ4uxOCzo/CRw/2K8iGiyKE31bqxSTZKM2DYHSwA0GFxb5oemFEUtu8S0qkXSIdxRkP65qUOekSDebj56B6ldD/5aJgeVbxmmg+FouHoDCZuDCsrRYPps+J35KbRVDwDMiIWYgEQb99sAXGdsZepSfdVQpc9s+lJeNFKjNDBC9fpJMvfMbmuXQv5t+5aARXav9Y+GbbyMN9t8FRqf6mg5C2JGqkuSmNRavM71sXk9mCth04xIdgaAvn0j5I+W6Kk718pM3o+ehOKhcRky6jIaiSvTEgCjQAv+nSy2dCUFHiUaiK9140bY0Uer/iNMYijdgFxByECPN9X3UQOec8uB+/qU6SAi6cOdFM8FIlJ6v9sXyzj8pW5zGM04PKvXWQgCCUroKaD1JHzbwAzRp5koYj/HnNEBDKDY=;4:9EehOFekBh+WbL885I8eWiGBA26lWy3C9AqAaZqd9+aWsP6t3SGpIzWMjm/og343L0Tjs2SggWlfxUBkfTZihn9AQJqoSPgFZUpv81FgoZLGA8OBwCgshtQT1nMtPFBGwZpTkF04eu8YWe2Cqwj/m5qKaCNraJCabWdNCi3tDmdapzPal2q9o1lMGQObacowv/JEmGLa5r5t5wR8l0WWE3yuz2PFBwsWNRasjDjFI8bUmTLrsWn6/WuAYrL17YA3Ae8RO08I+xvmdJoVyVn7BbVG8S7bxnsAo04nqA+d2aU=
X-Microsoft-Antispam-PRVS: <BLUPR0701MB17134C103345FFBAB7FDE1E89A7D0@BLUPR0701MB1713.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BLUPR0701MB1713;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1713;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(189002)(377454003)(479174004)(199003)(24454002)(50986999)(42186005)(106356001)(101416001)(50466002)(23756003)(2950100001)(77096005)(36756003)(87266999)(76176999)(66066001)(65956001)(64126003)(65816999)(64706001)(65806001)(68736005)(47776003)(92566002)(69596002)(59896002)(5001830100001)(87976001)(105586002)(110136002)(5001920100001)(81156007)(33656002)(46102003)(53416004)(189998001)(4001540100001)(40100003)(5001860100001)(4001350100001)(80316001)(77156002)(122386002)(62966003)(97736004)(83506001)(5001960100002)(54356999);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1713;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:3;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BLUPR0701MB1713;23:D5aI7gNG1r0BAlrJDY4CJ3P32t4bgc8csJ4Oi?=
 =?iso-8859-1?Q?vAIc7xU1PbiMs36UMkxJBn0BLcqV10Usyh96h5tHjCcHadCyiKBc8Uyk1e?=
 =?iso-8859-1?Q?8RPfD+q9zwPWK4aXYXNpV1WPJoWmgtX8ieNsILK+2o6UT8+iXv+9CYjbdG?=
 =?iso-8859-1?Q?4jsaMpKVSYlonauPcXwXcy1ImhVDH0A9U5Bzu2+9ujMq6TclKHekZNqe3d?=
 =?iso-8859-1?Q?kAtqcooq9mczySoe1EkBYKLP8T2tuCdxhL/JBoPNlMbA7U6b7KrRJSVUgW?=
 =?iso-8859-1?Q?V1HRnEXexghV+EVUfYSWn6j7hKFxNj7Z4EM4x9ch4kopNtyQ95Clgmt0O5?=
 =?iso-8859-1?Q?cn32OTXRqGKD8isKk50S6SQ2VKY3uH/paqD+UVLXrdblWDEDgsmvMi5/LG?=
 =?iso-8859-1?Q?RGzk832F2e/Ke/mM3/o2i63XdMv3j/vk5nRzaU4JGPax5IQQl4UeKjb0We?=
 =?iso-8859-1?Q?eKm2PNZyAzxj6ut3Yh2vSMso704RFCEvVOZfzCTgUKC3cr+QCz0hHHwFK+?=
 =?iso-8859-1?Q?FcT1ZmyvxU7+nocddc8cpNJbGSeT9FFYeh5vj99atkEP33cA8pOofUkQsO?=
 =?iso-8859-1?Q?/SFY4SOrsXUhZdkMGuDhuPa3F5IMXB2xOcoQGSJvmHK/QbjsibmpFjdBzr?=
 =?iso-8859-1?Q?GRqQ0UoPTeXTBEOfcnULjACKBWYmUkoJO2i6z0mHkEPy7fSnLC+b+GjmwW?=
 =?iso-8859-1?Q?80vWETVm/cqOWu12xYK3MErdlAYa/sl4TfVd6Rf94uqAjinq5y7C1eu3m3?=
 =?iso-8859-1?Q?muKoujClLg8cqXc0VJeJbHHSynr3Lxzyh5p10n5U6Zbz4kV631TVZGUqfI?=
 =?iso-8859-1?Q?UHiuKWPlIhlARBMiAtM0r2ySzsJHxyT+iDhdef04OPdK5FFmNGCvBwuEom?=
 =?iso-8859-1?Q?llRYzwksEB5pIvpH4nc1q0AfzlLqN3vHVL1pMG6Iu74mXHr0LANN3yiCg8?=
 =?iso-8859-1?Q?NONcaS6Ta3NvuwYUpVCoD4p6px7uLmNLCBg/S4Ya0KNItn+fqTZe2HMjA0?=
 =?iso-8859-1?Q?5LFDzQ1e1yE+HnVogPMO74Auz2Uy6oWHe/oujW5mmQ1dd8hQDaD6pgV5zX?=
 =?iso-8859-1?Q?FEW3teSPAd7EnshbjeM70ffgrBP+6humWhAb77/WUZoj8TO72xfQUgRRPx?=
 =?iso-8859-1?Q?k4bXqZ5EcT2mSuo0k0OjtYGbjTKqVbKKMcuRtvnTUvqwscdwQ2zD04AKuU?=
 =?iso-8859-1?Q?YPF55y89aOTAy8nkZKTc1KY8tIlqfY10jkZwHxzXTQ2a23FwrCizMdL404?=
 =?iso-8859-1?Q?5iZKRIdF4R/PWAY4tpxJdsO8yjGQJGt3Ej5LOAW29uClFguVuCwZZLMJWE?=
 =?iso-8859-1?Q?Ue2zmAwtoUrj3j0zLOGNgnGkBqP39WCrCgYHpzcuAybAdCg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1713;5:86jnrPFAyD8EUDVguNJqw+HvXakPp6mVFoilifbDb2Z3Z2jifOg6HsX6Ck3gYOljyM5dGb/owcdpUZhNOrsjYyAYXITUpkzAoyRD4Q4GAQAQ95XaOS4BihMVYyuAFXfHf2aurN0Ld1fxjgsWB0GVhg==;24:9lq8yb549cxIVO5+/tIcUhfG60ctcen0R1tFt7YsG5HUZCTYcd5uI/nLpwTk8/V3I6NxlosaWFTl/HVte6mcFsjfsKpzHOYlyrUeVbVv3Ew=;20:b1CzgkzPA6d8EZOu7sfafm6PCTSb19MDE4ksznsr4YqmDqKW3M/hqBGRoG1EMEhG/ese6mLRMx/7/NHEj4i4AA==
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2015 19:16:46.6830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1713
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 08/13/2015 06:21 AM, Aaro Koskinen wrote:
> Hi,
>
> Currently mainline Linux is unusable on OCTEON II CN68XX SOCs due to
> issues in Ethernet driver initialization. Some boards are hanging during
> init, and all the needed register differences compared to the older SOCs
> are not taken into account to make interrupts and packet delivery to work.
>
> This patch set provides a minimal support to get octeon-ethernet going
> on CN68XX. Tested on top of 4.2-rc6 with Cavium EBB6800 and Kontron
> S1901 boards by sending traffic over XAUI interface with busybox.

You don't say how it was tested.

Does OCTEON and OCTEON II networking continue to function?

There is no SSO provisioning, so there will be limited buffering on 
packet ingress.  For low packet rates, it should be fine though.

David Daney


>
> A.
>
> Aaro Koskinen (2):
>    MIPS/staging: OCTEON: properly enable/disable SSO WQE interrupts
>    MIPS/staging: OCTEON: set SSO group mask properly on CN68XX
>
> Janne Huttunen (12):
>    MIPS: OCTEON: fix CN6880 hang on XAUI init
>    MIPS: OCTEON: support additional interfaces on CN68XX
>    MIPS: OCTEON: support all PIP input ports on CN68XX
>    MIPS: OCTEON: configure XAUI pkinds
>    MIPS: OCTEON: configure minimum PKO packet sizes on CN68XX
>    MIPS: OCTEON: add definitions for setting up SSO
>    MIPS/staging: OCTEON: increase output command buffers
>    MIPS/staging: OCTEON: support CN68XX style WQE
>    MIPS: OCTEON: initialize CN68XX PKO
>    MIPS: OCTEON: set up 1:1 mapping between CN68XX PKO queues and ports
>    MIPS: OCTEON: support interfaces 4 and 5
>    MIPS/staging: OCTEON: use common helpers for determining interface and
>      port
>
>   .../cavium-octeon/executive/cvmx-helper-util.c     |  20 +-
>   .../cavium-octeon/executive/cvmx-helper-xaui.c     |  14 +-
>   arch/mips/cavium-octeon/executive/cvmx-helper.c    |  17 ++
>   arch/mips/cavium-octeon/executive/cvmx-pko.c       | 149 +++++++++-
>   arch/mips/include/asm/octeon/cvmx-pip.h            |   2 +-
>   arch/mips/include/asm/octeon/cvmx-pko.h            |   3 +
>   arch/mips/include/asm/octeon/cvmx-pow-defs.h       |  29 ++
>   arch/mips/include/asm/octeon/cvmx-pow.h            |   9 +-
>   arch/mips/include/asm/octeon/cvmx-wqe.h            | 308 +++++++++++++++++----
>   drivers/staging/octeon/ethernet-rx.c               | 133 ++++++---
>   drivers/staging/octeon/ethernet-tx.c               |  19 +-
>   drivers/staging/octeon/ethernet-util.h             |  22 +-
>   drivers/staging/octeon/ethernet.c                  |   7 +-
>   13 files changed, 595 insertions(+), 137 deletions(-)
>

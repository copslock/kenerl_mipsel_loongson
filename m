Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 22:12:04 +0200 (CEST)
Received: from mail-sn1nam01on0077.outbound.protection.outlook.com ([104.47.32.77]:6683
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992196AbcHYUL5mTPDF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Aug 2016 22:11:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=268bVWFyo0YkpZ5mhYm8K76faTy83fC6ROCtg7aH9x0=;
 b=jv3FS9XhMvzMY2A3+lO+nFxBH2hbkOejnJGcQ1l8TQvaKeVslVhXcJ/79AffHFa1qj09fZRPpdRmMtb0Q0sSsofNn1A53NH8qPBYYq62MVyfDDDnvnHtoLZHStDkCOYKDQ59D8cYeX2dEZLlDZCmHwNwDuY0hEIGGqrK92AlK1M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.156) by
 CY1PR07MB2136.namprd07.prod.outlook.com (10.164.112.14) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.587.13; Thu, 25 Aug 2016 20:11:47 +0000
Message-ID: <57BF5101.6080909@caviumnetworks.com>
Date:   Thu, 25 Aug 2016 13:11:45 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     David Daney <ddaney@caviumnetworks.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        linux-mips <linux-mips@linux-mips.org>,
        driverdev-devel <devel@driverdev.osuosl.org>,
        netdev <netdev@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Improving OCTEON II 10G Ethernet performance
References: <CAO_EM_nrb0M49YwU+gjL+bqT4V1rFj4z7DQ8juTYXgaoKet0mg@mail.gmail.com> <57BF21C7.5070709@caviumnetworks.com> <20160825182210.GE12169@raspberrypi.musicnaut.iki.fi>
In-Reply-To: <20160825182210.GE12169@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR07CA0035.namprd07.prod.outlook.com (10.162.170.173) To
 CY1PR07MB2136.namprd07.prod.outlook.com (10.164.112.14)
X-MS-Office365-Filtering-Correlation-Id: fe527a22-bd68-49cc-f366-08d3cd240b82
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;2:iTBR30nCBH41VNcPHMdxs7/TMThwEWFDweVlziyd1MkeFhQgsPa/LYc7YCzAvpsFmv4J+FxoKK4+Gp2SEurityGF3Fhudtm3P/qMwCffbMHqraxwoiu0F2EGDXvmSOSwTPnenkztZMpmwnzgiw4vTrBuHJU3VbOxqHIVfhl9Hsd8LRnZF2HKBmY0JysyAskx;3:Prf8LdIG0CezqKUBbPj8V+SVUR6SEyTQcGoDqBRzXq9R2oBf5OaMn0U9DRSUCDwscFcHdkedcZWEi5JSgMB+Jum9i2roW8ngRQ5DVzwf8NbuiV8LZXidowRVqTDVhCr2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2136;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;25:/jFtZsIiH9bbm0yeiwkwRVShcUqrPFOZBPhCRwsInGLEEgQePCFm7ghMJ+xpAOleRPZdD07T8abK2doiSv51f+Ow/vfNxTErmLG/mG52JDmO6NcP125Vh7kZQKswtpiYgpmx2vGcKbslz+r0D8+dbj9xqqPWSG+tEftdvMuWH8NZ5Vcr1M/lvber4rdzAmTEyID+kPlJXhORe4ndw4fseitkJsOKPqvzU2cIAYqaplN9XPe+fGJIIezxII10Wa+fqBVhHE5X+0HF94cAplv8nhHp+alPliHVQoWheomMEAJlsRSXX3OodeQ4afAHLXpQCcPweAfXgHcXziIavAmAByr2+kAXUj3OLgLk7geSMWeYwEX6+B1rtjBVUCtT1U4P0B9FwrGWEfFab6d5kY7H3aFhBNFvFyv27YqQ9Kn61Hft9GXEoaJqLbFqnjjB3Wh6+mi78X549kT7iMOE+L3XDrzMAK1AmWPW1ITvNsDMKz2TjdfoSui7Y6GffbFVoqcjJYfG1dfXxm4pqZVnH2I93Y2QD2R7Opu32WeXMMuOg9Munrs9Uwn9W4JjdfZo9Q/Z+CQabc9mVqQn2jEnfNmiwIlVgpXH61UZ947PkUQiRoQgAkMW/ewtisp+zSO+Y9Eco89bmpIgfCII1hN2vam7e9CQPfWID4YNLrCxL4zNtJ6kyVDALinG4UMsfYcQJhfq72bCLdfWGosBQtdnLUPACnrGdI99Evw3qcrSYVLH64HVTH1lI8vSFMh7h98mYycidyhHuhR4ckPuqKAdnhMeqfOS3GO4iSg0+6yubRu10O0tBU0RiGXd0/AQP5kvr1+538rr8oIcfx1LZy+qaLQ+wg==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;31:blkf7OVaJ4hW8xupGSZ+CPkYFjfCY0dDVeBk2cDyQQGQJfVFVZf3PTrq466k3Zfe9LTkW0SfpN23EZ61XNFq2HIqYlEX2oWAWps4M0JeITvHeruwpi9zL+o8jjYQFBg2ePqsGmgjflWQWixptMu2QH0Y9kfZCbmBsYr56JekA1iF8j/0e+udaWiJownH/Qo5CMgk9OPXMZ6kZergb3y/0aYso5X5MH90ZWJgVjuX6fY=;20:4nzLHFuZPdTMVmq5kdi6m+aBKtKjkLkK53Ai8riC0YDBwTH9URZrTb4CiIBO+b23gBzLgtk2RcBEMIDhU7ghHHbP+71GI4tE4/XDd1Z7YhaqpRLTGpl93FX9OeXz8JSNkIqBBavqlYUPj1dFapTZpbe6A+xNdVChI/rOzxQocz56N9tkIxqiTikLbbFxSPekm6xqU053rG8EWPhwRdpZTV2N+TSgn6sUfJh2p6ny2CZUYfcVZ2w9y/242E+aBdPAFZcs8woHbpN1ffWFgI8TloOzqwHvzw+IjZ9OXVfYaZuRQ4FEd0ZK6EvHdb6C5SpPM2ejp4PZV2qa3ZpWH8ra3ywVo8jd0o6ggaao1XCkXXsVf4NPf823H9mLcRNg7A1yDzOKx2eYbQusyw47xvIDdoYYLw1ZIeu/3VMylXbS5iNlQDvcJq6F5bU285KhZ0oWYNwUGyzo/sNFEzhWzgnXOvEpVEnn91NkQPbG46Zy0QQxLuoZCI9SKXvmXNLGD4i1JurXCoaqDXUROXduyAQvkRx5hk9Ov9KhQu9MkgoLsit/gyviCLgMrleAOdojOe2ZlcJl7OOFxPdVx6QNIOE7+Jr4BXUwM6MYJUPsFA+PFYU=
X-Microsoft-Antispam-PRVS: <CY1PR07MB2136D2F9F3B0FD945B447E7697ED0@CY1PR07MB2136.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CY1PR07MB2136;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2136;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;4:NZC2Hi+Jkr47jS/UdlNRBF63IgOcb6wFmdn9nBhO3MihoqmbSveKkricth8MyYNJDjk17l17/TM/AvrwWnAFiJM9Z6RCe8e/FwZLKQG1PjEbDO0VVe4XHlMeaB6n33xPSDXM7zIG0TDpOWqw5EcMtuJaRrUg5E1x1Un4Awnokan8F/Q+QNYp7Kj7pdukOQvcgIskV3oWeHOkdmMEsKSO3ZVhodxTa+zOfJbCa3j/gaizZKJHX/Tay7AMYmS1jTyfx+LVMzEXAoivXirrBcUYqZ9te1Z7R5w44B6XfVcI8esNYB8csJTKsb+YSiq+//Nu/Li4QVraJk6uJItg3Ulupe9UowvFmMtuxVvEN1mS/NOffd3027673O2d4x8Gnr9hgdRblR/ny6s5dZY4ImtcuA==
X-Forefront-PRVS: 0045236D47
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(377454003)(24454002)(199003)(189002)(8676002)(83506001)(81166006)(33656002)(59896002)(23756003)(19580395003)(15975445007)(106356001)(230700001)(42186005)(65806001)(66066001)(305945005)(53416004)(81156014)(7846002)(3846002)(64126003)(7736002)(6116002)(80316001)(87266999)(92566002)(76176999)(50986999)(4326007)(586003)(50466002)(77096005)(65956001)(54356999)(110136002)(47776003)(4001350100001)(101416001)(105586002)(189998001)(2950100001)(97736004)(36756003)(68736007)(2906002)(5660300001)(69596002)(65816999);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2136;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;CY1PR07MB2136;23:q1D4z9yE/XdVkaR0PqOqykKWSGgKrz793E5lCLh?=
 =?iso-8859-1?Q?yGbrTAMGzL7lfwpvA/WGY/4BM/wpdDuI7z/qVPBuav2AQyvzR5wKHUrqZd?=
 =?iso-8859-1?Q?TndCjLksJBBuVveOQbkkv1MlZjPKoTyIO5lPGMu/zqNAQ8sjVUaQKCYHj1?=
 =?iso-8859-1?Q?NJyj30PWQOKqTyLH/wZVvGjZrEcwTKvD+/vhmOi3fSXSP37tnas1tQNtjb?=
 =?iso-8859-1?Q?JiFJfJ0Zu6Na1KbVkk+NRzlZ+h4/K6nfM1lGObIDbJ6u1K7URz7znUjbZH?=
 =?iso-8859-1?Q?uWlr2xLHpT2hpLIBXJugJz+FExPY0a4HKBBx4gtdeTkUsXaLtiSp7vf/i/?=
 =?iso-8859-1?Q?SXhptfPBSFGvcWva/C+dL1DPNP04e1vTMIHZMP8b7hVZeNaJAyp6g78PNk?=
 =?iso-8859-1?Q?ieKPTgojErBAGefzgOb/oqsal1H5X17EIPjRdBam3Zr1ajwqMEyEEkezSD?=
 =?iso-8859-1?Q?u9yX7+GkGKFKcZFCFxKbCB2U2BDyevv3+syGMTzciznvepOEPouVH5o6Ln?=
 =?iso-8859-1?Q?fRdxGy8fuyvxAnXeiqkmL1KFbOk7RKW+AE2NHlD6QLX4BQsbEAAN+ksn6H?=
 =?iso-8859-1?Q?5qKWHTG8RPMdN+WZhUiGXuF7OCYme2z/0GtJWLjh24YCbocA6156SIPQRG?=
 =?iso-8859-1?Q?9dl5jv5VwD5LEpSk2zlduTUKooOAau+ism1IuJXbCcii9Jwc6zUXYn328D?=
 =?iso-8859-1?Q?wu7coduOiM6b7YG/0Flx5OD1Qcf0zWPdf4x3UYTjsgW3U0K5dJy5SJNZCP?=
 =?iso-8859-1?Q?eTsjwJadnR8pXbXzboQDPH/TyMrwXn63zNGqU1TCHlCC0RINB8wEv2SUXz?=
 =?iso-8859-1?Q?DjNT7H/Z/EjoyQp+/4aaElUZ4+H1VPteVQ9deyCeQRMv6dRZQfUlqjs2Ct?=
 =?iso-8859-1?Q?0ItZ20Wv9RWBdqDoQ2wk2w5DW/ExFw6XvBbHxlunng2bMMCvcO8QaoLhfp?=
 =?iso-8859-1?Q?NGjYGxQ2UzrA9VuN4TeyPZaIEEvybuiE/Vx6WZ7yQY15c+35Pk13EqW4ms?=
 =?iso-8859-1?Q?EHMR37JtOCayU6ychXzb7KjOxGvVN13m3+sKX3vekEVzTl8UYxHz1G7Dgz?=
 =?iso-8859-1?Q?HxHQpr4fhJZKopDfl/vDeoPtRDpPmdZLyYz6uTaYfFu4K/ABlKlKiUQ96y?=
 =?iso-8859-1?Q?HS8xTjSvRT9hu8Osj63/TznJywQ/+pTSGEKLTNbwqCPgffs85tDFRlfLSR?=
 =?iso-8859-1?Q?aK/Ps/atlFE7QXbvuGmef193gV0o7r5xt+c3a1tUzDPwIIGPkzhcMnlV7C?=
 =?iso-8859-1?Q?LkCiF7At+mNMLqKvRJmSRQhQwXJNnHxPJwFYrigTXHrJVfMaNDFTCnxXQJ?=
 =?iso-8859-1?Q?itMGR6lseyBJDklCafosTUoiDxSB2AsCsQM4jngUU6SkQVsIS14ejVTTm7?=
 =?iso-8859-1?Q?xuFlfEJc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2136;6:ryT9f2LgEMzSx9VVs5sREml4NS+0hTAhQB1+qSnhsBhirojiaWxZCqYIDeyzVoIxFiWQN4bnrCUy+tg2dBOyVu86GrqCAUHUk0eBzOCxTKnBaCWhrd3uP2HQCZ+2uccxRYX4g5jLiAVZBlE3yTZhidcBK1TNDEudlQjPp1cAGTee3ljInzpUjuAZlySzH5MH8CURBCXQkTHebDHadC2nnPsZbaMwWz9RXMNu32qN36wM7gCrUJUpNNDjv17hnP2Ea26YCYRIjFCMo3FK3l2V32u2hKkHuRGnLbqqVldcs00=;5:v9/J7ilfEPzKjhpotk8JSWI51Sl7FumoVW2CBwers9EdvstGt7JgeFzITkSRmmLKEoGq3ZYNhv4ALjz/T/FQ7CmPyHyzsTFEXXf+lDJ43Mpn9GfPZ5LhGB16OZXla3f+9HOXt7gVB4ElU4dMR9v2xg==;24:2I2NZigcZGJvwEiUsotRS+41Yc+sVWub0Fgjwj4qe+s/TddclZGeDNBK5KGS+1EkNQtZCEYTWVYoY8pVEJF3any1GorSIo21pIROkJusQqQ=;7:S+BjTF9RIh906qgfbd1/54iTk7zMlITL3K9WHQrqsb6arx+D/xsG4zJVTUINMSimOPnB9hfBA4U0YTVcqVGstCS7yaSfNyXDJoTiUkeXn7xLRA0ICWU3upURjfYd/WIrmV9ZrzrVWpN0eyiJKZTOehvLodkPWGml/SAuY1PoBBREHWC0Bwjs3MtlIi6hGxW/6aJPSwdTkfGCitIl/4N5GhQT1FyoHAhTLV/5KRjSTkt80kXxrFRjKmcY52a4jjfT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2016 20:11:47.7513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2136
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54755
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

On 08/25/2016 11:22 AM, Aaro Koskinen wrote:
> Hi,
>
> On Thu, Aug 25, 2016 at 09:50:15AM -0700, David Daney wrote:
>> Ideally we would configure the packet classifiers on the RX side to create
>> multiple RX queues based on a hash of the TCP 5-tuple, and handle each queue
>> with a single NAPI instance.  That should result in better performance while
>> maintaining packet ordering.
>
> Would this need anything else than reprogramming CVMX_PIP_PRT_TAGX, and
> eliminating the global pow_receive_group and creating multiple NAPI instances
> and registering IRQ handlers?
>

That is essentially how it works.  Set the tag generation parameters, 
and use the low order bits of the tag to select which POW/SSO group is 
assigned.  The SSO group corresponds to an "rx queue"


> In the Yocto tree, the CVMX_PIP_PRT_TAGX register values are actually
> documented:
>
> http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-contrib/tree/arch/mips/include/asm/octeon/cvmx-pip-defs.h?h=apaliwal/octeon#n3737

Wow, I didn't realize that documentation was made public.


>
> A.
>

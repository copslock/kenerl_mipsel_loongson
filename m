Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 22:31:44 +0100 (CET)
Received: from mail-bl2on0091.outbound.protection.outlook.com ([65.55.169.91]:16896
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008884AbaLOVbmvNDF1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Dec 2014 22:31:42 +0100
Received: from BN3PR0701MB1105.namprd07.prod.outlook.com (25.160.114.143) by
 BN3PR0701MB1089.namprd07.prod.outlook.com (25.160.114.14) with Microsoft SMTP
 Server (TLS) id 15.1.36.22; Mon, 15 Dec 2014 21:31:35 +0000
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1105.namprd07.prod.outlook.com (25.160.114.143) with Microsoft
 SMTP Server (TLS) id 15.1.31.17; Mon, 15 Dec 2014 21:31:32 +0000
Message-ID: <548F5330.6090508@caviumnetworks.com>
Date:   Mon, 15 Dec 2014 13:31:28 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Aleksey Makarov <feumilieu@gmail.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        "Aleksey Makarov" <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 13/14] MIPS: OCTEON: Add register definitions for OCTEON
 III reset unit.
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com> <1418666603-15159-14-git-send-email-aleksey.makarov@auriga.com> <20141215210942.GC10323@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20141215210942.GC10323@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA092.namprd07.prod.outlook.com (25.160.24.47) To
 BN3PR0701MB1105.namprd07.prod.outlook.com (25.160.114.143)
X-Microsoft-Antispam: UriScan:;UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1105;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601003);SRVR:BN3PR0701MB1105;
X-Forefront-PRVS: 04267075BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(51704005)(377454003)(189002)(199003)(479174004)(62966003)(64126003)(110136001)(92566001)(46102003)(20776003)(47776003)(97736003)(77156002)(4396001)(36756003)(50466002)(69596002)(81156004)(87266999)(23756003)(76176999)(107046002)(40100003)(31966008)(19580395003)(80316001)(33656002)(54356999)(83506001)(66066001)(105586002)(50986999)(106356001)(64706001)(19580405001)(120916001)(101416001)(99396003)(87976001)(68736005)(42186005)(122386002)(21056001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1105;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1105;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1089;
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2014 21:31:32.6628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1089
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44704
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

On 12/15/2014 01:09 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Dec 15, 2014 at 09:03:19PM +0300, Aleksey Makarov wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Needed by follow-on patches.
>
> Looks like only one of the unions was needed (cvmx_rst_boot)...?
>

This follows the form of the other register definition files.

If Ralf requests it, we would consider deleting some of the currently 
unused definitions.

David Daney

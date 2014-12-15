Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 22:29:46 +0100 (CET)
Received: from mail-by2on0068.outbound.protection.outlook.com ([207.46.100.68]:55894
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008875AbaLOV3nYK3Na (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Dec 2014 22:29:43 +0100
Received: from dl.caveonetworks.com (64.2.3.194) by
 BY1PR0701MB1111.namprd07.prod.outlook.com (25.160.104.21) with Microsoft SMTP
 Server (TLS) id 15.1.31.17; Mon, 15 Dec 2014 21:29:34 +0000
Message-ID: <548F52B8.7030606@caviumnetworks.com>
Date:   Mon, 15 Dec 2014 13:29:28 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Aleksey Makarov <feumilieu@gmail.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 14/14] MIPS: OCTEON: Handle OCTEON III in csrc-octeon.
References: <1418666603-15159-1-git-send-email-aleksey.makarov@auriga.com> <1418666603-15159-15-git-send-email-aleksey.makarov@auriga.com> <20141215212422.GD10323@fuloong-minipc.musicnaut.iki.fi>
In-Reply-To: <20141215212422.GD10323@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA073.namprd07.prod.outlook.com (25.160.24.28) To
 BY1PR0701MB1111.namprd07.prod.outlook.com (25.160.104.21)
Authentication-Results: iki.fi; dkim=none (message not signed) header.d=none;
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1111;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601003);SRVR:BY1PR0701MB1111;
X-Forefront-PRVS: 04267075BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(189002)(479174004)(377454003)(199003)(51704005)(24454002)(47776003)(54356999)(64706001)(80316001)(87976001)(33656002)(87266999)(92566001)(42186005)(120916001)(50986999)(110136001)(66066001)(106356001)(97736003)(105586002)(81156004)(107046002)(23756003)(122386002)(36756003)(62966003)(69596002)(99396003)(76176999)(68736005)(31966008)(77156002)(101416001)(83506001)(20776003)(46102003)(50466002)(40100003)(21056001)(64126003)(4396001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1111;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1111;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44703
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

On 12/15/2014 01:24 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Dec 15, 2014 at 09:03:20PM +0300, Aleksey Makarov wrote:
>>   	if (current_cpu_type() == CPU_CAVIUM_OCTEON2) {
>>   		union cvmx_mio_rst_boot rst_boot;
>> +
>>   		rst_boot.u64 = cvmx_read_csr(CVMX_MIO_RST_BOOT);
>>   		rdiv = rst_boot.s.c_mul;	/* CPU clock */
>>   		sdiv = rst_boot.s.pnr_mul;	/* I/O clock */
>>   		f = (0x8000000000000000ull / sdiv) * 2;
>> +	} else if (current_cpu_type() == CPU_CAVIUM_OCTEON3) {
>> +		union cvmx_rst_boot rst_boot;
>> +
>> +		rst_boot.u64 = cvmx_read_csr(CVMX_RST_BOOT);
>> +		rdiv = rst_boot.s.c_mul;	/* CPU clock */
>> +		sdiv = rst_boot.s.pnr_mul;	/* I/O clock */
>> +		f = (0x8000000000000000ull / sdiv) * 2;
>>   	}
>
> The f = ... part could be moved outside the if blocks to avoid copy paste.
>

No, If you look at the rest of the file, you will find that there are 
checks in the form:

   if (f != 0) ...

There is a reason that we leave f with its default value of zero in some 
of the cases.

David Daney

Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 22:39:02 +0200 (CEST)
Received: from mail-by2on0065.outbound.protection.outlook.com ([207.46.100.65]:2416
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012454AbbHDUjBM6jyi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Aug 2015 22:39:01 +0200
Received: from BN3PR0701MB1719.namprd07.prod.outlook.com (10.163.39.18) by
 BN3PR0701MB1735.namprd07.prod.outlook.com (10.163.39.22) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Tue, 4 Aug 2015 20:38:52 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1719.namprd07.prod.outlook.com (10.163.39.18) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Tue, 4 Aug 2015 20:38:51 +0000
Message-ID: <55C122D7.3040803@caviumnetworks.com>
Date:   Tue, 4 Aug 2015 13:38:47 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>,
        <stable@vger.kernel.org>
Subject: Re: MIPS: Make set_pte() SMP safe.
References: <1438649323-1082-1-git-send-email-ddaney.cavm@gmail.com> <55C10F4B.2050003@imgtec.com> <55C11A37.5070509@caviumnetworks.com> <55C1214F.8050208@imgtec.com> <55C12263.7070407@imgtec.com>
In-Reply-To: <55C12263.7070407@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN2PR07CA002.namprd07.prod.outlook.com (10.255.174.19) To
 BN3PR0701MB1719.namprd07.prod.outlook.com (25.163.39.18)
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;2:bPiV3oj27+3XQciHGO0QjO6aNYptDwdkM1HdpaPAJfbwZ4Bv7kUlzFa2ghDJp8pbUGB1AtQH+SbDx2YxtG5A5IOie/t9OWcnyHKkuGYKPWz3fc1fUp+W2K6GoSb0s7sjtHJk0Zhk2qsoIYZrqwkXwg2J5pXbXzIrTaEFiisvFaQ=;3:+Nr3Coq9hCn7mUKJAIXiimgldGIUphkDMx3c3yu1Xb7KQ9MO2R9o0BD3NNzBLlMYBXKHnZdjs74LPckpje2DCqK32+FaM3oVz1CjfUUVMMxIV5V2v1C7w+d1Gi7B/WSry4ZxHdBu0pYzUWnQeUDG3g==;25:SGa+OvvaaXuFZgEvjYL0U6a8LWPUJuLhA2ArqeEQ6XXbRLMmJSFlFZWcD1NaP2aBCHyrMdTKYPlMEqu/mw2e3MFC/akdntPeIBtMV/k5T88fmOhNfVix5JYmINLdcQLp7XADc1Ummp2MeDYTWPbn7043eCbFTd4++rpokm7/DBIOaUBDAx3JNVryB8AmKQ1jBEA8USoxa/oPNLVIs/N+HeR7fEyPxu9isUVR6/As2wUIQyI/uqKeOVopF9Uz20Dx881VV+5CXJs5Q7NydFctQg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1735;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;20:dNFyAYUWorIM+lPGVpjNDfN59DbHlXtresT0oWjOQXzaBQN0DqvX58EdYqVmpOO8RW19xS/Oj7Hs2Aj9EZcsO/DIbOib06V/dv0xjiw6RyrEYo68kapg2i/3SMbKUkmYbp0OzyM25GgwlC8u9GmkHrVgb38/bPnPBgMXyWwhlm4VtIH30o2P8OejsFnphVpaALO52GGDuM2/n1ByeeB3PrGpNWoRHS2quVO6iTUgqMpN6Oj02PwCLxDDuGh7UNHAhxi2ez3AdUTZsYl+krTvPN5Qd/EsWd+ZX7vqpfkjJknNQE5ndA6NZU3M5TcvE8qQYDY7k+dofWa5ya4aj++ZOkzAgJ/5YV41cwyITrnV8nHowutnv0XHaBybnkXL5NZNnp03JNE+1BGoTkCEddvYUbSj3dUi7jzjU1GGYX5vTIgNDkBs2x80s/I4v9Oo8FnhNmR+t/0SN/8kI8aY0fVg6LkV+XD9fp+tME+FrkH7iDu5n6aQhC+E2t9RwHvf4f0mLjFM64UtCS4NNJuB6+4qfrpfg4JX2pc7vXt6EqtffEYMjhmj+FtEEcwjNfk4i5Mn2GC5xVqNafYBSL9mYDNlZb8INoDet+rH5HBf3RKx5E4=;4:pkApGbIVf4ULX+DU6uPBqxQfGS2yjVQ81gkFxKAgIhansmvXIfzisgBVB9fbkG7av6G9TcQSuTxb26xt/9qaKPXsSE4HtwxBSt8xtGaw5O1nkeunJuGe6xJVubjBJo6ljNdc/Zfll2gY5VtcSIGna6CZ/XkNgXkz8KzyBjBUiiBi/WpQUqdg30ubH5IHCnT2OI4tYTZpyn+FYlWgZiPuaBxHmFFCMADsrZ0FlVXQabGudqomQLI6vIM78z2cVOhEO/zPhcuiYLkFIW26TDq2E4yDnFK2UOq9EYiuoSeQmYs=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB17195101F626CC7C078F66759A760@BN3PR0701MB1719.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN3PR0701MB1719;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1719;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(479174004)(189002)(377454003)(199003)(69596002)(77096005)(62966003)(122386002)(2950100001)(105586002)(66066001)(65806001)(64126003)(83506001)(33656002)(47776003)(64706001)(40100003)(65956001)(76176999)(68736005)(54356999)(59896002)(87976001)(46102003)(65816999)(101416001)(87266999)(23676002)(50466002)(50986999)(5001830100001)(92566002)(93886004)(106356001)(77156002)(80316001)(53416004)(189998001)(5001960100002)(42186005)(97736004)(5001860100001)(4001350100001)(110136002)(36756003)(4001540100001)(81156007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1719;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjA3MDFNQjE3MTk7MjM6MWhjakRraVpBejNBbytpSnFhUGxDamVD?=
 =?utf-8?B?ZGk4em5qSkxnb3lEMGsvYjNZMGgwdElUc0F3WGZDLzVCejFubmZERnlhbnBD?=
 =?utf-8?B?TGVQZmxJUGQxL1NwcHV5TG9tcjJSeUhyQUpoNVJ4dVQvUWFKc0MwS2oya2V4?=
 =?utf-8?B?Ym13cmtuRVlzZjNRRy95eE8xdUJqeG94disxRnJhWElFUEFLZzBZV1MzNzI2?=
 =?utf-8?B?cis5ZmV3UkNSMTNQdS9lamx4WmJsY2FwWVhNSzJTUjFYVERLMUNSZlRjTTRo?=
 =?utf-8?B?Ym1VQks0Wi9Ib0lOTHJZckk3OU1kbE1jbk5SNkF4ZGxPTHoxa1FHb3NDcVNU?=
 =?utf-8?B?bDZEdGs4eW04enlmZWx0UC93cnBNTlNnQ2dxTFMyVmM4TFhiRFlCdEw2TWZm?=
 =?utf-8?B?WkVOSUJDRHJXUXhhRkp4ZEtHd3dPYkJKVzJ4aUdpeHFxTUdoaHFmNVZLZWpa?=
 =?utf-8?B?S21hWjJWMndNTW5Sa2pDanVTODd1M2xZaWdUakQzUVV1cUsxOGFGZFRDbXBW?=
 =?utf-8?B?TDJUNk02bXRXTWpXS2pjQStMSzRjK1BzVzRhOG5ZaGpXNDRrM09yT1RaUXFM?=
 =?utf-8?B?N2dhanhJajJCd3d1c21Nak04QXc0NG9VQkRCR1IzWGpjWTEwRWZyZnFCL2Z5?=
 =?utf-8?B?cXBMNTlvZ2NOVHRrK0EvdEZBM3ExN21TRUdJVWdaTXJpV2MyblRxV3oxUkdZ?=
 =?utf-8?B?NXV2ejVTWDJXQ2JvVHFKaGRhelo2RG0vZmV5M1RpcWJzRW1MNlg4Mll3UG96?=
 =?utf-8?B?K2JtSjIvekR5a2UvdDAvKzJBSERxbGNXelhkcjN1SURjOVRVVTJvZG9LMnk0?=
 =?utf-8?B?SkR4L0F6dmVra1FyTWpKdEJJejBxRjJCMFBtZU9QalBSOHZWYnF6VEQ3WU9m?=
 =?utf-8?B?VUYrV0J0aGVJWHRyN3lNWEJvZDBDU1pabENhOVNvNnZtdEp3MUkzMjJyR2VL?=
 =?utf-8?B?RXVHcUxLMVovM1lRajNudVdhY1RlbTl1b3YyZlRzOVNZcFM5RFdXZmVKeGNF?=
 =?utf-8?B?a2V0WVJwWWoyVW1aMDhoK1FZemUzTEwyS1IwNWFmL2ZHTFhIUng2c0d0ZHJ3?=
 =?utf-8?B?UUlROCtyaEJaY1pUY1lRRDcydFhvTmdBcWJoT28wYkVldjVtYVVsQlovaStN?=
 =?utf-8?B?YS91eHJONndWRThYalA5S1o3QnNncWo2MXVHQ0UwYVlaMkZtdVVpNU85bXJG?=
 =?utf-8?B?WVZhM2R3TnJjRkNULzlrSHc0Ri9vSVJ0T09nTnMzbDU2TjVETnQ1elEvU3Ja?=
 =?utf-8?B?Q2ZYK2s0dE1rb0l6SG44Q1F0MnlITElFZVY1aXZUTkpIbzJ4NkxMKy9CZmxR?=
 =?utf-8?B?cEhrbFdkSHcxMUE3bzJVb0VSSTBaQ0RKS2hseVE4MmxNWFFBL2ZoeXZJbXFp?=
 =?utf-8?B?Zi96bXdkMW90Zi9HRTEzZmdBSUVCS2tzTzF1cTJOZFplSGpXRWdDRUVvSmtF?=
 =?utf-8?B?S0RjaVlnMC9wdG5iTmNKYVcwd2VHclZjNmlqYlpGWEdHVzRqZWoyZjVNNkw4?=
 =?utf-8?B?S016REN0SUdhWUpmc2FaazFnQ3oyb1JmNEc4eFJ2T1IvK2N5NFBWL1VXKytk?=
 =?utf-8?B?c1VRaGNKRVZhRVRRN1NENXRsMGVuMldMMjNPeEY3M1o1V2I1eHdobUh1Rkda?=
 =?utf-8?B?U0FQR0hRdkF3SXFJaUlqUUh3ajJKU2xBYUhKejdiR2tPYXRobzlheUE0WVlP?=
 =?utf-8?B?RXZIb1FtbUtFdEVhMWcrSitDekovUk5tU0VwRk5qYll1Rmw4RFpkdVR0blNk?=
 =?utf-8?B?cmw0SFYveGJ1bDYxb0t0UXV3PT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1719;5:VMW6KnqqtBTFXYVmpIPmka28+NbHMABNjZn1W1ITFXVDNDrjl18douQMht9sHTWV8t0CFGLxX0Q7pJzUgG9/QoyRFeuBVlokhVrgfGbGnaygOZMmD+IonxWp3xl9Bcgy5UD/22uUBVRcXnHgP5T5OQ==;24:gkOrV/yvXuli+xn2IlnMm73X3Ij+20yTFQFlMIQGA+bFyVWW0xYcx5liHuSEA4GKFqdpHbcEq9HKljuquVaDAnr1CgMFTFV2Ko/dMPMbK4g=;20:FAASzoznQ8FYGehZW4fgA3fE25r0Kg50/RGwQ6ha1aClWYHEIK0XYHNa9hdPJHYAKqvm/tnsLZQ362ZrphVY6A==
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2015 20:38:51.3727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1719
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1735;2:4C50SSZzs6qsoTwUeZW1oKktAl6kCuNNf962mHMNaDJUKMMV1znF0Sn+knAwOSDlpMBeXTfSVDjQJibK+fNn4MVLBBPu3AfVor0UFolH6gYyyiCHNl0KX4jt9AMLJAV1F2DKzdoGxUGUVA/rv90pJZ9v/UST+2JSynXtGFYV4NE=;3:qvxzq6beyFtHj0Twet5u/STo5vUtpeWyqLHNX+byrE1rmS5Z2t4KZkCl5t08iO4Bgm8Hs+LO29jrHlkNQEs80lkEeSbfA5UTkGivUtdgHXG6on+cTJxpG6ptOdknZcrtqTx5VJXDzDwGub/kmySppg==;25:7kr/L5VraIJm41vO0sJYQ7HxnAMTTc5CL3R6kdbHk20m118TXDILoNxXoGQcNd/wNYkoz6a5wH+Tsq4KJ7oPe7/G3cfbfxBAo2D8jE4v/+c5d/mVLNdTr7QTV/eCeZOS6qO/Ko05XVE89rR2ZZ8kLE5JGctQUlBNQyBq1ut8IjrgRgytNfb6RrmFDpR48E14DFE4CNkiJw1sZ238yoB1mz6Jm4+dYss5Ht4lVv6jmTZxUW4jvvae813u06SAPdqc+i0TGMfqsi+J//7RUthjzw==;23:lzsX//C2mR+E11tVP04WX/ZfgpcGHQYTbry1C8Kk0WgCs/0RldPamHjmJOt7F3pdqPa4Kwe0ma7qLmPDpMOeN4C31oFRVtKTMOxTz2YlBdo+q48MlUJ2VwjZf4nBg1P7etk7D/9UVepDJKhhXeGCIS4kcuES+FznJM/maUg4dq6iKNWncpibzuYBBG3IwyO4bHQHBE/FJJqoaydv+QKUowPcVC5Pnub6pIORaDegCjvxwJquMkFqpuO5nmJQqHTu
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48573
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

On 08/04/2015 01:36 PM, Leonid Yegoshin wrote:
> David,
>
> Note: Excuse me for bothering you but if guard page logic doesn't work
> anymore then it can be scraped. It allows me to optimize some cache
> flushes in VMAP area - instead of flushing a full cache, just flush a
> range of pages.
>

I don't know what the purpose of guard pages is.  I thought it was to 
produce an OOPs message if you accessed just beyond the end of the vmap 
area.  If people are using them for some other reason, then I am not 
aware of it.

David.

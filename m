Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 09:31:42 +0100 (CET)
Received: from mail-by2nam03on0089.outbound.protection.outlook.com ([104.47.42.89]:33839
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993029AbeAZIbas6qP0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Jan 2018 09:31:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xOHxmG+lK/IVrNrPpg7EbDFKFW0q723tDCQ68jcbjHs=;
 b=LcfVhD+4UvNnoucSqNmHRlpQjWZtgRh52YWFvCNXdjQBrp4B1OWGeaGBu5h+4m+c4V4cLChlLgo9MNF9F0SsoNJLq4M0axUwi8SQZ2LhbHVTDePqEfUGLoxqE4Z2/dy7lTZefhWOcVVGgl3/1Qp2sSM3yCi/la+jMduSuK39qI8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.40] (50.83.62.27) by
 CY4PR07MB3608.namprd07.prod.outlook.com (10.171.253.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.444.14; Fri, 26 Jan 2018 08:31:19 +0000
Subject: Re: [PATCH 0/2] MIPS: generic dma-coherence.h inclusion
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
References: <1516758010-7641-1-git-send-email-f.fainelli@gmail.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <ec150822-45f6-1e6f-1a76-2ef9a21da20d@cavium.com>
Date:   Fri, 26 Jan 2018 02:31:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1516758010-7641-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.83.62.27]
X-ClientProxiedBy: DM5PR04CA0062.namprd04.prod.outlook.com (10.172.183.152) To
 CY4PR07MB3608.namprd07.prod.outlook.com (10.171.253.23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fffb88b-4c4e-46e3-658d-08d564972ce7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR07MB3608;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3608;3:VlQWJjzEPIDyvRWIZKQwFEtlbJHwS2wc6kn7hmbagsU5QINFzEoVMIFOoA9I+FXHzRmvDT4e2UNUAIVy1vnAAd8WeILoodeFz3QF564H5+B1kGOhYJLjK+CMUBzmpJLhOp/m1WFbHwdL+Ax35Ct/Rx7u0EC1ofLAj/KU/V+TH3g31PxLXSbAXV/dVH+LJ1HbaqpXdIkGg9TByV2CfXzn0sMgOZ+sG1X5ZlGcvFF9cQiGnGf/NALqmvjnYugaHhsr;25:6aF4WfhcWkFNT7UHxlwpsqVj9mqOAUC/zZ2k30159UArPMaTSblV7cB6miK6WeI8Sb+kCcGPpfCC/3MiNV8Ic+u06pv+j7mhcWu7ZeIBUZTjOI8PsF8Xzs8waYIA5EMeETLiMnlJGCvn7mP8i67WKrqww50V3FHrg+WHaXzm4O7MErIYIHV8wcsVW9gDsuWhXdCjZ6QWfEtAZrIVlnxcWkLC1vQvXqpwObbze25Lo3zf2QgBliET4QRlv2GEAH+HueeevNVbJHoxW4mHYRYyvoJgxwQns4lN/6OpVnKKS5ZIJDJyKIxYbNa+iCbklugJuHZpre+bECCsqRPgVT6GCQ==;31:szwhYD5L3rHGXOVx/WjycVBL0H/gQ5SMa6NXiIXZBOnb+5SnWuzjEnkHMvGMhQm1xkMRpqbCR78NYILkZyNp0kyHV32fj4olSY493zNsQW9N+A0k+0dIeBEG8qj9ERAkR8aUKUagnxXqXSjlLcjzPaUBz46pz1NlrdUY6BKKHLkF1O8POfgK4/h0qVgm20RlQHX4KsMBICaoOklh63i1mSmkTDYU9RNwaI3NxaV9xNg=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3608:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3608;20:1wIYmWW5fW+u0JYcJ0/rL1hcgFpO0fXGPjcoVghNAqKsYTsxdrBQAwhJCvw2+ZPZsFFGDowqpb/JQ43KdzdEUjumRdYMSHlcowwZMV6bdoY1cmU9dxnWWf6waOqz95pvACGFoRDX0oQXFVJ8vAk15gIPoKfpK2htu+FxE8Tq6cufsdJRFkCKgzeVCHrd+re42Mwl1Q+nTxcJ815BRBFv2wDwOaylkXmV+ixL+avBB+yhY5aPE5xdAlqT0t6BPPjIUAFtkONYfYsVJl7okOPWl7FJUgwFN2vfccqxTc3r6KFTIDnh9tB90rTkNBN5N9glQO4yLqCnZBnk4XyO1HBvQzJceQJMGFohwTgD+26QJ5712BCIvjZhlZxFNtHJjRGCAvz8zBCpXUclvCXSwd5vl7p7/b9fx1bhxxgCNIIGdN3BHEIScP4uFxero8U3GgvM30s6vDd1eeLWRSho04M7keOq7Ri4Gpz5wsMQ000pGs7HFIJEzGIO+eBmLar69rIt;4:i52oZWa2M2El4XA2wms4rILG/kfGa6cK02ceNVxA2aS/Nl6Xc7tYUfs3NTmrrbPvgVCIgyDGipMgJxI4zVcj272OHPPa38N6sMHsC6iS7FJBnshAegWmrWnrg9lowcS8LgYHN+vA1Oj6Ewqe8LmUaeYbX6sq4sA7pX4w+UP3QW/gffsk7WUL9iLMogSqb73FnCT4vIvXs1zPTcCh+TMH0kRQis+sqy4hO6FZS2rUvC3XTf9rE2rsapy9VwYuYajVGnDOl1kwcQHjXfFrjYDWWw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB36089746812D84F9EC16C60580E00@CY4PR07MB3608.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231023)(2400081)(944501161)(93006095)(93001095)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB3608;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3608;
X-Forefront-PRVS: 05641FD966
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(346002)(39860400002)(39380400002)(366004)(199004)(189003)(65956001)(65826007)(65806001)(64126003)(68736007)(81156014)(8676002)(47776003)(31696002)(83506002)(72206003)(36756003)(77096007)(26005)(31686004)(53546011)(386003)(52116002)(6666003)(2950100002)(23676004)(16526019)(105586002)(52146003)(66066001)(86362001)(50466002)(8936002)(5660300001)(81166006)(2486003)(76176011)(230700001)(59450400001)(90366009)(106356001)(39060400002)(4326008)(2906002)(25786009)(305945005)(58126008)(6246003)(316002)(229853002)(6116002)(7736002)(107886003)(478600001)(97736004)(3846002)(16576012)(54906003)(53936002)(6486002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3608;H:[10.0.0.40];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNjA4OzIzOldRd2lvbTgrVC9CR1ZIclloQm9hQ1VRbUk2?=
 =?utf-8?B?QXdXRmtXUm1kTmN4UXFYWk45a0lwY0h1ZHBpelNXRTM5bElMcVo0aG1ha211?=
 =?utf-8?B?Unh3Vm13ZDFHc2pCVkFDR0ZvM2RTQiszZ0dpZ2JVejBWMk14c3BHbngyVFRD?=
 =?utf-8?B?QUFtVCsycG16eDdDaFVUdGxDeDArdGcyQzZweGhJL2ZoSXd5amNjbnhoV3Ro?=
 =?utf-8?B?cWVJdGJmRnB1SDJQNWxXS1VCU3ZhcHFlQzVzaE9QNnd4bEFDTDVOMzFQelUz?=
 =?utf-8?B?RzBuUjRZcnE2dHRxNTg5RlR6VExnWVM2dU0yRmZpZmM2eUtIa3BlWnQ2bDFC?=
 =?utf-8?B?YTFNckV1R0F3aTYyUVByT09FZjBkVmN1bmdGcjNMU3hWVFQ2bXkydUE0eWd6?=
 =?utf-8?B?S2JZbnhScHd4SURDdDdxRVlXWlZ6Z3FoYmRzbzFOUkgxUzl5VHhURkw3azJ2?=
 =?utf-8?B?NVU1RnFSb3Bxd2ozdXUzdHdPejU0TjU0VmNkT01WODVGVU5ET0dkOVhpWjZC?=
 =?utf-8?B?Q05qVEsrMnAyRjlVamlRbnZHRFlhUXI5bmszbzFPL042Nnk2RDJBcDBiMS9x?=
 =?utf-8?B?WW0rNVZuYlVndHlXNWNKdWpTWHEwQUp5QmtvWXhXdEJjZ2NhdmlVOERiRFcy?=
 =?utf-8?B?ZWtYZ1JqN2xvck1DV1N3TVVmcGV6YmlhQzBHVWZvTFU4V3lyY1RhUGhQSCta?=
 =?utf-8?B?aXFvRWpYSTJaMW9Zd0JIcjNHM3pSNjFKSnpIVWMvSXMvRExNU2JybzlSV1pH?=
 =?utf-8?B?c2ZUSmNIZG5ocEZCeEVpVE9QVzdFMWZDUFBHODZoQ05KNTFDaHladjd4S1pu?=
 =?utf-8?B?WDdtK2dxTFgzM1NzN3hoTlZWV0NERGpzNGpMLzhQRWxaVVNYTEhwS1pNNmNU?=
 =?utf-8?B?Sk9ZcHBqL1JCbVN5TC94dlc1UW40U2orWkVjcG5mdlNia1c0a3NNUmY3VFV0?=
 =?utf-8?B?TGovQ1hTRTNPTDJBaUZWZ0VEYjVNTktJNFFucVgwSzNVM0xobDVmRjRDd3Mw?=
 =?utf-8?B?d3pFdlJDakVuL2hIUkF2eDd1SXY0NFk0S0l5WndzbGFjOVQrWmlwaDJMWlEw?=
 =?utf-8?B?UXVqTzhtY0p0RW8xeG8wcU82bjg3R253d2x1cUN5Q0xWSjhweGVZZDdDZ0Zl?=
 =?utf-8?B?RmdQZEFBY0ZFdHZqc2tFcitGMGFhMXRMV2NHSmpPSzB6NUIrUDAwQ3JNbHM4?=
 =?utf-8?B?WTlTK2h1bU5rK1NWUHJZc2JXSFVFYlNHMmNyT1Y1a1F0QmNIQzJKNGFnQUhD?=
 =?utf-8?B?YTVVMThrb29YV2lzTStFWVJaa083dzJhNkpMR21MMlJRdTN4ZnRnWGQxK2pP?=
 =?utf-8?B?WitwMGJRQXNWN0dKSW9XaUtpaEhlWkNPRE5XM3FiTnBtNVJ0NHdzbnJxckdu?=
 =?utf-8?B?V1NoNmwraENQVTlZZDZMS0FwdXBZdS84NWJPcjdMa252ckF1NWJDeHNRT3RO?=
 =?utf-8?B?bzlkQjhleVhabFJJS1owdGg1UjBFV2ZJQVk3VXdkL0FuQXA1UlA2NkJReVpM?=
 =?utf-8?B?b1V5WGJMZnQ0RzZtMHdWWGVWU1V4NC9rc21UZzlrQUk1ZEpjaHZPVDNCa252?=
 =?utf-8?B?M1Z2L3kxdUF5eTlsSkRHcnZzVTM1Y1pVb0xMbEZlN0pCaXd6dUxQWXBvYVN3?=
 =?utf-8?B?OUk3SnVyZ0hLQjlUT0d4OU9DSUtYM0tQUnM4em5OcVBGeWgrZjRnWG9Kd0d3?=
 =?utf-8?B?ZGtCYkVBWlJQY3VsTTFsVlJpN0lUa3orVENrTnBseW1Kc3IvKzdLa3YvNndi?=
 =?utf-8?B?Y0k5ZTZqQzN2VGVyeWI5T05aQkpqWURaUU52YmVNUEFPMmtvVW9ic0pLVFdX?=
 =?utf-8?B?WUNQcFFpVGdtSVdSQnh0citFdXRDVWtGMDJUK1RGOGFQQllqVU5UY1p1clk5?=
 =?utf-8?B?dDVReU9DcUdEOHpFZ1IzQXlnMkJueGVrTWIzN1I1a2hYNXRTVjB4SkN6NnJi?=
 =?utf-8?B?RjlGZVJKcWU5SVM2MDlwVkt1MHlZRVRuL2N2eFBmQnV4ZWpYR2lXN04ra3kx?=
 =?utf-8?B?STM0ekdQd0J0dHMrUDhRVmhSZVl6NGRxdVNEUT09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3608;6:qnZ8Eo6vHox2ZFTUEi3iEjT4xwF6V08d6QbbQUBODPG98d/lZ/87epBIf51owwFFVp849irsKJLQG55cz1rHMG7255/z1yDgqOQOXIOZQXlowBMR8VkDStS4UF5xwo63YqQGSie6gbjb2WKLus683vCA4nXdgwqpaa+V3hVGmIpmDTLSbvQQbCKonRK5HMzg5uOln018ntwNTeM2Z9HycUpfQaLTvnWqKyZuLNZ+EUYaiVMDs3GjIDeSmmrpMX4ENXlmfrCzZHm+nDd2y2+/3oOGrd4qP5cPC0iwZRxBzfstMMIp36tFG2yeL36EfD4Az4Uuj/XJHGus/SqHPla3VZxFdP1hh5B5Uy+vgM++B08=;5:PvmGTmzTf0JWLNO8CflNZoSPrRqA0+fIGuo/czwlTgkUwg2YhXqLy4B6QCWu2fXdbcThElWKFlFRrHRaikR+DpJ4foSVJcyfTDHWo05V4mDV6F1uNBiEoiAqXDIyKB8ZwnNLB5r6lVruqtaPeG3kH2RR3IXihHCw7Ut0C0zjwqg=;24:e4JZ8IrbRFLC1bozDr38/FCrKvi3BUTf1c64pYbEMfnIS1afQ++Dbv3/HTKWXI6cT7iZnyMiYn6Stz7ALU0SgwBOj2Qu0F/UWTrmJtI2ud8=;7:8jML8RyZWCG+g7lMdBjzIYya9YzWvX7PcDk/4ezKAETP4dpNlr5TdgF4uEwL2aqTAarixAVX0d3AQg/CAzR4l9ND1cbghOjFMNsMzMsexINhwedEHpyN57PeBQJSjTqc9lAdzVa7plsOUOKAdobix0jx096I6iuHaV2RL/WXyu1N75k4AXiaIOeQppZSg9mb5SAFDWPH+AQOpChy/oW+IEiyeWhzci6c5wAVEJsw7MmJSHk7j0qxcmvZX8ya7AxO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2018 08:31:19.2744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fffb88b-4c4e-46e3-658d-08d564972ce7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3608
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 01/23/2018 07:40 PM, Florian Fainelli wrote:

[...]

> 
> Florian Fainelli (2):
>   MIPS: Allow including mach-generic/dma-coherence.h
>   MIPS: Update dma-coherence.h files
> 
I have tested these on our Octeon III platforms with PCIe and saw
no issues. Thanks.

Steve


Tested-by: Steven J. Hill <steven.hill@cavium.com>

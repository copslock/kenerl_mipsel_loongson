Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 19:16:31 +0100 (CET)
Received: from mail-by2nam01on0079.outbound.protection.outlook.com ([104.47.34.79]:26714
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990765AbdKISQYBkkrS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Nov 2017 19:16:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qB7Wwoq4ISAV4ylUgz6VGmdLxH4M/ZG1IzKckadLr0I=;
 b=crBU3M4SucUEDdvr9CS0mYPRQnDSsIvDUP0xMKNngvnFXAnZyXU9yT/eZptblSD+VrPIDsDX8r7mTHXxGS9WwZkLb8WxdvxbSdz18JkkBNZ1YtHH8VFD+c7+VnXA25OhzfrkbkVqs0Pm0asp84MEE9NTYrLFAbiBsC58SosPDX0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Thu, 9 Nov 2017 18:16:11 +0000
Subject: Re: [PATCH v2 0/8] Cavium OCTEON-III network driver.
To:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20171109005126.21341-1-david.daney@cavium.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <6b9d2ea8-157d-61ec-5878-334a00485d7c@caviumnetworks.com>
Date:   Thu, 9 Nov 2017 10:16:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171109005126.21341-1-david.daney@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0040.namprd07.prod.outlook.com (10.168.109.26) To
 CY4PR07MB3494.namprd07.prod.outlook.com (10.171.252.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 358259d3-b280-4850-430b-08d5279df56a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:CY4PR07MB3494;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;3:5zqCM6LlimNkYC9qIP0e4BAWeHiMA/LhP5hEkbZ3TkFzqb1ouCjJQKEHjW+BZ3x2IwG0dOhXzxA6OHic0+fVU9dTld0I/FE9rDRvLtSBZEDVufTUzRrtGgutAayA3ERXd4yToTnq2f7PnaMYcHFI56Y1zvvy3VoijwbvA52riRkJteCQYbT/cNEpUkSa5p/pS1rOczvdkHkcrw7I+46nkh/D1JouAI3DGwXdt0+VN4sl69bqX3t/SmK/t9UN81/z;25:roMVYawAkyjbLD2zGUvJIji4pQdnomlUemU9dYZiT+54b3QpJqJoK9OkmX+ljV/3xpBCIk4Nskl6zVjnuScU7AnpWaVeKc6AT8ruFWNWMU7PfqnTe4p7eUZD6w5571jxjZzMbHmi7i58YYoBaxJjPgGtrdLy+fw2OFpgsN0dOMzdiK7guY37g84eW8dNBJ4Vi8oeLguvpsxl+lu4qhT8BB9uhSEOiBmCotV6wZLj2Y8/0IH7aO/+RjMB1gG5jLoNw61NsGvu165nHcqb1X1CE8Rus5ErXib4WtgObD+Hhzh+9ttRiGu1wKBUOX+DdWkcihYnzSZVheDfIJUZXCy7rA==;31:tDleWehAvQjAc9K8WosPAlKsbWcuHktBhBZOe4RUpx9RfsD6bXOMHo0IHFDqcjVVGZw8GB+aQcYFOzk79yttqan92X8HCQik6QRMZo7Fxuuqq90LliCVsqeTO2HzG2AXxlrjMtnpxfhsP8FoeZ3GGnbi9FdLBBaPOSB1U1Dyzb+Em/xJY2jS7C74vZOuxzwjL0cg5VDxHWros29643m025tOWlTsVT+sZK52A5x2LJ8=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3494:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;20:lCsAec02OUxV+ctZhkMV6m+Kk//H09FVK9ujzWWyVZC3cjBNWjmgtunbXnVMJTzAjmRONA1iI/qSuOvbWLUtZBCrG57C+SGwIQ87GbG0dHe745/tF5g6PVmIrhWbkQ8ADLgmO2a8Zx11ad3Rm64Tu3BvL5c9gBCQkClYQEUND/jOJJ7jR24PL4mKuFpAI/dzB0JYrChTjeh3ZDVkO6nDrczPjm/pXa3wHJEwfZfxC7PK54WFjI8Wx7owZ4JbhxJF/kAAvForLHhma69AqoUGHLM4OnTAy7jz/07JyyB4ReM/VHqlnmyt+DvetFJLDCshKPtbvdi/D7/eFAu6ILKgjsDG50xFFKMMB1sJVZYtWgdgvf9wAhnpxFnHsiCxDU212ZHvVFu7CTBWmOvbz7rbHs/7J+0tDPBhS+KdNS9vTl+a/df2Nv5uMJ9aJwCnNWlbtYH8tL2i13yEsxQac4VwM2LZVu4CA1IzBdn1OsFva6ZxqZgRe9NW+j5M9esQc/1zQoH9/xpa8vCAEpzv6Z4nT+S+A88BowJS6OFumMrMjQYOf/pEYNpiONxoNXCbJ6y5CJ84WRIScy4eMU9Lva3jn9vhTkKQGMxBr5FbC73LlXc=;4:wKBiYdgGFCqP2dnwg+0AMZJd8g2IDfPBwbxt5CjFJic/XQpXwqxBOTgbwf4GNWP4qdgffzCQuYN40dDGuY/EmhdrllpHqftNilX6A7kVBhguSIWXSGClgt6X9l9NuQ31kOkTju9fRdRJUk+mn/a7YyD58x3jYe0tXJG8OAU6yry8LYey0jb2Xh4MzcspZVnrm6xftrsiP38iCVPiQbhQ/ZBRtEufg3vXlrMdPcxDFSgByN3HNVT4yd8YgseAAext92QHsOjxWPSydLBRvkZaHA==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <CY4PR07MB3494FC9879BD9D76F5943B7997570@CY4PR07MB3494.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231021)(100000703101)(100105400095)(93006095)(6041248)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123558100)(20161123564025)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3494;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3494;
X-Forefront-PRVS: 0486A0CB86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(24454002)(16526018)(53416004)(53936002)(69596002)(6512007)(2906002)(25786009)(58126008)(229853002)(4326008)(65806001)(6666003)(97736004)(66066001)(83506002)(31686004)(65956001)(6486002)(6506006)(42882006)(67846002)(2950100002)(47776003)(23676003)(316002)(110136005)(6246003)(54906003)(7736002)(5660300001)(33646002)(305945005)(31696002)(81166006)(81156014)(72206003)(478600001)(65826007)(8936002)(8676002)(7416002)(39060400002)(53546010)(3846002)(68736007)(76176999)(106356001)(105586002)(50986999)(189998001)(6116002)(64126003)(54356999)(36756003)(101416001)(230700001)(50466002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3494;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzNDk0OzIzOnpmUzMyZWJwOTZwRFNQT282dXFCR0I2eEFS?=
 =?utf-8?B?UXZxOHBMRDFsVmJ6S1k5S2dhL3hpK2NSQmNISFA2V0E1ay9SY0N3V1ZIWWxk?=
 =?utf-8?B?MENXZWk3MkJDbkt4Ym43dlNzSWdsZnA4TS9xdHpTaTJaQ3BpYUttbXVsRTJt?=
 =?utf-8?B?SVIvWG9ocE01UktHRzM0c2J1NENWdVRHQ3BDQ0pYRXlicytOZXhnNkpld3ZV?=
 =?utf-8?B?SEFZWnJwNU14YmphOGxmdU01VXRqNGJQcklMTVNLb1pIMHlPbStFelFUcDQy?=
 =?utf-8?B?aVVEeFU2dkJPdjBSUVhiQXJOUXd3U2dDeDlFckdUTWtpZXNoZXlpRlRRNnFx?=
 =?utf-8?B?Ulp1aTd1ZjJVbVc1ZlJYeE9sSjczZ0JMWGp3YmpEbHA3NXd5anVDeUJmbzVO?=
 =?utf-8?B?eTVvUmpQZHMwd3NlVWNHVEkweHprN1BBRS9sYUpES0oxOXdoWkFPemVLZVdR?=
 =?utf-8?B?NnZod05DWnVxVzRyL2lIYitkV2RJYjY0S3V4MGFtS0MwUjd2d1pUc05YaU1x?=
 =?utf-8?B?TEJxSkpkRzJiN0llUDMrYkcvVkVKcXZYaGZ3aU96MFlsWUczWHNvaHFndjV6?=
 =?utf-8?B?K0wxVm5hY0lnRVIyYVFCNm1kZXB2aTF0ZWo5eW5ZenJSOGxBbURBRXV5WStn?=
 =?utf-8?B?NnRSbXhaSlYrVG5pS1E3SEFqeU41ZzZnc2hYZ1JGWjJaS0FEdEJpeHQ4aEg0?=
 =?utf-8?B?aGNHNjBrQTEzV0hmbWVxRjY3NzFKRVdEYjR3bEFkMXBsTnk4dFlDa2pXUnJB?=
 =?utf-8?B?NUFaWmlFTHdVcUZKajdKU0Q4S0JnUFJsRVVqV2htb09lNjZGUG1OZ0U3ZEs4?=
 =?utf-8?B?cjliU3BIQTlPZ2YxV3dJczBvL2NBMGRWNHFEOWQxYVVGdnFzMFNrMWJvRGVX?=
 =?utf-8?B?UC9MbTlxRXlOYzBkalVibUQ1YU5tYnJQMzB0ZmlyNjhHN2Y3NFQranM2OGY0?=
 =?utf-8?B?T29PZ0cxWndBRE1hOHovSDJtSVY4S2VNL1FncVpTOHU5bktxSnpRWGFMVEtv?=
 =?utf-8?B?M3RtY2J6NUJtQW5mQk04bUZmTUVsd3hWTzBYTk5XcmV4OEM1ZWJ1NFIwRFdF?=
 =?utf-8?B?WElkb3dEcE96bmFHWGNZUEZMQUgwbU9pZHFDTmJackk3QnVqZXEySGRTaFM1?=
 =?utf-8?B?cEFwUEtCUUJLSzZ6SUFHeVo1NkhSZG5ERW9TYTZ1dk42UFloRUZibTZqRjNv?=
 =?utf-8?B?ak0vVGxWYktKeTQ4V1FzeFN5bjRnR2c0T25QWndMYlBOZEtjL3U5KzVwY05J?=
 =?utf-8?B?bXo0TXNOVVNLclJyb3UzVU9DSjNKTUVHUTZaS2xhTUhWT280T3VkaTN5OTdx?=
 =?utf-8?B?T0V2TTFiajVBelBtWDJZN25uNEhwY0UzV3ByVHBtS0dyTDNob09tMUtQUElu?=
 =?utf-8?B?M3BlZG5mZVlRUmlwc3R0STEwN1NhRE0zZFJvQUMyUUZnTHJWdUN1NUl5bmhB?=
 =?utf-8?B?NHFLYllmbUdNRm14RzBUYm4rU0RiSllQMlBwWFhGcG41eDl3YUk4RXZOODBU?=
 =?utf-8?B?WmltSC9CaGhkWlVkOC95cDFoamZ1MndiZDI4dmF0am4zNlg2SUt1MkY4RkxK?=
 =?utf-8?B?c1dVRTFZbzRlRGFpaGpCREZ0S1JCSzB5dmp4bXVpWDJRMzNFZ2tmU3VYaDdp?=
 =?utf-8?B?RnpiVkVwZkNtT3gxRU4yZm1iemdxQlg0TzNYK0YvbnlXcmFoSCt4OGhpbXZI?=
 =?utf-8?B?THZmNzBqUGhydFZORUxFS2daeG1mdGZaUFZibzJ3aGVVaExHbkRRTUpJRGtI?=
 =?utf-8?B?ZG95K1lSdEZGNHdYTGNOWjJSR2pZK1JnRjZURllCdGxBSnhqYjlQc05lbHh3?=
 =?utf-8?B?dWdDQlB5NHZXODBublQwL25YRkhLV0plc0JlaGIxTGV6N2JURlNyNGE0bzBP?=
 =?utf-8?B?Y2s5MkFFOUxUNFYveU9jY0VxMW82WGpENnMrT0VTNStSK2x3NmQrR0VrN25R?=
 =?utf-8?B?VUM5b0tzdGlMRnd1djNDeDI3Um1yc3pINkNjZnZTZ3krWWVUcXVWQTBBVEhB?=
 =?utf-8?B?WkRYTnpoSzc5NjJ3bnNpeE83ZlZoK0xKOTZPZz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3494;6:n2WR/yHjyDJOFJr89rKT47CvkjnHwolg97z3H5RqU4NWGWjZrDfp9/0sJlefcuZLzNWSgPeHfU5yT0/Ulg/IDd79Q529bNi1kWEwpqIMKJN2mgjY6srDBDkFF3D6RfDhkFglPkpoEaBAMlZopbQ96qnrzEk23PDEy6BcQrWk7j3RiefjYySzW/JW1wKXkHJI/AoYmuZGTb4tggZmrfpj5Sg5eISj7f8HK8aaMwHqJoqbVPr83Kl25lxL/OxiU74OdKsGuKN6GiBj2I+MUpyRfVWJVZNmvtlfTVX/ttmx9ys/cWBwdz9/9ug4MUE9zeKfWbP3n2i3Ce8UjMjIvRU9mygWFexOb/LrfXaoTupTt10=;5:9RxZMRR5gwyEYGB7WhaBfr8NArWWi/ZVBl3qFnfa1VrOQSRVWzivEZzqyJsficvvGwsJMJQdVljVgPfY2guYSqxCGvIprJTZOgkofEJnRwqt6XTvqu2DOatXDEwzmXtAr0TUhtIsDp4mJEoiK85EvciiQ7o6SR6H3O58Rg1FjjI=;24:GrelzSLT5JqN4DR/LlUQdkFVDQT3sj2FFbXbPba5U8E2mOlp2rnJ5pLNPeYbUpZ6F3t5S0toqffdJTdCW04kt7w+ZcPTzEq3LUCaeY/56Ag=;7:DVwNqPd3ORPZTOJ6h/fpr2B/D3N9bTe/hBBf3NwfCXZxJ90P/3EpfMCV0bBZcRxnqN2uJvzeQ9vgTSdq1Y/8SCzUavIg+3WolsXlJxzSFaup5hV61FRoqq1BypRf4Z8peUPdBfUofD6CfJS3ZlT9bqWS7MvTvlwvW9vD3bDmRdRlR70QxnjInLRy2nOnGJmM5X3Q6JoYKmOCeG/u86SfPmH+qMlfkq1CfXEdEMbGIAWU5BnScEn08rPh/Fov2X+r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2017 18:16:11.0804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 358259d3-b280-4850-430b-08d5279df56a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3494
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60814
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

I need to send v3.  With this v2 set, there is a small bug in the RX 
initialization that causes failure on little-endian kernels.

David.


On 11/08/2017 04:51 PM, David Daney wrote:
> We are adding the Cavium OCTEON-III network driver.  But since
> interacting with the input and output queues is done via special CPU
> local memory, we also need to add support to the MIPS/Octeon
> architecture code.  Aren't SoCs nice in this way?
> 
> The first six patches add the SoC support needed by the driver, the
> last two add the driver and an entry in MAINTAINERS.
> 
> Since these touch several subsystems (mips, staging, netdev), I would
> propose merging via netdev, but defer to the maintainers if they think
> something else would work better.
> 
> A separate pull request was recently done by Steven Hill for the
> firmware required by the driver.
> 
> Changes from v1:
> 
> o Cleanup and use of standard bindings in the device tree bindings
>    document.
> 
> o Added (hopefully) clarifying comments about several OCTEON
>    architectural peculiarities.
> 
> o Removed unused testing code from the driver.
> 
> o Removed some module parameters that already default to the proper
>    values.
> 
> o KConfig cleanup, including testing on x86_64, arm64 and mips.
> 
> o Fixed breakage to the driver for previous generation of OCTEON SoCs (in
>    the staging directory still).
> 
> o Verified bisectability of the patch set.
> 
> Carlos Munoz (5):
>    dt-bindings: Add Cavium Octeon Common Ethernet Interface.
>    MIPS: Octeon: Enable LMTDMA/LMTST operations.
>    MIPS: Octeon: Add a global resource manager.
>    MIPS: Octeon: Add Free Pointer Unit (FPA) support.
>    netdev: octeon-ethernet: Add Cavium Octeon III support.
> 
> David Daney (3):
>    MIPS: Octeon: Automatically provision CVMSEG space.
>    staging: octeon: Remove USE_ASYNC_IOBDMA macro.
>    MAINTAINERS: Add entry for
>      drivers/net/ethernet/cavium/octeon/octeon3-*
> 
>   .../devicetree/bindings/net/cavium-bgx.txt         |   61 +
>   MAINTAINERS                                        |    6 +
>   arch/mips/cavium-octeon/Kconfig                    |   35 +-
>   arch/mips/cavium-octeon/Makefile                   |    4 +-
>   arch/mips/cavium-octeon/octeon-fpa3.c              |  364 ++++
>   arch/mips/cavium-octeon/resource-mgr.c             |  371 ++++
>   arch/mips/cavium-octeon/setup.c                    |   22 +-
>   .../asm/mach-cavium-octeon/kernel-entry-init.h     |   20 +-
>   arch/mips/include/asm/mipsregs.h                   |    2 +
>   arch/mips/include/asm/octeon/octeon.h              |   47 +-
>   arch/mips/include/asm/processor.h                  |    2 +-
>   arch/mips/kernel/octeon_switch.S                   |    2 -
>   arch/mips/mm/tlbex.c                               |   29 +-
>   drivers/net/ethernet/cavium/Kconfig                |   55 +-
>   drivers/net/ethernet/cavium/octeon/Makefile        |    6 +
>   .../net/ethernet/cavium/octeon/octeon3-bgx-nexus.c |  698 +++++++
>   .../net/ethernet/cavium/octeon/octeon3-bgx-port.c  | 2028 +++++++++++++++++++
>   drivers/net/ethernet/cavium/octeon/octeon3-core.c  | 2068 ++++++++++++++++++++
>   drivers/net/ethernet/cavium/octeon/octeon3-pki.c   |  833 ++++++++
>   drivers/net/ethernet/cavium/octeon/octeon3-pko.c   | 1719 ++++++++++++++++
>   drivers/net/ethernet/cavium/octeon/octeon3-sso.c   |  309 +++
>   drivers/net/ethernet/cavium/octeon/octeon3.h       |  411 ++++
>   drivers/staging/octeon/ethernet-defines.h          |    6 -
>   drivers/staging/octeon/ethernet-rx.c               |   25 +-
>   drivers/staging/octeon/ethernet-tx.c               |   85 +-
>   25 files changed, 9065 insertions(+), 143 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt
>   create mode 100644 arch/mips/cavium-octeon/octeon-fpa3.c
>   create mode 100644 arch/mips/cavium-octeon/resource-mgr.c
>   create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-nexus.c
>   create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
>   create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-core.c
>   create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pki.c
>   create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pko.c
>   create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-sso.c
>   create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3.h
> 

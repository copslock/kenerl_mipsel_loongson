Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 03:54:32 +0100 (CET)
Received: from mail-co1nam03on0049.outbound.protection.outlook.com ([104.47.40.49]:6579
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990482AbdK2CyY6lOg0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Nov 2017 03:54:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ta4SfmxXZjtbvov+9y7mgBOwlVIn70C8F7jVjTudcrA=;
 b=T2MuZn5YFvbttEtHmnlD0aIpAF0Xrb51sS4+y047QNG8vgff/zxnh3sahvxHVlxnLzo8O2DW69wyZxRT3YxJm9qYANbJfSFKzg7IopUMVKxGG8QPcQOI+8FtTchZel4uUGyH4x7NNsaKB5mLIIzPAIPhqvTTxfIA1au6xQKPU58=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Wed, 29 Nov 2017 02:54:12 +0000
Subject: Re: [PATCH v4 1/8] dt-bindings: Add Cavium Octeon Common Ethernet
 Interface.
To:     Andrew Lunn <andrew@lunn.ch>, David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-2-david.daney@cavium.com>
 <20171129020153.GN14512@lunn.ch>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <05f5a001-fc52-3376-d823-41166ed7b59f@caviumnetworks.com>
Date:   Tue, 28 Nov 2017 18:54:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129020153.GN14512@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0006.namprd07.prod.outlook.com (10.162.96.16) To
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af787bb8-72f0-4401-99a5-08d536d47970
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603199);SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;3:02d0STz4h4qBDilqFOtzQaAcRc9TXYu7wMUhoNkuXeta7DaJJ0c2wWYvvhW2XVt1WHCJfL2CZ8jqdJqD4N3yaw2I4uY8w2jYylvMQPr4kAtGydie1vkhWVeOTg4YxG7MUfVEbcXFZiy9CQUsOa57qxdmRKDGoWfotTv5P6XtCBV9mIP0XB2c6Ds+pKOr3NhWavgnNpMkvzDFxAdhcXjI+WZpAEsWp7puDcemQeSwvDEudDHmXRseybWuiPEmkdmp;25:IbioWOqllzO6aS2ZAB3L53wnp4wvv0MKqQlwk9822H0JtNta4WGjvBTTWxEzx7oj3o0ztSgUyzHhW/1ChhUuFgOBU3HQden0I2/oh0Y6ofMB+7XtZxvcbqyXLO4f1N+KJS3iC9l608HsQEILnYHwmC9vYP8iF48g9t36tqaFMb8worZ3MZD7vbaFSJ9ZuPFkpXYiNdYDDqw9gMXOZL8UGI+ZovGHGUZef0dzL+gU3CeR3N6q98k/OO9hyc96K7JNE1zh2wl0nHAnvEfN4GcDFsY4sXjGBisFdcWrOXjxeYQjL+rCmltwJq2AI+SYzkOKKQG3c2Z30v/qUqLrqwLV8Q==;31:Ax1XmkTvhcv37mBjTl8bGiLRLeZf6UA6ybJZYbzihoNHJaAYOPgo3EZ5HhNI2zIocqxG5pQwVWNuOE05KD0672Ps68pErw3iGqZQJDdpPLaXu0ji8QanE3VMakAT+iz+sxYkKqSkuhTAQfuAYzV6BcRsiQNEQiS9xVxR6tKFJRMhpR8HmN9iYE5OMwxeeZs3tz7wfh5Cep7k0F3HtKaCaQ2rEuyaFyMphDYoaY1MpQ0=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3500:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;20:6Ko364XB8LWf8Wa6Jn8d5pMpzt2RasBP/H+td2yvxlRkbhfduZ1gWvVQbOMD73Grc9RL6TKIeZuWX8LxibjqSd2OpJia4Jf8TV1JDz1F2aSb0aRRjJNs8RW2D0MJtkqIynSXBz5dLGQ8AstLA7pMQUdzjNzRqXw68PctQPZI94msoe7UrQi50TtO0Z2HnQm9Poy9U9GFi5gDKXVgSo6VYfAkKDwxwmLUMqlgi6G46tDed5GRgoX94VBc2WjxDAAMV3Yv8j+GimKrpS6lqa0FuVqtUUXR3kNAYhaZ5J1WhC+uiBNxDjLd9rS5GOQMBuAQ+w7zSC9+c9hgR2S130vbTegKZ61ykBWkP48auGgETb8R21VNLIKLUq26bR3SbYy/+Gt5iOfkswEuD0tNBYsrqVExvQxlcSJD2zUEzp/8LvSUaqpTERnKkiGIKlhF8e+tp0tJuzL/y/j8eaXyZoj3j/925tBH0OzRk0NuWAeCmR38uoVnNUxN1hCf1fS3ae3X1v904+m2HCx8morb6izSj+BVKwZxhc0IQTAAhDOWTdB004fgqiTu4pc0fBWflAC+1k/flpqbVpCVAK9GOv0zPc5PDGVoFQAB1v9LZMU+lXs=;4:DDBelfEaaoxn3OvdqRNW0HRWawXppiVwltXYUCetssIySqIIhIb4eFCXh5s0wS1hHAjoOOI6oxm5TR/IXKp0JwG9QaSFiyEwu4an1DZuSdfgVnth7bUkU6mlfWz5YREV8inecD86qvnBaw5tB2l0UxP0PW39ExlrYQ0QJtOuNj0+y7+iHjCFLFvVQp6FerkuYg84QMvYQDpjvSB6OThE1QCZHQh6/xv/9sPbU9b5bKFXaTvttNUd8/Z7dQ2umP/ILyuw6xseC7jiYOXvV3bsvg==
X-Microsoft-Antispam-PRVS: <DM5PR07MB350088C89984CF7304AD9F82973B0@DM5PR07MB3500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231022)(93006095)(6041248)(20161123558100)(20161123560025)(20161123562025)(20161123564025)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3500;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3500;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(366004)(189002)(199003)(24454002)(42882006)(6506006)(16526018)(5660300001)(106356001)(2906002)(105586002)(6486002)(7416002)(65826007)(229853002)(478600001)(6512007)(66066001)(72206003)(23676004)(33646002)(31686004)(47776003)(53546010)(76176999)(50986999)(65956001)(52146003)(54356999)(50466002)(65806001)(101416001)(64126003)(8676002)(107886003)(6246003)(6666003)(53416004)(110136005)(52116002)(81166006)(7736002)(25786009)(68736007)(97736004)(8936002)(4326008)(2950100002)(36756003)(83506002)(316002)(230700001)(2486003)(53936002)(189998001)(67846002)(31696002)(305945005)(39060400002)(81156014)(3846002)(69596002)(6116002)(54906003)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3500;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNTAwOzIzOlI3RG9uNVpobGJYZHZObDVkWG9JNGhxaEVH?=
 =?utf-8?B?dXVBWkQrbU1IaTBqTmpCTmxFb29xMVpQWTJVZk1MQUJNUlBzQ0xRUFMwSEZt?=
 =?utf-8?B?aE5BZDMrU3F4YnB5d3M5d2V0Q1N5U2FlUFZzNnAvRjZNb2M0cHlMZUUzY0Rw?=
 =?utf-8?B?a3JTQzd4OStQMXZQUGdNZW02TSs1RWlhdklXY1hGRE5EeGdKRzJBeUpvdnBL?=
 =?utf-8?B?MUJSOGVFR0lVeHREY0t0RTR1YWQ3eU5NRCt5ZUlVQU1BelkvTjhYUUtGTDFM?=
 =?utf-8?B?QkQ1NHlweGFxMzZwbFB6bm9COWtnVzlKY3FsY1N1a0ZTQ2x0QWZqclFqbDFz?=
 =?utf-8?B?V1RQd1hCdmZ6YS81S2ZkOXR6clFwZkNOMGJnaFNBM1dXVzNvL2lubWcwUkpX?=
 =?utf-8?B?M2ZoMWhhZC82ZTN6KzZGU1lwTWlFTENyQUFxTDdxRkxHTW80dzNQY3VMODVk?=
 =?utf-8?B?eVZJNDB1OEZoSk9PRForN2RKVXJMRkI3djRXdEpIK2RsWW5FNnpKK005SU1y?=
 =?utf-8?B?TTlyR09nTHlKT3ZMN0xMSVZ3cGlPcVBpRUg5dzBzMldGU2xlYmJNMW0rRkwv?=
 =?utf-8?B?VmY3TTh5andtMWtvRFJrbFZjU3FnYmtMT051YXhoRFVveFZRcm5sY1pVWWNX?=
 =?utf-8?B?VTgzYTFCSnJWUGpiUkR0ZkJHQi9ZRkRSRW9oNzNBWGREZVN6RGxsaVhvaEZt?=
 =?utf-8?B?SXVheEhydkM5V3ZseGlLc2Q1SzZleHVuYVpYaXBub3JXaUloU3cyODdKVldR?=
 =?utf-8?B?QmZFaHAxdHpiK3VWRUlkWXZlYTdHMnU1MUIva2dvNlg0WFlqbXVLb254cGMx?=
 =?utf-8?B?V2laUnpXQnVucXJneHAxQ0FlUDlESms5UHFGVGVvY2V2Zm1aT1hTZ3M1Z3hL?=
 =?utf-8?B?OStRVjlDVG9DM0dGbEQ2UGJnMzJoNTYrMVRCWnVWV2swbUlRZnVnR2M1Q2pD?=
 =?utf-8?B?Z2xEazYwc3pURHJ2WUg2dWxuaSszWW4wRkpPZ3ZRTHdYdllNNDdMMnVScGlC?=
 =?utf-8?B?MUFiNVYwNFV2Y1Y2Vi9pYU1jeFFNWU1KUnYwVXFScXNOV2pWTGdDRDRCY2xW?=
 =?utf-8?B?dDBMZVlpS0xrdXRUMTY1bHBTQnQzRk02UVFPNDNHMmU1L1RpSjc4cXorN1Y2?=
 =?utf-8?B?SDAxY2duOThsSGpWdnBxSGlaMkdqQ0doeVh1Zk1ya1hmVnh2TDE3N0QwNmtG?=
 =?utf-8?B?alVDSU9CYnFjRk9FdnB1T2FlZWN5Uy9TbCtqRE9tR2QxUmxBVkxjd2lsdGJU?=
 =?utf-8?B?UFpwaTNIQWNwNk5MU1ZjNUZLbytjQmoyNlFVU1grRk9HanlMeDhXblZCa2Ew?=
 =?utf-8?B?TEphVldZOUN2dWM5L0VMaEJNQW9uL0E3MXdrcytRZ1dkUk9iYjhRdzU4T2VR?=
 =?utf-8?B?SUp2VGw5UzAwSHVseWlCemNvRmNXcm9KNDNNRVFtNm5xdkNsd0JIdjB2a2RB?=
 =?utf-8?B?L2kvVVhtUDJHQW5xSi9FQnJ1cGZhNVYvV1QxMzNRSWFYam5RSkpmSS9Mckhn?=
 =?utf-8?B?YmVGeTh4OUJPSVYzaWhFVzVoMlBzWFRRYzR6WUIyTndFZGRpaDkxMWU1OVVC?=
 =?utf-8?B?ZFB6ME13cWJSR2lrbm5jRi9xZ1gvVXN6NTB0ZGtzZHlIYzNNcCtlaHd0d2FJ?=
 =?utf-8?B?Um1pV0VSZlRxMFd3NUNVaEtVOGJ0SW9qSWtRalIwY2JkbWhCU1I1czlIUkoz?=
 =?utf-8?B?Z1Iybm93ZnhHaHBLenliVXoxMndiOUVjcWJENWdPcWpxZFpYMVFjRjIyWDcv?=
 =?utf-8?B?eGNxbGVSb01Vai9tYXdXbms4OXlxVXYrZXZ3Y3RwU0VJV0hPWkNUb1lITHc4?=
 =?utf-8?B?SE85UkFZR09oMWd2OXNBR0hLZ213TzhQNFZwN0IvTlBWT1YybWZ1azRmOS92?=
 =?utf-8?B?dDFmME5lcTBVaGxqWmJsNTZBWTdRcjZpWEhObmlaUTJhdDFabi9jWUNrR1pn?=
 =?utf-8?B?UVdjdGZRa3VhMWNvZXlhcHlHaGtRWnNMdUwxOUlDSTl0cWNmNXBqL3lseUtM?=
 =?utf-8?B?dDRZN2tsWlAxamZXYzhiRlJrSk9GVnJzNnh1N0haYTFpMjVlVmRZRmxaZkNV?=
 =?utf-8?B?ZzVQeDJyWnl0K3hvMmtBYXB1cW14clI2S1hLWFBadFBzTEF6K3lMRWFhMkcy?=
 =?utf-8?B?VVE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;6:9QFJKeGNGAuZt8538Yi3MsoXDPObcgJQtWtM0ZxTbOz8IM2eI5ZvaH2w/f60MvH6dSV/Tz49gBxi1Z2VsJDeTA8KvliPvkjInmZHoiJVpnbCPaH2hWOm+vAv4VSYO5XvEyQ8XBNmjsgHCSeqA/NFZwL3yqBup13A1r3LNN/p5N8pDv9Ik6dXRBpyRw0XmoST61zElrQoaghZXxnFrfzeHgsn3ZVpZS08KB1kEBbdQcOLyzu658Hst0zCDUEGOrj6PO/EtdyYCxBsUpjujvt9VzI/0KkF0NsbVkyIJeVTYsUFkK6s9gRuvcphueQkokObMQsHrQaCMxT5pWD2H5iANE9PlTudwZ9kTVq2w5r+BiU=;5:kVqNeMQARUlRr/H1zwKuP9ti4cDX7Uq6vkgomEuDn1RQbydeOS9yo1APtMdh3ChOu7NUZEKZ/zgSLnlfeScEMSMtyfkrrK/LDMsrDmtRaOPAH0RR7wO4jArclVb38D7k/92H63R5NzK1wz6hCZ/wpB3eHTQuqyAs9kjsO2S5hFs=;24:4/W/hQXzbi8m95hRB84FvviZ3Aoe2zTVBTHzDnq601eD82e3G9r7EogYuR1mf3eYekiTdPkJKW6YnX1JMNRHAtpSwEoc2BbVqZc8wPGAMPw=;7:NPHN9saGqQEGsPGU/ldAzXPDWbbN1GG+MDxI9HBkGLkCfkJ4OuCiCXs3uTubnrfWebA/61ndz8JPpmjZjadZ/K+0lifyaYIjpNDV60bwVtJvIROtsCSr08fQYk+qcyqQmpzSWRwjCuGXXyawtHWZeKvKTKZz10EIlW86AX+KntG621h1Vq/YpiuPQSmjgmWVbYLbPqKLNeB2jGm0gDRMZ99439bqhEqCF1WSy5OXiLbT8nDfZzQcqApB8z02pC9v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 02:54:12.9307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af787bb8-72f0-4401-99a5-08d536d47970
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3500
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61181
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

On 11/28/2017 06:01 PM, Andrew Lunn wrote:
> On Tue, Nov 28, 2017 at 04:55:33PM -0800, David Daney wrote:
>> From: Carlos Munoz <cmunoz@cavium.com>
>>
>> Add bindings for Common Ethernet Interface (BGX) block.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   .../devicetree/bindings/net/cavium-bgx.txt         | 61 ++++++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/cavium-bgx.txt b/Documentation/devicetree/bindings/net/cavium-bgx.txt
>> new file mode 100644
>> index 000000000000..830c5f08dddd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/cavium-bgx.txt
>> @@ -0,0 +1,61 @@
>> +* Common Ethernet Interface (BGX) block
>> +
>> +Properties:
>> +
>> +- compatible: "cavium,octeon-7890-bgx": Compatibility with all cn7xxx SOCs.
>> +
>> +- reg: The base address of the BGX block.
>> +
>> +- #address-cells: Must be <1>.
>> +
>> +- #size-cells: Must be <0>.  BGX addresses have no size component.
>> +
>> +A BGX block has several children, each representing an Ethernet
>> +interface.
>> +
>> +
>> +* Ethernet Interface (BGX port) connects to PKI/PKO
>> +
>> +Properties:
>> +
>> +- compatible: "cavium,octeon-7890-bgx-port": Compatibility with all
>> +	      cn7xxx SOCs.
>> +
>> +	      "cavium,octeon-7360-xcv": Compatibility with cn73xx SOCs
>> +	      for RGMII.
>> +
>> +- reg: The index of the interface within the BGX block.
>> +
>> +Optional properties:
>> +
>> +- local-mac-address: Mac address for the interface.
>> +
>> +- phy-handle: phandle to the phy node connected to the interface.
>> +
>> +- phy-mode: described in ethernet.txt.
>> +
>> +- fixed-link: described in fixed-link.txt.
>> +
>> +Example:
>> +
>> +	ethernet-mac-nexus@11800e0000000 {
>> +		compatible = "cavium,octeon-7890-bgx";
>> +		reg = <0x00011800 0xe0000000 0x00000000 0x01000000>;
> 
> Hi David
> 
> In the probe function we have:
> 
> +       reg = of_get_property(pdev->dev.of_node, "reg", NULL);
> +       addr = of_translate_address(pdev->dev.of_node, reg);
> +       interface = (addr >> 24) & 0xf;
> +       numa_node = (addr >> 36) & 0x7;
> 
> Is this documented somewhere?

In the Hardware Reference Manual for the chips.


> The numa_node is particularly
> interesting. MMIO changes depends on what node this is in the cluster?

Yes.  Bits 38..36 of MMIO addresses indicate which NUMA node the 
corresponding hardware device resides on.  Some operations can only be 
performed by a CPU on the same NUMA node as the device (RX or 
TX-complete interrupts for example)  Other operations can cross CPU 
nodes (TX packet submission for example)


> 
> 	Andrew
> 

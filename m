Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 22:56:22 +0100 (CET)
Received: from mail-sn1nam02on0048.outbound.protection.outlook.com ([104.47.36.48]:38304
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991940AbdJaV4K5tppl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Oct 2017 22:56:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6cgsu2Z0SRHo5WiEJJhp6/e+s8Z9B9w5MwctdjwOC5Q=;
 b=SayLKeaW28x4TpG2zgq/6by3Fe0xbnVgaU56aOQ9aeqgpcHhkKKG7BGPrLNqMXrp4w8vlAck1yuUDz0adGiVdET9cvoTyqKR+KBjirn8OuGM8o0RdeUdiDH+BEATVyTiMN5mCoPXCv1cO4THfGdFNBjD3F0iveSThwLuaxjGgzk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BN6PR07MB3491.namprd07.prod.outlook.com (10.161.153.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4; Tue, 31 Oct 2017 21:56:00 +0000
Subject: Re: Octeon CN5010 - Kernel 4.4.92
To:     Gabriel Kuri <gkuri@ieee.org>
Cc:     linux-mips@linux-mips.org
References: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
 <3d272dc1-4012-c7ed-7c34-876265afb25e@caviumnetworks.com>
 <CAO3KpR1VGFYdY-Mxb+Xx6yzKhzXAycizEm_7f9LT5GdXcLbkDQ@mail.gmail.com>
 <c726a4ab-632a-0788-1147-c3de26ab6b75@caviumnetworks.com>
 <CAO3KpR2oYGY89utWTpwd0+hzXQ8xJCsNpxLaX7fxV6hWiFbtNQ@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <148da245-c31e-03e9-3d19-f7d125507b96@caviumnetworks.com>
Date:   Tue, 31 Oct 2017 14:55:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAO3KpR2oYGY89utWTpwd0+hzXQ8xJCsNpxLaX7fxV6hWiFbtNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0074.namprd07.prod.outlook.com (10.174.192.42) To
 BN6PR07MB3491.namprd07.prod.outlook.com (10.161.153.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 685d7300-574b-41cb-473d-08d520aa2c90
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603238);SRVR:BN6PR07MB3491;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3491;3:xdsmp5NT8V9V+1Bxk6rLhgJ+LaY2fDVgYlk96ecLNb/cZHI27UoyV99cTjDpiX/o4J2wlNKcBh5SDNT1jjsqgabh4Bte/Gyhj8qfVyCppsUCfeEiuwIz08Mt47wr8JY00TcctXK9FAgu0JzP+TY3xUT106jF9sYFjPobH5H1TIdkZnx7weMXUWnwO3w1txbruPdNQ18PYCo847wsEeD94k2rQIQQRKrxxEipL3vs+9M8hTYBvFPXAOlQy7nmxpEw;25:ZdbkI7TXhV/GE1qsIXn2ymaz/p/qtnAT9/dKkk3JO4RqutPSUuqayehZtEuuHaxyBnS+Qm5Oanzyp0U62L+7bCjI2qZP6Q/hbGXSbP6vaAtX84yWJtS8B/efbuj/gYQjKD7fRwN2ZHDkYR7cctorL6AnHY7euipBzF1QPWCjE2bgnh0JkYjerxt7RX7sHobPdNBBf2yek/2D8yyEuyzWOidrwVChrpbuqb9tXf10v5kFr0FuoyYPUe+vFrqmcWo6mWuWo0DKgvUzuhOnq3mnDaEJtqXR4KDAcfXLU0ujBeToxwT9/Sdt4oDZCYpYK5S2zAEWzCzuiVU3EhOKYL1XCQ==;31:XUQ6ReUom818rCqrhhxp+q2ly3eDk6k4fGN0OBp/d7FLUIhcccz2JGvGLeHEDUHapI3potSFHi+OwVYZ1rFjYrtIInsTPgZMnM6+rFxp8rVXpw5uonJHweA9UFylQx2Ci8DH5yBFYJctQDM8CfevYw+EziBCxiV85BAUSZPU7D2893qZRMpqgIGtD8gPcvKJRq6Qo9EpEyt7vxeVQwpsMHUOjtAD3MP1x9u4ak1U/As=
X-MS-TrafficTypeDiagnostic: BN6PR07MB3491:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3491;20:Kss072lUi2MkKpNiub9ET6bSinZwMkXjVnPLozmxO1X7BWBIkdkRt43pyqydYEz6wFPy7WPDmnAJFYtZHYyYPQ9W8I1096+ZgmTnjoorqhBMkel2CYzINZNwBnhY5TETuW2w6Z8SSKFRbia/DCZcSPLAvD2QW90pcqG5jM/YKePP26tsQJprcqQG0C831UTv4gr6ZKt3vBiwoS3ujlmrvGmoDY6PouvblTE0PiI4Zlcw3xWC24WeSlcXlyGhb4tkqn6MzA+w/N9XZ+E93ioafmkEJcEoWDa3Jw/k1fgjqcoTBnugg6+dq1LhQhA0FqXsg/DVFVtzdfasrBuy9s5xJlYeg/q6HugEedHunNyyOxCy5smNToa1cvuT+2Cayl/R0vxm/sul2MPEVDcUoiYjD59h8jjMny+w5GgT8iqVsCUz/T4YIG/otxhniOHGmPkGC6kn56vGIOSIRCDzKf2AVn0iYlRd4b2ZdEIK87bciQ8oBOzJ+3I5eof6ue9VPCZ4ot/ZTSMsz7sY2b1upkc8vsaUdXMMsI43hHYOeBDTCURCZT2Fv8brfNzZCxD58ArmOhOlhLpUXuFA8bETwyohwABAknCmCI7aRmmSytQvhDs=;4:l4OoAvV1oW/UnBTLlqiqUhSPISZ+S3BUxbaH2mbxfGbFR0kEfaDUIC+pEVVfjjdF0lwSIwcm/BgNCfDr9YanX7+yIFx8Y299wq7O5pWgP9quhXVJ7Mk4VEiNtCd9/vHk3jcN22JciW1fh93LyraRjWF9AFmT78oJc307XTlyZd9+HpHZbE+tg/UQUDxiaRmpb2D8T6D7ng4Zjuq7ub5rinL1G47IxKcwWMOnIB6NmszRNIhMQv6axva+RZyrJyPy
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <BN6PR07MB3491AFF382F316F9084B092B975E0@BN6PR07MB3491.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(100000703101)(100105400095)(3231020)(6041248)(20161123558100)(20161123555025)(20161123560025)(20161123564025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR07MB3491;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR07MB3491;
X-Forefront-PRVS: 04772EA191
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(199003)(189002)(5423002)(24454002)(377424004)(2906002)(81156014)(76176999)(4326008)(6486002)(31696002)(53546010)(93886005)(6246003)(31686004)(101416001)(8676002)(68736007)(66066001)(53936002)(47776003)(72206003)(478600001)(65956001)(97736004)(50466002)(23676003)(6506006)(58126008)(65806001)(105586002)(229853002)(6512007)(42882006)(5660300001)(106356001)(16526018)(25786009)(2950100002)(83506002)(50986999)(65826007)(189998001)(53416004)(69596002)(36756003)(305945005)(81166006)(316002)(54356999)(8936002)(230700001)(7736002)(6916009)(33646002)(64126003)(6116002)(3846002)(6666003)(67846002)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3491;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNDkxOzIzOndhRlkxc0JyQnJEYno0UXgyUjNUdU5zSVlx?=
 =?utf-8?B?azR5bFBWdkJLN0hzK2kydlkxamlkbllWd1UwTy9aaGpjRjNOZnRvZ2VpRGZT?=
 =?utf-8?B?TE9iWTIrSnV0cjYyYlE0aTBTbVc0OWpuODJGcnRYRzhia0xFOXpkSEE5ZmJ2?=
 =?utf-8?B?clM2em0zR2Q0UmpMeXZ4aVM2elgvUHRhclBSMWZTMnRPQjVRd01lYXJVRVY3?=
 =?utf-8?B?aW5NczNWSmlrTERBaEhnT09SR3czVWFhZGI1UG1ERTVQLzZ2ZG9HditSNjZX?=
 =?utf-8?B?MFZVL3pTaGF1Q1R1c1ZZemt4TFhCSitWWGVlRjl2RmZXOCs0MXhIZnJwRGFv?=
 =?utf-8?B?RHUzSitDMVVWSzBNNk9FQ0hwZFByZDFRMmlBWEQxdjFISkdSV2hWOUxQYmpP?=
 =?utf-8?B?dVFRd0VEUXdEeEswVDZsTWJEcXJmc0lvcDFVaUxKVXphMllhVWpkS0U5MHpT?=
 =?utf-8?B?QStOOXVKYlVleU9BT0ZqQnR0WVp2S2xKbTlvYWcvS2lGTm52RDJvM3p6N0Rj?=
 =?utf-8?B?UFhjbkFGaFpYODREa3lWbHJsRTJ1N1pYTEZNZ24yN01hY2laVjlZZ0MyVXdk?=
 =?utf-8?B?R2xKVDNFa3dtRVNBQWl4VkRTcW5SOWlZZzRzWk9rL1NuNjIxWXBpVXppWDV0?=
 =?utf-8?B?NTJPVUlrQ0haQ3duemVrRCtubGh0M2lMckU4eEdta0o5dW0ySkVETzlNTXhy?=
 =?utf-8?B?MjBpSDYxVVpDQm1HVmsvRlFCTXhaQlc1ek93aTlGQ1FHN1VFM0FjS2owZmFN?=
 =?utf-8?B?RElDTmtRNEdxR0tJbUh3c2Zxam44ZlYwY2tJeHBHaDRNNDh0Z05GTDgrejdT?=
 =?utf-8?B?TDZxSkNWKzF4amwxWmZIYXBnckkvbU5UeFNjQ0l5NEJwdCt6RHFyaEZEQlY1?=
 =?utf-8?B?VkRhWFRNMkRZcWtyQldBMWVQU1B2Y05ITlVsOUxpM01wbUVKaDRjQlRPbjY4?=
 =?utf-8?B?aERRSzJGNEVXOGp2WjdjK3lvSkZMakF5V0VNYUtNblJTa1U3b0E2d3NvYmVE?=
 =?utf-8?B?NnEveUNTbGN4R1lDZVVUdHVtMUc2aWFzb2ZRU3dpS1doLzlqRDBPaUVrZlFI?=
 =?utf-8?B?UEdhNkdoU1BHcW5vanFHYVFBeWdJRlNjeFhRbUI5c3hQQklvZmRDVlFTdndi?=
 =?utf-8?B?VktLdmhDNWw2YUpOUDdWSVNEMFIwbFFYbUd6QStKWDZ5RDZ1cXIrNXM4WU05?=
 =?utf-8?B?SDhrUGo0K21mb3cyT0tTN01KNEhoWjVZZy9WejVMdEVBVW9SU0lQK0szeEY1?=
 =?utf-8?B?L1NPeG05cmRsYVZ0bW92VFpGaUJ2NnI1dzBLMTF4VXcwaW85eXZ0WmQ5RGNZ?=
 =?utf-8?B?Nk45czQ0MXdWSzBnaVp6TkEwNEZkd2h3bXVXYzJRblBITFVmVmVNMkRta1pm?=
 =?utf-8?B?cm9PM2dHQTRKVGVhRU1aZHpHWUlUdXRqWktmY0RPTmpuaS9FUitKV1VBY1Ny?=
 =?utf-8?B?cTdLRlM3NThlNFFBT0JiQlpLTDMvRTF1THNFTzdCRGxhOEVQTUZBZ0dvOTBn?=
 =?utf-8?B?VWhVMXhPSDIycG5vNGZkS09IM3JESVN6U24vVjB3MVRYM3loWlhEOW5QcDVx?=
 =?utf-8?B?OXc4OGVMRmhXUlcvQStsVmEvN1RVSmZmYW4vb1IycnBOOWgvUW1uU2tuWTlG?=
 =?utf-8?B?V2dmWHJBdlVaSnc4VUdyQUViclgrYXdCK0UyOTFLa3BLSzlWQ1ZPdjR5dnQ4?=
 =?utf-8?B?R29ha3RmTUUzMi93VmtlOW1rRkJPOHNUdUNIQkQ5SElRM1d3UkNQMjUrQVVH?=
 =?utf-8?B?RFI2cTNicHZLZDNsemlnWU5ET2FQOVVzazFvQzk4dUlkUEMrR05SWTlCemN0?=
 =?utf-8?B?S0hlL0hnT1lpQ3ZkMXpaL2hXWStXbzNRQWhtTWh1czZQcDdjek1ORVdVazAw?=
 =?utf-8?B?a1I5K0VYTEpLN05JTVFrWVg1ajlRWEV3VjZDQ1BoWElTbVV0ZmJrUDkwZDND?=
 =?utf-8?B?Q29KSGJrZEJmcVZjNHg2VWdaSnFsVTRxQ1M1QUgzMVBvQzBaUmJpZWlUZ3Rw?=
 =?utf-8?Q?RtKJz8?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3491;6:ReGt03Y5ktvrqA2sYZI9FgfyZAsl4YH8pzWJJUw1aGFX61/xruzooDDT1XvkkdialFcfAUtse9cuYCKO0yNxsri193nmkaMmwLIRieITvAxNJf+2sM9pmaCB1l6gGvA/WupBBo2YkZmXqn80+0PUED9oyTSs0omS2CVc12Bj6otu3ou1hV4NWf35u7Y/v9h9EgcHg3UHfLHT6R5gz5v0gbxxn/3+Gux5GDVh9MwlUBSyL9kTfERQzuICzmQnTKAIW1FDMNL9tXPqudt3NWr3NCxBLDFgcWdmLlJLjS9LFaTIQITjp8qDRaSDk4MzbJONb3sNhxGkamXeRpXk9zgiNg==;5:+HdKBIylcecYFo+2R9yWVKlWx8jRPzs2lqmwp9COuldLMetf3wQcYzy6h0TflfbzQF8hE2G6FUmOBkoDqlKNQRP6wtAvFzR9sedHLmCcbqS9r5ldkdRLVixH3iYeiCnx4/9r8gQ6m78dyRXBX/eaQg==;24:qGcVCpA/RezGcnvY8WL+lzmvp7DYkWZVEtGajXkgVIiONM2SDAdag/cJBh11giUIbLhL8u8o5j0XsfoIKVRtnhf5U5e6pKxOV8hYtX8snWQ=;7:oKp5R/hM1iOTXZJIuBnV17XvLYlcPsREKulXjixmhY8i8dH+H74I0ZoSPm3P+l74z+v2qEIoqM3YF4nUr6t6WA3uvuPiZNzalmuapTFdzRI4ywBStBUMfxKTj1QAxUIlQvQ24J7Cg3IjYPjtlteJ0LwHWMrgbY/PmOJO69rhkQMh7oG47AN4MM9RqiSVd355v3g2gdUzHziY2hQHQvHlcJ2X5/2RygYhLeMTTe/awBw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2017 21:56:00.1662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685d7300-574b-41cb-473d-08d520aa2c90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3491
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60620
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

On 10/31/2017 02:31 PM, Gabriel Kuri wrote:
>> What board it it?
> 
> It's an old Aruba AP-125 wireless access point. We have decommissioned
> hundreds of these APs and I'd like to integrate them in to a
> University course on embedded operating systems to make use of them.


Interesting.  It sounds like a fun project.

> 
>> Why not show the entire logs we could know what you are doing in u-boot?
> 
> Here you go ...
> 
> APBoot 1.0.8.3 (build 20343)
> Built: 2008-12-27 at 17:03:46
> 
> Model: AP-12x
> CPU:   OCTEON CN50XX-SCP revision: 1
> Clock: 500 MHz, DDR clock: 333 MHz (666 Mhz data rate)
> Power: POE
> POST1: passed
> POST2: passed
> DRAM:  64 MB
> Flash: 16 MB
> Clear: done
> BIST:  passed
> PCI:   PCI 32-bit; scanning bus 0 ...
>         dev fn venID devID class  rev    MBAR0    MBAR1    MBAR2    MBAR3
>         03  00  168c  ff1d 00002   01 80000000 00000000 00000000 00000000
>         04  00  168c  ff1d 00002   01 80010000 00000000 00000000 00000000
> Net:   en0, en1
> Radio: ar9160#0, ar9160#1
> apboot> bootoct bed00000 mem=0 console=ttyS0,9600

Try:

   >  bootoctlinux $(loadaddr) endbootargs mem=0 console=ttyS0,9600


When booting Octeon Linux, it is important to use the bootoctlinux command.


> argv[2]: mem=0
> argv[3]: console=ttyS0,9600
> ELF file is 64 bit
> Allocated memory for ELF segment: addr: 0x1100000, size 0x2628a48
> Loading .text @ 0x81100000 (0x35ca1c bytes)
> Loading __ex_table @ 0x8145ca20 (0x57c0 bytes)
> Loading .rodata @ 0x81463000 (0xca880 bytes)
> Loading .pci_fixup @ 0x8152d880 (0x1db8 bytes)
> Loading __ksymtab @ 0x8152f638 (0xbdd0 bytes)
> Loading __ksymtab_gpl @ 0x8153b408 (0x6710 bytes)
> Loading __ksymtab_strings @ 0x81541b18 (0x14cfd bytes)
> Loading __param @ 0x81556818 (0x988 bytes)
> Clearing __modver @ 0x815571a0 (0xe60 bytes)
> Loading .data @ 0x81558000 (0x3bbd8 bytes)
> Loading .data..page_aligned @ 0x81594000 (0x4000 bytes)
> Loading .init.text @ 0x81598000 (0x278b4 bytes)
> Loading .init.data @ 0x815bf8c0 (0x12390 bytes)
> Loading .data..percpu @ 0x815d2000 (0x3eb0 bytes)
> Clearing .bss @ 0x816e0000 (0x2048a48 bytes)
> ## Loading OS kernel with entry point: 0x81107920 ...
> Bootloader: Done loading app on coremask: 0x1
> [    0.000000] Linux version 4.4.92 (gkuri@galileo) (gcc version 5.4.0
> (LEDE GCC 5.4.0 r3560-79f57e4227
> [    0.000000] CVMSEG size: 2 cache lines (256 bytes)
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 000d0601 (Cavium Octeon+)
> [    0.000000] Checking for the multiply/shift bug... no.
> [    0.000000] Checking for the daddiu bug... no.
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 0000000000800000 @ 0000000003800000 (usable)
> [    0.000000]  memory: 0000000002628a48 @ 0000000001100000 (usable)
> [    0.000000] Wasting 243712 bytes for tracking 4352 unused pages
> [    0.000000] Using internal Device Tree.
> [    0.000000] bootmem alloc of 8388608 bytes failed!
> [    0.000000] Kernel panic - not syncing: Out of memory
> [    0.000000] Rebooting in 1 seconds..
> 
> 
>> Archaic version of u-boot being used...
> 
> Yeah, it's Aruba's old version of U-Boot, which they have called
> "APBoot". I was trying to avoid compiling a new version of U-Boot for
> these boards.
> 

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 01:02:22 +0100 (CET)
Received: from mail-sn1nam01on0073.outbound.protection.outlook.com ([104.47.32.73]:22336
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991940AbdKAACPrV6RU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Nov 2017 01:02:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6KZnFxxhY44wlE5ygA6DzekLVoAKJ80KHfNCJPJk8fM=;
 b=B+j+BIAJ8cOVofMhnB3DoVMvwR8OpwfWbpsmjqCbVhowgEc7F+O4TYnyesZi/mA9WvQ/egqki8/WiC5WwqpFvdSvLa1XJpVq2aSo+t28pfrPyV3vb48jtAlS6uhgUTWCB7bER5T+LiLn4+IyPhF/cLQ37PIZ7dmj0k/CQbve8ok=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Wed, 1 Nov 2017 00:02:04 +0000
Subject: Re: Octeon CN5010 - Kernel 4.4.92
To:     Gabriel Kuri <gkuri@ieee.org>
Cc:     linux-mips@linux-mips.org
References: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
 <3d272dc1-4012-c7ed-7c34-876265afb25e@caviumnetworks.com>
 <CAO3KpR1VGFYdY-Mxb+Xx6yzKhzXAycizEm_7f9LT5GdXcLbkDQ@mail.gmail.com>
 <c726a4ab-632a-0788-1147-c3de26ab6b75@caviumnetworks.com>
 <CAO3KpR2oYGY89utWTpwd0+hzXQ8xJCsNpxLaX7fxV6hWiFbtNQ@mail.gmail.com>
 <148da245-c31e-03e9-3d19-f7d125507b96@caviumnetworks.com>
 <CAO3KpR1MRHr=1_2g=UT3P8Jq1fEA3XbEf=-rA6nk4mBHdU5CDg@mail.gmail.com>
 <CAO3KpR0N_ySTUgjuj=0_2gaobTv1AoixKwbACUNNwbrggACYbw@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <5df3f426-8aaa-0cfa-1560-c96288376e0d@caviumnetworks.com>
Date:   Tue, 31 Oct 2017 17:02:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAO3KpR0N_ySTUgjuj=0_2gaobTv1AoixKwbACUNNwbrggACYbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0059.namprd07.prod.outlook.com (10.174.192.27) To
 MWHPR07MB3502.namprd07.prod.outlook.com (10.164.192.29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eca5dab2-a5c5-45bf-6d27-08d520bbc932
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:MWHPR07MB3502;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3502;3:wMl4LEa5AzooYy7juoP5TNaodbH29cUsuA9mh8DWRSu3TqqzMD+yexsiEsAnti3OCHp6uvCjAu7j8RJeVAKJkfkgpJbg1AXatGHs9i0Y1zpXm3NxdB4p/poDQrjjBmvwwcJ3eRt7hH1eeAnd/n+aRJzXTzBK4bzxpJ+WOZczkuPDihXx7wZvmI1VFlfJ79Y9eyfxj7So6sX3rIif6bdAOoQ8x1YKLw4SwdlDkTDiIl/iFddlzulSm9RP0qxD4yCi;25:Gj+xBJe9NKM07b8egLxPyTRJ9R++X5MlH4w5qt1vvbN1bAWxiOV98PE5vXbTzqWrOFB25h8nwLlIqYNrURD+nIYRPAHEIGqgXgyypKDzwRod7p1RiDF00b8McKggTyQG5h8NxcOLrvc6MKo6lNKty0KP4eLTxou7CUvoCu9HNk8UwjKAGr0FmAJ6H5WT3LiHOLGrIk+I0LVlv33/XULFfgjCRD69SIGDHgohL1SFGqNHpYcZKsMuYYC+oGekmFt2MBzBwNHFDo/qZBoOmphaK6qKKHI8zlMF8bosaPN00UBkyRat0nVict4BnBEroaPuMnLd5Hn3p4qJOrsQ97GjSg==;31:hPUHVSb1CoDkJ4VkebZrR5FaBuM+jeiNhv2ymEQwG4ZFn3Tha15/P+nZgYFtGbh6ZGp8sk5cQduP7dt81UI4V816QBH2ol0TORTRpNIotYPP88hJexDnp1BfM9TZggLXB7ZzA10tvK6h4BQtj4ZtnbWXSMtaj2Xj/HNy5Lo0iVwlIdOKEvWaxDSq53717kIaZSAu8BXhDaDqJYYFu4CsZybItWvXV9x9oBx4m6RS0As=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3502:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3502;20:HQAWjj/Ap/MULd4K1P2maEc12oKQetoHamHQ2q5s5fHXjlQQoLBMuTMPWDcnqpYu2H4k/rt/SxdEkKcG4H1YJpaTibKatvV3B7T1HPFFOZFYwYhgMJyqd9rkfAYBABMa6+yt91t18thw0VYvWufgytWS/drPeMAa7ldiKyaB8uxEJI99J3TKo08WiMe90rf003p51MokFPtxlSlit69CIdACXWfJ3pb/sCHUMgwN35x4wpfXuc0ixtOkbAVeV41TJMewpIQ1iOU+p29rm68zKCn85NCt86IbkUIliVU2k36MVOqKl5gaftumOYL4JG2uk4sxXQeMtzZGkRAGuyLLl0er+Wde8fjOyXLL5W8Q/te6mr7Gm/XgRXoPaa0IKPUgTg0WQIL5qYi9WiqdJXHuwDnaBRyM03c76Mo+EgPtcz7RvfZeMBPYcvN8yUaDOssvFDBcCnhmUeyrS5xFT/DOoSNNcEy3x4TFV8OM6Oz6FTCbUqFPbBRddHK3HsqJm/XpW7swF3p6jpXAunmuwnTS3vtfvQwEXtLbf3tmCDaSm+9f8GgBZz+uKWD10djXWj4cXyqEYwFI/Kst+R6klN3cpG5VmzaxYxR03mUHqEiYcrU=;4:4zbaSkBx2GoIjwi4FD0/UJqClTGvXMkWYqGPjLtf6O7tGtFh4KkX66Hi/ugwEaATAfHdghnTYYziL4iYogS4EsVvU7Y4n9QZmZ8xIeo1MjJMfZ8ZLKWsGepsguXqVhUpzMIFQoXdqSrx0uE8VduvCZcvzvuUZ07p37Zxct3Zv0xuJ5qZWk9dLRrpNEkSN43vYAtKCr6uivedCCYlC1117fltbQNJ0zuL1DnnvLBb2I5Jb+nevzlcmQHmJgd1/J9+Y2lP6A84JMbvBcum41FRfg==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <MWHPR07MB35021F1D2837CB2B68136D22975F0@MWHPR07MB3502.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(3231020)(10201501046)(93006095)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123564025)(20161123555025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3502;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3502;
X-Forefront-PRVS: 0478C23FE0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(5423002)(189002)(199003)(24454002)(53936002)(33646002)(2906002)(31696002)(58126008)(105586002)(106356001)(3846002)(6116002)(101416001)(50986999)(81156014)(189998001)(8936002)(36756003)(25786009)(76176999)(54356999)(68736007)(81166006)(65826007)(97736004)(6512007)(5660300001)(8676002)(23676003)(47776003)(53546010)(65806001)(65956001)(66066001)(69596002)(50466002)(67846002)(16526018)(72206003)(42882006)(4326008)(6506006)(93886005)(478600001)(31686004)(2950100002)(6916009)(64126003)(230700001)(229853002)(6246003)(83506002)(6486002)(7736002)(53416004)(316002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3502;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAyOzIzOmx6dHdGZkphaWNtWDhJVXFVTmVJa00xL1dH?=
 =?utf-8?B?VmY2MWNxK3JNb3NzeTVTeGs4TjBKWm1YdnFsOXN3azMrVThvVDVnUVNyVkRW?=
 =?utf-8?B?MmEyd2h4KzVGNUFoTWdIL3IxNk1NN0hQaHFOZ1QyQmQ2bk81amx2bHh0V1Bv?=
 =?utf-8?B?WFNzK2pETHlkUTROWk1IS3BzYzRnVnN3aHV6UExHOG1RWG5QbEp6ZFg1Tjc0?=
 =?utf-8?B?TU9HNGlaOUlkK2dFMHJXMjN5bTlpR0xUbVR3aUl4L0doclR1QzRvMHZqSUJv?=
 =?utf-8?B?SW8yTVpYcnhucVRwZnhNMEFyVnRkNnN6cVErTi81U2orSmJMWEJURDdZSUhx?=
 =?utf-8?B?Mmp1czRqWXRaZHJLRU1yeTg1Y04vaS92SkFnS3FvcnVlUzNpc2pwYldXNzZI?=
 =?utf-8?B?Uk9XMlduMXdldkdIR2c2cTE4STc1a1BEMUxTV1Qyenl3L05NbTE4VGFlc3Fq?=
 =?utf-8?B?aXp0NnI5L2Z6c2RYOUxsNnl2bXl5WDdrcmhLSi9NRFVtWGx6NlY3UUQ5M1ZJ?=
 =?utf-8?B?a0RwemNsMHg3dW5xREVRN3FvaGZHdjNqVngrY2EvNHFHdzFDT1cyS1BlVnBK?=
 =?utf-8?B?NGhJaTZQVnNFUS80Zkpoc2tHNDM3MnlpYkhJcFBXc0dBT3ZjOEREdHRqMDlv?=
 =?utf-8?B?c2lqUDdLWVZsdHFxV3ZNTlVabW1kNjRIdmNGRWljMFJBTzlUMVQzTFhCeEpm?=
 =?utf-8?B?b21rcFpaOEVOZXphcXVsbzdHZUlrZUlJSUVKdFFYOGtPUnpxZDkzaHhqME5p?=
 =?utf-8?B?czMwaDR2Vk9QYzl5eHZXZVRyc25NMHdFSmg0dTJ0NkR3dkwyNmw1QzZtYkx4?=
 =?utf-8?B?eTl0OEwyWkE0eGNUb0dUUklkc3FKc3VHSTREMWNaUUlPWlVGOC9XUGluSitt?=
 =?utf-8?B?dGgxdmZmblJHZXNTWTJ1dENHVGtyZENoWEJhOUcyMVdYSG9aOVVlSThrbENB?=
 =?utf-8?B?cU11K3k1S3RhZWYyZjh1Qm9BdUptQ3d4RU0xd2YyK1l2UUJYcnNuaEVtcDNv?=
 =?utf-8?B?M3pFamJScExLRldEK0YzSXZ4SG1oVXFrL25JbUtaV09hU3JTM0hQNVBvRnRk?=
 =?utf-8?B?aWdyS0VvdndVeVpuQmMzczJoV0tZZ2JjKzFVMlUydCtOR2p0b0dTUm8xM2lW?=
 =?utf-8?B?Z0JFM2NDQ0E5bkN1Y0VVRUxTUXpuTklXNkNSUkhaRHlXcWhCcW1nVGp0YTUv?=
 =?utf-8?B?TXRxL3lSMU9JSzNQM3R0TUc2cnVjOXNTU1p2OXBFN0l1bThzdFRPakc3amVC?=
 =?utf-8?B?cXBrMDQzQVBPeDdsR3NrUWszK2M2di9pOUVMdjJhTGdrakRqRHQrekR3VjdT?=
 =?utf-8?B?a3orWTVGOHRyZVZkMGVvQUhLVjFFR0p5MUZ5MStGMlBqdTR1Uk5GeUZheGY2?=
 =?utf-8?B?ZlZYOWQveUx0WTNPTnJWcHlUTHBjdkdoajRPdmM4YzNod1ZDb1lxbDZYUGFT?=
 =?utf-8?B?THl1NjFBRlZxZkd2aXFIMGZDclJ4bnVncSs5TWFTSmxRbXdMWmZOUWovVTVx?=
 =?utf-8?B?Q2lMVHJLNy9Dcm1PYVBqYkxRbXRxMXlLb0hkcGxYeGVlYjV0REFzNkQ3QWc4?=
 =?utf-8?B?bVJnL2RDTU9ZYS9jQ0c2REVVbVRvVXdUNk9QWEJFczlhRnB6R291U3pyMmc0?=
 =?utf-8?B?cmQ2NE9IbkxhU0xEc3lTMi9BZjF0QjV6bE1RMmdZN3Fyb09GRmIyL01LckJE?=
 =?utf-8?B?TC9KcmRlQkIrWWRuVmdhdGtubWduREVrSCt6RlBVblY3THZpUmUyK3ZES08v?=
 =?utf-8?B?VHBFaWVXN3ZpK3JKbS9pampmeXd5WnAxVDIzcGoyMnJMSVZWSlFpQlF5WlMy?=
 =?utf-8?B?WXgwc0toczFXVXZvcXN5UnQzRlVpNEUwS2w0RStUbXBOZEJ0d3cvaWk5Yms5?=
 =?utf-8?Q?+mP00DJAM7yFnqCNI+GWlCZOWF6Pvzqy?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3502;6:up56yPkCt5VdA+LbqDGNA5Rwl1WUOL5fUBKLZ4bCjCpulLguZffozNAGf1CYUZIA/MF+RXmYlw0Vj8WldNGdW1yvHnvymPHDAcdgKbC0djwyCjukR/zk9aNKA3HgauqriJWefCR4h0iMCIwxpTU0aedIUVi+e1NqsLX5BsTZegA9/iJ9NR/b0I9JowSM1NwJ5zUaHM2CrAv04q5a0rDu91KL55G291aX41J5JmemxmP32SHgx4+9057nAY/0AXVeKX066OQZ8IM/THNQFdZm/gi1MTY4sG0R0cCp/8Z4TSBssZdXrSBmiVYzyM8kcgzFG+eLmKbwE790gf4/2ZufIF3Dewif0mrKZMs1uxdHvIs=;5:ElF8pzzYtHOjAnrUxZaZgLnJRJ1XWh7k500aGgiWg1g8LuCePmaOjNK6Hg2N6w6S2QrGcOkg20fZ2hTX4qlQY67feE/U//WKhZU8UIYOyHL2CTZQEp+qfwOwErUGZC34YboM2u/v3GRlH4vKU+uFaQeLso6JwAoOMgmk8DdFeGg=;24:2t833k2mWGkEX+LOjcbe/yXKbM0fMmWnrVF15n8u3PsoWDFayfIRx1ZHfW7oepNbNRNnvrlwfeFWrXT28O/IkUtvxup76A/gC+KpN3xReQU=;7:hNKJlbquhKToYJA8jXBJGY9uZwa9qH4XDlXnmn/J0NKSX8kduNFLw09gc05w4kLtCeQ0U3dwLC9V98ivMDAHnb9DXltvXUWlZMqEIVP0+0ldDgNQW78sUZ/4IIvIjv3hQfAx2bhKHvgDXqaEeIBPERAcOQ9nbymjOFf2FAHyDFriklzWYxEJGLFa1RBD0utOv4pLZgoNoVXXKfE3RjikI1tTxbWUF02O5J+HUaPsBwuQZs11vYeWCS2th2JKo7oV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2017 00:02:04.6947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca5dab2-a5c5-45bf-6d27-08d520bbc932
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3502
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60627
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

On 10/31/2017 04:42 PM, Gabriel Kuri wrote:
>>> When booting Octeon Linux, it is important to use the bootoctlinux command.
>>
>> I had to hard code the command line before compiling the kernel, it
>> wouldn't take the argument in their U-Boot.
>>
>> But now it panics saying "Incorrect memory mapping". See below.
>>
>> It seems it thinks it has 0 RAM at location 0x0 according to the output below.
>>
>> Is there anyway to tell it via the command line to use 64M @ 0x0 ?
> 
> When mem=0 didn't work, I figured out I could give it mem=64M@0 and
> now it thinks it has 64M of RAM, but it's still stuck only using 20MB
> of RAM out of the 64M, which goes back to my original issue of the
> kernel memory map being messed up?
> 

Octeon memory allocation doesn't work like most other Linux.  And, 
neither does the  built-in command line.

I would recommend looking at arch/mips/cavium-octeon/setup.c (prom_init)


You might try a local patch to force max_memory to a value larger than 
the amount of memory physically present on the board.  That should cause 
it to attempt to allocate all memory that was not reserved for other 
purposes by the bootloader.

> 
> [    0.000000] Determined physical RAM map:
> [    0.000000]  memory: 0000000001800000 @ 0000000002800000 (usable)
> [    0.000000]  memory: 00000000016186c8 @ 0000000001100000 (usable)
> [    0.000000] User-defined physical RAM map:
> [    0.000000]  memory: 0000000004000000 @ 0000000000000000 (usable)
> [    0.000000] Using internal Device Tree.
> [    0.000000] software IO TLB [mem 0x02724000-0x02764000] (0MB)
> mapped at [8000000002724000-800000000]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000efffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000003ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000003ffffff]
> [    0.000000] Primary instruction cache 32kB, virtually tagged, 4
> way, 64 sets, linesize 128 bytes.
> [    0.000000] Primary data cache 16kB, 64-way, 2 sets, linesize 128 bytes.
> [    0.000000] PERCPU: Embedded 13 pages/cpu @8000000002771000 s16048
> r8192 d29008 u53248
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total pages: 16160
> [    0.000000] Kernel command line:  bootoctlinux bed00000
> console=ttyS0,9600 mtdparts=phys_mapped_fla0
> [    0.000000] PID hash table entries: 256 (order: -1, 2048 bytes)
> [    0.000000] Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.000000] Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] Memory: 21392K/65536K available (3384K kernel code,
> 264K rwdata, 968K rodata, 1312K ini)
> 
> 
> 
> # cat /proc/iomem
> 00000000-03ffffff : System RAM
>    01100000-0144e613 : Kernel code
>    0144e614-01587fff : Kernel data
> 1f400000-1fbfffff : 1f400000.nor
> 1070000000800-10700000008ff : /soc@0/gpio-controller@1070000000800
> 1180000000800-118000000083f : serial
> 1180000000c00-1180000000c3f : serial
> 1180000001000-11800000011ff : /soc@0/i2c@1180000001000
> 1180000001800-118000000183f : /soc@0/mdio@1180000001800
> 1180040000000-118004000000f : octeon_rng
> 11b00f0000000-11b0130000000 : Octeon PCI MEM
>    11b00f0000000-11b00f000ffff : 0000:00:03.0
>    11b00f0010000-11b00f001ffff : 0000:00:04.0
> 1400000000000-1400000000007 : octeon_rng
> 

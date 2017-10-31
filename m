Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 21:21:41 +0100 (CET)
Received: from mail-sn1nam02on0075.outbound.protection.outlook.com ([104.47.36.75]:14593
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992312AbdJaUVeSKxkA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Oct 2017 21:21:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rXTV12uDirS3lQ6Y6XeheoelXUMNKktkM3wwG1Wh3lc=;
 b=gL0fJDPqT9qyqwwpmHwNLE/9iqaCEbFX0L3CGKR3canXTrkwWPFnxq9Odt/zgr7BAFcwJM5SMJaNObUQlf9gJ8Swkc4jc5rqm7Ssp5ysEMAhDy6ByIXGSkY9rXK+v4RVv5izcwewDn2pARXgKuvQv3sGL1fPigC/mBZ4pZ0p4d8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Tue, 31 Oct 2017 20:21:19 +0000
Subject: Re: Octeon CN5010 - Kernel 4.4.92
To:     Gabriel Kuri <gkuri@ieee.org>
Cc:     linux-mips@linux-mips.org
References: <CAO3KpR3+j86m_Bbq=C0Ws4jR3RHO9oq0Gdkq60JP4szqNKcosQ@mail.gmail.com>
 <3d272dc1-4012-c7ed-7c34-876265afb25e@caviumnetworks.com>
 <CAO3KpR1VGFYdY-Mxb+Xx6yzKhzXAycizEm_7f9LT5GdXcLbkDQ@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <c726a4ab-632a-0788-1147-c3de26ab6b75@caviumnetworks.com>
Date:   Tue, 31 Oct 2017 13:21:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAO3KpR1VGFYdY-Mxb+Xx6yzKhzXAycizEm_7f9LT5GdXcLbkDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0073.namprd07.prod.outlook.com (10.174.192.41) To
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a5a7c1d-21ea-46f2-9cee-08d5209cf2c8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;3:EbwSRNZUtMFh3XT9P8UCu4UQvyljTGyr1+eSGDS5nx8WY/iL+ngdz49DVW6V+2x6amLjzSpMICZH+YD34o4YKxRwKnkZpwLUvMHrOHlxTBTNint0gOVAZ0AlCl/0i5cmgWi2g5Bf8gtlUp2YRuDKN02LpKQs5rrF5m7soPVUYAdOKQy6Fcg1wgTCR6rHk+fBXlN4cXNHBxuvklGSjb9P9ay/apH19LAWwff3f4hiP8WEeONq5hgegcruxmmwOmd6;25:nTOOhEIMgx3dapVTW93x4O8URHPJ74PMo+RAmGvV91NkboI9X8wmaRAfM7C53dJ94XdQAGgF0MOBU1SjRi9DtzgXmy3k2OYO2r7OCiE4x9SMtsFBI9Cmn35d/QpEHTKxYK5TnxdloaFUUxzTdrHuDNScpp92YgHgQusIEID+k7XkVmEk5bkUjxWLFKJB91SUrs0wYlpQjncihW8V8dFHyxShgGe+yGlWS0ExwoIQJ6e1EZYj2WHsvIowjevmtB4fNi7BixpGAez2xMtOkTwdRojP6GPMR0eHQJED1154dTDdjsKB9owI13OmVCCkqBUqobxKEUNW9kF6BS9opZ7qOA==;31:js/PStcdfg9kizyYvhdATU34o5sjKU0y11EROSw0CGnIyDEjSOXI0MD452Y5O5euhXTSpo9BKRyvBWdLGuVs+KE6DLcUk+7owHF9zavuZaJmvBEjMGUsJoDC+DE7rDWXElxvlAKJXVmS/SJvpZwtd4ixYr7iCps5zpWBixsLOaxxzw9ue+ltjt7Iiq59OplsvGCmYoqePBaGLo/oVMDNmo8fMnbhnr6x8xXFHSL6kHU=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3500:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;20:Sn9n3CyJxFi67yLMgdLxlyyOTYahaJoi4yh6BwwlPQcOLo3YTSUDNcFMeDceb6x7YO7T2ZoGxSzdBXIo5F0lNF/YZthocD7Mu0Sfbgav+XQzcj2BwShmvoAgBxRyhlcf1GErMCUKSBIHOrJs0INvf8b/HEV0iTfnDTthjgB82Ffl5bMmwVl+och1PSEIpgdOceV/RLZ5bCWwqI6abgyG2/ZmGm5MJaGpOGtB0CysW+yuF1nZV1JKN5C7ypo01rd9Bzc5u/IRpae2hFpYtmOTDiIA9bV8NJsaHDSr+aEjgEWU2pt/Y7zAVv4LJxHnfv3mGwFoo3ZhDAEjlVcHYudCC7TP8dywdzKSkxkuobiJBFmGwgAHNE+KUpUbCcELvKBvStu/LUY3dWFjP+LbV+h53CXZV1/rZiQFuIMLWYz07KOtw1W0nIhZ4+9dmPcsf3nNNbLjdR+TEssEvuABkHOxUI3RS7RuW6KOEK/pKeHOPmhpIAXaLD4C1r9h7vgP//I0jrKlYgbKSZowYXGyD5/UitdZoENN3qodizg1CqRpQcGx6Qvh9Ug8+VMnHaXC3xYpwtioddrvdy80iIpQZPsuIu63rlpmc27Qrvxh7/CHOL8=;4:eFobABCfbXsZIUDG/hGQ9HxTzFSpE09pkn28G4JiLJNJ2SuhQaic7su2K6Uj6+ff/fVVMHpV98crUbXOXfsX+SQRvHuRqlpXL0Ngo/KuNQQ8YPsC0pc4ILuUfpj2/n8q6hgdPjka30NEnZMsXAOPy34Zp39q9Bu+TDJk8G7i5XYgXXcEU+Rh9thJpxip9Q6BeCcNN2TPAP/cbO4DJZTdGeer/v+dY89FTTb+GqwG5zMvh8/0Z6LG1syIePFgJCMT5TqPNM2Vip/B2IaPRs12cw==
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <DM5PR07MB3500B59B4FC9D61E62D7D7B6975E0@DM5PR07MB3500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231020)(10201501046)(100000703101)(100105400095)(6041248)(20161123558100)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(20161123562025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DM5PR07MB3500;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DM5PR07MB3500;
X-Forefront-PRVS: 04772EA191
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(189002)(57704003)(5423002)(199003)(24454002)(6116002)(6512007)(316002)(305945005)(53936002)(478600001)(65956001)(81166006)(2906002)(64126003)(50466002)(65806001)(6246003)(81156014)(53416004)(67846002)(4326008)(50986999)(68736007)(97736004)(54356999)(7736002)(76176999)(69596002)(31686004)(189998001)(8676002)(53546010)(47776003)(36756003)(6666003)(16526018)(25786009)(72206003)(3846002)(31696002)(229853002)(105586002)(6486002)(8936002)(106356001)(101416001)(23676003)(58126008)(83506002)(33646002)(6506006)(66066001)(230700001)(65826007)(5660300001)(2950100002)(6916009)(42882006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3500;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNTAwOzIzOlVtei9BU0hGUUZpU21EVndVM1ZHUTl3dzJu?=
 =?utf-8?B?WWZhbzNkaVRQTzcrNjV0d0g5QnhrVXo1VFFRc1ltZXNXcWhLaDNSalRRcllD?=
 =?utf-8?B?TGFOanhqYkpFWStQd2lidElqNEFDS1dMbWlzZUdoaXNiVHZjZmlaaDJqOXEx?=
 =?utf-8?B?eVRrUit5Y29vbzNvMHU5a3pDbndKdHVCQkJ6UVhmenFqOXlRaitPRFNYVTNH?=
 =?utf-8?B?VGFwSDBTMUJCU1lWNVY3UmFWMnRBaUdBcTUraDlmS1JkSC9QWDRFRnE5b1Fk?=
 =?utf-8?B?U0ZrZStvbDE5VklBOW9wRFJ4WmRPd21JQjV6L1JBTUhOT2lUL1J2ZVM1cjhP?=
 =?utf-8?B?RWVCTUd5WWhaUEk0d0NYTEN4Qk5kVlBuVjUxai9WNmZ5UHlsaFBEbVdUOWtE?=
 =?utf-8?B?YkJrSlpBWTJpVi8rdDF1VnlmZjZxZFJoZlZJSjhNWHpWVlU4Y1YrVDVRNGtH?=
 =?utf-8?B?WXR4b3Z2eFd2QVZCYXp5SzNKeTJlN3EveENTQUx5amF1TkpFeGN3Sit4WHNU?=
 =?utf-8?B?aVgvcmI5ZlR3c0dCcjJlWnJGMnVsTm9COUthQ3lWdzlqVEZxaEhTWWx3Tzla?=
 =?utf-8?B?K3NMN0JkOFN1QmJ0TTJLeWowOVZRQTR1eDQwZWZpcUMwai9KQ3VxSlY3am4r?=
 =?utf-8?B?WU1HWitiZzVUNTJrTnk4ckhuUjQrdzdmcGU5TWZocld2cHF2Vk5PMy91TGds?=
 =?utf-8?B?K2tNRTl5bDVvaUJENFJCeTRBOXdudXB1cDc0UXFaUWQvLzJPT1dqSXhmNmJQ?=
 =?utf-8?B?VFc4MjlOVmowQUhSNFJaendRc0Nna0V1Q0EvMkhvV3F5UHlkczF2VHZPcW51?=
 =?utf-8?B?ek1kTS9CaW9GeWh1VUUyVzY0S1ZTQUN1UG9IUnk5YzVqeTE2aFZIRG1yL1kw?=
 =?utf-8?B?bm1TVXpEWjlkM2l5dGtqUFJnOGcvdmYrWUxTYUd6aVV0YWs4VG1Mdit3OVdl?=
 =?utf-8?B?eURJOGJ5M2hWVi9Qa2VTaEtDbStNdjVScTI1enZmZXZWWGVkY3ZRRWp6a2tS?=
 =?utf-8?B?VllXQ1Z6OFpaUkFpYUpSNm1TWjJIT0NRMFBHN0FRNUJVV2E1bXYvbWwzdEVy?=
 =?utf-8?B?VDhDa3Bud3pIS1hibmwydjhVOGtMRi9oVnNXUHhLM0RFWWQwc3gweXhpSVFV?=
 =?utf-8?B?bSsya2ZJdDNWdHNnN1NQWTdRMHc0SnlpdUJUUDhsOFNOeDlwUEQ3VkxlQlBu?=
 =?utf-8?B?eWo4MXRhU0ZTdjYwb1JnY2U2bzE2ekJHeWJNUklBSzAxTEZoTDlXcWxBN3gv?=
 =?utf-8?B?RnBwYnVGVHhDYzlCNDBwTmVGYnE4d3h5Nno4OTdybFFiMitCaldJUnFZdmVF?=
 =?utf-8?B?YnRkSzBHb01nMjM4V0xTNzdMd3dPQ1dhTnc2UE9CNU1FSk0wZm54UXlZVWQ3?=
 =?utf-8?B?Zm5yT2hhU2VKeFFZbFdkT1lEZ2ZBcTJRZEZrRVB5UCt6SnB4Mk9aVjc4TVd1?=
 =?utf-8?B?dGQ0ZC9ad0JZSTBtZDllYTJOY25sQkJjZ3VUOXBKeGJLWXV2akdVdkFjd2ND?=
 =?utf-8?B?Uk9YRkJ2TndBRXF1Qm4vMm0xVW1nSkUwRjZQZFdINzU2V2JZTjNaVGdQbUlC?=
 =?utf-8?B?TVgyT3h2VWNoV3lWQ1B5WW84Um5vRjBQNXplTVplZG91d0hvZzB4WVZaQlAw?=
 =?utf-8?B?U3pSZjNaeStNMTBnVWJGU2J1SUx0eWJpYnlBM0ovVjlxcFVrS2NpbnBXNHk3?=
 =?utf-8?B?T3Z6dG5lZDhGbTdhdDB5TnhzbWoyUCtuc3lqbmdIRVNyMTI4TVhLVFk3RXhX?=
 =?utf-8?B?V2ZOTnRQMjlpaGg3ZzJsVXE4MENteDRIQWtWTnNLNVRzblI3cXJETzBKTG1B?=
 =?utf-8?B?OWNEZmQzUitCeGljQ0x5VzJacUhlMTh0T3Jodm05RU5nUXc2YTY4cXhQdHA5?=
 =?utf-8?B?Y1RsZm1LRjVYYlFMV20vMGxFdE4xMGUydWZwbTVhQUNEVzh5Q1FVT1hyL2ZT?=
 =?utf-8?B?aVhzeG50ZlRRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;6:5DQd8ad28+zlJfVMQqyAXxK9zQB4m+MAvFLYtmU1kdWGB/bHeOYx1PEWyGf7yS0ungTuvXwy2EMuz8Qw+tMmXk0cQBbdiil8G0jKMBgTESqd4zIp8RA3deV1+Ot2jHJJF8mYD2/vSA+hepsQ/7W1l4Con6zyXBwI263JjLMtx3xhzT/Iyjx3oVl2elhHKW2ZOzw54EMTil4ZC1PQNaArhvBs8j4nADQioq41xFSn3fSyfXzZwEnakPZScQkLZpC6rQpByKkEDJbBMPGLLXIuE4Xbkep7Eg+6fqBfy/w7VYrOliA9y7dqGuHnl3UxkdRytI56oMSNszV22oyNBwUyHUoO1SS9q5CBYcKf94vRZPY=;5:x2FkL4tZI0LHYhFXYNAaCUaZQEQag9cY3Tx76oqttAM1IK1EmlANGa1b06w/7dxccJVdXx3m0h9mAwgu9sFl6B92kjDIY4lgl93F8VstYIjvVvjrU3eGL/MjTHh7RywF688lCewR13J+FXFisw6naLuV0XWxo3vtHhOPkwnBxDY=;24:D6b+yPOhcoHI75qEjr3GfE44/Zhh2MaCP2QPinH2V1LVl8Jp994AVvakQXm0H7Hhm5F2NajqifVtzWpbAOx8k4mfyDEhEPqMQ15bMmeCguI=;7:57V72cwUXjnGdnwXVYAErOQ5Z0XIyrjYH1HuZdym7nHt8y8Kiyn/QnjAfPe7Tyw2HxHUmt0nNU/XYpdzrzWXRHnYiQIo91eD29tPVOOdWVMvJamTsbrjKNx245zKIK7KHQUNWldTrf5XX3On++83ojx3t07VDVrL5619opM10qi6BAoeWKNQsklHPj3uZbOokFTIe6GuWP8uieOOreH6XwblMRqQiM+eNT/mpe+ZmaAUqCfqTC4shW2Y5zyoEz8i
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2017 20:21:19.8951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5a7c1d-21ea-46f2-9cee-08d5209cf2c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3500
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60615
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

On 10/31/2017 01:15 PM, Gabriel Kuri wrote:
>> With some kernels, not all memory is allocated to the kernel unless you pass
>> "mem=0" on the command line.
>>
>> Since special Octeon code consumes the "mem=..." parameter, it isn't
>> available in userspace after the kernel is booted, so you must look at what
>> is done in u-boot.
> 
> Well, that didn't work out too well (see below).
> 
> Do I need to tweak the device tree or
> 'arch/mips/cavium-octeon/setup.c' for my specific board?

What board it it?

> 
> Allocated memory for ELF segment: addr: 0x1100000, size 0x2628a48


Why not show the entire logs we could know what you are doing in u-boot?


> Loading .text @ 0x81100000 (0x35ca1c bytes)
> Loading __ex_table @ 0x8145ca20 (0x57c0 bytes)

Archaic version of u-boot being used...

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

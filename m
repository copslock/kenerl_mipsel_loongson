Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 02:21:40 +0100 (CET)
Received: from mail-cys01nam02on0089.outbound.protection.outlook.com ([104.47.37.89]:42591
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990435AbeAEBVcKh7s6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Jan 2018 02:21:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/mWJmvn8tuY4M38n8rg6fRHhRtHNixJSGoPvlXyNMN8=;
 b=ZQ415redFOw9oXFDMhx6IglzB4NLVMK8PGID3NYOs6rS3bl31Jy3k+CPbDb9zkSP3PPPEalia2p4DTY7X9OxBHVbyn8+TTwK/AfN1T7G4ad0zGqYcB+ddH1hV7GsuiFjXzQh0zl+5EkedVtSpROPT6PJBLRfz7CMG7byPPlg6CA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.386.5; Fri, 5 Jan 2018 01:21:20 +0000
Subject: Re: mb() calls in octeon / loongson swiotlb dma_map_ops
To:     Huacai Chen <chenhc@lemote.com>, Christoph Hellwig <hch@lst.de>
Cc:     David Daney <ddaney@cavium.com>, Hongliang Tao <taohl@lemote.com>,
        Hua Yan <yanh@lemote.com>, Alex Smith <alex.smith@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <20171230160928.GB3883@lst.de>
 <CAAhV-H4fzuocu6wx3kmTO96vY-0YkRqQboqtRVXzn7b0YZSS6Q@mail.gmail.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <0fa48a91-6987-85e8-49fc-d39c5461be1e@caviumnetworks.com>
Date:   Thu, 4 Jan 2018 17:21:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4fzuocu6wx3kmTO96vY-0YkRqQboqtRVXzn7b0YZSS6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: SN1PR0701CA0047.namprd07.prod.outlook.com (10.163.126.15)
 To DM5PR07MB3500.namprd07.prod.outlook.com (10.164.153.31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cacc43f-6da6-4d03-b0e3-08d553daa10c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:DM5PR07MB3500;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;3:M/jcdPQKXRN3J18Q5kTsxUD9kiocXPulJZZkj6ORBjddxhNi8pfQDcSaX3WlDosSVb1KMQ9PTkofmjtSLjYUDmuY/p36bU4JKGYvAHYnB1ovc+5pAo/oQQPFR2LtxHiGjkqbPfZeQ9LAVNssP7ezHboWU5IMxG5gCwvsfOTV5hIXjncOj8ZVshODTjQ8XMPDgwW2K/dEDzP5sjhh4XEcNMDkc2D9q4URU+06p1OT88LQ575phftKjRiWYIwEdSR9;25:ak+QBYh+1ph2ebv82/ybky+Wjx1TNdmgnwb+hz0LPoTOAZe/WI0hs1QGYFZbRHNcepMX7wB/vETj06YR2pGcf4R7oyVIDByVOKh9dJwpILi3A26uIHIZTVtp1qvEi5eTfHm3Rj1FBaxEkzyFw4WkTByecl1RlAK0Pj6yL280amtA9L8MqgdOMzMUikmvjWVoH06ITr+ySOSWQgNmoRYpkRbbYOPDzZAlfLnST4lH9OH9UNa233Kq+AJ7sfLU3cW9j2448MPxwrFnVillfMWThDah2+C/F7Xkx2yhPgPNMwAuEnDhRQuioZ+MJ0lObWkyFiTDQ6tRbSRGWYTEwhFraA==;31:eOyBhiUqCf9s4yIluH4WQ7Sln3ijdB2l4po0M0xUz0CB7e1bOJBjL/UzAO1PlYpE9mwWcsCwHDiXFGsSxt6t7cp+BPN9/vxpcQvtTuwB0YKhqbyQVrJm+gNHMEMCj3exeShupn0U7wXYIb2MGhzBihp+v/W6YNNRbVhAKosJZQHp/r7AQ0Mz2zFDEPeCBvhepQYn3A3RoBltCTrxLDThjYZpVZ2bgFLge1tjpoHGPns=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3500:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;20:4nam3HEytPmphe3i18orFf6Q+pbi9EIJUFyXuz3A80cniiljbCEi0CbWi9ATdTH+nJYySA4Q5igcf21hM/amepTFLYcMjiEXq8/XAyrBKmo3wEkevNkyHic432UyNJzMARafJ5wpemY1gFWUfdKSlQ+qh0xQpVjqfaryNtJQu+21nsh70YHBNvKzpl5MB39Hfs06gQ6vauSR12ic6cP0SAUuMJiTm3xU3QT9S5V3l3qstbLLsV5QovI1x/eYTHLALl3HSOMPGIvB4UNxiivbXV7CFA+FCUtwgoeuS5cvA1rFxKlywMFJkpz8czIp5RX0tqmw7u+pFga+/3JW+A5cKtQzQ4QK1zFU+CRJzmyVRs5HxMR2v7RCwUj6W2HFf2JJAQYSYf5s6PilliqhQ8VFn6PiTEFNl5X5/yOGm/NlEYhS6zPMaGsauad/PsnaKLhdOMUmKZy25uDuyDtSZwUMGcsJ7hpruCU1MdOX/VN9KqEgbTWknpzg/ZxqkzYPCVB++3m260PsLs1ulSnxhC4M5a7WNDbtvWdC7SY6KLUP1FqOLzjT3MjEMXIILglyIlbm2Kb/r/WvNpkDwX5ilvOnGhOBMwMvaI+v5v8Y9Au463A=;4:37UtBWjsxRf0ST2QtMf7rhEfYLn11pFXOos/wNT4jIZW6XP9aLzLL7WGyMwb0TgRiTC/B6qhfR9sN+BEP0gUEYl9xFtkjAyXY5Z8kt+Qh9hJHm0AB/LT0kSXpqUxDLKxB80+FSpikMX9cxX5YI2dxQ1+WzdmV5oS586+Baotw0x2dSO/14ccrcFlZO7TkRjlRUpcIdSZVjbJxOMqmJx/ph5DDyVb7F5OyWOX7LQdB3/W70OhkAhH8YUmPpoHbFHBt+wyUOrNga6zhwZkr68xtA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB35000A221B7B574F0575F500971C0@DM5PR07MB3500.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231023)(944501075)(93006095)(6041268)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3500;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5PR07MB3500;
X-Forefront-PRVS: 05437568AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(39860400002)(346002)(366004)(189003)(199004)(24454002)(52116002)(39060400002)(64126003)(31696002)(110136005)(386003)(50466002)(6486002)(53546011)(6506007)(230700001)(47776003)(8936002)(4326008)(6246003)(316002)(478600001)(58126008)(16526018)(105586002)(83506002)(6666003)(575784001)(54906003)(2950100002)(97736004)(23676004)(6116002)(67846002)(2486003)(6512007)(3846002)(69596002)(52146003)(76176011)(2906002)(25786009)(65826007)(36756003)(106356001)(31686004)(66066001)(5660300001)(65806001)(65956001)(42882006)(8676002)(72206003)(68736007)(53936002)(53416004)(229853002)(7736002)(81156014)(305945005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3500;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA3TUIzNTAwOzIzOmN3MW4xNEdWcm43WHM3T2RlakNtYU0zamZv?=
 =?utf-8?B?N1YycE15UUplV3JJYzBNNTB3eEYvUStUMG1BWkVMZGRFbVJTTkd0ZzJKU2FJ?=
 =?utf-8?B?TGtXWGY1UmkrVmM0K0MzUE5VVlIyVlBOSHFTajM1TnA5K0g4OG9HT21BRmJD?=
 =?utf-8?B?dlJvYVZHY1laT3grbkZZZzhUUFVyWHg0Nm81ZmhwejB5UEJzZlo3ZW9pYklq?=
 =?utf-8?B?MWZDbXF5WWpRUGwzenhXZU1tQ1A2bjAwaUFXaEpsUUVnM1I1N1FYVG1RdGNn?=
 =?utf-8?B?NUIzbktLaFZnN2ZveUpKQ2NmaW5FOG5tMjRCVTBZYUJNWnpYOG50aDErWHd2?=
 =?utf-8?B?dGRHMTlIQTBnc1NmRXl6R0ZnQ0tzSWZEMUM1YjAyNzNab2NTYzZoUmxBWmw3?=
 =?utf-8?B?MWZZUmJpUGlwN1ZKa3dOVWRjaUk0Z3Q1SVZxRUZZdzJhVXdiWWdwS3lqbHJX?=
 =?utf-8?B?bVpwTXBRTHovcUU5eVhDM2pvZUdyWU1mV2c0OFFLQktHT0lveHVmK0c4M2lJ?=
 =?utf-8?B?a3htNTlHREZqRGZzcnUxaUYxeWVySytpUElDWVBLT3l1UmVSSXNuUkJzQzN1?=
 =?utf-8?B?WjVIVWhQYm5NVU1sYXFwaVVKek5OeDVyMjRFU0tJRmJGRXd3b05ZVU5HUGt6?=
 =?utf-8?B?b2ZDK1hqVzlRSXNFNTBCb3c3VGx3alh2MUM5am9ud0wzT0NMaEVaNWZ5R3Vk?=
 =?utf-8?B?MDdlQXlRUjdSZGd6OXk1WFlMMmZXanp3akVTQ0JOTU8rUlU0dFA2QkNRemdG?=
 =?utf-8?B?WnVMWXlNQlRSWFdpdVhoUDFtNWF3eWhVcXI5TDFKbzRlN21hRmF4cGV2cUhG?=
 =?utf-8?B?M2k5SU1hMzRUUFdWWGwrUkN0b0NWT3Y5U1VqMzU1SEtURnhaZUhVM3NiTGhH?=
 =?utf-8?B?cFl0Rnh2WFIvYWRzQlA2V3hOWFVtcnpsQllXWkd5MzVJazhWNURYVGxJVC9M?=
 =?utf-8?B?ZmRkaDY5OVVEeCtZUXhKL2tZeGtkSVJLcjJYMUN5Wi9ydGRWcTRCQ1V4aVg3?=
 =?utf-8?B?TUVPYkhteG5Xam5MU0hvdGFYb1FtbWVWbTY4VXg4SHBkblo3MkhaNE9NSmVI?=
 =?utf-8?B?MWpSRFA4VzlpN25DcVIvMEROd0hKaEthQUt0blR5T3BrTm9YMW9LdTRjTWZu?=
 =?utf-8?B?RVhMeEFoWFJCTXBSblFSVmlOcW5JSDg5L0JKa0NHNnVidTI1Nk5sc00zelpt?=
 =?utf-8?B?SEVVWVJEV2JSaUhoNXlpRlRSbjVLVHcvQkQ4eHJRWGl6bEd6Unlra0pkZ1No?=
 =?utf-8?B?bVR2SmwzckNCUkQrcy9EWllzUnFqNzJSTVBNdzd5YkxkejJHU1pPdHlIeXRG?=
 =?utf-8?B?bTNZbWliNlAwWWNMbE9FTitLNytGTzBoMmpOSGRLTWRMMGgyM1ljMjl3Q2xt?=
 =?utf-8?B?c1VuQy9WeE1pRk9FaWg2V1ZZUWQ5K0FVWmVuaVJ5UU5GZHJ4QURSWTFGVzdk?=
 =?utf-8?B?UFUySnY1TXJXRWw2b01YU2lhRm53L1BDS2ZDMXdrSzVDM0QrNkpjN0pRV2Rh?=
 =?utf-8?B?a0MrQit5dG9WRjRyVVhBV3kxOFNXUjdDUDZ5bTdldmxTMFdYOEZVNUNBN0k4?=
 =?utf-8?B?cFZtR2wrd3NLN1Fxa3RUVjNIRjNNempZMERpc1cySDU2MHF3QzlIZzJlSkhh?=
 =?utf-8?B?Rmp5UDMrenlaZzZ5Z3F4bldTVFIyMGxrQ0F5SFJFZGo3Kzl0ZlpwSVJPTUdu?=
 =?utf-8?B?WHpJTVhiMFQrRDJPbnhFeGpXVDU1NEtueDdhUG9ZcXQwWm5jS3lhbXgzWi9z?=
 =?utf-8?B?VzFXSnhQLzBOdmZWMXlsdjlYRGxxSTNDVzBHWlp2Zk4zMVBQdmVhYUl2LzJ6?=
 =?utf-8?B?Ly9rOGJmUDZHVjlsMXZ1Wk90d0dLRmtENVJHakNzZmtkQnRZSm5CSE82SFhC?=
 =?utf-8?B?NEpaWEJxZ0tCRi9UUDlvTGN5T0lWOWh6UWowVEhaeHNMOGpiWjFsNFVXM3Qv?=
 =?utf-8?B?a0ZNc1hnTjFFRy85TndQeG4yS3BJd0UreXlJMUpKUzFWRHJqK2wzODBralJq?=
 =?utf-8?B?aFVmY3phWVUwQjU4blRmVXVVOGw5YVQ1VmNDUT09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3500;6:m7JBRVBPy0JoxgVscXFLqZ69dUS6KNDth7blQISwAANLw6h9HZv0tou9itYGZQY1HNNosX3y1tEO5PiSkru3bhLFcZtyjw8Wg87qBl9tAoAf5v+chIyHgMdg+bcVPkHPWYAEzieDlLV6YxKHYW6MbgAY2op2UKdUhi7eiCDblZkIDmLbNaT2ubi8y+vrYvvcCHpsCpWiVWzoiZcSJVp4AAWqA/TRARX9OD18/iLoYj1akGZ1qJ4jOy82tcQOVWUocS1VpdMcFLue9x721Fcjcdd3IlxZ06PsaeD2x6PwCx621FEq8v6/RyezSb37eR+kjemkTSf7Ey9pbDDKO1Z2AiyhkwCym6VbHPsqxzDRCVU=;5:0N0pf+uhDZZ/9BGxmjhi8MGmz/YlXQiJEZyQSiFnyDVU5Rzm3v1aBNtEApRZRQxz65Pgo/iZ1RBjU7gAXa4q1SO6YetEI10lgms949c1v02VFhOGzqGYTfM3u/1YeK29NX7jadxZ+SMK53vuOVh5X8E/P0KxHDCrO6OcU+AEjyI=;24:RHAc8Xpi2TvdG4P6iZWXjMthlbeXnqXlYecdQGGy6hMOYQ6zPP15RRYQ6HBrQv//P1TeWHHFC0WlwZm9Y8tvn+N1wM/K/vRsFhLcx3Xg4G4=;7:9fVUVbl2swAWaiRjKoath2jbk38XEvgTxqYvw3hmhA6WpI4RcqkZOZzSDgQgxg85UqXMbLG2+SgFgVe4QGDEk/B+wJdOepwlNsUFMFyzXI2Go5sPUv+ltu8fupQ5Tf0wLMYdb9fuqnsqDeTeRvy4IiCAzpkxwaT2SPDsfoe6wtu9+ms8KvUEytLtLc2fk6+tLS8Co+fZicQ/H82K6Cid2fo5wMSNGceslpf7izEt4kRi9V/XVlCudc+EF4pKX080
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2018 01:21:20.5545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cacc43f-6da6-4d03-b0e3-08d553daa10c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3500
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61902
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

On 01/01/2018 06:28 PM, Huacai Chen wrote:
> Loongson's code is derived from octeon. So, I also don't know whether
> mb() is really needed.
> 
> Huacai
> 
> On Sun, Dec 31, 2017 at 12:09 AM, Christoph Hellwig <hch@lst.de> wrote:
>> Hi David and others,
>>
>> I've recently been refactoring the dma direct mapping and swiotlb
>> code, and one odd thing I noticed is that the octeon and loongson
>> swiotlb ops have mb() calls after basically all swiotlb calls.
>>
>> None of that is explained in either the earlier octeon dma map
>> commits, nor the commit that added the octeon swiotlb support
>> (b93b2abce497873be97d765b848e0a955d29f200), and neither in the
>> loonsoon commit that apparently copy and pasted it
>> (1299b0e05e106f621fff1504df5251f2a678097e).
>>
>> Can someone explain what these memory barrier are supposed to do?
>>

It has been a while since I wrote that code.  It is possible that the 
barriers are redundant.

On OCTEON, we the primitive that accomplishes the DMA-Sync operation is 
the MIPS "SYNC" instruction, which ensures that all stores are committed 
to the coherency point (L2 Cache) before the DMA is initiated.  The 
mb(), is implemented as SYNC, so we use that instead of open coding the 
'asm volatile("sync" ::: "memory);' in the SWIOTLB operations.


Does the SWIOTLB DMA mapping code chain to the underlying systems DMA 
mapping?  If so, the barriers there would be all that is necessary.

Does that make any sense?

David Daney


> 

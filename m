Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 22:02:14 +0200 (CEST)
Received: from mail-bl2on0076.outbound.protection.outlook.com ([65.55.169.76]:13568
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012442AbbHDUCNDbeRb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Aug 2015 22:02:13 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BY1PR0701MB1721.namprd07.prod.outlook.com (10.162.111.140) with Microsoft
 SMTP Server (TLS) id 15.1.225.19; Tue, 4 Aug 2015 20:02:03 +0000
Message-ID: <55C11A37.5070509@caviumnetworks.com>
Date:   Tue, 4 Aug 2015 13:01:59 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>,
        <stable@vger.kernel.org>
Subject: Re: MIPS: Make set_pte() SMP safe.
References: <1438649323-1082-1-git-send-email-ddaney.cavm@gmail.com> <55C10F4B.2050003@imgtec.com>
In-Reply-To: <55C10F4B.2050003@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: SN1PR0701CA0047.namprd07.prod.outlook.com (25.163.126.15)
 To BY1PR0701MB1721.namprd07.prod.outlook.com (25.162.111.140)
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1721;2:p9A+LamJzDvLPG8+yBw9sVgj8j03zP8SSRUSkRoEw1gyA7UFEki37gQlWbJbvVec0Q04m/Vq+HXD9X1FANodshKS4Qr2PZjfkVEcihoD17K+7DR88IqfbB38LNJhl1Pi4JGLAFIDGTp0IloBzD/+BLsEQpylAWqCIVzisFJbk5c=;3:oWb6E+oALvEDlls11nVfUGxZ/76cMmKQZ1AUyR6ZsPhftXqn5HooLoESLcQQw2gn0rKXYm9sOOVZuRKGSpbbJ16mp1BMIiNiuVj8Ak4LymwFKoCjthMANHdZ3966GzUH+7JkBSznjw42BBFijzVKTQ==;25:xgv/CgTLGFOw67VYry8QFfjV+vO8fyKdjkYxCNlvMyhGAiWUGN0Fn05JK17METnB260+TpPfFLFq2Ip+AF6Xy+wmddkp7Sm3FXOEO8d3u/HIZZhIucUNuRaBZ2xIOzt1tLUql9qaLGyk7Y0fl92xuJeySVn5BDhuNCNt02BzoRHxjgirj/SJ66iSW2IfETfv3v1m/8azxcJIAk3jNrGme0Tg7+TSwZnPLbSZpEBpxVRoBjhQoHUzfIid4dL8FJJbC6CXJi/64NSeu0UdlbHu3g==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1721;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1721;20:jYH3Rxc6uXP7wY21JHouqXP1zHHCXMDh8Lw4vr0h09WaFb+kcxrXajRxqZSN2QtXKiDD8agz5Fv0JnzKZVzGFjdzFVswakdlgB+cviVZU0jKINnPY2xZGRVthyxUrKtfkv6dOlFarC1XbFHCLwwe/b3AJ9LrXZLZaitaYjPZH7ERxowhPS+EefXVRqNvstIH4xGbhOq3tYfplG+50bhs84FuOKKJhRehaSvjdW4KBkUiSucsnt1YaK4We37bT5ur3L4XM/f3hiT7zdiP2/Q4mjdyEuhz3iA7Shmzt6jfRqSMZtU+usCB4mAhEzz0vvbpzFWtn9cipuZgRwbuGy5/DwVPggwCPwmjsvKc2xhBnCNo+oOUN2wQ0E6n1KrLSYH7QQEB7Njyy+bXGucZ6Z4fvLjEnSiFL+wkADgQNYC04GUXg9B8LFG1yqOPul71rbKKgyjRycXQ9b61G8wOUtLEWmTouEzSjTCf02ibMzJ7/KiE1BHsSiypOdzi/cbZvtG6c3nvU2X6KoKB8IdKlLsenW6yDoRdp5BZFJe81xEclRObDo/ajKszHZmUTwaZDGUW7ldiaxBTzPZi0cLTg4Qr/qz8LrGbYEbZ0aBh0ddPcYA=;4:y4kan4etPtrD9H8vU/bweQqmUXH5jdAvwsyjl2EanA/Uf0QJh7xcdjBcc7VHDe56lmzhShOeQehqFfYgtlZ4oH9n4YojMbhkHM6Sg/gChc9wjDpKiG44+JSMKjHs3yVDO/oeSyJRrwdyUk3vkzOZRO2GmD6hWXVG62Lt5ajy+ArLN0smIWh+B0dU4ZtZgVkVst2mQZgjXRn7vfyqJsdV0aXdBWXhg3q99kDWieKGLcHrG65QjM9AzmMkICOt0WVukUEZKyZVQSotrYfQ7ExKJ9OHWDe67GOrslgiyUtQQI8=
X-Microsoft-Antispam-PRVS: <BY1PR0701MB1721BB66C3C6A9BF1AE0C3349A760@BY1PR0701MB1721.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BY1PR0701MB1721;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1721;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(189002)(199003)(377454003)(479174004)(66066001)(59896002)(36756003)(40100003)(77156002)(97736004)(50986999)(83506001)(53416004)(106356001)(2950100001)(189998001)(80316001)(122386002)(68736005)(92566002)(42186005)(77096005)(110136002)(5001960100002)(105586002)(64706001)(62966003)(23676002)(64126003)(50466002)(76176999)(33656002)(5001830100001)(65806001)(87266999)(101416001)(65956001)(87976001)(65816999)(5001860100001)(81156007)(54356999)(4001350100001)(69596002)(5001920100001)(46102003)(4001540100001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1721;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjA3MDFNQjE3MjE7MjM6RTZYbnlSOHNQajlFdFJGWFZGSzhESHBi?=
 =?utf-8?B?VVl0aUFSdmgwaGdRSFBMc0RFaFFWTWxwNlozVzlsUW02azhHNVVlSTNiczQz?=
 =?utf-8?B?RlZ6RXM4b3F0WGZ0VTNkb3E4L0FIU0llU1dYWU1CRUxmLzhyNk5PL01pdTF3?=
 =?utf-8?B?MkJnNmNWZjNENERjN1pydW8yUjZUOU5UNUxWblBsdXNnNU9VeWxDbFpwTTNS?=
 =?utf-8?B?aFB1Nm1hVm9tcjlDajlCTDNkZFMxQXNXYWQxcW9WdUV6Zlg1RmtJQWFYZE5r?=
 =?utf-8?B?SnlZMFc5RytnVUZKYm85Z21hWDl5Q1NhaGN6SHZhUGFlSDd1NTNtRUF5ak1J?=
 =?utf-8?B?K0h5MGdvbGNwdGlFdnh2S3VOYnVyOVpSaVg3UHErTXBlUmhzNllQUzVmaEho?=
 =?utf-8?B?L3U4TE5NenJVSjhrMHZSOXgvUDFhK21HaGpVL3lzbWhncEQ5R3ViUkdhVUY2?=
 =?utf-8?B?SkRKMHlkU1htL0F4SlU2OEFzQmtxS1hPTkZROVU0SksxVDd4dWRSSkZ6eGZP?=
 =?utf-8?B?elZUQnRnczVPd1I5K2hZcURCUHZTN2hVemJ3VjZnMU5QazhnUVZwLzFObTBs?=
 =?utf-8?B?QlZxWXJ3UThPN04yelpjZTU2MFc5M2pZMGowaTFYVnFBT0Vyd0w1NWtnaHBl?=
 =?utf-8?B?cHpsWHhOREUydnFnN0ZFakc4dk9OYTZKM0ZPUlYwcFkzN1N3NW1uZnV2MG5V?=
 =?utf-8?B?VTYrUlJ4VmlrcVZRakl1SG5HbU5TS2pEQUFnUnJjM2I3V2t4bjBkRGQ2OGhP?=
 =?utf-8?B?VkRtZlhVcWs5Qld1ZzdKZW5JMCtsSEpySzJYcmg4SURtNXREZ1RrMWYrZmlk?=
 =?utf-8?B?Um1WOGNTV3dlQkZTU3pSZ2V0OGoyQUl1alJLS3g2ZStObkkyU0xsVWVoMG9N?=
 =?utf-8?B?OGVXSUlrbmY4V0llazY5bEtwN2NSWEVjYXBrcDkwdXZrTHRKMU1sVjBHNkJq?=
 =?utf-8?B?S3ViVytPTG1tWVFtaCtLSDVYN2FwWWVEektSVWQ3YnhNeGhyRUdoRTNjMXVZ?=
 =?utf-8?B?bDk3cVR0cU1BT2FJMjVYZjZyc0hjSXZSYTJWbTVvMGExaDZXeUlielJCa0wv?=
 =?utf-8?B?NWRUcjRnVDNITCtsWkhpelBBSlE3aEFaS0ZWUjJkaEQ1ZVNKSzVGRFZlZEVy?=
 =?utf-8?B?RjZKOXpQZzhRbS9oM1JxRENVeC9iYmtUVm03b1pJaGpyVFIvd2dPQ3paS2c5?=
 =?utf-8?B?V0k4eVhkVEsvNWVEQ05lTEtoTkhmMVhYUHpQT3ZVd0hFSlU1VU9IYlBHT3FC?=
 =?utf-8?B?emp6T0xYTEhEOFVKdG5LcElvNjF6SThJZ1FaajJGeFVVOEpNVjdYWThYQmRD?=
 =?utf-8?B?MFA4YndieGN3TnVBMXc0cGZjT2hoVzZxR0N4YWlGSWsvRGl3YmtrOHJZdXU5?=
 =?utf-8?B?VVptR1ovYjBmTTZsT3NBZ3JKR1B3bXdNeEJQT3BXNjZVQWFDcmZFNDNITUEw?=
 =?utf-8?B?T01QaDVJejlmNEp0RnRiRXlxc2c0N0Y1Njl1NmpEWjE2aXZrZkx1djlEbnAr?=
 =?utf-8?B?L2dESnpTbWswUlJEdzhFNVJodEJOM0tDYVRpLyt3UmIrVTVkSlE0Q3lQSndU?=
 =?utf-8?B?VEVvL2pGMGtYYTVrNkwyUGMvNm9vR29CcGgvbitCeGo3R0RCMlliOVBlZGw0?=
 =?utf-8?B?b2hjb1lZeDBqM1U0Q2c5SGFLL1ltbzYwNEJGU3UwbTF2ZnNOVWRlbm4zMU1B?=
 =?utf-8?B?YS9qZ0FCdHB1Z0FkUFJJbUVEb3B6N0RhNzRDUXp3TXlpeTM5UkNOMER3N0xJ?=
 =?utf-8?B?Ylg0RjlSNTJDVnUrVkVQMmp3PT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1721;5:m2FuAlE1J/B0YBqt6UwztWcF8yS/BB4htK9w8owP2RnjaCzA2Ao2g2P4Dfvp3ht2I+s8DKl0lx65iZg/gicl4YdTXtINDKXAX8IlODXj8q6d9qCsxt06EAtHekZNQZ28DXBhiDP5kmPc7wmeWs7UNw==;24:FngKUXsPHZKiXMLskUDHWdLEfxwTTbxxDwL2ITmtLtWRQhJX7NFZmgzMXNITVIAd7pUMesnDdRVMN4lE89E0rovPmTsBO/L4NGfJt9Ktvxc=;20:Li8kVAlesZBOPKTrLbiVB1CR0M0quWrfohPqHfL1TVKv0476ily0MRHdaPCy+NpYpdW3eoyuVXU4NLR2fCRBDQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2015 20:02:03.5074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1721
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48570
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

On 08/04/2015 12:15 PM, Leonid Yegoshin wrote:
> David,
>
> Did you observe this in real?

Yes.  It is not hypothetical.


> The function __get_vm_area_node() allocates a guard page if flag
> VM_NO_GUARD is not used and I don't see any use of it in source.
>
> In past vmap allocated a guard page even unconditionally.

It has nothing to do with guard pages per se.  The problem is if a vmap 
range (including guard page) ends on an even PFN.  The buddy code will 
clobber the PTE for PFN+1.  If another vmap operation is executing in 
set_pte() for the clobbered location, you can get corrupted page tables.


>
> - Leonid.
>

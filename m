Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 03:08:12 +0200 (CEST)
Received: from mail-bl2on0084.outbound.protection.outlook.com ([65.55.169.84]:35376
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012535AbbHFBILAfwSx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Aug 2015 03:08:11 +0200
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1718.namprd07.prod.outlook.com (10.163.39.17) with Microsoft SMTP
 Server (TLS) id 15.1.225.19; Thu, 6 Aug 2015 01:07:59 +0000
Message-ID: <55C2B36C.20001@caviumnetworks.com>
Date:   Wed, 5 Aug 2015 18:07:56 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Paul Burton <paul.burton@imgtec.com>, <daniel.sanders@imgtec.com>,
        <linux-mips@linux-mips.org>, <cernekee@gmail.com>,
        <Zubair.Kakakhel@imgtec.com>, <geert+renesas@glider.be>,
        <david.daney@cavium.com>, <peterz@infradead.org>,
        <heiko.carstens@de.ibm.com>, <paul.gortmaker@windriver.com>,
        <behanw@converseincode.com>, <macro@linux-mips.org>,
        <cl@linux.com>, <pkarat@mvista.com>, <linux@roeck-us.net>,
        <tkhai@yandex.ru>, <james.hogan@imgtec.com>,
        <alexinbeijing@gmail.com>, <rusty@rustcorp.com.au>,
        <Steven.Hill@imgtec.com>, <lars.persson@axis.com>,
        <aleksey.makarov@auriga.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <luto@amacapital.net>,
        <dahi@linux.vnet.ibm.com>, <markos.chandras@imgtec.com>,
        <eunb.song@samsung.com>, <kumba@gentoo.org>
Subject: Re: [PATCH v4 3/3] MIPS: set stack/data protection as non-executable
References: <20150805234348.20722.71740.stgit@ubuntu-yegoshin> <20150805234936.20722.60927.stgit@ubuntu-yegoshin> <20150805235543.GG2057@NP-P-BURTON> <55C2A50A.50805@imgtec.com> <55C2A6FE.1020003@caviumnetworks.com> <55C2A91B.1090704@imgtec.com> <55C2AC5B.50408@caviumnetworks.com> <55C2AE7B.4040805@imgtec.com>
In-Reply-To: <55C2AE7B.4040805@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BLUPR07CA080.namprd07.prod.outlook.com (25.160.24.35) To
 BN3PR0701MB1718.namprd07.prod.outlook.com (25.163.39.17)
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1718;2:c6O6G86z4yz0V6kDn5/RHfY2/P9dDlNWGpqIb2uaesJH2Jqqo9dw8S3Wbrf9xdIluqusSFxvuT0FHZz2M/7Qp4i2Lo9HCZuCjVeiC/TTKVvw06IXoXY2lvA3ZIlARJ3zRenRtK7T0cGUVIKfkSL4p6ufvKqGYb4s7xEIbRriTf8=;3:nFeoDTIEbqOGklkc9sOclWekmOdaTPMzzPBQvvqLNDUAEgevSkzusBvSN0t6L0BijFh7ajnf0eWWcCveb2KTcwTOrWyYnZEJs/ybdO+SFaEJbZC0OCptZrV3c9aKOkbCe6aP5xrwpqI9R31Zw0CsHw==;25:zdEQgNxUKr74JSillIkb8dTOJxNz0ZqCzrYlWepytorzf4rCcJOsn6tmSqf8CGpY2EvUr2NouFHGIlnCgHz5E8VSDuO+6opl7XYIA//+JOh2u0z8e4GrdC/SJp5d4mh8jqOFmMOGFmcIr4hAf7ummNcAMRiVdH9gqFuwekYRI9PakeyiGJexT3IWov4K48jAbrwbYwc9mh7JSluWzlDYHeuUyjYkkmj4WJ8hGGZ0p3mzH6Yie1s0N3BbIvJttydBKeo05Fv8KAMF3Hq4NzZr3Q==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1718;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1718;20:g9uTfO9xNNppP7lb8384TUePCeKpsltpz0egGpF9egsZUHMQHdngscqQV7IZiHZX38/0Ojg+mUlzwa7mMcpagCpRQVqePuKA5vD8jVHsjEb94jxLNIS77zMZLcASsIlnih2RPaumggihUeW5IrhWKoEw4/ibg/HfmFqD2I/+025fx9xKmtyLanPHOHzKVpIsiiGJ5VvVpaNE14xxWpUeJCk9PhocgSNj7f7l3SSgiAHh+Tr22HQAMhTPiMPrX0qivrQQwyXqyyLDKEs5jLPboPmEKcZe17604J4kUdDfND+dKM2o54jkuSPCnbcvnK0N9eHjOt//OYFBPdm+pqwaR1lQaEG0dveXzo4VaM00fyy31sIY7iZbiw2/3flk6czv9TesUCqAOOM2aIoJBBDtOFN5T6TbUOoZdPU7RvkgK5LQ1nrVzr6cnqFu/tyC7G59w7B8KMGBuIo4v5pPqtsH3RJywyQTGU4h35ucD6vDYTr+7jVM/oKeXRKbiMwzNIx0FfpBqICb+37faVZbG2rK9zKkHOTaBJGijFFkHEGkXmTS3jWiFMwNd3PxYSb+OHnY4cgeyQdt8MRne2CoKAtqQ7cDHO/U945AicJRJxITAjA=;4:caDV/RseOomGmZXcDZEBWI1XUValSrRzoYUvPHiiXiC0CrPFDKFrHuL68jxbjlSho+SFjhhuJ5zNFKgQr5vNJ+qlDtgfeFy6ey9oIDQBfG0qGBdREZHf9btnS/LaMoHj05AyV4r6fYiL7+lSiI3gpQif0jL8RJTdWZDn1Zee62wsYkG8ZmohyZSAUorXzsDF4b7LbyghOwaUwv4HTk4lGVs7f5S/8PGlzI0/iMhH7Q7dd8OD+SjXX6SPDtaWd4pUAqcvDmx6QEsQDl4v4dg99VtGl2Tf+s4Q93w2aGsLxYY=
X-Microsoft-Antispam-PRVS: <BN3PR0701MB17181333D1C3E401BA24C1979A740@BN3PR0701MB1718.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5005006)(3002001);SRVR:BN3PR0701MB1718;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1718;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(24454002)(189002)(199003)(479174004)(377454003)(69596002)(83506001)(47776003)(19580395003)(64706001)(50466002)(65806001)(65956001)(5001860100001)(5001830100001)(81156007)(66066001)(4001540100001)(4001350100001)(97736004)(87976001)(77156002)(62966003)(33656002)(77096005)(64126003)(68736005)(2950100001)(50986999)(76176999)(54356999)(101416001)(65816999)(93886004)(189998001)(46102003)(23676002)(42186005)(5001960100002)(92566002)(53416004)(40100003)(105586002)(106356001)(122386002)(110136002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1718;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjA3MDFNQjE3MTg7MjM6WWd5K0dDM2t3d3JTZXdqODBpY3RYa3hP?=
 =?utf-8?B?aFZ3NFl0YkdpbHFER3hZV05VYjRZV0Q1MWh1NE13cHplcmoxd2hpTUtQaFpM?=
 =?utf-8?B?NnRtWEZFVk1wSXZUYUlGU1piOUhTSkNWQ0xNcWhGTWV3UnE3eTJiM01TUWto?=
 =?utf-8?B?b3R4M0NXUkkzOVpJVXlrZkluRXJSMDQvaktkNGNMcTEycHl5VHRTdWRiU3pG?=
 =?utf-8?B?bXk3M1FvN2hSY0MzQS9BOEtTb0hNcFd3RjMyTW44anVQK3ZxbzJ6MXlTUTZJ?=
 =?utf-8?B?N3dFUUtoUkIzNUg3OGlMTnA4ZFVXQnVPSFR2R0pCdWhNaE00VnkraXc4aVBv?=
 =?utf-8?B?Zk45L0tQN053dnA1a0hCSGd1YitYU3YxUXNyVXNFWkFoU0FlRldYWCtZNnlX?=
 =?utf-8?B?QzdwdzhSNGsvRUFselN6TFAzZktUTTcrMWxhU2lFWTJzUDVXYndncDdJakp5?=
 =?utf-8?B?TzRXM0NvQnVlQkhTTHAwSWozSnpmZ3lRV0RNLzNSTmFnTEthRFVPQ0NoVldG?=
 =?utf-8?B?RS9iaW13UmhGalR6aVdURi9aS2xuemNVOTBwTGI0RG1Gc241Uzl0VnRRYUR4?=
 =?utf-8?B?R3R1QndtbTVBMytjSjlLRlc3c3BDQVRLQlFqZkFCSHJwVldiS3dvK3Jyd3R2?=
 =?utf-8?B?aUVVWmZWbWtsM0NZZmd6ais2U3YyTmIxWGtnMWpvTS92dlBIc1oyNHZiS2kz?=
 =?utf-8?B?SndvS3pVVmt0WEZEUitkU2tBVkl1aVlnTVc0bWtKOXUrUlkzTG5STTNKVnZT?=
 =?utf-8?B?dms5bWV3VTlBOVhJblZmdG9jTXVYanZIRisrVGtGVFRET29hRmFINFI2dHQ5?=
 =?utf-8?B?SGllejN5VlUyMW1zNktvQk5kVzRkdkNIRXFXTUJUZ3N4K3BoT3VkMlpxeXJO?=
 =?utf-8?B?QnRpZXE2UW1QdlpTajhyRmlyc3M2eEpkQUpRNWpVamprb1UrUUtPcVpFL0ZC?=
 =?utf-8?B?WThHMTB1dnhPaUs0MFlvdFlsMElFNFUwZlBVNmRSS3UwbEVIRWZqcnd0YUMv?=
 =?utf-8?B?Q3FBQXRRYWFsTS9WK1E5N01rUk9LUWZQVUc4amQrdDhOZnpIZVdKWUp3SjlR?=
 =?utf-8?B?NVp2ckhTNEYyd0hKMFBmNTI1WThhZjJpQUpuRGRjeWdmWm01bCtwalhpWXNK?=
 =?utf-8?B?aU1NQUV2ektiQ0Q5cUJ4R2VKSkVnV29vOWNGb08wWjRIbnM1ejNyS0k4cUFO?=
 =?utf-8?B?WGQ5alFOc0hzZk9rd1hjVlFvVXV6cEp6UnF2bHhITGNSOE1CYkFrYUw4SDla?=
 =?utf-8?B?NVZHc2t4NDgzMmI4WTlNdE91VkduVFhDa1M2ejQzUGhTeHFnc0pRL25SRlJ6?=
 =?utf-8?B?RU9DMkJ1ZEZrSzNxaEZHTXhwd05idk81OXBoOS9XSXRGWFVLdE9tb1NDRWhq?=
 =?utf-8?B?MXJsYS9PdEhhWmdiZzZUV3V5VzRqbVFYZ0N6c05ndFB3WTZSNEt3WUdpd1VI?=
 =?utf-8?B?Vjg0VkNaV0tGczlHTU5JWmJHelQvaHQzWXRwOTBLUVBua2JuUDBkU2JBeGQ2?=
 =?utf-8?B?WlgyZHNPN1BydXpzTG1QM0N5MSt6S1hoZ2pRaG5WUzZKY051SU9RZGtuVDF5?=
 =?utf-8?B?QlZWRTgrSVpQdWVVOGNJWkF3NE1mWWw2UHNjam1SNlRvMEozdjZicmxnM1Nk?=
 =?utf-8?B?cDd3SjRvWER4cFpSOWwwTmhaSWVQaGRuSVU4dFplNHRYQ0QwV1VYdElaMVEx?=
 =?utf-8?Q?0XZrdmfoXIFZQE12o2hs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1718;5:pK1lU3PWndwyfd5atOPU6ov1TlpwJoOJtliRIdSL63pLGQN+8se1Ibz2i1KQpyksM9Dg5qhJOjiU6km6G4acOPITSW++vWe2z/srKN8wh74TL/4Hh0OBH1U/pytyz2YfMKhwCncUhbOx75WiU2FXQA==;24:nmb/uZY6Kjm0QcL9t8/jh1qRJjp6bXxz4dnudHSl5IRb94NbXUMoXCwUcjoHWrRZ94aPwgZRj11kd8ijsL7EpitrsaRostQIsd1PpmJ/dOg=;20:EENBWLCjA/ANbwnFmyH+VdSq3+jMR1c/acqJKkozw5tx5djkRpewrqh75pjpe5PeH7bK+RObLHPtcJjkXqcJwA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2015 01:07:59.7487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1718
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48644
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

On 08/05/2015 05:46 PM, Leonid Yegoshin wrote:
> On 08/05/2015 05:37 PM, David Daney wrote:
>> This just means that your userspace is broken.
>>
>> If GLibC cannot do the right thing then it should be fixed.
>
> Let's skip this until you explain how to create a fully
> non-executable-stack process.

Build almost any program with a gcc/glibc from a recent Cavium SDK 
toolchain.

Something like this:

   mips64-octeon-linux-gnu-gcc -o myprogram myprogram.c


>
>>
>>
>> You cannot change the default setting for executable stack just
>> because you have created a broken userspace.
>
> Please give me at least one example, one existing application which
> would suffer.

Anything compiled with gcj that uses java.lang.reflect.Method.invoke()

Anything that uses gcc nested functions.

Anything that uses libffi

Where an older toolchain that doesn't set PT_GNU_STACK was used.

>
> I remember that people already wrote here that this kind of apps (which
> is based on eXecutable stack and doesn't announce it in PT_GNU_STACK)
> need to be eliminated.
>
>>
>> The ability of legacy userspace to continue functioning cannot be
>> sacrificed.
>>
>
> Not at any price.
>
> However, this switch is a separate patch from others. It can be not
> applied or it can be applied, depending from prevailing mind - what is
> more significant, some (unknown) app or non-executable stack protection.
>
> - Leonid.

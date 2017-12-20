Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2017 09:22:25 +0100 (CET)
Received: from mail-eopbgr40111.outbound.protection.outlook.com ([40.107.4.111]:43008
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990421AbdLTIWS0lv1f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Dec 2017 09:22:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L+5N+qoI6cGcg8jHaDthyHDIELklTS3wT7aLtidQILA=;
 b=Dp8ckMaea4sZm3aP3Hibqcb1yknwVtHeAKMYTKVdSFsFFRHAt2B4ZKAZ2X0CCHBM8RJxdJIlCXuBqS9eEwpaUAaReIUTROuOuddAvkrSk1ujuxd6oCpjIB3HcnNTv4sYZiUl8rdMa0ufVixeZyiL1Sb9PerID+BUhH9+4ra6ZVo=
Received: from DB6PR07CA0165.eurprd07.prod.outlook.com (2603:10a6:6:43::19) by
 HE1PR0701MB1977.eurprd07.prod.outlook.com (2603:10a6:3:11::11) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.345.10; Wed, 20
 Dec 2017 08:22:09 +0000
Received: from AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by DB6PR07CA0165.outlook.office365.com
 (2603:10a6:6:43::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.345.10 via Frontend
 Transport; Wed, 20 Dec 2017 08:22:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.240) by
 AM5EUR03FT059.mail.protection.outlook.com (10.152.17.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.302.6 via Frontend Transport; Wed, 20 Dec 2017 08:22:08 +0000
Received: from fihe3nok0734.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id vBK8K3oj025291
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Dec 2017 10:20:03 +0200
Received: from [10.151.72.63] ([10.151.72.63])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id vBK8K28j025066;
        Wed, 20 Dec 2017 10:20:02 +0200
X-HPESVCS-Source-Ip: 10.151.72.63
Subject: Re: [RFC] MIPS memblock: Remove bootmem code and switch to NO_BOOTMEM
To:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <paul.burton@imgtec.com>, <rabinv@axis.com>,
        <matt.redfearn@imgtec.com>, <james.hogan@imgtec.com>,
        <marcin.nowakowski@imgtec.com>, <f.fainelli@gmail.com>,
        <kumba@gentoo.org>
CC:     <Sergey.Semin@t-platforms.ru>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
References: <20171219201400.GA10185@mobilestation>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <e4ef6c82-f3c1-1a07-9f0f-cd442130ef37@nokia.com>
Date:   Wed, 20 Dec 2017 09:20:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171219201400.GA10185@mobilestation>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(2980300002)(438002)(24454002)(199004)(189003)(65826007)(316002)(6246003)(22756006)(54906003)(4326008)(2201001)(53936002)(77096006)(7416002)(76176011)(50466002)(47776003)(65956001)(65806001)(110136005)(106002)(39060400002)(53546011)(97736004)(83506002)(5660300001)(229853002)(2950100002)(58126008)(36756003)(64126003)(86362001)(8936002)(2906002)(68736007)(26826003)(230700001)(31686004)(106466001)(31696002)(478600001)(23676004)(2486003)(356003)(305945005)(81156014)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB1977;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT059;1:+uMQfDwBWxW95zd8xJ81iPKuftMMzNNLzJP9ByQY+amtSViKjBj4dvtioSce/QG83UWveWehAgGIktWgqiuZuf+BQ/THq66W1IIa9uhm7LJ/u3wtrnSrDmZ9AE4Yq1Dx
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 460970f1-fae2-4565-f906-08d54782c31e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307);SRVR:HE1PR0701MB1977;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB1977;3:m0yIJUgRpgoWRNY4iLKjyd7PB4fZVLDbRxGSmQvjlzn/rxQkDNIoC0cd3rd5LHH+NOptn68J/Kg3zJqnwhaVmeV+jEVTn8QV9aeVf+HWPe7vHr55MlnG2DJbvh4sDe2HVx096E1sJVSZi1JY9UCmTPECHEB/zp7E/rmb5n4xmEb7R7TLvwa1hR+GOTFdQk9DgAIedpHPwvKGJ7YOy+PrypxcmiN98Y/RcWsD6L9b0VyWnRabAabMmwm1gRDXbrwZB7rKriPR6rvhZvNl+KWpyyThc+JsmDmshGxPtUug5Ky/Rh4Y8l3Ryb5VGZEmUAhlDDI5ZTjUyTo5c7gc+AFKJc8VALFMpA+vz7Um0bc7kPo=;25:rdrXgmy3OLm3iXoQK9m+LuuTh1WI9Jj5HDU9FaySXzsvDx6pP+Pj+XZIsHuZBjPXqUpMIZCNOEOvfFoiPHT5nyL7Rf3aWMZHCD0wMBlTwTdTcXX22N58Z08GJqrxpwaG29xNtHyZmYLSRo9oIgRcm2V5kgOMQCsobqk1HEwIUQxn1iYabwvb6Gaozy0uCXdGScfPLqShZMXrZ2IjzW+HIIQBEF0kD1GV+D/eXc8j6Ih7lGLWYCPajYBAfq5QbVMljlOauMsf5FTNUKecPJFV8u1Ub6Ys0gekxLV8A77puuoDtEIePX8oNQ45/sA9XIVPwCXY+ybwVnbiyAN0GIgTGA==
X-MS-TrafficTypeDiagnostic: HE1PR0701MB1977:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB1977;31:jsdGiYUbkelxIczu8FP7u2YS+GtwjerMz5utFFCjrrgoLvMDMW8BdvlM/YV5wjVXK0v5FcHA9pva9z2l/ghh546A66oSyZBvdLoNQLheryadRJwSdk0wm9x/BdW03Utg02IzofjK4F9/90iIW4wjJ651OUK93sXNZP1Td4CSYjh6/EDCr4EKg1izzNAP/UcljTFIMqYeSCiCRDq5isJjqXGIJH31P1ume1CYb8jCFsg=;20:x13rfM9baSEzXIydjh2tIBtqdhLCxTneVE0pl8IvJOSWx+ZUFsosToplmOQ90BCKoBqJEhGMrti158BKeu4bBiZbBc+nhIIshLH24iY55okNpGS9kpFploz1TkstSqNRcPgQxi+ZhL7i7URMiKY+4OgM144l7cr4KAhYjsidLhXu5fNK9odl9xhSMAPzVQjl84dCWkT4XWwBlcgu7ZHLDW9iPiYTHiH+Epi/0E8Y8cvmhYo67S9qcF0jH+zUPRky4kvie9fQeG2VfywXY+aVldo9pBenR6ZPbnrERQrqxL1Ib0hAmvC55AFSGhn70Ao4rgthbGEisY4k4UPJcJrSsP/j3rvSGQKoAL6uZ02HZSfAza8xKJ35fV6VlMIaYRNG/i3ttdKzbJ7mSszdAK0RFz8ys2CsL/Kar+Y/DjFHM5nDvjLW8y0J6mn7AIGcGWs8HjvyDSND+PZQdJ9SiAQ3GzuA8dQ4lksq7kmXcZPOwzWpVYFoNcXkDs0zzv3R/sOEEM87EXKbO3EFNj02uhu++8fxNv9PVPjOA3+0l8Q3tdI5fg+htloF5UctfxZW+mcgSyS/R3QUWeZfJWxAQ5q4uIIPiGrHUHoWbsHZzhZ0xpI=
X-Microsoft-Antispam-PRVS: <HE1PR0701MB197763FED5F3D26F11742205880C0@HE1PR0701MB1977.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93004095)(3231023)(11241501184)(806099)(6055026)(6041268)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0701MB1977;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:HE1PR0701MB1977;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB1977;4:h2TWRuxiovPEAOBf5o3BvLcFSuf+u38Yj7WGTVi73sPZPBBXELxomTHA6q8M/dhiZAcao83syCumiOMJ35XBYKTY19ZafQH3iv4N8ciFozQyfXk3JvtiXJtEphS6PiOfWMWvev3sh5UBBu/DdWunsS353jWl/ojm8N/vCAY32qYzqNCYfnyrSv6K3n347mkERJIAKSlLZkjhdjwQDeLtUDUtrXG4kBSNheMfGryS0jGNG6bf6OX4oFPNXZspnunflSCAtrbY+MGRcrSwGJPxXA==
X-Forefront-PRVS: 0527DFA348
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3MDFNQjE5Nzc7MjM6dm1BeWNDSTU5R2Nwd0JpWisvaTdsMVBu?=
 =?utf-8?B?UnZ1Z2hLSGVyMnZKUExiQWJQcjBmMEhZeU91ZVh0SGVuYnlVd0VCU3V5Y1Q4?=
 =?utf-8?B?RWZpTFZHTlFxZ1hENVBCR1ZkSE9kV1EyMWdaUnFmb1ZqM3NVckl1ZjVXWVpm?=
 =?utf-8?B?QVpYYnZSRWpSRHc0dnJMRjQ3SEpDcm5jQ1U3U2s2S0NsaVRlQXBQdEZsSy8y?=
 =?utf-8?B?bTZQUUpWejI5Y1lQRjFsY0t3R2MraWUvYzV0ZmVFbVpKUW9wSnBlaEdSeVc5?=
 =?utf-8?B?U3JjL0RJYlJWVzBoYXFUbmV1WDdLVVNxMlNLQ3JyWVBJUGxGTmJSZWpyVEVp?=
 =?utf-8?B?T1doUmxYVHV0MnEweGtSVFVCTmVyYnJaT0ZUQ29lYUh0S2Jud2VXdGd2SWp5?=
 =?utf-8?B?WWdhemExQlFiam9sS0F6YWwrRG1LVzRBajExZ0txUTBtaVN4eFVsQ2NtQllW?=
 =?utf-8?B?Q3d6bVoxcDQ0MXp6MlphUVdsOGM2WVVjaWdlQUZVK096YVJXM3ZpN2JiemZ6?=
 =?utf-8?B?d2VRYmRmUWNxU2xpMU13LzdEbWdiTEs4YUNHakNwWTA0N1BYa3dHcVVNeXlo?=
 =?utf-8?B?SWVJUlIzODlrZ1ZQTE1GOU8yV1J2Z2kxK3NsK2xKb2lLeUlFaGttaHREbzB1?=
 =?utf-8?B?RVVDRkNFUUdPdVYyaXp4Z1A0U0tjRnZPTHhpMHJwWWNoWUdoRzAyODdSdEpn?=
 =?utf-8?B?WUFNeXFuVHRSVEo4R2pjYWQxYkMxc0dUSFgxY0JEbVliM2paRFc1RU1TQTJo?=
 =?utf-8?B?QmtFb2F4ZGFmbjNFZFpubnBRalh3Smp4VHFaTjg1c1lqRGdHeEE2YUl0SERw?=
 =?utf-8?B?NWxFR290OFZhVDBiaE1QVldVQ2trTDQxeklXS1FxZGpWMnpvWDBmZExFSTlX?=
 =?utf-8?B?ZlNDZ3FGcGtyZjMxbVJ5ckFSOGV0MGtkTkUyTDl0UlYzRVRLa0hSRGF6VnE3?=
 =?utf-8?B?bC83dWpqZXhCUmNyaEdOVmZ6Q3QvZm5VNFMrKzFRdHo0dUtad3FWbTM2TVU3?=
 =?utf-8?B?UkJMVFZBTFF5dHo2TDQ1VnQ0NjBzU3hEaG1RTUtiZUQ4R1lZMkk3QVRiRmZh?=
 =?utf-8?B?UzJUUGQzTkFLYW5tRDZXS05pRjE2R2k5NDg4ZlBsdDdkazVwa0prR1VSeFpl?=
 =?utf-8?B?Si9TYmJFVzdsR1VxbzcrMVhmQW5LWkcreW1HQ2FTMHlRa0twaXl5c1hYV3VR?=
 =?utf-8?B?TldXK3RDYThJbEtGSmxPMkxneXY1WVFObndvZjBPRDZRbnI3QXo4cGtSUmo5?=
 =?utf-8?B?VldCM0RuQVFNeGZ6NWp4Z1hpN29lUDF2NWdncldHRXlJbEFaWS9xMFY4RUNt?=
 =?utf-8?B?U1EzVzBvRU1mcXdrR3NrRzVpaWE3RlZDSFZvaDAxTVBxOEk3V1drc1ZBTThh?=
 =?utf-8?B?LzVSbDJhZGRyMmlFWDJWYSsvNzRLWGtaRXZRdWRsK1hpbk5WZ3UzcTBtNERa?=
 =?utf-8?B?ZWNvY0VBbE1rQmlpODdIWTdrY3VCR3lzdVdhU2FDYVM4bzFZVnRHMDhSUzhF?=
 =?utf-8?B?TUJWaExnMzZmaS9XQTlxZGwvV0N0TkM4ZFl3ZXB2VHpIOVE1QzVaTzdjU3U4?=
 =?utf-8?B?dXNPcTdxYi8waE5KTTNFd2cweS9XVW5hZTRxcGJNMlU0YWFuVjV1MWNkZTYy?=
 =?utf-8?B?enRWdWVRdFFNZmdFMVhDaVBFTzVaejEwZkFRK0lvVHVnYUtuVUJZM0pBZXZF?=
 =?utf-8?Q?Oh0DkpQ/m1yDNq74ayLuv5D+U5AQdBcOaRsut11Nz?=
X-Microsoft-Antispam-Message-Info: Y0gSIWjVUBYdiQmX5C8n+Yyfy1O2ocK7fffZWQBlaxFWarZkNnzeK4RKqekZZpFsLq/eSyXPSRHekKsA/quwog==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB1977;6:uc3hJjJC9TQB87YSlFJcEpaK6ZT+33wpDa0XjTXdxPvQ0XtFp1nu3k9YA+rLIhj1eYOYK0oFNm2LixPvFiaKK8kUzV+EMSwNHQZiUeQb6HE7pEnvROfU3nP7EzqVCc35LlMXpD7Nde3TdwZ6geEIxC8Daz1mZno/xI+ZwwxXe5Zyb515Dugg3x5h1ScFyJdCABXH0KWveB63kRMEBG/MCDajSfLHK3w1ML7C5244ih7ocfYbbnb1QmCiHRjj84pHXbrzFym+kgrwFUyPRvNHq+V1rMaH63sTzqqVdpcjJIOZ+LRSsQDTtbaRJ3y90vhLh/fPBxXb7VXkvbqahhf3vMxrtrQTHFZtJnrZniqlQjI=;5:VCIgIyZ+lERPh1By+FvH+lEyyu/u6JV7JLZEEPXoHL4bUX1Z7L0tsWN1hfjnjm3lHHE1eAhTBWrA3083mduX9TnpveZwxgz8SnvwTf32IHQTECHyKw2xePWWq6JTR0aRMvyNSjmRVCAerMIjCFbJVFPft1cQvoRm9lF29lHZGkQ=;24:2dTRwOughj2sTR8hrvRhCPOJSlTMj56huEOPllT3i24ecDeeNxfJrwlWsobcubjEOHEculZbLEkPSHYOFr9rEk2p5UTAA4t/6c8XPxlEojk=;7:0WY4xRm3binP3nbHsoQ3zT5vyjqP1RU/7STT2G7991YUIk38hfS8k/0OpPq8tQbi6KlUUASRuDlKTM0hOyi5267UilT7IUNNMNV7q8gOpdIV+womd4t3CHz0lKFhieLcve8ZmZQks2L6vCf0ThXBjrd3tZ1l/9JrC8X6+0tVskCApoHfEMsapyXqW+6K8ERvb8hBmezM84/5nnDLn915Loo070Z3CPb4iuN7BuqKKkSWV7mT3gYM7H+xwVJHOP12
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2017 08:22:08.4105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 460970f1-fae2-4565-f906-08d54782c31e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB1977
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
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

Hello Serge,

On 19/12/17 21:14, Serge Semin wrote:
> Almost a year ago I sent a patchset to the Linux MIPS community. The main target of the patchset
> was to get rid from the old bootmem allocator usage at the MIPS architecture. Additionally I had
> a problem with CMA usage on my MIPS machine due to some struct page-related issue. Moving to the
> memblock allocator fixed the problem and gave us benefits like smaller memory consumption,
> powerful memblock API to be used within the arch code.

[...]

> @alexander.sverdlin@nokia.com. Do you still possess the Octeon MIPS64 platform to test the patchset?

yes, I'd like to test such a serious change on Octeon2. Please include me in the distribution list.

-- 
Best regards,
Alexander Sverdlin.

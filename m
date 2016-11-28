Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Nov 2016 15:47:50 +0100 (CET)
Received: from mail-dm3nam03on0044.outbound.protection.outlook.com ([104.47.41.44]:45792
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992514AbcK1OrnzVQ7p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Nov 2016 15:47:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3iBoPFUMDwHMzVfUKnB/Umx8egd3scBSvz8WwJgvSS0=;
 b=ajXzgnWFYuA78fDRnnRxIZmMpo35jy5pFmGmzVVXemtnY2gILH1xoNth+L9ay9F12AStEfRAxkOtKXCpVwWsNB3nTbCU4nNDky4KKieYLGnAvduvh+Nw2/awDA2Ck9ZsBPPPkxf8lGFMjmk2HATTfhrM0wKIQubdR4XcG4YPC40=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 DM5PR07MB3209.namprd07.prod.outlook.com (10.172.85.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.747.13; Mon, 28 Nov 2016 14:47:35 +0000
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
To:     Wolfram Sang <wsa-dev@sang-engineering.com>,
        Jan Glauber <jan.glauber@caviumnetworks.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana> <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana>
CC:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <10e3f92d-2f8b-0862-1029-e9617d770f73@cavium.com>
Date:   Mon, 28 Nov 2016 08:47:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161128142208.GA3916@katana>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: CO1PR16CA0006.namprd16.prod.outlook.com (10.166.27.16) To
 DM5PR07MB3209.namprd07.prod.outlook.com (10.172.85.147)
X-MS-Office365-Filtering-Correlation-Id: 3ffff6a8-08e5-4cff-6573-08d4179d7e4e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM5PR07MB3209;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;3:kwUsNHHYKtxchdNhZK3cT5sdSEYb+WWm+LrKspYND27lE05lHYbGlHpBSZHHjxPVT/NxbFMkU7cTNrM8aY49M/JGvaA2TPCiU7V3dsmgf5ie/CEX9LymJGGd2+7vImUcJahkPraxurueZdlZm/aD/NSfETmU/aTMyW56/Sml8srCnzScLAszWg+9Du6DVanoGSoWTVME+y02a1MJpKVw+bTpgNyFVmXUkgElVMkpUnjktUBBA5l1SVhy1xbzYIgwYQ706jzpKrksUzd6wS+Sqg==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;25:ka+Ei1lLGDWveG10yoNrvVYBowGIjWdIbPhiRbwsluB58MgMd/jQpZptwYuVrCdzo3BML08gxAW1YuD4BXg5E+thCFMpTY8wjdgRZcpVq+PC5IGDZ3zKSXXbV6joWnvtvsJkbAa5+6XfboarnvmGSmTrwywvCCQZPdJjLK1kICLCe/m4rXTlr1eXNYUyrjxCHkl/UuGDFsr1Y0tqonhsJXXxeQuWehxAHTQsOkakYncdCJzR51AmYUnSoqZ71XaZR+zFx4wHKs/JA/mgseiYDgKU2bTHLiTYqz8f5lvndfY/rzDbvkkTB6llb6MgFdQaKldV6CNeYaESRsxQ9U01BrguHNNfr/rtZutaXqL0ngP0xh6v15n2mSNmOsQiq2IcFklT6oLz75Yo0pgDllIFGwNh78sLFhNEGzZK/1dH4/3ETgmIlGIVwu3hDZ85vA6dStgPxkxlnXvxJwdNakOesnhU136mkiUGMDhp6r9Pu1vznwmBT9fNnXpJ+7+5StWDYplUKDlIvIoSouarkfFVA4YTdoieH2xr00tBN97qnVpKoCq72QCtW57iZq7ubAg9Ur4yxGtkIlauSGbPsuo+9j9W+YbSWjEj4HhcQzBX7klWbDlMYrB2VIuOsAmmE71MMMNIJM8VdLwYqygZP2agxjJApwzNxNfJRKlINTfw5lbwjSlehRzdJAFGsn04zuLRwTqVCknQA2K5BkzjAYHu6uEiuLK0qYUoSLfrpzZbVHbrbG7pdonRgu5f1V3Ga3vwXLG/GSQRz5+9GBp/jtKarnkuCR7SJrAqInBJ2Mn16ng=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;31:ASa16y6k63EAQxlyZxzxhiCQj+J8XNj/8XLRvqWOGHxSQ/1KxN5JQDtkWtVimc+0G1/cmJGlLtzSzoRHS2nqKfCS+vvzpVKDgC+03kPn64qbs2u5kSo3/WHeUfil/nb6vL6cw1mjLC6XHoToLeID99fSjD76R5vclDs1WUHVR6UI0ij0Mdf5mz3JEP56I69Pgy4qopBSqKZ9C0ZqsUzt7nVTlnsd09KY4VSSQJ0MXpWeYH5TlIi/5jz1P6kjFeR4RPbnByO3D3ezN9ijO6oDRktkx6Zd9N7onNFBgz7r+Ig=;20:LJQfamTCyyAkgv5JZrmmHMWdJDdC2Nl1QSBVj7utivJ/QCJ1IDVcbwQbxkAJbwoTPtqQLOxhgwDFgSEJpzvPsN/NWMM65nmMWKGc6osFi0Y2m5XDYAly7PMSvnNiikWXI3i2nCieSFCjZl23qs1MEkk++P3AXoEdOpk6jSgTDXMszP4eWvziJZKempL+1L6Id5M60b89R0uuNOy/XoD0RdcNZUwg8Fixgo4U75gMWD1+wyL4MDslcI0OgaPOKajdkBUmSgicXwCLcUmt+45eULfHo3Ttgq2nlHBAXcl1O5nwLbBAvtn5wCubQU45E5Uh6RCb45J/QvgTZTWSZTloy4xVqWwPF4g53oDGY8WOoLBxMKKipIleY68P1jL3gj1z3XUQ13yZ+/GyYN1imUPUraZIIBNnMPDhB8yNPfSCyJvryOtWI4E0GDFb7fk5/rHMaD+vgYIooXI77PFrF4YjT+Cj5N2G16S2oXkMXVZhg3AChnhlldIzi3qvupEZK4De
X-Microsoft-Antispam-PRVS: <DM5PR07MB32093EB30D488C2AA9D64647808A0@DM5PR07MB3209.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6045199)(6040361)(6060326)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(6061324)(20161123555025)(20161123560025)(20161123564025)(20161123562025);SRVR:DM5PR07MB3209;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3209;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;4:UOAdhGDYUkS4eg11aj5Mlh2BL5drq1ByXn59tOo5XPTVriNNahRz640I4HUJ69hq1WPbRI0J9oopDRJMVydjWWaKOY3fZpKwEhrXpahXdzvH2nmZCZGtvATlsXEmnqfZ/ELwtF1tBG7aP8aAvjmyeLlrFAClGPLHzDg4G2VQheEynYO5OLfki8bT8N6LQgSrAcdl7xoqAcGHWyhLeudOGfenFhFTd7SjH/EGDXBTtzL3qLnGnYMK8IJ8XuIN7OzX7O4+VUu915leBDwu8hT1fCVG8KDoDgATSUSn+hcjVNYTScInWUIzUN0q8IJG/aj7146iWz0S475QDPoAvFipsBKc928YEGr0AJIQDP5a0Fd4AFJQoDkCxWAhpdDYI5e228u9oxXQMdMS9ZdUazNaNKf25mU9j3F+hldWVAlO31PGxSzAfCrY1c9LllBTvkq4Wqeq3GRJYbcr/zCwoPdyCYGpdSH4oeraZG7T2JpzWgVigqTZi74hxV1u+8+6o8Q1VzocX4tTf8Pv5csM6Ox5sM5qUtGESALM+NdD7T782JWioyPtgPFoAd+3oH9bX0p9XEEEFYyYX76Pgx27RTQ/w6QVr37CIN5kfY/wIO1YtVA=
X-Forefront-PRVS: 01401330D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(199003)(24454002)(377454003)(189002)(77096006)(733004)(5660300001)(39450400002)(42186005)(6486002)(47776003)(101416001)(31686004)(105586002)(68736007)(65826007)(106356001)(6666003)(76176999)(50986999)(81156014)(81166006)(23746002)(64126003)(50466002)(54356999)(2906002)(5001770100001)(4001430100002)(230700001)(39400400001)(39380400001)(39410400001)(4326007)(36756003)(4001350100001)(38730400001)(229853002)(31696002)(93886004)(305945005)(83506001)(33646002)(6862003)(65956001)(66066001)(6116002)(3846002)(7846002)(65806001)(2950100002)(86362001)(7736002)(189998001)(8676002)(92566002)(107886002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3209;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM5PR07MB3209;23:Ol0DNNsHkunz8jIiP+cfcvc0qby4W3dkeQ4wE?=
 =?Windows-1252?Q?eq+8moq2TVpKuc5X14r8+kiM081PmVVR95N8wxdO/JHynYyPCCIW4I3M?=
 =?Windows-1252?Q?3NSlvia7cudyj7Cl8pUduyWp3QXa8Ia5DUHLGhfqzzLO28JHSGMVfeG7?=
 =?Windows-1252?Q?xaKL0cPCiMd7pqXnEXlp8dOF0A3YBrvQfPyBkw7jW75EUde1A3/Hh42v?=
 =?Windows-1252?Q?9ipKybJVspjBQHvV3wIfsTCQnO3gcRPSG7VUjb8PotrYOArV+hdapJ6H?=
 =?Windows-1252?Q?4B9tlwAnBXUpZfMKRvX1TqhDWZgkcpfVfIHlYbUc0i/ZPaJGcmdD3WO6?=
 =?Windows-1252?Q?iRdUpPx7mr5MDstx7ZoOijiItFiuNBbAH6qO1ECiWY6DwKsS/jqQu2HL?=
 =?Windows-1252?Q?jzH5OjEj+Y6n3QJKkRsk1HwUHto+l8XHZt8yIt6Xmos/fSU8eC5DTVrq?=
 =?Windows-1252?Q?qNsmMdsjsdX4qJCbBxlShNQVBdiRDsNeZSbv7DK6rDZnF0buKFG/jt5y?=
 =?Windows-1252?Q?Kh8xCX/LqCnbUOTpkKjWjhf9B+wnb7DydzFkeZfc0T0WSPJN/gHlCUMz?=
 =?Windows-1252?Q?IjDSWhEgei8ud+LQj0KH8lB9YHIPe1OYd3A6YOh5s0aXYAB+ElRKA7Sb?=
 =?Windows-1252?Q?In0o8gMMHhOcEqN4YsAgRPXWoE8KkXwUj5X8dgxOCJSXpIC0IZOV0tFh?=
 =?Windows-1252?Q?k7xxIDMuHeUPEyLh3SVWa3nGqPTlT/uHqCurqNQTIy3+lHc52tQF+kcy?=
 =?Windows-1252?Q?9waCgc8gP04lY19Mtj08O+U7SxcymLeKFVU+KEoQ2ncDvDh4UeZX+bxs?=
 =?Windows-1252?Q?EYyh+Yw1B7Ore+3XUdXdYaMI5hWlJPfFh4l1niBIt8cxjb+D0rJZxx6X?=
 =?Windows-1252?Q?Xacyk878ZBPW0zxV2I+6j4A8TrV6K2xD+ya0IbAEwFp+yy4cuQR1rq9o?=
 =?Windows-1252?Q?FLvJaonKXW3+noGDrizM/03WcU47Qkm6N2YbTB30iRDXzNJCHjuXbMqF?=
 =?Windows-1252?Q?VeZOswkWzlbLmolxFy6/PZwgkMuzd2MchIvb4JkNl/LxGKv6QMlyMU2L?=
 =?Windows-1252?Q?LJbjkgN2Fwh/OaQGR36m3htpdTSoOQs9vL3kwrZlAcrvi6+uLu2xGQ+v?=
 =?Windows-1252?Q?bDQUZI1r408tSAHK0tD5D8fRdiPz+AhcvQXu4XqkXtEYvGnNZ9lq9DDW?=
 =?Windows-1252?Q?sMZsZdBWPet3q2T1Ng/lehZYdsJBcklcJAw7FLVC0zAi5wrJrHQolovh?=
 =?Windows-1252?Q?ve5x8f7I8z8k1vFjbMNOls9lS6ufHq2XlJJlATJnhxQmN5ES4TXbO9A2?=
 =?Windows-1252?Q?2QzEf+wl8Dti5rjxl8KCmHOlWz1yt6PPigwZEKlMbCw6nywPS2KIP2HD?=
 =?Windows-1252?Q?TMtVlpKSFsfgF4enn8WMDTRKZOMNJyAjofVH9P8tLRtrJ/yQfjsle8lg?=
 =?Windows-1252?Q?z5RprW/zddHvw4jyK+MHwJa9gqqbBPt4oHs1/ZVcywk2z6f7bKPlSAg0?=
 =?Windows-1252?Q?GJfLbWlMuwtPQMw299YHuJS5OtuIE1mRzBqu8jiWfcTtETu/kOtOfk1D?=
 =?Windows-1252?Q?8SEMjPfA6pSqLsrKHrhgCk4j/HksU/WS5HmOcogI/REbZpAcVRBNdUzU?=
 =?Windows-1252?Q?DL/QhW+4UCUZA2x+iUpiaQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;6:Br2vRJ36jfvtmURF1qhqDcaSe0g81gk3K1aExNrAJQPMjJEA7yBTMkSqcsxLR3paunNWaRz4LgHA2irCuSA06EkjvH5gpol3MDLo7HoUhKxHPjrsNxeLn0m1pQup0b2EOboyd73+SVszP9e7FoXw6yLx7imAaVE6YtVVj4guQj6P3mmQASC7LjlCtQe4w3LNbbYeA4XYditUOA1lNPYNCOkGlPvdBgyy3ieyvLtH9oePjfBaDPWizpiEoKDP7IgnSwjvW1XxoZoRwY/4dbeDnA366sRJbMUf11H3z36ZzqY9ilXnPFjlrFmMjAL/HBax+o/fe08KvVt31F6rEsiLZFKmNdXW1TzZgvSkYkFLcDRZySZ0HyyeXYYmUq9embq2gQpqLZlZRWfbgBeHsqvJPa0O/yYNE1dBsO9MTjC7K+tFJxOxFf3vYbMIRzyEX5eoVmzkDFexjF8poJLEOD85lQ==;5:FwE52gA5ytWr4DDP20n6e+FEpekOq6p5Jp+fnRpWATXnnSVHRVzS8YQ3lIxgXT5nNeISBZ4wcCxz1XVZCfZLN88amkTzWDQu1UbpdlgsKb0m7kZZdkd1iTF+FdTi6T5jkPxWTnhDAt1ZdpC5KWNh05iMTrsm57xLEeG27PQwa5w=;24:z2hkV8Cwgr7AshZ3tA83sHsKcKhtSCpny+NhIKFx9+LHu6JUWyHqUsftIEgTZ/eTZEuT3bFcM/APVIXPrMa2ClcDmTFJNP2rhfkIAlqVVCI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3209;7:h16z4k308uIfNJBTzrIw12ShpvShFxk90zNAFDkHWiGFsV9u0lqbiPJeRKXjga/uGEC9TVn2SjuNrw7YeQmf/7Huolb4+ajCdjYevFx07Gi+47w3FyEh3SPHYferWbQAg6A6jS5QDOMggteETwf/t4UFD8XzL8CgCJgsccpbmUFpANFVZKvnFMnF6CWgkqhJu6foXlDJhPIi6yNxvxnn8WDrSahH/UCg05uJz9VzPN/1WKg4zwt/8/qd21VbRBHAe+L3VBIxLc86rsXsplZsVueQoanqEGq2WoESFfBR2P6YNsMngBe0cF8c09sXy09GRaxZ94D6S7QRBXLZWOizx5bhMFvqW5qyCxE4oHdTujjRbKplbK0pR7piqpJ5qJfQNtCBkJnn+oeyRoWACBcaNiVXDWY6WEMlvSU1+BxkElIAtUWGhXHNXNsM53iLnnnrHp+Gb1A8OdlrWSbxc2xRRg==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2016 14:47:35.0493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3209
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55903
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

On 11/28/2016 08:22 AM, Wolfram Sang wrote:
> 
>>>> This does not work on Octeon 71xx platforms. I will look at it more
>>>> closely tomorrow.
>>>
>>> What's the outcome here? It seems we want a bugfix for 4.9 but this
>>> report keeps me reluctant to apply the series.
>>>
>>
>> Steven, did you have a chance to check which of the patches makes
>> Octeon 71xx fail?
> 
> How do we proceed with this one? Is somebody at Cavium able to contact
> Steven internally? I mentioned this on-going regression to Linus and
> said an rc8 would help us, but reading LWN it seems we shouldn't count
> on it...
> 
I will finish the bisecting today and will let you know as soon as
the bug is found.

Steve

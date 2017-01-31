Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 20:32:31 +0100 (CET)
Received: from mail-sn1nam01on0077.outbound.protection.outlook.com ([104.47.32.77]:11840
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993899AbdAaTcYclwvi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 20:32:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sandiskcorp.onmicrosoft.com; s=selector1-sandisk-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fn7OQvbaMbLlF6Hw8sufMBIIMXYva9Qd4wYVY+DRA+c=;
 b=lafeimHWequ1xIjCMtpaR7c2vosUztuzc8kPs1QrwpuCgDpPRqI3LHuy4ByyrEcocc6rfH4jtRzcQojpShhnlAnfsAwXxZ40M9Gjxf3DCBo/X2vV656GiyvnbD3cpYXrYNfshR3a6a5gj4FfwJUpFCwbBBRhjq71jpUi+6rxj2c=
Received: from BLUPR0201CA0017.namprd02.prod.outlook.com (10.163.116.27) by
 CY1PR02MB1415.namprd02.prod.outlook.com (10.161.171.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.860.13; Tue, 31 Jan 2017 19:32:16 +0000
Received: from BY2FFO11FD017.protection.gbl (2a01:111:f400:7c0c::143) by
 BLUPR0201CA0017.outlook.office365.com (2a01:111:e400:52e7::27) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.874.12 via
 Frontend Transport; Tue, 31 Jan 2017 19:32:15 +0000
Authentication-Results: spf=pass (sender IP is 74.221.232.54)
 smtp.mailfrom=sandisk.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=sandisk.com;
Received-SPF: Pass (protection.outlook.com: domain of sandisk.com designates
 74.221.232.54 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.221.232.54; helo=sacsmgep14.sandisk.com;
Received: from sacsmgep14.sandisk.com (74.221.232.54) by
 BY2FFO11FD017.mail.protection.outlook.com (10.1.14.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.874.2 via Frontend Transport; Tue, 31 Jan 2017 19:32:15 +0000
X-AuditID: ac1c2133-4386e98000013ebf-66-589160b8ca19
Received: from SACHUBIP02.sdcorp.global.sandisk.com (Unknown_Domain [172.28.1.254])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by  (Symantec Messaging Gateway) with SMTP id 43.4A.16063.7B061985; Tue, 31 Jan 2017 20:14:48 -0800 (PST)
Received: from ULS-OP-MBXIP03.sdcorp.global.sandisk.com
 ([fe80::f9ec:1e1b:1439:62d8]) by SACHUBIP02.sdcorp.global.sandisk.com
 ([10.181.10.104]) with mapi id 14.03.0319.002; Tue, 31 Jan 2017 11:32:11
 -0800
From:   Bart Van Assche <Bart.VanAssche@sandisk.com>
To:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
Subject: Re: [PATCH 4.10-rc3 09/13] iscsi: fix build errors when
 linux/phy*.h is removed from net/dsa.h
Thread-Topic: [PATCH 4.10-rc3 09/13] iscsi: fix build errors when
 linux/phy*.h is removed from net/dsa.h
Thread-Index: AQHSe/i3nY2j/fx3D0CIhHO4QnfypA==
Date:   Tue, 31 Jan 2017 19:32:10 +0000
Message-ID: <1485891116.3113.2.camel@sandisk.com>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
         <E1cYdxN-0000Wr-AS@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1cYdxN-0000Wr-AS@rmk-PC.armlinux.org.uk>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.1.254]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C15BF99F1975BB4F8A878C6D0FDBB237@sandisk.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWyRobxn+6OhIkRBtsvylvMOd/CYvHr3RF2
        iwlTJ7FbXDhwmtWi+/oONotFy1qZLd6suMNu0bb6DKPFsQViFpf6JzJZtC59y+TA7XH52kVm
        jy0rbzJ57Jx1l93j/vYjTB5HV65l8vi8SS6ALYrLJiU1J7MstUjfLoEr4+aE2IK37BWHZsxm
        bmB8x9bFyMkhIWAi8fjocsYuRi4OIYElTBIrP01iBUkICVxilLh1NB7EZhMwkpg9YQ8LSJGI
        wDNmiesbZjGDJJgFehklpv7PBLGFBTIltvRNAopzABVlSey46gph6kkcuCIDUsEioCpx7VYX
        I4jNK2AoMX/GQnaQEiGBdImp6/1BwpwC5hKHjyxnAwkzCshKtLzmhtgjLnHryXwmiIsFJJbs
        Oc8MYYtKvHz8jxXCVpD4vOIfG0S9nsSNqVOgbCuJlZv3skPY2hLLFr5mhrhAUOLkzCcsExjF
        ZiFZMQtJ+ywk7bOQtM9C0r6AkXUVo1hxYnJxbnpqgaGJXnFiXkpmcbZecn7uJkZwPCsa72D8
        t8H9EKMAB6MSD2+F88QIIdbEsuLK3EOMEhzMSiK8c+5MiBDiTUmsrEotyo8vKs1JLT7EKM3B
        oiTO+/pYVwQwgBJLUrNTUwtSi2CyTBycUg2MjDONJW4FyR7KnZisMO/+btYDqa8Pcyz6v+P7
        z5//nF9feTBxe8hOJSkpseNCYj+3VzNFGG1b1KTw4rVh1o2mjmDvmyZfi0RWTzwmdvv9YkU5
        eTG9Q9+T93nmRcpejJ2o+f5QxYuEN4t7RfX6t1z4Xb2q6LHKVBEB7nNPmE52mC7ZsbDn+Q7f
        V0osxRmJhlrMRcWJAGX4cTDjAgAA
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:74.221.232.54;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(39850400002)(39410400002)(39860400002)(39840400002)(39450400003)(2980300002)(438002)(377424004)(199003)(24454002)(189002)(7416002)(6116002)(356003)(33646002)(3846002)(106466001)(102836003)(68736007)(2270400002)(50986999)(189998001)(106116001)(76176999)(54906002)(69596002)(54356999)(50466002)(39060400001)(38730400001)(626004)(2950100002)(7736002)(229853002)(81156014)(8936002)(53936002)(36756003)(23756003)(103116003)(81166006)(4326007)(305945005)(2906002)(92566002)(5001770100001)(2900100001)(2201001)(2501003)(8746002)(47776003)(5660300001)(97736004)(86362001)(8676002)(7099028);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1415;H:sacsmgep14.sandisk.com;FPR:;SPF:Pass;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD017;1:ycL986Uz5GDmNFsg7HHLts9ITsSHYJHEn4y5pKt6wznuszA0yI99Vo1zXsrVewRaB6ZRZ6ZbuI8g2b43hkVDeLOv+qL0qHnNkMrukVlWX29ZMEesqz1nThTfV2l7++l5lSbsLWOQ8Rebuw3NzW2uB6HUL7TzDGLNBUWlClY4FNjyFOgKVOlm/XewDeemxUMGUyMXO3oguJA0VC16+2wB+H3MqI7tbFsAkEDENxx9vCBNQOIi17GNf0/ZLpbUhz+cqPakmbX11kMJo0yXHvccIX2Jo8NP7b3OqlyCwlhI+e0QYCfM0+e53dHBLjofkPzzYR3VmmC/KnfIIK19zh6w1GBgMUjAqJCpHFOt754Bmo2yeH1DGoTCvIN8+jFq4UAhAb7kmTpHLg5kutGeyo8kGneYOKLKY8eBYmOi8H71wgS4/SWynYQzaSvjreMxIlHRt80LpLsEy5DFnRQJSGyAJtyBRvNmD7DPb5lQM7XDbJJW8I0A2f/hjfi/b3If/JndTAKtP5jfz2BgAMx66RbtTsqtK5PsRulbx7qj/g7fTYxKhkuoJkO+6/y91x1VcqSv
X-MS-Office365-Filtering-Correlation-Id: d1bebeb1-4df1-4028-5cd9-08d44a0fdcf5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(8251501002);SRVR:CY1PR02MB1415;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1415;3://ClqzbzPj4gMwr8O4FUyCTFpVxrl5UhMmtypx3LE1H/skufh2A2tUwfzlhdl+UGpz1UDclv0cz4G1eEmAu/D17vYtEOU/aAnL1TaxBNWZSkJdaUmATpVBUCWsz45WE9mWfSQ5OYXMlm4rjD31y8qks0JswfURcdGRk5pY4ybMQI8HnVpi9zxYr8BljBW8oFfc5ZyjDwbGYaaJ/ZwcQW876SiwFejMuJIYBJBKywTrpZJFapJzASF0xgqPelw0EsYG0PWe371uw1OImQQwiqGA4YQiC24+M5+pq4ISe8+1xXlEWwFTgOOPiIxtryFQuGPT8O/mJKb8ibaSRcyyQaJWUUFrMNY3K1O/F47T1uxRk+zA/MmbrePhLIniG40qtyytJjETQ/pr0u/H1DFO/LAw==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1415;25:NnL4CE23MjRcJklCpR9Bz+7mTqVZF9zM7+4h8BbFYQ/h9DD5k4EHRLUjJO7qBEpcijmIA6HLsa8AuOfL+QBgIbxaT2KrbPuSFV9eImj1Snfg1l2d3qT2AkDH+MjEhm9VJ+OsrPGPcuyZSCp80yYeelIvLk1T8JnFUWHjpiXMJFfX5TlLx8Gn5Rj0T7xi6oZn1DZNN6IUs0h4ASlCWPBqIhGqGiYK+GStzPZJ51s4O1ErdrVhZ3MYjwvcPCSO+SXXhGhRwzbRgfj3yJapx0ZsypjWrn4dXLZ5FwRcLohXide5RyyiQUpz/3ndObwqFW0iZREC1Sgp3Nb+Xe7hNJYVKLwPclJV80cHODOYr+HZJ/eNMO0lpPSYCZFVvAa0usNsAlILGU1IeruHxo5R+w5mn283Rr+8YICMZ2V0gAQIrGywZk/f45xTjOE6BHSHH+3bkH2f13xOSwRECfLFaZtWGw9mr8UryICcqfZRdCHhBknDepoA6DgdtcQ6aoAdrgQ6TsbjLR+SecHB0xwahWxdFWRTJrXvm4mOqUKJIGh1pPq8rzGvDV+1kv0ek9TAozJHIiOHfSD5/wH1CMJVD+IUU9UgLEbIhK+7pb8yabaGYeLyjY0nD4V64lTo8GzDZWOo/vQwoPVyrJQSqiTTyLGfGp5jhhl3gp1lMsO4ZjqUrOpLwYUcWCX2G+vAFE10MrNBvtLX7mHyBY55hI00M07HRkMMCGKbkw+cjfdwz8CleAxgmbuFbK7IEj+vBQHTooM/
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1415;31:jhGwABJ0JNeRwHInag0mx2Z+18thCRJf8MBv8MuzajA+ITz9t15XiJecrkP7bQFlPb6GexKuaY1XMfGy/jG7IBIk90hSsrOYxGZQya4elhJa4VGIzCtXDWWXKrOdRY3UOz9eXO57RfzhWJpytJPedaWdMEqczYUf9ZUn1ZIaBAk96Jlwh5zXoxipQp+llutL4dmtRE8RQeOLyQvrNW2HeaM100UI2X07PWy71YadwcMFStIeAJoWIHe6JS3eGGtdnLBAIIjMoSzOsSYX0GcUVQ==;20:hceco786YtziAeLuFI9VfU+JsbYAtKNVJiYLxaqly5ZbcXebDXkFDUKDM6xqvUmq61kGdgnz90n8J03sSuVVsAyVGsnJS29bpru9LADumZ0465BxxXKgRr0pLDEHYs5w5kPyBAeM+RmEJdmClw4/9y6SdbRumEqVLsW8Q8THCs+MNDlfUV5o7rkk8wxwWgGO5aXITFG14hweDq5RvJHTpUAGva6knPmcteY10LnI2QEO3ozIexKEsQLhl+dZbEL501cBQ/HWUp4BluBk7MIr/l5AlMuH0MQj0feC145OhiL+clb35pDFhLomgmBupzBYpLA0bL9ko6j9mIsGvMaKA72U/oI2wslHkdFjDjz+MYROn1J+DKJhQoV09v/Oe4/g5aOUhcHbbsIjezouqmSSvuhuKnTblD13b4RJ8WfdMza1T6dYA1JkmjEtwHEjwcU8D6vQaGMzasd838JU+S8YngYlRNh+PWk6A5uRuNEPUS2tG8Z95sVRcRjhTECBWaFt
X-Microsoft-Antispam-PRVS: <CY1PR02MB14158CF6C23E65C14BB6B5E0814A0@CY1PR02MB1415.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42932892334569);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(13015025)(5005006)(8121501046)(13024025)(13018025)(13017025)(13023025)(10201501046)(3002001)(6055026)(6041248)(20161123555025)(20161123560025)(20161123562025)(20161123564025)(20161123558021)(6072148);SRVR:CY1PR02MB1415;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1415;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1415;4:VAX0fMv8aTGilm0sXHZUoC450SHCz0jFdl43K/2PKDZcWCgchCxAcS+4jlqZGfY8aNGiDNg0V3uRNix0SZ/b55JP97RmeGqCXzcZ7lN1/6G3zzRccznI8JHJEz0WAbZ10w9lOYEg9AkKBlcquaZQMyfhOogE2+A/v9XMv7RcKfcPGxMCg0njZ+kYni3C1l1o8X5zdyaTHbV8T4kmoMG0RGF+CrNiI8KUjTr2A4uCcEXYvHVF2XC0sRZFrjDJFeykIsHqbXTwuD7J97T+6UHceRAlO37QphchZt+Ydk5jYiwj7wRs7cH3FlZIFlKFIkGMymB5/9G5wwMCiDRzmxzYBgySV7D9qigN+1Q2D3WERhHRs+Bu+N9drAwdt55pbHOhjVcrUKvjJIWBQOsCc5LQFxG5FLoGnCEKkca2HgaSGxEEMWAqF7JT5Szoo51poGRuHI7yd4m3OWsUIME7o+v6i1Ncje/CQeQzhu6fNQUpfBE7UtiKCjZvjT3U/nEEn77kcrwTC4CqC9UUt/AxCDAwx6yFjjFkwZH/c2XvGQKEYKiU+2pvlwu38U7DCg6PNm6nBm3bYLyfDlMqQs4pnN5LSv580RKSSfs6HOflrZxi9N0PYVmr6x30OJTnXNcJopxWqGBOTK4rsFkHNHvao+7JvUuBkcjRdCsOatnJj6J3drxSGyaCKzb3Hx6shDkjWH+MvpobsoNGJPG3pbK079Lo4z66H1EGiGHarFe4X2HYplG4fDXXAXtvtndcKrqPUbWsQ9HHgObnbIkALdCOORcSTw==
X-Forefront-PRVS: 0204F0BDE2
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;CY1PR02MB1415;23:oDOcTaJxfhU9gtelz+8ESwaQcS/JpBohNBR1LvU?=
 =?iso-8859-1?Q?5CoLYVGhAHMfs950PrFTFNO3DIbmFM4m1Jyzh4BlxurRqOqmaZ2zWzb5lf?=
 =?iso-8859-1?Q?nadsIOEO8qk5luIpJcP+LwSQWOZNK6xZawPo9EAeKUxEi4zqNa8Gv0Ota9?=
 =?iso-8859-1?Q?EBzE9Dk0TMJZ7wIh/H01Xub/3Lic9z0Wzwj3Eue8wrGSl/DpXzS5xSY15A?=
 =?iso-8859-1?Q?f4vdzobkKktg0PXIdNt0mfljjvLNc/hDWPeCvla7DQYIIY/7d9jAWHLYo4?=
 =?iso-8859-1?Q?Z1S8FgpKiRRj48DGXj+l4500U8FLI0zNfDaTQoNfEHx5l3BeEowzd3q5c7?=
 =?iso-8859-1?Q?hM26TBAmK41mPCFzjBnKnUtvciYuIW1OE8R64g8E+72dj+5hF9tpCrvYL5?=
 =?iso-8859-1?Q?k+VjvXFBqxFoPHAyCuneuGKkareaNBgrAmku2nWF/B1FHBJJHiFEZg//UH?=
 =?iso-8859-1?Q?YkS3kwCRe0e3ED/BjHZTErdx30D/sP+tAYmrN06y6q2o4Gc3chv0QbaRjW?=
 =?iso-8859-1?Q?TQl5RG03HNTu+APq5yKYER0gH0FmrDLtkzLPxIOuqG1Dqyoflv5uv7YWUj?=
 =?iso-8859-1?Q?P080li4dK80RIv8QVhAZP33LRXJQupV1I7sdHXAFx3wx2kwOS/+V8Ll3PG?=
 =?iso-8859-1?Q?wvmqJYsKZT3ua1ItDretAk0pbnM8tBBAmjc6enoV6jj7E6Doagh5LAJ7WX?=
 =?iso-8859-1?Q?bhJklGAc55HO4WYl6BHSfdVxiR5VOGljFoWOZB1AOcfOsEZWfw13ichdw7?=
 =?iso-8859-1?Q?a0mzZTE5ro9qlQc7VpKx8h5L0+TAQb2BU0Fd6PABBb+FolDTeqe1gt+Pg+?=
 =?iso-8859-1?Q?Hi1kTwRnfyV+MNqqFrxStYpiV/pBTzT882rg2WCyiQT4YSHjlVJ8fCQujO?=
 =?iso-8859-1?Q?SuFgaPa0NeJ9BY/SK6EEmskOOVEFa/1t8JrtKiAOeat1l3GJ5PCuQP+rIc?=
 =?iso-8859-1?Q?1YuNbHrE75/wZ9EwZ8vZz2QgR3lYL31pYKP4zkhB7fqighokofvrAgbkyC?=
 =?iso-8859-1?Q?/5tKMwyKdZqyU2F4/1uhRQDFFQJMA2MLABmBrSDsYGPnrZLCW3G0BqdLPw?=
 =?iso-8859-1?Q?VN1Nt0awjhSPlTOLr0qvfOtHPlgR9npMpstCzFaapi7Q1Pfwe0gdDy+xMa?=
 =?iso-8859-1?Q?bY0s8mcNtT7YWiQxg8nhudby7Q/MKDzTiC0t6SEZPnVCNIHfG11onMOFtE?=
 =?iso-8859-1?Q?bP01Qe7uNUqspM9q0/nLSFcrQryGHcuXTvoKOl64BPoGAGWVG2iXR4Euia?=
 =?iso-8859-1?Q?MQXLgRQtqc+Snz2Gc/y1fY3ajnvErken8rfBP8TJX2zUR4OBs1GEDaKfcz?=
 =?iso-8859-1?Q?PFIEK4VNQIJokQ2UhC028jRQQGuDC6YnsAX9wO/7BnzT/LnpdhNM2YKsgE?=
 =?iso-8859-1?Q?7tBjNdfbqT1M96wsq4sNbVfWp8NVRgLv7FY0wbIXjNmFFOF+XyhXVIWXDI?=
 =?iso-8859-1?Q?QFwTOQLjrOyeyuz2y4nqoCcdiJCjSLpb/cJ?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1415;6:h64szCeYBqY1v9nDlk9EHPEWwC2l3YB6/eubLIukyiD/eCliW6RqAexjynLV+6cEiRtMu48RglXtvYm3E9Wc67DcOS8muCA29In6tySflxpFwk0Ipx92rLOrEhjgWSz7c6P7bQK9RK8Ykkna+olAf2Kut2MTjxYhVKLcDo7dYaZxC5PE36jJ/J15ttbP3UzH62quVxGvV5XbPGTPLP5SxxdkOxXd5xe2Mfy6g4o6txcC7KHndm31gRatbYKtiwpuTXZvtsJu0aawv80ihu+wOxYE3FE/p21cnmEtThAe2jRDAPXszrfdgX4e+q/iUx0OQuSUMX0ZHjmKVg4Jpzvfc1oPoRQOVOkkzUNOSaqTfoYpgyCBFExhZwvvrSelnWErmkxoxHtA3W7i3zubIGJTy6ixxrWjf0DngQOdm1L+VXxrI2XZgO56Gqn1WV6bn2k9;5:bVI415OjEoMaJ3HKYrw5oUVJCa1zLBPowt6wVylEon/cIn4LufTiAkLwnryLIr5LqGCmaoFb1n6+0F2vrpWapiauEeqdbTW9/9yVN98VAK+PwFrN/4DgSjWwzusNxaCukxyFBRD5IVMg8B5HmxWwqIfVgZ3wEggt+eCYbRnGIFQ=;24:9SE0MW18ulYE/Du7hdZLdTtJOT96q++bWpLkT9ji+orE/UWnRvBIt/tejqAbz7bwQtw238u2d09JE4ZbcPAP7EtbmGjVgV5QB1DeOOMo1sk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1415;7:cpSoDV1NTmmBaOiX7A+iwokvVuNEbTa2IByZpRLirUckoQSaCufd8VBzUpLF67R2zOGLwjQOIdEKMxgSmVsQ2ETMCduZvoswPI2O6RGVsBcDsqLdA0QccmPoYVP2VhBW96lpyT+i5WExU2kiRnpuLYzhhM7s8GJ8XMzLACu0sz/wbQSRAn+qNR5vWwUuLJrBUqDXeJCLxHWW7oAaNTEPL6Ok163rcOoi9sp+MenFGdpZ/ZtuuJBQzheIQOW23060TqrhEmK/A2sXh/MzeRnVYmYBKBlcDvVeG+jjR5W/hlZwh4JdjOOqD20j0T4Vit8fZygWIdZ5RrdTInBHqLbtVYz4f8kjk2hgQO9KmRguYMbA6Zdbfz8N/sUZi7V0g6ydECNQwITOBPOU54vO6Gz5sqVbvLihx2j3Ex5X9aUcWvZ24k7Du6v1ZiIzehLblk0x+EsC9/S2ML0N+9KWpubegyYg7CkFKbdtP7zl5AEI3FX9d31T9tDJxkHTbA07j3KYC5dHFyMsw3skZcs9iqPNbDSjbtj7Yq+jnDFikNyVK3XEFFMBe3xyK4B0HSJ+DSCX
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2017 19:32:15.6555
 (UTC)
X-MS-Exchange-CrossTenant-Id: fcd9ea9c-ae8c-460c-ab3c-3db42d7ac64d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=fcd9ea9c-ae8c-460c-ab3c-3db42d7ac64d;Ip=[74.221.232.54];Helo=[sacsmgep14.sandisk.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1415
Return-Path: <Bart.VanAssche@sandisk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bart.VanAssche@sandisk.com
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

On Tue, 2017-01-31 at 19:19 +0000, Russell King wrote:
> drivers/target/iscsi/iscsi_target_login.c:1135:7: error: implicit declaration of function 'try_module_get' [-Werror=implicit-function-declaration]
> 
> Add linux/module.h to iscsi_target_login.c.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/target/iscsi/iscsi_target_login.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
> index 450f51deb2a2..eab274d17b5c 100644
> --- a/drivers/target/iscsi/iscsi_target_login.c
> +++ b/drivers/target/iscsi/iscsi_target_login.c
> @@ -17,6 +17,7 @@
>   ******************************************************************************/
>  
>  #include <crypto/hash.h>
> +#include <linux/module.h>
>  #include <linux/string.h>
>  #include <linux/kthread.h>
>  #include <linux/idr.h>

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
From Anna.Schumaker@netapp.com Tue Jan 31 20:49:19 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 20:49:27 +0100 (CET)
Received: from mx144.netapp.com ([216.240.21.25]:30617 "EHLO mx144.netapp.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993899AbdAaTtTu5Hxi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2017 20:49:19 +0100
X-IronPort-AV: E=Sophos;i="5.33,315,1477983600"; 
   d="scan'208";a="174051109"
Received: from vmwexchts01-prd.hq.netapp.com ([10.122.105.12])
  by mx144-out.netapp.com with ESMTP; 31 Jan 2017 11:40:54 -0800
Received: from VMWEXCCAS03-PRD.hq.netapp.com (10.122.105.19) by
 VMWEXCHTS01-PRD.hq.netapp.com (10.122.105.12) with Microsoft SMTP Server
 (TLS) id 15.0.1210.3; Tue, 31 Jan 2017 11:48:12 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.120.60.153)
 by VMWEXCCAS03-PRD.hq.netapp.com (10.122.105.19) with Microsoft SMTP Server
 (TLS) id 15.0.1210.3 via Frontend Transport; Tue, 31 Jan 2017 11:48:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uOWCiHoJOkeJ03T4mq0DkYm1YX/LM+dO6vMB4b4yogo=;
 b=ol0wo4fSJiK9ThT5aRZzpKEfdIMlk3oOq2hVjsGGH5cB8RvD0evUS3Rd+bd6P79YOdedQzTjOZbnvMA6Vkp1Cuz32mD4CUgmpIldMDVS9cbU1T3iav5x4hBPocr9jbxDnHDHYgCAkphs+kXVAQ723EPvkCqNQHvhqCzrKJJQUKQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
Received: from gouda.nowheycreamery.com (68.40.188.1) by
 BLUPR0601MB1635.namprd06.prod.outlook.com (10.163.212.141) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.874.12; Tue, 31
 Jan 2017 19:48:07 +0000
Subject: Re: [PATCH 4.10-rc3 01/13] net: sunrpc: fix build errors when
 linux/phy*.h is removed from net/dsa.h
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        <linux-mips@linux-mips.org>, <linux-nfs@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <target-devel@vger.kernel.org>
References: <20170131191704.GA8281@n2100.armlinux.org.uk>
 <E1cYdwi-0000Vs-97@rmk-PC.armlinux.org.uk>
CC:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Trond Myklebust <trond.myklebust@primarydata.com>
From:   Anna Schumaker <Anna.Schumaker@Netapp.com>
Message-ID: <52ceb082-1e0a-7210-833a-f4ac22df4b8c@Netapp.com>
Date:   Tue, 31 Jan 2017 14:48:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <E1cYdwi-0000Vs-97@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.40.188.1]
X-ClientProxiedBy: MWHPR14CA0052.namprd14.prod.outlook.com (10.173.97.142) To
 BLUPR0601MB1635.namprd06.prod.outlook.com (10.163.212.141)
X-MS-Office365-Filtering-Correlation-Id: 0b097ef3-bc3b-4f54-2fb0-08d44a12156a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BLUPR0601MB1635;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0601MB1635;3:pqQdKQnggVpXZO9kxDGGHXk3jnYxph8zNcHgN123tPYZ6V21FkmUKK0KLfpFZbd+MDx48Y0ZQpEnYayQEqbYLIkxb7/pSsJp3oY5Bhd+WbIJ0q3evXFvZdFo3FjGg4WAq5/JqKpcF7V0bqktVaq//9kN78GINRzSysWksyulT3TfakRpmVsM36PjLeZSP/4cLUUi5Kzzn1skeyeYJWvtzZp73Nx/AOAljKKRPlEiRUDnt1dHDecckXOis6u0phWDVu08AwmgkFAdIiINYOrkZw==;25:H7evsomXQrGUJrzkwAjsHBn39ESJypT6h+oQ+JNNzHEslcZvDqHRnC2tk9i4xWdrrvNG9wh4wcGOHqNqCnHeP6e9gYLkkjj9bTIbJAUmcpcL09H1OH7UdlAdr6wrUdcgT7dSyk5LMslrROICSbXM4dDjzhX1+yPj8s9lB0B3jvFNH0l5bWGFlpnl3NrBNHq19gOTlqnWTSHtQ4apE15BGNQEFZNDWMMlRYMuZic6gea+oTDiqzO2Quc74TdaA8Xt9RrzZjdWkWU4IRD+XpE144MAyHFxSkXClXdfQdrM/F4mixCqJVwGPwIJX3VfsUyMBQEUClXefVyqxw7Xi6B72Luc5Nj0i8zqy4h0uHjhwrbIgUMbMUt+KfY4YtK7l3gbXLhWN/7+XQJIYnDyk3jxrslCa0L+d1zQY2pCDLuRshKuyQeZgbzQ90iwKYcsrPt1zu7bN7c3J3a0pPBVUehDzQ==
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0601MB1635;31:FPynjvJrN9BMI8B3BNKoHQkq1MZPPqM9Mif8RRC77N4dy/1NVfuzSCbBPJYGZxYQfB35q8mJQr8+wQMIURjD8hck35fQcmnHgXOtwuiI90Bv8C2Wc5N1G6505tSQ5ZxLCA2DeFILxXP1EzReathqsjxXM9411zYE/+hRo/96CobErHkKQAaOQ4U98daErgLDyxfkzOgDJcagj6ez8EggXhEXWq5iTp9xPdyuORAKOIjADnlwM+sMXNr+CNw/OueblnlA2UPQprhodUnwmwBwFw==;20:xVlh5kgHDL3g/cNSrQRJrpzu52Dk4hxyD2EiNs8FNLwfYYTFGTUKZhOnIs/+ft1bP6Biqs1UOV6MuXEb6uF+6OBYYy9BnC/yR/ActKjccGVN1jfBmDHvpPr68hklyHGKYRA4WYnW3UDCywPy31Af7MuKIJFlmOlhvLLgWBD8Dpxy8L+tJPCHVigb5ABrGrIxDmtSfXLJ1CcvBHDtaueLCFcnZ7GKTldFgZz3oWSMFoueivz6+gWTTlaX0cAZVRNTQo1Be+kabWW/EXiObi2tLeNfrW/MjpKdie3GEt2EopCIhtS9JNI5SkSW8Inf4AxxJcz+91rTAqz0g0WqpNSZe3I2i/7smCTmGUUvUsRlNGcmUa1WL/F//xFIyq5sHWNCDQ7GUAM1hwEbNYYK91EP5hmoG5KUCpgtfPGuP46xmZ7tgUtzZx664uTwUfUYrqujW6KVpn9A9ebV1rnx6NnoW1Z5v4rjB05ESqmoFAfEQJTaZh8hfftrcxHjQlMgGfEu
X-Microsoft-Antispam-PRVS: <BLUPR0601MB1635ECE13E0623F977ABE259F84A0@BLUPR0601MB1635.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(6072148);SRVR:BLUPR0601MB1635;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0601MB1635;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0601MB1635;4:WQ7hukXGogirq7lIFOPEnAoI8nYeiVQTHRF99OC/Sqdesvzz3Db5RBEQyDc1X+Z1oaFO88whk5vJ9CLLTfJfqu8R1auysiV+GLuxQkA/de715ZF1L6heZV7rTK+IlpUB08sBInyIEEC/1W6EEWYnCoqrSaBaGisyPouSPv1tmdpAz5RlgXS2ayDnihpnydFI6QBzDh6w8bd4jSASZZAbrepu+CnYajsWP/OuUzroj/AgEZ3EEKA4lKZ749ozJTZaHwbkBTnuNt5xhmSkUl2WBGWuNgRde6Dtg3utXQOcUqrzj2k0Q7azJqoVXjI5S4RXpRaVeqOfrLuq1WEk+QJvEwuszcfbrlyu5FqSlwB2DyRlICzL+yEPCQ0okUwUImwMiVOJW+Oz8cz0aNeqIw/RXq64qCoydJWU6zoDlPiM+QxhbJ096LAqkH8wSaDJgXsuMfIPybA9L2l6Bz+PvAr9/uRXkBgZcJEfROCiFXDmXwrBIklyk67YFLqdChSNc1Xjzd4qlzcF6U2W/U4gEgEt79/WndCJhlWxeoSMFMRVvSFrwHya2i2/2FuJyYTfcO/74VjNYS5Wjw00QFP/v/+G4w==
X-Forefront-PRVS: 0204F0BDE2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(377454003)(24454002)(189002)(199003)(6506006)(39060400001)(97736004)(42186005)(229853002)(38730400001)(4001350100001)(31686004)(54906002)(6512007)(92566002)(83506001)(36756003)(3846002)(6486002)(53936002)(69596002)(101416001)(189998001)(81166006)(76176999)(54356999)(64126003)(8676002)(50986999)(50466002)(81156014)(25786008)(47776003)(4326007)(2906002)(6666003)(106356001)(68736007)(5001770100001)(6116002)(53416004)(105586002)(66066001)(305945005)(33646002)(7736002)(5660300001)(31696002)(23676002)(86362001)(65826007)(2201001)(2950100002)(7416002)(65956001)(230700001)(65806001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0601MB1635;H:gouda.nowheycreamery.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjA2MDFNQjE2MzU7MjM6S1UrUys0dElrLzNLSC90RWxFUjJvNy83?=
 =?utf-8?B?WDhHRHcxaDBSVDV2STBKWGg3LzFMOWdHOGwzc3E3WWVlakpnRkV1STFmWmcw?=
 =?utf-8?B?dmdyZFhrczZGRGRuM0pQQzU2bCs3L2E3M0IzV09HWkFmK1JWenVHQ3FiRzJH?=
 =?utf-8?B?UlVQVGFNdW1vT1VVZWJxWWRZYUJhakhlVDd3NTRnU09wU3FFdXdROWkwWHhV?=
 =?utf-8?B?QTYwazdpU1NhdTlZcDErZCtDVVRNblYwY1dOUU1HY0dPcTd3U3BpNW5XdlI4?=
 =?utf-8?B?eHJlRGN3RGFiRHNEblQzcXhTc0FyZm5kdGxpUW0xbWlIeDRtSkpJWmI5MXlm?=
 =?utf-8?B?QU0ycFJuOHg4bTc4dTAyTmUxOXlKYzRFeEdrdktoQjhOUzJ4SmE1NTRiUnFY?=
 =?utf-8?B?QjMwMTRzZjBsWFd2ZDFmSFZlby81OVdQc0tPQUsyait4ZXl6cWNtdEk2OU5B?=
 =?utf-8?B?VVVubElKOGtCU1d5R3FJa3hNR2toajlKRTNKZGhsVm9haHYrdzFYMUgyUDJw?=
 =?utf-8?B?UGVidjAvNDNveklLUHg4enJJY21DbzRubWZLVnNDWWQ5bTFFQ0NoQ1VTdm8y?=
 =?utf-8?B?blRLK3dsWUZlVGtvSmZwZnJmeWpEVXFVZEViRm9ma0psb0RnKzYrQ0d0dTFz?=
 =?utf-8?B?MVFxS3lFbG9ZL0U4OE9tZVNhZkVSZThkRWptWi9lMDJKYTlvbUYyQkhKRWx4?=
 =?utf-8?B?YXlBK0ZDNkowLzZBN1RiMW5SSU9MbG5XWFd2ZXhVaG9xZG9ob2JXcUl5UDl3?=
 =?utf-8?B?SldUR25EendDamQ4U3B4L0pGWlhoYm9HVEpIUEVxSVJwYkFxbE8xcWprTllS?=
 =?utf-8?B?ajV4cW9qbnR2VXBaQ01MK3RMODNlWitvb0VuZ3B6bTRKSFdKTmsvZ1pOTisz?=
 =?utf-8?B?Sy9zZVFYYTgxTWhrT0Y2Z1lRc1d3SWV1cFJNZm1MTU5DMEpLZkpLekUyM2FX?=
 =?utf-8?B?L3dVa3FoVlNIdllOZFhmK3JkS3JOZEswdXV1RU5sVTZaR1NqM3AwSlg0NHpx?=
 =?utf-8?B?amF2bkFXSzVIVi9HSFl6RkUzRGpHK1U3UzVsNjd6bi92ZUNFc2NsV29WVzdY?=
 =?utf-8?B?RU4yV3BYZ1RQcEg0V3duMFpaeXlZODRmZnlQdEVPOXVLYklQSHY5U0lOaGRY?=
 =?utf-8?B?Y1ErdlZ4TFlLeERzMm5SOTkwMmYxL2ZNWVNxRk1UYjVRZGkvNHp4d2FvUmlv?=
 =?utf-8?B?bDZBTWpXdHpIaWdxVHp2UThoRG1KQzdVbG9sRkRnSWExYzd1L1JyUUYzVW83?=
 =?utf-8?B?aStWbW9lZjNqWThkSGxUZmllaGgvOXRzS0Zka2g3N08yT2NmQzZpWExiS1BN?=
 =?utf-8?B?SU9mWlp1eWlJRmc0dURuU2Y2WmhvSmNCcVFXV1BWUDdtekozaDRlNHRrWVVu?=
 =?utf-8?B?SSszeVllb2dISVJEUUF0Q0RqeWpieDR0M0oyYUk0cXJVL05BR2V3Z05tU0pp?=
 =?utf-8?B?SXVsZzNkUEVjVmZ4eDE2SlpudjlVVGx4NWQzSDRXbWVwNTIrVHhQbXlrQnZY?=
 =?utf-8?B?cDNnL0E0dmpxSHVra3NRS3UwSy85R3hZYklMaFNCV01FRzNFQlZzL05zM0Q4?=
 =?utf-8?B?Ulc2UXRhVmhzd0VhQ2VLZWN1NzNYWjVNL1pPMFZFSmsrU3RQaWZXYi90YlN4?=
 =?utf-8?B?dHFCQnhxTnEzeVBaZkJHSnp2bFM2djhXaDBiWE96Z1FabXZUMVR4SkFsNXpZ?=
 =?utf-8?B?WUJUZGlickl5VWNjREYwQ3ByVUd2NW9GYVhzTjllQy8vaVZhSTh5MUhJUkIw?=
 =?utf-8?B?RGFXWE1VV1hWU2tUMXpoUFpCS3ozbDFJcnpGbzVuelRHR2FWS0RmdUNCZ3gw?=
 =?utf-8?B?d214L0FQZDg5SzVMeFRFVUN1MWlSM1BmNjRVUFJBZERCUWora2lYWE1iV3FJ?=
 =?utf-8?B?ZEZ6UFh1blF1WlUzY0ZLcHV5Q1NKQy9sNWNJbGVEYmNwejl6bXhMdTNkalBo?=
 =?utf-8?B?dUNsdVQxWFQ3ODgyQk81UHhOWlJCNy80S2dXN2hZWS84ZFU0T0VXdFdGcHA4?=
 =?utf-8?B?cEJYMmdodnp2M0ExL0VwVVEvWDg0SXQvbDNRNkdBPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0601MB1635;6:WBLtr3MXXwoiHkSwhKjB673n8OX329kgpwwMBXNqeCS/EQFBbUGHSsuqSk92sCCl2+JLRhBvCPJVKpDnluqxe7eIitEzjXfXh4mOW8U01bMeJovtsel8plK7iNeiw0+bRIpoLZi47r5AGXsxs/dmZXNRupF5ZK9F6suMm7OGKTbpHX0HyNZFESYLtBYP9agxizQkubL6c4gIh1/Yybom+vTlYV8SI+MHj7iJFYOmb+3QmtMvgf31vNll54wNpfyJgFbTnC0EhJy8byMN46lvfYLIsAILmr6trcwWxClGPxfS6clss2KZK/r3q0xkpzWNAH8m7ZBT0c65+enFhrJh7tbEXGvyS+J9jtmjqahPAkhzQXi3UqL76Q8ZbAcMJ09611t3mR1YC7rEpRQbEegkaxSnijiJ0u9NGm5cp2yUEII=;5:pzqEmbfXD1634cfC2rXSM9Esk+gpX9gLy0mBHGt1rCJgtjKgIhLKsHMeJhV9OVJsBhGKMweyrCiL4SHbK5CNwaSvWJU/ar1zjwYSoQaTjvAfMYHQ8beQC5FlSPXKD3WxSb0U5mjnfxF9q9bnzSLMfAf6WgiTrGChx9K9Y18SrBs=;24:FjvrVeHw1jlBi2zVZGiMJxIh0Rd1Giet37EvGDiMeDJJTHTGj8yitNhlxclTSa41EVFMsgjneP81dvWtuaN5qocnwo5FOjPscWHu4c6oj0k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0601MB1635;7:7BaS/kk9Q5ZaK3Y3BVeMBlAsV0tO/bcGbrxXHcz5ZMLMNXoVd2BiOe4Fgq+IgUQAhntgcK6XzHuJ42cwuYpF6aVjDo1jBhdG62EtEECrEcMUFRGpGCTLD82ljyFtNBtnsLGRp6J9qSG+q4Ky5tdTBv8Pm3pMUAcWnQzWA/QsUpm1NV1cDB4mUFrw2jjHdZOf5YpZ7mq45xxJSm9A3j1Em8zdiaR3x2bUf+PD1Em+EZ5GGTm392gP+Fh1Q2b5Rp+6RFTvGgP32xOM+OrPGJBr9F3wlJRskmupi4nBXr3DjHEx/KVXGbzT4y5IH3/oQrNRYMIGFDs+LBx03uIHMqiiTX692AbQF8+czBtVsfrOnq0QsSgPacFUb/+uVcEkdz6eFldr4BmCu28qkU7obFBYLvxR7o2sHKrJPAlI1nkOGG2/ep2s2tOJXUiDiLKSzjQfuxRUlqgB4zAVINN0aPoY1TzfHg7h4o7KbpJBMbu64Cu+nBnsGZ56G+ZSjFcO9ytbLiyt7V21TnSd6uoU9hVn+q7ikeNkYxyU6a7ppEPi9YVUJbbEnRofJ4n505T1KvhL
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2017 19:48:07.4192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0601MB1635
X-OriginatorOrg: netapp.com
Return-Path: <Anna.Schumaker@netapp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anna.Schumaker@Netapp.com
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
Content-Length: 1346
Lines: 36

Hi Russell,

On 01/31/2017 02:18 PM, Russell King wrote:
> Removing linux/phy.h from net/dsa.h reveals a build error in the sunrpc
> code:
> 
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c: In function 'xprt_rdma_bc_put':
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c:277:2: error: implicit declaration of function 'module_put' [-Werror=implicit-function-declaration]
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c: In function 'xprt_setup_rdma_bc':
> net/sunrpc/xprtrdma/svc_rdma_backchannel.c:348:7: error: implicit declaration of function 'try_module_get' [-Werror=implicit-function-declaration]
> 
> Fix this by adding linux/module.h to svc_rdma_backchannel.c
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This patch looks okay to me:

Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

> ---
>  net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> index 288e35c2d8f4..cb1e48e54eb1 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
> @@ -4,6 +4,7 @@
>   * Support for backward direction RPCs on RPC/RDMA (server-side).
>   */
>  
> +#include <linux/module.h>
>  #include <linux/sunrpc/svc_rdma.h>
>  #include "xprt_rdma.h"
>  
> 

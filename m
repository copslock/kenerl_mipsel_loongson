Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 19:02:57 +0100 (CET)
Received: from mail-sn1nam01on0077.outbound.protection.outlook.com ([104.47.32.77]:52852
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993893AbdAQSCtKLaO0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 19:02:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qYZj7BoQEPR61ZbygZO2MYj0sWH88+EHkJxoqm1+bUc=;
 b=Q85ePwrSzZxgZU4lL7ULaDz5Tte8v+5FxdwNkhIJRFsm1fSXdgITVpQeQVmg/+sSgXbOuQbDfjRolP/pioMFQZV3vvNAdbOCbPGy9UVGyTPCqmSDJL+8SAh5l7q+9uMP8rvMIRsOasPAY2p7Tc8qsCFvIHwBOTx/Zoh5pIbXpLE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 DM3PR07MB2139.namprd07.prod.outlook.com (10.164.4.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.845.12; Tue, 17 Jan 2017 18:02:38 +0000
Subject: Re: [PATCH] octeon: prom_putchar() must be void
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
References: <20170117173644.27984-1-alexander.sverdlin@nokia.com>
 <20170117180033.GK31072@linux-mips.org>
CC:     Alexander Sverdlin <alexander.sverdlin@nsn.com>,
        David Daney <david.daney@cavium.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        <linux-mips@linux-mips.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <881d4269-414a-3b98-4099-74af7f54a4d7@caviumnetworks.com>
Date:   Tue, 17 Jan 2017 10:02:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170117180033.GK31072@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR07CA0041.namprd07.prod.outlook.com (10.172.104.27) To
 DM3PR07MB2139.namprd07.prod.outlook.com (10.164.4.145)
X-MS-Office365-Filtering-Correlation-Id: f38cfb2c-a62e-4b57-d72a-08d43f030718
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:DM3PR07MB2139;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;3:hU0wP64tTDznm2MJspN07Lk4E2+VnVN6Xc2Ut+tV7Xpn7osWBslCIRJJwO2Z887O2Jg+D1eufg/KEFvpfmUfVl5BaF7Ws/gw4fg3SUqhIW6fPbTvBEGUC7oy0M/jUBxlR7xeYD+B3BtLly5YyMK8NoFVfs9JPVUkdYcWpugGB8WoqQHCBIVQcw5eNQEKPgE2lDQTsZpB2/faHy5N13Tewufj7VVAFW9ryvaVwQ/mm8cQjQv4N7HlS5byrhnVK9d2skbxgsOtYjaYie69SYNu2w==
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;25:DV11s/V4Abrt5yQ/d4JDOzi9WBMm7n9/TLaJ79Z344FsX51ATiAgzDfPzbHoAdpATh/ByG3agZ0ujwxRwuF5Ee+3dfUJVlLdEu57fdMTUBSpgk2TnJ6jNOjyRqpA+KysRMYszYwppE51+1waHnaS9xo0aMxix0SKHcsWOxMR8DR1sKK5jDWL/N1tEPW7zkuw96fCr6ERQzzqlPujJjhcUk8n7kORr0lUThD2SbSAvs4RAc1cpu49h4VMPFQGPfauYAbwsk6qFRbA78gSsC/IXXfVVIy6MaiL7qFXyASyP2HDOVl1VThiYKbcoTMxR1MGRaURyhTDrR6KMsG2aw3Bl8rl0s4mRZNhmAVEqmU7PM8jhNhMsghFI6eEDPWbKsQZN+cwxbO7WZSgZKETcSU7jiDpzeqXn/TLo44NrraAZN993ETiR3gdzHL54gX+n380Y4zuKxQ2R/rMZkb3mLRHUTXimJ1zh/wrFANdHiWRKYHTdvg3D9z05YHUYLe0rJ9CWI7x76hbYKdXf/kckrgb6ZP+gcvsTkqTWjbX4AjKUQMyJexFV57xm3eRLKcSGsTk4ZIQzstBFl8zVRK5pz4Ws0f2VqC5xEZ/ABuhrMrtIq7bBCam+FEAAw5SFmpSX9v/hTeMRqUfQLMS3h5SO3nj19sduSGzVaWFcggxktbh2aX2N782Csph3N/hAs87DKnMpIvKDFutJti3V70QXAgJseKqAbFJ5DtrLxqUsepymuXlUR6irGMMEmUdFzmU7Li353cESsPAqt1J/wgg7y3N+w==
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;31:5Vujs0WOkWkhqLxvDe4eclEnwuwHtZOcP5+2S8r8qhe/fLppYrwIoQraCqar1FbEIiti7Si1qoLkmbEzgy6sJWzNlM5HjEWhO5FuqToj2qg7N5ogcj055xY/iBHYXO9I1r/NgVdJeYfxfSZ6zXcuWhG40FwDYLafsOCJp1Ruz5JGSL8u+IdTsh901cySkwYIFuBybMGKtfFEgoqTelI3myHedSphK0WyXIDxJWRXC7iEktiOvGoNhKD8Go4mlLfM;20:PzQ7KjAbGgbzvpA+OZtS/iY3KY75xxXgaFg20ou5CGREjK5TJ6YlAr8podX2lbGnbpSNsdsL+blaG+OQYeJRMl/xxxvXbST0cS8mE1z+x3fXpSmSSlCjISkITuda1nWNxs7c+7fYcldqCsquum6f5zHZJspFQ8D+JLvxhMLGdyUllp0xvxv/rbjjX2YOKYxF2+dRrHgM2I6epeLrCa6UzPa8M83zd8SV4ilbw0nxvDL2xGmUD4kXFiYEcF9bHxSKqg310ovbZmsfcy98QyGozSavYdlJT/DIRileW+7oOf2xUmlZH6457pQRhX9mhNKJQfdN+ZnWkpWtwca/0qsLpoiuLnkLXUTf7F09bDBD6Xt4faiu2B8PmTy3NKUUwRZTuxIndYCVQ9Q6GAnqnVEpQM2mBMvqc6B5hrQRb1Z/Eg35KlN0lC4cOce2JlVjKlgyWbcFh17OvyF+I+txaiAp1COA9G6KK9q+t9LzyNfHwAxhvVph5nwvHPhyN269zj5r2m5J3J4I7zgYW1ptPlkE0eF9FXs+G0n5F26nIs8TrdGFdCVyh1QhXhi9wi23jDaneUZmz/l0ZiFj7w8ByLER6d/zuqEd8USbgJis4Zp2WMM=
X-Microsoft-Antispam-PRVS: <DM3PR07MB2139D9F8658866398E4AF3B4977C0@DM3PR07MB2139.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123560025)(20161123558021)(20161123555025)(20161123562025)(20161123564025)(6072148);SRVR:DM3PR07MB2139;BCL:0;PCL:0;RULEID:;SRVR:DM3PR07MB2139;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;4:1U+U0TRV3ISZFbDTglJ9rLnSvdi2zk8LBwlG7W8sAwkRhayiYjpbSH8iiiGgE4GITjSDx/cH1knCnbs9CWy2H9QWe/C2hAyLJ+U2Jp1xV2XkMdrzEi2MCX+gdDFJ+JunBzNct3qsOwp/hLc+KR5fS8RZScW2YJX1djMQi/AszdKIlKlNF4+BwNrFTcCyOaINSewXuXx4NUfPkgNIQseDtJVfob83AElD+jNwDAcBciOKLiJ1VvbeKKFRxT3KxuJgDn4Qm4eTKXiw4PJFX1LWLRTT/bEXX0Kd++1JRvNIsiyw2G2tL4y6uuz8Y13QZiEGYdFRdKh/sDaqRNRJAoCPqFZ1ZIeFN64eTXJmDqiTcMIUHNHuV5TLI0cZwVjg2d1LTt5wX8xibAzdAiSz/bEw2ih0yrfjS0TFGx36rf22vq0Ni5LZPppP2FXHbQz8H8pEj1gqrZPL91O4eEY6UhKO14HoCRPuq9FttNEL8tU3UjMM/UkRcYL3fqnYUhgHeCq6l4xvV9m2IYOnrJoAHzDC0HMlIdI0dj4DhM1beWi0TLBMSBj8d6257wZulQU3cU/ks7Xu1TT1H2Jmjw/im0EbzNv5CZUaCOwVESBxmNrkLA1XNy3lU1U1i/K6A3ALDUtDTbpJkk2+R0yx7eMRHiO5mQ==
X-Forefront-PRVS: 01901B3451
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(377454003)(199003)(189002)(43544003)(24454002)(83506001)(2950100002)(305945005)(230700001)(42882006)(4326007)(189998001)(36756003)(54356999)(39060400001)(3846002)(47776003)(65956001)(6116002)(76176999)(50986999)(38730400001)(6486002)(66066001)(65806001)(6512007)(7736002)(6506006)(33646002)(4001350100001)(53416004)(25786008)(54906002)(106356001)(31696002)(105586002)(65826007)(31686004)(101416001)(64126003)(2906002)(229853002)(5001770100001)(81166006)(23746002)(97736004)(92566002)(8676002)(81156014)(5660300001)(68736007)(69596002)(42186005)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM3PR07MB2139;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM3PR07MB2139;23:cPsiDlqhtpToRy00y1Gp+NPmTnmtGJF+UxpKY?=
 =?Windows-1252?Q?q6x9Fg59jatEdRgsEW0LkKJ/mD9WqL3t2EpRKssKFU4W/afd6i/jlR3h?=
 =?Windows-1252?Q?tERn0Z3L9hk9ocZvucFt/MP6x9dLdH9q64t28WstmNLqa9Sntwhw0dOw?=
 =?Windows-1252?Q?SXvX4cTEzJBzV6Jd63d6XQ70he1YLtRQ+qDxaiSjDgovG4Bug6gVbSao?=
 =?Windows-1252?Q?BRgBE8npM9ysdZADzw6J/dKi+2sIbhA3OMcbEn296cPZp3774spc2YiK?=
 =?Windows-1252?Q?+CKRngXvvYmZpSVYOEV5L3a+PUXHu8kymJQMNIsqAldy+xLFqsS6aNXV?=
 =?Windows-1252?Q?pO5CXqSq6YRw9BcsceIYTwuhZBVw84pAhV3rRJ76DpC1ctvKDdsPKEuX?=
 =?Windows-1252?Q?VAFKgNAd3wg9IMi8nmDgYfCs3RGbWEVE8KQclYHTdOVqJ8mMyaYyTtyG?=
 =?Windows-1252?Q?M/YDw/I1WCSo8/Y+yoSUOOZqbWXDbvpTAq1e8/48Hp5DagCkII6EYivY?=
 =?Windows-1252?Q?VjaTfuH4Ea31plCXh2GxbEnbnXlz200AHue/cFpSEaKaim8G4B+ixoWj?=
 =?Windows-1252?Q?y5DbC+o8zpHCrQYyuxGnxnXK7Q/C35ebIBGwVtNJOadf176EkqNB4oVU?=
 =?Windows-1252?Q?Z0xXVjc4PK0dlADLs8bi3E6CpcLk3sLpppvvIx+l8rX3F+1iuIcbWv3W?=
 =?Windows-1252?Q?Hl4QibKWm86Ej+vMUhyb/vAzdb39dFxaakH+WXp+U2Qi0IAYfXOmxYmg?=
 =?Windows-1252?Q?GgPU5BaFM0ZIBPD0Hlkmb0zmukwBwmpNG0gMta4l5/kVl5H8/MGgLxX/?=
 =?Windows-1252?Q?eCJrdPx+PvjPEEsW6TDRYsDaDsaiVVfZgEBLIWXNCLxNvd5dLD9jlThF?=
 =?Windows-1252?Q?vOuLumaM53ev5V9l1mE+nSsZGl5HmSUcw5usLPSWaYjz0VGbiTSdVXdG?=
 =?Windows-1252?Q?fBLa+AiIka5ZzYdGTPJqkqATi8Ihlrcqz6zriEqwYQwfreD+pRqJ4ojT?=
 =?Windows-1252?Q?ot8AFz5bH7zSgaUuFPsTCJkjBN/qjb5vVQzj7JanKNbe+/Pw0IQ/XwEy?=
 =?Windows-1252?Q?l/SGHP2n72iaL5zZ8daDfTvn9QGDCUvN2ckXgWFbi9tmT+g+++yQF16A?=
 =?Windows-1252?Q?Ngj3aWGZlTytZ/oOy67Dg+jjtgYeCj4JApb22t8utoItwOallfA4b+QN?=
 =?Windows-1252?Q?0EqUOJJv0pYXk81VeCy5SSBYp/8irz8di/yBM670K192lyLUQ14vIvJS?=
 =?Windows-1252?Q?Y1OkVbUXEHVmGPNPSehQynRcY/EPOklhWopXcozwLVvJvaNK7Js53LSg?=
 =?Windows-1252?Q?IOrl7wfM/Hq9gbeyP6YOR28ji2C3LppLfnW0dXH9Wq3YhTccr/yz1H5b?=
 =?Windows-1252?Q?bjZkoM4Z7wOmHvX6J/BDk33wSXHHajpSeUSAIBA/gIE9454LsOxpdadv?=
 =?Windows-1252?Q?ORElTaS3BX1v9yeMm1fN2AC0BBOkHs7nuBOP1/YVkbptFLoUIi/vNspt?=
 =?Windows-1252?Q?xWTNcqo8VbRSRRBYtXEa8kn+ezT?=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;6:NaZq5l0v0SODcJKZUuroehHHulN56vTb2OJpHRkMkM5OLYp3yeWaUJLGkFVaxjBLv7uruKVG9KbbuZgo1Q22AplWDEEsurw6CU6eykaCJuI5AZRcQOJX3WSl17s68sQOGrz51cSpF+4ZnSWApQhv9mP2j5OXI6Xn5KWJ/bbsXqmJssehvUdXUWACXeJp6d+5jBYni+qzsDNsz8sP1+6d7zLutPJWvpw6gYeNAPrSDyZMJ5Q1KhLFVVHIOJrq3y5a3QQzEe8iKZWMzc18bZPYeI+3jjmQ9kOLIxlMgf1qOXlQ2Wmj2xEpbhMk5tRFcBcT+4oqMY0li5BAYW5fJ2+rE3pRFTuAziAkPiUmOL/fSNBW2KZx7oSJA3mVZFck2fkztefb/EVBithaaDwClisL03xtmlOfxTBY7IKHk1d1Soo=;5:uxqrngKT4BfCrA9tDoHyfE7FapOrWBrcDukhnvpOdb+OE5AjSn1s76+Tp4TLMHasQoek5U0KKwChpfK0XlPDWyvCTE8k9wvF3ZhZnSuT6HxkUGetu+4Qf/fUZkYwAm99hYz/6LSWtVm/EdHPyMsmeQZaBVysSq1p7DSouRWrJw8=;24:b9umDjTVP1paM1ed+8uvfAd2iFPtrzjKHs/gCg9ETjTslyUuYVcedccSW2tSZJTebiyOeWVu95TF4mh4rXQ6gYNz6B7M2o0dIFJTLn/niYs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR07MB2139;7:4B5XdxJ5A1SlztL45iNha9zNwXh6nYF8EP1y3jBU5/KdRIZ7DYgFPWz1Pr5aTJIteX/kM9XH8f3FE8M+YrBSms8JYj40i7vz2ik71o6LBhrbl0t8SMEUCkMz2aHm3F4LYfPSN4ky9zjoOjPbqqtMf+jbHHWStxelonSqJMJqCjZkkJ94qc6QJUwiRvlp8i85R1/mJYeRZ897VaLFbybeY/uuBoaScIKliY9EYkPrfV/KhntU0yIAHhlxac4LxUg6UtocbBfo0Ghqi+WNRmT15BAkz4gfMQ48zauHBSqrQo2qWo3IrzaEEY15zwUCIbaK9JXGw7xHkh3qKXOY5qoJ6waNeyUBZd0Lt+7mZ2akj+npbPzL1Cymq4uNpdpuIwjfeKgwde/eByP1cecBWNFsPstImsZZT8UNDyh/4XicO1U46YCAVVOQCtbaoP2JwM9mSfW/p5U/Z5+wiIrmQpMbdA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2017 18:02:38.9121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR07MB2139
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56368
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

On 01/17/2017 10:00 AM, Ralf Baechle wrote:
> On Tue, Jan 17, 2017 at 06:36:44PM +0100, Alexander Sverdlin wrote:
>> Date:   Tue, 17 Jan 2017 18:36:44 +0100
>> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>> To: unlisted-recipients: no To-header on input <;
>> CC: Alexander Sverdlin <alexander.sverdlin@nsn.com>, Alexander Sverdlin
>>  <alexander.sverdlin@nokia.com>, Ralf Baechle <ralf@linux-mips.org>, David
>>  Daney <david.daney@cavium.com>, Aaro Koskinen <aaro.koskinen@nokia.com>,
>>  "Steven J. Hill" <steven.hill@cavium.com>, linux-mips@linux-mips.org
>> Subject: [PATCH] octeon: prom_putchar() must be void
>> Content-Type: text/plain
>>
>> From: Alexander Sverdlin <alexander.sverdlin@nsn.com>
>>
>> Correct the function return type.
>
> Thanks Alexander.  There is another instance of the same issue in
> arch/mips/ar7/prom.c which I'm going to take care of.
>

If it were declared in a common .h file, this wouldn't have ever 
happened.  Perhaps you should add such a declaration.

>   Ralf
>

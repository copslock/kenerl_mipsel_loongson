Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2016 00:22:27 +0200 (CEST)
Received: from mail-co1nam03on0049.outbound.protection.outlook.com ([104.47.40.49]:43072
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992043AbcIZWWTxIpVP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Sep 2016 00:22:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LVChhvvWLGT0lKR0HuJdjosGHihCqtSZnF8XFyGiiYw=;
 b=W/q3LM5CdD8TdSTR/cyZfzGraVffnhNzrvv3NPLqNjOaUP1mtbSsvXNxu1K2mScc3QhswHlanVIYPWKEV83lc7s8XQpenDtkU3oKMKlnsAmlSpUt89+FMRreRPPGtf0TOyHgay8GH2tnDMYNQ/BAlWWdll3p4xKuDMpuAXl19nk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 MWHPR07MB3213.namprd07.prod.outlook.com (10.172.96.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.639.5; Mon, 26 Sep 2016 22:22:11 +0000
Subject: Re: [PATCH v2] MIPS: Octeon: mark GPIO controller node not populated
 after IRQ init.
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>
References: <57C0922C.40907@cavium.com>
 <20160926204101.GB19498@raspberrypi.musicnaut.iki.fi>
CC:     <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <da926586-ee9e-07c6-afb1-863093a0895e@cavium.com>
Date:   Mon, 26 Sep 2016 17:21:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160926204101.GB19498@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BLUPR15CA0073.namprd15.prod.outlook.com (10.162.95.169) To
 MWHPR07MB3213.namprd07.prod.outlook.com (10.172.96.147)
X-MS-Office365-Filtering-Correlation-Id: b83e99cb-d195-4ed1-d363-08d3e65b8ff9
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;2:0FRsPgTZEHm9QWlmhlT5kbElIOYneo0e3M0LGp6HzyaB4bXZRzEFjzCpO+LBU73Cy6QB33sHwM31Sn3Kki8d3rLGr9XRdXMjznPkX+BlrTOyUkpgzwJfeOiCCKPJkwEkJ+SPX5Ne3oIkhzNAfcSQTB3UMq9bU4/46Kv4YtdtXvvMUoVcsi798mf8BGMqs3mA;3:htLprUpUCdYRknk12E/lj4mDo2hBBWhGJBm4unWD2+JjIC+Aw+eUsNPdNQvTaV7lXL3ZPhec71+KEb+lrTRDTCUPOajqouXK+MJ+lvSVHRfT5x7OuFfbfJVmiBJy9HIU;25:4NDdLgCoff63XdZ7DwQkw5Oz2QK+ApW9DDX7YcNhgOTlEyNZJWR2xpKz0aAjHGU3o4mvoHMibG09fjD4116omR1HfZlQhKLSHlmHLM85B/783vJ5Htv3u2+NODiwieG62MopSc65hCzVWN5Tv9pH6Ors8NbuOi/e+SN0aCtgvdrvKQQfwvRDVFAJpGtZmxJiqJMfwp9DttgopvxT7PlUxo+AxPq+oPTOl0RnX71KNyPP7dF5hweY/0Pxi+zGF9dy+2cswWqMJGFzzc4v75YMn3LF2SP+LPuXc+IAmcig1FpDy5cwh3U/4wHBV4xiN2ePrVMoaklwmtCXo9Qk5+SCEW4R/Go3he2TYyOKK1xoQqvJ38dvmyDNjxLcFTlAl9tNdkaORZlxaHDyVP/XYL9PNv+I/u2rHuLZRVD6AAl2VAs=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3213;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;31:rBBWcWP31zunTuA+5cj4dwmkONzELcRN4XyAuiAsu7Edpa/kFAIy3R/YqcUHWYPzzzPHcEKAzRrYFctOJbgVgOc3Fbf12SUgZz4uDd2YkatocUTnkKe6G+H1m7Q4Bwtq2Dx9aZGhP2bExcOZxuyOuFdlhIbmkihbVnAwrOGc1izjg8PyVGTDpMgXuE2iKAJbMDQASa+5cFsF54E/NrklrFGRRCQv3XiwA8CtHncsmJQ=;20:9XOF44ofhJVpbBu+PEGhTLEVUoRnJHf7QJDYWqdEQytSAP1RWw1Moc3ut7AbO6ba/MDlvR+ivK7svLL1GfZ8zxPsz5d7Bw+DpLvJBAebRYzamCVSye1fq36yjBTBwWgPAUpi14v1tacloff+WcbszRmtNJV+c9jX7cZh2BLMVJ/3MpMVCd/TOmsVyik+yqSPx/8Di+bgEeTKrawnEerNKITrVpejTt15s/LOPTUdOArN9e0cga5tyj1laHpDEaSg6TmXN/e0GRhyAxoq/8E3Uij2QsI3vp0a+7NTvlph8H2l4poL6rURkVcaIJC/U0hy39OkZIqAoDLbK49zG9SSWHtVn7j1bMuYLc+hE8F1WNaGU9xORBV70DUqSzynUjjPxmcbum4o02xawkyoB/OCDCppxirHK63uRlI/8rwY3bdK8zIxqQnROKP2wyG1eO12QTchPcdOCMSJAPX95wBTF4AWApSrvwdTaNuZCyChAXn7oFtI+tGyHULh1QSYkQUD
X-Microsoft-Antispam-PRVS: <MWHPR07MB3213C4B404108F499440446880CD0@MWHPR07MB3213.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:MWHPR07MB3213;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3213;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;4:ra3A9lA0TQHBvb2Tz9nXJjdmczXyvy+CpPR6lda93UmUuj4B3AcoOLk+yL+w4Og4Ge8lztI2BVSvBpqnf4uuw2gwBbEhXFj5JoixtTDY47xXksnWxEDZMAgy//9fmx8NIFiZ0HLlAfcsx4mCOqrY2UmOFfH/FG/3chWhSCS3NZU5QR9LyCRpA6GmFEsquIf1juD1pOIjazVns7uFJueCJMf5mTDpa1Mi72Is7ucTu9sOKN/k8+D+bbOZ7uIGzbmuedOJ3hQmldGelbQisMwvKpG6e8aKLrIRcItvBCpGMXA3cglfAigzuUKt9ELR/vly8XW4WxW7ScK9YOJFlsGooCtYlTHD9dPw7tSguOgOLBnVTUFGwd1J+HTYTViAhR67q1hG3Qk51auqAdEmlC27Fg==
X-Forefront-PRVS: 00770C4423
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(7916002)(377454003)(189002)(199003)(24454002)(5660300001)(31696002)(7736002)(64126003)(86362001)(50466002)(558084003)(65826007)(7846002)(305945005)(6116002)(101416001)(54356999)(76176999)(3846002)(31686004)(50986999)(4326007)(77096005)(42186005)(2950100002)(68736007)(8676002)(33646002)(65806001)(92566002)(65956001)(66066001)(97736004)(5001770100001)(106356001)(4001350100001)(47776003)(105586002)(81166006)(83506001)(23746002)(230700001)(36756003)(189998001)(586003)(81156014)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3213;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;MWHPR07MB3213;23:GiB/XGDZShemswHuXE2PfteiIE6cPWJZvqTk2?=
 =?Windows-1252?Q?leIoPkNkM8R5UZIQVIf91QwVwfIIi7Dcbozj1iUMXW5RgsXART88xGGy?=
 =?Windows-1252?Q?F5GLwAOQzQjiv0+D+1B7jAigv6s0hmDiYJZfX6N80UNnema3hToLlMml?=
 =?Windows-1252?Q?wBRn3tY++ugzDqjFhWe/XOSwgSpMPUKEIjn9sjCiKEto5+DRGPBLSyLo?=
 =?Windows-1252?Q?d8kU2mocGSFbuUcIr3qansmpffuS6P6f5nxtfLnGgqxWzb6M6g0kTvFm?=
 =?Windows-1252?Q?ZlXNoRS/uVCqy3eciDQ7CGJo30MPD326KBGKCIAEqrFxzEJv8994PQmC?=
 =?Windows-1252?Q?mNo9+TMz7tivG3wnm3V6eXnkFngOtmnk9u7wI/kjOps6dIYH2VBNBtsq?=
 =?Windows-1252?Q?X2LuVnnVtTvcg4HVabct/1cC59YjcKm7OrSr482EzHPUmG3gZFvsxx2q?=
 =?Windows-1252?Q?LlJn8D8t4EVcIIZ8pCxcfwO7oHsoH8fY79lxg+vbaECOUHGHrlRAoQng?=
 =?Windows-1252?Q?ffWYplcllhq9dkQoMYjOWyxAaBoW97TWGASNo3Zy7Xjn9XJthgGuDHdm?=
 =?Windows-1252?Q?8DLV6lZP2kLsd/OJwsp60l5swm6ZlpeoP8P1O0h/SrNmUlJlBlA083ON?=
 =?Windows-1252?Q?JJ9xAQPJmppVK6Te0K2k6n6pkexFiwhF0d1cfgPfMdP/UUeQ5PJUwrJ4?=
 =?Windows-1252?Q?lUVAGQSMX7S3Negkm681E1BGBZ7O2crbE/HGLkhIFa0bimFZho+qinXs?=
 =?Windows-1252?Q?QfOaWCaFKVpFI4uVYTv3fG5Ml3gPYltyXqnGKbGr7WktFVAynca2TVir?=
 =?Windows-1252?Q?H7ysvWkB6o1SSeKwaTMaliqZlmspfYui3e7YPFvDncROlxGQW9rfo7cO?=
 =?Windows-1252?Q?Gr4kKu4Dy78rSCHpX4xPDsING+tfuUz7R57SN56Xd2mgFJVlT+7X7+yU?=
 =?Windows-1252?Q?78A501LKRb5srQ4tlVO+mIH3pzTfzCdBYoPgKO0NusW78K4gDyqmMqVe?=
 =?Windows-1252?Q?zjHu5W4P5OzGXXyna+mmKXIoerkgwFm5iGe10g34hEBTJhqt0lXvv1+X?=
 =?Windows-1252?Q?AN+IYnSti8FfkqscmVAgruvXP/EyS8dQZ1ETMk1MW/X7lhnzJSvHv3/u?=
 =?Windows-1252?Q?rVbS/AdFlL14ueaSl41PVGNQhed6JyyGUWxc6EsV9d4D7DZzxrrxRMLq?=
 =?Windows-1252?Q?yggX19Bz5tt5HtcV+bGYnIqasHJuAyJp8djO0ELgSWBdP/2rU3V9ErYR?=
 =?Windows-1252?Q?rJiJOUmYivg4DkK3D+4Aufs48FIUeiGA8HlktKztuEE4nff8qh2A3dpp?=
 =?Windows-1252?Q?/8wudy80qW6OG/zbELpoQ4W71EXLgCh52rlJXzkEnN4aRca9woQj5kgW?=
 =?Windows-1252?Q?3yQ48oHqhPo?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3213;6:UFlDA3uVOiiyXL+nRev58dT09XRSt9rBp6jvVtNkO3PdhgBVjZ6WcXzQcKWoR2xEM6t7P7K6MDQ99A/8slWor9nBfkJOhELQX7lPZbOaAD1O1lTBrpca5+Qg6niOX+RA5mlDo5NRssnugUd+24s6KpIjoYnEC8LrzMjtDk681eoVLFc/zsN6ReZaLsESUe3BJqVWJuQ0q9jCf1reHKBw2HXG0gwxc7cTBIAauA7WDUzx/Qi5QqdLYNR5dOnCYinMCu4xdd+ybSgH8M5CoX7fOG89AW0B4jPGo03dFmmwpI0=;5:xSrvb5onJmkaYh6u7TW8tnbOOQccVmRcPc6TstlnqvGH1iWrndTveeZXaTZh6fitxB6QKlPi5lC/FTjEMQLeyED/DmBkunGxUY/poUkEpurZcMAYjfAGCyth0OHS7ODd+cAn8dCuq6iUqcnRhbzJGA==;24:FCSoUHQlMt7257kiCwFeNTRC0MEFnPux36V0PRlJ50FhIMYk/hIh6Zt8uoQ31934fDfhgVvEOvmQMcFj+uJlyxUQ7B4J40bRi4X3PI+sqmE=;7:zg0tFAzE9Pt62EQhP0m8I8OhqLQZcu12qpuwF8BqceIn+m0N6yHgp2lL11hOt7oMEACackqk4B21yVqDWjDhwOqw68TPejhtgG6iEuewibSS4CV9yNEFbI+1s1ZICNYkxRORn4KoakmD9bjhwuoTWT8cj9SYU1zOaaEwSg3y4aV1fXW2gykmMgV4BaCqWKtXiZUkif6UDykDIpF6reVnmAtL7MqtbFPnCmUlQq9dvTsiHh78+X7o//hL+704uhJB+C78KVwGvEkorBGGVhkN1QYBROO2T4ZJwLbLBuEEHoTX8k/DG5gxXcbKXaHzKqOJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2016 22:22:11.2091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3213
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55266
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

On 09/26/2016 03:41 PM, Aaro Koskinen wrote:
> 
> Ralf, I think this patch should be still included in v4.8 final.
> 
> Thanks,
> 
> A.
> 
Yes, please put it in 4.8 final. Thanks!

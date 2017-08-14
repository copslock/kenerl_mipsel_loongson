Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 17:35:09 +0200 (CEST)
Received: from mail-he1eur01on0138.outbound.protection.outlook.com ([104.47.0.138]:42720
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993931AbdHNPfAoUdXD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Aug 2017 17:35:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9zkJa49Fq9fg3jwSs/AK2hHm2kH9zm3DFPUeVnkF/ww=;
 b=fULmUuHh1a4yUQdgzEOIFzWeh9kJkY6uHOzb7XxY8o5AeFEgyEQ7fvfek/7ukbZRAl0788gzmncZQ3aDKwrLPGgetkGgrtukIsFite081ZStno6Q/puj4VTkVoDlqwtM9MjjIiDvRZMUU41BzmcAaVChqnEyaZa7+lro8qkmM8k=
Received: from [10.144.184.250] (131.228.2.0) by
 VI1PR07MB1101.eurprd07.prod.outlook.com (2a01:111:e400:534c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1362.12; Mon, 14
 Aug 2017 15:34:45 +0000
Subject: Re: [PATCH] mips: Fix race on setting and getting cpu_online_mask
To:     Ralf Baechle <ralf@linux-mips.org>
References: <77b85cd2-2ee8-ae51-a27f-ff046900c3f9@nokia.com>
 <20170807082338.GA20422@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Message-ID: <ab4a6593-b8b7-01a7-2856-1a5d8cb136eb@nokia.com>
Date:   Mon, 14 Aug 2017 17:34:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170807082338.GA20422@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.2.0]
X-ClientProxiedBy: DB6PR02CA0031.eurprd02.prod.outlook.com
 (2603:10a6:6:15::44) To VI1PR07MB1101.eurprd07.prod.outlook.com
 (2a01:111:e400:534c::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 932f8418-2b77-452c-354b-08d4e329fe52
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:VI1PR07MB1101;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1101;3:bcuwHDF+p9h4p/xWq3NIOgX1lOoo1huHgcsL3e3O7IINoAPVPiDAIAP4g0UnExCILynr00T2wKF6o2jQcJ9a4TNtXx7nRv1TqSdTv0t6ImGFET+KD3+xYifNfE+QlEgxmsVPXybdevd5v045C9PBcXp9HGWajIYa66EPToy5gRxBXDRcMGTNO9GskbCGkAut8gFToD9bEu8kfet0d8PbASoRq8Qp3+td5dwGuddLLVn2tyjPSTcq9MYMJW+I202W;25:sO2pQ2HN7t6eXqrpT8ieHg2UxiVwz+KfTo+hMGw9NkOrnyoLpMvTAOfqL0KIxYVnth6XmihLfsstLV2BZBrSbZLV/QxESLfRRUBziroKgvFxhaUDP5LHz5H+RHGywtoOkZKI6CYA6vUJN49QSEJAMlVDiNVG5LyBz/UWMCUAUF6keumvytjUuY4srZLQy6ym6PpIID+TlIKUq12qSpffHPMk1+4jZ6zZgB7PFOwyVxOBDKVvnusq1YTC+dniWqmPuZ5OEOpHGrUBf8tyxw9zg7QW4CIvf3EGYb9jVAbvtJsXsfIvRdujvWDq3Tr14suhKKKOFt7mWMhs/47n2FKjsA==;31:K42XI+YXxNtKTKWqvF1U1RDKGwxFMxURuZZLRoKC29fYc+l/D9fMvuzD9EUreKsZiMlsMzX7spljI1Myc3EeJ86l5OEp/XV7QV3h/BJVvANUMgkYSbg6oFr87YA4uUnST2xETkcqD0RJ3TzIGx/O775PHD6U/PoRh0wkObX8MmNFywjlS6/ukIOkRfRr1TD3m7j62lZvoDlQzkv1gLkMLjB+MQeaHXB2qRpi7Bk0H/U=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1101:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1101;20:S9qP19ZaWDMI6SjQJYAPMpjoiWoMeiuz+rN4+rDT55eYqtjWfbj2Er99jxbiIztg4bd/yIqPTpoYv61I+tOXj9+i9j+ZdrvFubhEYih1Qn4sBOn+B29VjNLvfD7w0upF/5Q1E+z/fDcaK9A5rzU1aPpqhI2FQmsV2JAVRIFMK8Ayj/cYgjle0DMXfYvR8iw2H5JKdg9fQPGTW/Ey4wW3fvz5LYTI3XEdquqI3I4wrpZFsLJ3BR4KfNcnhGAM1crOrpyDqCdX7WbtqP31CXF4ZjvSwVAIAs2Rp+zb+pRceIrq915EWC+qhyi9Ip7NJJtwaKYJu92kk3JItH8UFVdBwdMAKGsaemrq/R4MRD/F26KojE/S5LZV3lF1ArRQx5Z/WTgXB7XL3WhaEJoKl9znS6DDddG0Adp8tHzgfXZfMn/BdJ0yxM+/KKiXrAl3/lY9spO5dSHDAE82sztiEUAyQe8m+RhMY1MJpV+htFSn5rUIJZ+NudTVziD2M84HQ5tROlpR3bSljLudMKKx8WyrlW9aavONM0OYSCzBZZTGbxxO8E1I9Jjk2vrJgf5KgXSrA5fdg+/IOMNe2CXfRCrhMzPAO10BLJQasoOXIeS4tIA=;4:uFUxYXvtizbvwQgStB/GPdhBFtFy2RkozIlD4nrw2J8CQLbFQ6cNR1kA8nkqposBeSwWqtFmvailFCRBa7PDgbkcKmusquvOS1E04q3xwJ3hxw7VYKqAV+/u/kIb0FG/UW6Ub5K/XO/lfuY0XDqPs//q94+ZyQZllGPPF3mpqNTIa7wvN2lsh0uP+7vUr0VdxZkkGjt9ptN6VNTqHhdNGFzqL0osdbZY6ZkFEERRSXadW4pUUkw9owg0fiGpRW1J
X-Exchange-Antispam-Report-Test: UriScan:;
X-Microsoft-Antispam-PRVS: <VI1PR07MB11018326C4E10B4E02E72EE9FF8C0@VI1PR07MB1101.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041248)(20161123564025)(20161123558100)(20161123562025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:VI1PR07MB1101;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:VI1PR07MB1101;
X-Forefront-PRVS: 039975700A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(7370300001)(6049001)(6009001)(39860400002)(377454003)(24454002)(189002)(199003)(50986999)(76176999)(54356999)(25786009)(478600001)(107886003)(110136004)(6486002)(2906002)(53936002)(6916009)(42186005)(31686004)(77096006)(2950100002)(83506001)(229853002)(101416001)(50466002)(66066001)(4001350100001)(64126003)(36756003)(53546010)(47776003)(7350300001)(305945005)(7736002)(230700001)(23746002)(68736007)(31696002)(86362001)(189998001)(450100002)(97736004)(4326008)(5660300001)(8676002)(81166006)(81156014)(33646002)(3846002)(6246003)(6116002)(106356001)(105586002)(6666003)(7756004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1101;H:[10.144.184.250];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=matija.glavinic-pecotic.ext@nokia.com; 
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR07MB1101;23:dTmGZTc9JlxG/h3uWFJCKl+me91plUyh5C7no?=
 =?Windows-1252?Q?3i/y6m5nML7ylIuP9D7bj/qZwLJ+DFohEVnB3fDNh8CgYreSBaACb3Zs?=
 =?Windows-1252?Q?hXbrtH0OWBo5YOz5bQFvcrpYYQ4ajVBTmjBvnCUSOglFCTYWRUEiRpkL?=
 =?Windows-1252?Q?jaxUAvF9BaqJNAAfKmip8L53Qbw9V8FQlMMDn6u/nXZkCJgZSDEzujyg?=
 =?Windows-1252?Q?7FGCyv7ykK2xTmZZH4iUf593SyDHPsVbo1pSMoO2z6NOvN1hUQvi359f?=
 =?Windows-1252?Q?z181iQY31rZ5kFO7dyxEg///y1HqSi6jM/bdtc3N+ZvHE8HvpNOIHVFZ?=
 =?Windows-1252?Q?9PHsIwvLUQjx7RwRqM953WbpMnQINa3nfST4LrrWSIot4bA1A+HmkQC/?=
 =?Windows-1252?Q?nR467Qa+0EzgFPLHYPZtjBaXHp/+JXUajzOlEzhUy6I3QsOVuBT+Uaze?=
 =?Windows-1252?Q?P3HUv9jwV6uqiIp6Z0Bodu9LygpUyostGeoQLw2cXQ9XiHj4f2Kx1nWi?=
 =?Windows-1252?Q?ZXwrbye7NFP39dft49DFJYdGEYe0uYyVnoZGbapgg1y4p7+mpFo04dUr?=
 =?Windows-1252?Q?VCSOOdloyxHvPTH5DfDKZN3OEgQS2Hywt+A8EhIxqJJ/OxMJVhIa736f?=
 =?Windows-1252?Q?/1vwB//4sSm779ocxoifxQRkvHE5wLwAGb9aWjZcsLpTnpKoqfuG0+/t?=
 =?Windows-1252?Q?f52wJcFOhapoTfJ01p5DIft1Oyb94MC5FbGhJZeam1PH0MskAhx+80Ib?=
 =?Windows-1252?Q?z86pwrOP8+uyPwbnrO369qMhTv3xZpRFM7OUfpPMkxKMdafVEzd8/ovn?=
 =?Windows-1252?Q?1OCzklpaI5+EO9l55vTglbd7q7Hb4DDR5tVoP7OkpbepfrF4cBrE+tDH?=
 =?Windows-1252?Q?+LYGrnTvoYSOPyegjePL4IbFLzfx4fqa1vcqHvXcXfNGlWaBsGphDCbq?=
 =?Windows-1252?Q?Dur9mcGWj+4Ar1mEd8vjBYPvYZzTOc6EDGbIRC8voxZTaSAsAkD9A/eK?=
 =?Windows-1252?Q?3BWaGZ/zzD9eL+Rf9vEnsHfMzg+Q31ybWnBX6TtIllpmefi50bi3629Y?=
 =?Windows-1252?Q?oDLAw7u2S86DUHjhd4hh2Fy86zZwuLzK7YzB3JOXsco1vweX2JcggF+5?=
 =?Windows-1252?Q?mHisj91ZpGSr1GL8tez3946skybTzbHnxja6w9zTgOsBO8iLr2g6ZJuP?=
 =?Windows-1252?Q?0JAek5lk6xChNBH5m7rYXzXKu4/VYnC/nSlIBfDj0CsgOEUa8/Z0EaLc?=
 =?Windows-1252?Q?crkB/OCZ1WpbTjWz0D3luieOq6hFmkddSnGL26tawJeIF5pWPOw1VSk6?=
 =?Windows-1252?Q?pYuWmbfLSIjdTpwQCM0C+7KQcNu+PR0Yq1YoWuT5SM5lgVVotnZlyqg7?=
 =?Windows-1252?Q?Y9lqpZQL77MofqYaHyMItQowkrsJxA3MobnwQfzxImgdVyHh1945IplS?=
 =?Windows-1252?Q?d9q3d1QTvMlIbugvcDWdkgvbv+lgY7a+bXTyEP5C+Vp9DnNxQX1Ucg/F?=
 =?Windows-1252?Q?lQvAjhFD8KP+cadEa7rRePEFM11?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1101;6:TIG3LTrtU02WMiyemzxyqc/M/k+EBNvKDedB6/81HbHeKlbnxMtUdHVP+6cSafvRCxV4IiXmD4JmUtUQ+2WIwhKO4dxjIuxIahNMf6StQG9fvfvXTWMHzjr1Smg48IKZ7whbJd8FrWa/ROZi8e/jARk406bmfwEDVGdyoFujmvV1sXJeOiy5YQ86iJJcJE39fzZCHCTXemz0SfjS8is8qMS2w+Mp8NMc6Dtd9QJtZqCnq4SZw4j2e8b65e1wDBVUkZCUTJAPVvyKXJ0cZ7DJ9H6LHvtN5uUF8yGYizxQTbCtHDoDGRZz6ujtryosR6FHzDQ2d0tepKl2NG8kdWthcw==;5:PFWSlLRAviyD/KERrk7ql3cZa8nv9BvVzyoGkpK35BqSfqIOxX/bBkn1l0tOiyKJhebo3aZW7O1GkGuLo735TYtsoPPbSbscfY+2QAOPKBfkNhxl2IcZLzg7mp0BAZgo87KbayHwhjyHfVZ0zFLW+w==;24:E8AFPcE1z9rUihm8UiWyUOMObwyCJPlRwhHfnF32rgZ2TyNNb+G2dSjrAJo2GLnNTHDRLNmdLuuIgLbRtb2iBDnXYhA5wRMvfj9Eebnm1KE=;7:nsQMr1j2NNtx0kLc+HdLGwzKy38FFkIOX+ZkxJLQ98pDpb5ww1cf7s5B3XYbIw2csvg+dKhHGu7OCq5h2lxWhEKeM8nGclAeoTtG4LuwaHZhnjnzo/zQEzjF18hUB+zXBy3SBFc6eTFAJah/5zFxdApLRpdPpsM4DJARmcn0fsCvu5pCSOw18SXp9sPBm1ubFiLi2llcXDzqBWKKv2k9FsEtEDZvwr9su8DIWe48B9s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2017 15:34:45.3858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1101
Return-Path: <matija.glavinic-pecotic.ext@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matija.glavinic-pecotic.ext@nokia.com
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

On 08/07/2017 10:23 AM, Ralf Baechle wrote:
> Makes sense, applied - but after applying I was wondering if
> synchronise_count_slave() should be before the complete, not after.

I believe it would be proper thing to do. Do you want me to send updated patch, new one, or would you like to do it?

Regards,

Matija

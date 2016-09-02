Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 09:07:23 +0200 (CEST)
Received: from mail-by2nam03on0075.outbound.protection.outlook.com ([104.47.42.75]:13239
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990522AbcIBHHO0dtRq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 09:07:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0QOyQRND3wPgaCizGfuJfluchMkl70d6sYCXgpA5pJ4=;
 b=4bjHEkKjPPO2ZBNRlGz4Qdm5lFm2dWWLCdK7xUmMFtDul62DoSEbgnBcSf8SmVRymHectrA8BEHNH1QsMKNPuYNj+fpS8aNgsDXFcLJsDZQXib8SqdY9lQW9JLLE+y+R4C8YSzF5KKs8cou8ISV1DDZ+K9tTe7cgk06DBmvOFXw=
Received: from BLUPR0201CA0036.namprd02.prod.outlook.com (10.163.116.46) by
 CY1PR02MB1149.namprd02.prod.outlook.com (10.163.15.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.609.9; Fri, 2 Sep 2016 07:07:06 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BLUPR0201CA0036.outlook.office365.com
 (2a01:111:e400:52e7::46) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id 15.1.599.9 via Frontend
 Transport; Fri, 2 Sep 2016 07:07:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.587.6
 via Frontend Transport; Fri, 2 Sep 2016 07:07:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfiZ4-0006vw-GY; Fri, 02 Sep 2016 00:07:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfiZ6-0001Rv-Gy; Fri, 02 Sep 2016 00:07:04 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u82770EZ013342;
        Fri, 2 Sep 2016 00:07:00 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1bfiZ1-0001Ny-T0; Fri, 02 Sep 2016 00:07:00 -0700
Subject: Re: [Patch v4 06/12] MIPS: xilfpga: Use Xilinx AXI Interrupt
 Controller
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-7-git-send-email-Zubair.Kakakhel@imgtec.com>
 <f9420816-81f6-f5f3-8bf6-8eef7721c0c3@xilinx.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <netdev@vger.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <594ace15-e304-fa3d-2544-2e7abe9b10ed@xilinx.com>
Date:   Fri, 2 Sep 2016 09:06:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <f9420816-81f6-f5f3-8bf6-8eef7721c0c3@xilinx.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22550.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(24454002)(189002)(199003)(2201001)(106466001)(8936002)(586003)(4326007)(2906002)(31696002)(19580405001)(65826007)(50466002)(5660300001)(87936001)(19580395003)(11100500001)(92566002)(77096005)(626004)(64126003)(65956001)(2950100001)(230700001)(33646002)(65806001)(76176999)(83506001)(356003)(5001770100001)(4001350100001)(8676002)(189998001)(7846002)(305945005)(81166006)(31686004)(54356999)(9786002)(81156014)(47776003)(63266004)(23746002)(36756003)(50986999)(36386004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1149;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT056;1:9mIvVEVq2bK/j0mAZZQlUHzoSzDPyYzhmAZZomqbnxWClhOAhYOFXbL6ekhNgSON2n0grK8AFtM6D5i47knDWJ6tFm4gHumjHWTxfcP4kJ25lFB/1g7dj7g2O5WpyaGizeZVz7PM3dENGGU+dBGHLkVfxv1SUN66PeR415vCreac09QEhFO7iyOy0mtn0CsYjKxnpAGXzXA9qQgVANlppjm/2c3gF7FK+hzQP3SrmXFDTowGiYBPRR8NUPGOHP+pqOdQtVLz/0uChnc4zkuI9z/DLl5KtCRASFwvUigDnGtcuLvcSMdcrXgromHzs2mL2wcaswhMw2Fy8AC4WothzNZjQP5ATJS95rxbFpx12ai/YqJSoADulI7rsBRs+lkS+LMMol/qsCzMFj3guC8deAekcJUBZrjZBlPSysbYQYQ008o9e3Eyjh4wdZaJXQe+2ihMj1P0jMn5qzr7A3xGX4w1eUXkBYDHaBsySte6TvxB8BhLwZcZIBtKsSrx8j5LdCRrD9ceh6tPq3LHiU8elTfVxOJDAFdklIZYjnakQbY9XukpOXih6Ijh/0wnAHzDaT8MQjTPbwJuV4NDsqGTOA==
X-MS-Office365-Filtering-Correlation-Id: 4be745df-a8cd-4fae-3a9d-08d3d2ffbf5a
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1149;2:fFRwqDf743/REbcPv9M7WRowDECqv25/pm2G+IhblIyAfvjQxZ+0FDPhU2CwC353kZJlViU7+S4qBepjpkn0STulrxPTceLjr12xksdAdRl8/zg+o1yuCAmZyyg5YmxQzRKOj1OEpSnM2++KEjdiwr4hD1EQB5FHl3hG44So0RFnDtp8gHkNv1QfFW02Hukk;3:J3bpzeQQ6nQbWasFjK9QQnND+XXbI1IzxY0U4CxUNyLBOc/QFY78V4sP5qADbdLZfAE/swNfyACUdcCAoHjDYR7z21S36eIQ9Kt1LJPA/KdcIvWBfkF0hcHk55AvAxfXeI9vhqp4m1QwQpaOE1L44fqdNaH4ClpC+IatibEHzzBy0QDbvILS1Hm3kcYTqBy304if1FDnz7ZahHyYWtfrkBRVbfzVb4308Iu2iM2jcXCuNfY8Ho4fw2J70BLJp/Jzpc8fbepAcDWSfiuD5Xatbg==;25:IZx3inDQMJDoQgvsSmOdn2vCI+E58kSOm2IsAm+u87QQdIuq2dZk23vBBh3TkxVjhLCO1zkTWT9YOQh+H7idTQCBW0y1CkhLc9zQVMNuHT/nKMvhsqCm5r87iCfxMv0Vw4pUaoryV23PG+IRo7c9ikkH2WzRxqhkl5iWXkp+PRdanJCa6czrf12YJ65cINPuXfmmOifP+KLnN2qVwEuCY2tMic83D5GUODt/TouoC6s6CdUz7KSmn80MHGjx+TSxqSYMRLoZGSFjtTEwXKHvEVmZ+ouByEPeSUq8UkCjL3lYOcf+5Magg2wx+IMtn5SnluFTJNfnmNA42uvx1/rEVXpBTnrLS4Dnwv7yP0zhCc25FQuh/TpFd7CmFfR2SxK10CqSodw8B9/JjuEiB36JPdDUkFeELwd9M7NzlUHFe6U=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:CY1PR02MB1149;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1149;31:eV9GiDkVXEStj0T1cdmIWuIJVxQEu+Qe98vZ1DI3OuJCff2INCZbrGiKyTIWZHcgixmii2gyvQdGB/S2lfqzOiAaXt1jK4JqD1Lc5RPoUNw8XxuhRDtrdxT4D+HGcNNelklSYVUI+ZlOHipwIB92pQhp/bluX67Ey6qiuFYR3UFPIF2oYDmvHPdz8OYs3tzWQ2ol4dZ0woS14EpkjCEpueg5PBaMC3WwYGEzoBPz7oY=;20:sqOpe64BSPrVFzLOhZebh3WzwJnG+Jag08dnpCH6lGzATuS+mCXbFo/LckB071IiidH31BCVhIhd0oIEsiLi/CC+osi8sgYX+9Pfs1p3oNm6A4cxTe1aDM0pj9gTzSpad2ZwIVKZTiZV0lzSeTnSUgSVx1Q9q8MsRN3JlcuS9n2kM4t2KpF+TPja3AOa8GfOctfo28dwdvJxkoCF4yQxMWsp/ZzuwVqpZR4ju5IjgrmGRir/lyWUDM5j7/9wTMYSlhJS5mRrPq12eBkJlotCttoFmj/y8gLELe4LyuVl1+A+oNOhze4gySw6rYSnyKV0aOW3Qe8yTUZ6pHIDC+S5JbBbse+CgRSkvd+eX84Cfj9X0CN8VzdprkU4FZX9AM3jkSIiQvA/i8O/6DhXexvd+bveHxxoH/3dT+Ixc/KV1QhooXIDyy/5DNyb7m1uY91aORol0WYUUfD8Cgw6phgabzEZb80uShtz3SSxxCDVxVDKD0bzjC1ekLPAgb1F2oth
X-Microsoft-Antispam-PRVS: <CY1PR02MB1149F188E3FFC5C1C1099543C6E50@CY1PR02MB1149.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(13017025)(13024025)(13023025)(13018025)(13015025)(8121501046)(5005006)(10201501046)(3002001)(6055026);SRVR:CY1PR02MB1149;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1149;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1149;4:Pt86qTWwhjzVWvC8po5qR1v8oP4qFkFmlG8dhQIhaF/CLZlYonnFDSP9UHs17P7VwyTn2O94KXveWVQkBBVgaGKmhuxekxkfmcuPgYlKVijrvXc3oJ9FpPRArf45VOm+Zwb4SBog3wAiYGENiw16LmFSxHZuWLi9qJlgLnQP8LC8+569QCdV3kQmAl5TKeGqUDOYvX2hItXFGEa0eCAn34DOSD7dm6byLHvwl5ylvQjuR0yvlHf9PUHN4wCmGQFmc2XseOPPvU4ocstiCHhWNLe3lE2SABMmT7FpY6BJOt3aer5lE2Cwokl+QdtSs0RTaeyoQSMennj49yOLi0HT/0bCUABmeXt6YNe6syYiH88Rfxgqb9qMfOGGGw0nnwzGDodx7jxbLmINUYVztiET1MBreJnu1nf43kbSVW35A3lHstFUrxvJfdkVX9ZTPkrlSUSF9b47529sWRkmToETOMEMsDLdru72cIHGfH2oJkPZrsGQI1OyFCnolmRI67OW
X-Forefront-PRVS: 00531FAC2C
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR02MB1149;23:ossh/dMUXv2an0dyhsqGCnn+Wko2FFTh4XrZM?=
 =?Windows-1252?Q?M6rO126tkk/qb6edlCKyBYG6TXIQmXXUrRFrb9iM0z0noDtxf6J+gQQi?=
 =?Windows-1252?Q?zFshLsbdbZryWmfcugywN0wXTI3KICH3cj7G2n0pa8EN3mAqaDbJOaYE?=
 =?Windows-1252?Q?h1noO3IF5bwHu1MrtfKWT0dBGmxtB2frhquxDC9FtocEzUqpcvw+OrVK?=
 =?Windows-1252?Q?gy+ReCy8wN9cAwK5gK+XYMfzsqBIutPsnuewR9ePFLYvX9e5G6GSwfkh?=
 =?Windows-1252?Q?NYGG5dOAZM7FapHebYNMo/+sfjgF2J/IWxJplCF4VWMWnxxObRD351nt?=
 =?Windows-1252?Q?JM48dqIEN9pvudJoQOM4iqkeJqPxu4KnRIiQJL9mEM8l0UiuwIOy9mvA?=
 =?Windows-1252?Q?w+noDXE2wRBxfYLOlCJKoIm17X/4EmnzzyE9Dt3MICILOINxE6tdQ1iC?=
 =?Windows-1252?Q?3c9h2bduyRxivvhFiZtDF7pBVHVGPd3LystZC2qWMv58VJ8+zl8P/P0C?=
 =?Windows-1252?Q?mI1MxuvGUusD04o9jOAdHENJ1nGbVFs9MpPf+19mB/n/pQDB5ydwzGkE?=
 =?Windows-1252?Q?bIj3ApYtspoVCoeTSt6ObIpY93Edr5EOmc3afXIp+Qq2OHatpJel9Pao?=
 =?Windows-1252?Q?20PfzH9LIhjLnHCpm8hJNWR02werjPFdSX2TQ1aIwwSJ28C0TNrcA1kZ?=
 =?Windows-1252?Q?0ElTg4UB9iDqGXRI6UWHo0EemDewiUPHn5RMdWGnDsHnitt2IkCxefKu?=
 =?Windows-1252?Q?FaRuhX1gkp/OftHyDEzzniMyS6lIAuKSNa9YAjbAeHnrVcVuRMvZc9wx?=
 =?Windows-1252?Q?rvzW8BgUvwRkof3D4OvNF2nSLcPQWE+yb/7NHtEKU5wLXWGiLOUAaeO1?=
 =?Windows-1252?Q?JDhsfFXCdyD0nAdJ1lYNHn2jpDhX0yJneQc7HftHpGFJ3cmMbkkOr4Qw?=
 =?Windows-1252?Q?0Camnyx+k1uBSF2CTKjv4SgMKJ1NrqreNslH6cp9N3iL5/EXlKcUy0vw?=
 =?Windows-1252?Q?tR1SYkFa+UizqidEMGof1z05b5pKRmYKZNL47jxjoqyZc6Bf4IDrxCnu?=
 =?Windows-1252?Q?qnk3lmlt+4NBywVab/5IxctZEV8YDFOayMx6tcU8aU4wYUbpFZdfrSwM?=
 =?Windows-1252?Q?RaY473KHWO7WLAc2s7i7Tg1NmLai8kQ7/JcsIhaAD8ShM8PaBnEjx24n?=
 =?Windows-1252?Q?r+A4XuqW3yt5vLq9WmMM9AL/RW//Wk4wMsaAazxLmS2q27cvmVxfq5wu?=
 =?Windows-1252?Q?a5eOwO2iZv7IAiM4HWx6RO955nMkRlTY2GmRY9Ym1dBMiyGClE/u9DWp?=
 =?Windows-1252?Q?h8yq31VdGkIhuuOlEBehpAiAQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1149;6:xP3/uSIqq/RO3YRsggcx9b1HyctBOvbHYt86fMO8LoZhtkAtk25u0hYC9Co1UMU/y9Tyub8hdtdiE63qB5JMfxFsRoZnsZzKXbQeJrVwDyqoCKh86rTLWoPLbogeO6s/sD8r5qn3twknZZS7vG7iZ39Y+3VUe4LCPMrC4Kakt586nb/RAvBxLOfX5X/3ehHzfQ/86zooc4ZNnYvvrJl4wJJqNl5SdJfbdjFWTwQN1nImUHLNbb4zNTbJRmwY53111lsHN1lyzw6cjkSBUQCeIh4PuQzlrIk17RAiE9s6G/5ts+NN/S52pbQTC7fxZCxykuPOYefvBA3AcWtq9B5qdw==;5:M76okW/w41V00W/B6RiUpbYb6WuGJJ+G/oC17jU+2V6KVb7KDOPG6tDTQQmX+72Lmr2k+iviujO49fAkjAJs8oa/WAQOz8/bUYeSTrltTl10U+P+RPx13ACJMR8j33Yg/nXvtyXkh+Pj8fVoMgYd/g==;24:wfSVRDoNM7vLoaY0MDn1vJyl8mp5g7QmLh50Scj9v0IZAgqOfjvC8inj/e0y71cakjbFXx0VOlFZySQZk9xw47nfztTAph5LX5QZYNHEnKw=;7:WBpJ/SA7Yv4+8EV8hVY8Z076cB0G6+OscQOiPzo4eLT0BBzvWUZF1MnH2gxHlf7SyD+v3P/+fB8icfk2MUwyfAOxbYrNI8N7Xj9gR1mmufV91PtExfJKI24dUybC1DgX1mD2ruleLdmso4qhclfQpU8JDLZl25vMV689g3C9e5yeYo9sjBv3Wi0a13E1IAInU3MqdlpMkG5cewmF6TD9owvRN8EUFWAjVcRj44lX09hFp98iFdM4gUJCdJy6yviK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2016 07:07:05.2914
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1149
Return-Path: <michals@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michal.simek@xilinx.com
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

On 2.9.2016 09:05, Michal Simek wrote:
> On 1.9.2016 18:50, Zubair Lutfullah Kakakhel wrote:
>> IRQs from peripherals such as i2c/uart/ethernet come via
>> the AXI Interrupt controller.
>>
>> Select it in Kconfig for xilfpga and add the DT node
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>
>> ---
>> V3 -> V4
>> No change
>>
>> V2 -> V3
>> No change
>>
>> V1 -> V2
>> Renamed select XILINX_INTC to select XILINX_AXI_INTC
>> ---
>>  arch/mips/Kconfig                        |  1 +
>>  arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 12 ++++++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 2638856..e8a7786 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -426,6 +426,7 @@ config MACH_XILFPGA
>>  	select SYS_SUPPORTS_ZBOOT_UART16550
>>  	select USE_OF
>>  	select USE_GENERIC_EARLY_PRINTK_8250
>> +	select XILINX_AXI_INTC
>>  	help
>>  	  This enables support for the IMG University Program MIPSfpga platform.
>>  
>> diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
>> index 48d2112..8db660b 100644
>> --- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
>> +++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
>> @@ -17,6 +17,18 @@
>>  		compatible = "mti,cpu-interrupt-controller";
>>  	};
>>  
>> +	axi_intc: interrupt-controller@10200000 {
>> +		#interrupt-cells = <1>;
>> +		compatible = "xlnx,xps-intc-1.00.a";
>> +		interrupt-controller;
>> +		reg = <0x10200000 0x10000>;
>> +		xlnx,kind-of-intr = <0x0>;
>> +		xlnx,num-intr-inputs = <0x6>;
>> +
>> +		interrupt-parent = <&cpuintc>;
>> +		interrupts = <6>;
> 
> this is not the part of binding that's why you should remove it.
> number of inputs is above that's why this is duplication.

Sorry my bad - this 6 is not number of input but irq to primary
interrupt controller.

Thanks,
Michal

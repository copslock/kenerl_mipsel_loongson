Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 09:05:41 +0200 (CEST)
Received: from mail-by2nam03on0070.outbound.protection.outlook.com ([104.47.42.70]:30942
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990522AbcIBHFdpTZgq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 09:05:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ArXb3ks6/fi32omJ5rC9U/oG70c7yPmDPA6ayE+TFfY=;
 b=fxBmQKyLZdRRZ390Tjqt/V4csSPuAyp9bf+dmVQuTtjJfvOYBo3BKEx2mOYRnW+E0BPeass1g1OmFZNmFRb0sRgttJp0EA0RQDAac5T54bfvMpKK7u5MDkUsN5m6v82oCV5wC7feFXA8QzLg1cIq42UniCYcPB/h4GtZQw9eIBE=
Received: from BN6PR02CA0063.namprd02.prod.outlook.com (10.175.94.153) by
 BLUPR0201MB1490.namprd02.prod.outlook.com (10.163.119.156) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384)
 id 15.1.587.9; Fri, 2 Sep 2016 07:05:25 +0000
Received: from CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR02CA0063.outlook.office365.com
 (2603:10b6:404:f9::25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id 15.1.587.13 via Frontend
 Transport; Fri, 2 Sep 2016 07:05:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT015.mail.protection.outlook.com (10.152.75.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.587.6
 via Frontend Transport; Fri, 2 Sep 2016 07:05:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40492 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfiXW-0003xV-3L; Fri, 02 Sep 2016 00:05:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1bfiXU-00011a-4Y; Fri, 02 Sep 2016 00:05:24 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u8275D3d014625;
        Fri, 2 Sep 2016 00:05:14 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1bfiXJ-0000uL-JR; Fri, 02 Sep 2016 00:05:13 -0700
Subject: Re: [Patch v4 06/12] MIPS: xilfpga: Use Xilinx AXI Interrupt
 Controller
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1472748665-47774-7-git-send-email-Zubair.Kakakhel@imgtec.com>
CC:     <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
        <netdev@vger.kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f9420816-81f6-f5f3-8bf6-8eef7721c0c3@xilinx.com>
Date:   Fri, 2 Sep 2016 09:05:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1472748665-47774-7-git-send-email-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-22550.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(7916002)(2980300002)(438002)(24454002)(199003)(189002)(65826007)(36756003)(8936002)(81166006)(81156014)(50466002)(9786002)(54356999)(76176999)(63266004)(31686004)(305945005)(189998001)(77096005)(36386004)(626004)(31696002)(65806001)(19580405001)(230700001)(2950100001)(65956001)(4326007)(19580395003)(5660300001)(47776003)(64126003)(356003)(5001770100001)(33646002)(83506001)(87936001)(23746002)(2906002)(8676002)(106466001)(586003)(2201001)(50986999)(11100500001)(7846002)(92566002)(4001350100001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1490;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT015;1:zyXz7zbTWkLxGLLBp5hMWFOlgxPZvK8lEiVmdQxpOg3fwmow5IEfxG1T1wKLnrQuErAhxPp7cTIDKuTWeBpOxxRQ72f4L3/wbLpj7MYEnUncDYaR9ofgbWYHYLfJDljK1Bs3btWGD7JF1zhECJgYXIDx1U5AWEZZ/GOK8A252dXgCj95Z27dVPQRsmyg91eecBXG7hjqa69Aa0M2d66on/6VyAp3Nnidw+Kc8dofOaJ0Y+0WEXXNnEyDNlL6HQTU3n2K14UfRO4iiH00/pT6KtuXpEkAHyqu5imBnb0zq28IIt+ZoU0Z+t3IlIUkS6ZcJljwDukbeWPUhmpMPEO9GmjkxgYo23ruLteaE1burJ5IkxxsefWB0lORl80v5J33seAOeHCmyXMLNHHrHL9gjTcYtR7SHLe3BBvDj+cUPMw6c9SM1NSHxANucHf+bC67RoDG0y1KjAYjQsjCgnhGcEbSyddnInLxzaGQnWnZceQzcQ1UFbWqsdK7etLn9QqAIA0FeNkerP/4Nw0utF2ulY2Vwn56yZz8kE7KhU+/Xqpb7GejlbdtWitaHqK4JSRc
X-MS-Office365-Filtering-Correlation-Id: 0856b736-703d-4709-642f-08d3d2ff8363
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1490;2:ZHlu43hRJenBWz70stZEsEZslgxmZbriYLxoohWIn6oV/Givf23uu/AxsCjcHG8Gmc6MzkDcDlcjRXNCp/FAItzgb/dCet9u4yTGJ3F09au4ArIN2NgrpZOAjdle4TeM8jSKgQsiXT+U9GGiCYUxkg2XvDvPB6P1eMV9fGnq3SQxb2GiSKvUndqwk5DpKC8a;3:c5zQ0evGJukYBG1AI1wgp9Bow+KR6jUPntmY1z0/6UX7PbHe5gMeFd78Zu4eIrFCJfldyA7PjwPndX3S+alqxRiZhiQgAjfphFziH6se7XCHIGZaaqbwXkfsg63VJjXI14OcrSeJid6ipr0JAt2xS4msovaqNtb0q1+EzFs+gZNfnMlCuSx6qWcscA/On2MD0QcCKzJOpPmFly/5YoGj0qZPp4GBcPuA72k/hngiBZE62t29MRN4gZNiW+GnwJOFkUOl6xY6QZ7qeuVNTEVpfA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501002);SRVR:BLUPR0201MB1490;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1490;25:r5RRLoKvCwLjjOQw1UzzbM7gog85ozx/nUIQsmLIthcCQqeUxV29Fy8yCLsK9r4LENVg423x/z4548Zok3p8VkiSZfyJcmhRmOqbo8Xes/ZSONSrbzpMrGqxa7SWJs5WMa2lLdYmevUeF4/gtJ0me9PRvV2dHlG1NM0RZLIA74Sx0pXU60JIn5XnA7YRVJJjex1w0kucPMETe9Dyfh6yz8q3OEZUMeSbwjsJwCGQRgD4hpPTyIJZcCjGjRWzqm+5agHm1akmU4ApOuFTRP8iTMjbBXY54OcY8x/vc4W+whZqE7Xhzw1infg2Q3BrbFtMWZteZ0Wi81OCxys3bPtH3v5EDNU4/NFuzFhXuonjL6q1NAoJj/unx24v7sWjGORsokSgfOrDi+D4rbAnDxos6A/+WABdr+Sk9+saZNIJY4FGE6qPsQwGA5m7w9NH9QZkodpm186I3bcHMcf1brO8LJrCKWu2DwFMNAgTxoxdk+CvGW/PaSRzIjnrXoznesmaBWNt3AnIozwWOG9FFDez2E4Zu9JbrIP4Nu82twsWshxUmnmwCGlv/NPm5+oX7iYvvJrXpxr7qnWttm+9fYQKwI3T6bzSQ7lBhnXZz6c5EQ3n/QeDqhUKA5pxRh01aEK+TrjysScAzHN/BweNNzPhPovgoIn/V5DX6A3EsGv9pjG9wSh81NRaBGsDC1rjeEaHImbJGA1Ay5Wi7afWH2aQJBGhz+PQFGLo6psIPOyBFpRiONTOt0BTurmdHo02WRiHafaZ0COcI/Dp9cubnrt3kA==
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1490;31:k9Sh+li1aQYiXVQxqtgOgwHO6CTqz/Q7eM+D53PKzELSMMDmgBn5WOFdXvo/R0H7COjZmU3ppT0jId/Ajp73LDqDOVs92k5IRx3vZGyj3MXw1g/cgRiYb+KGpKs+LuVUVjG5VGNun1vORx6Nvhy8BP177rITAmHBdUL4K40qWYeQ9Z7V2ak8dsMXzt3MaXvugdJ4s8yA+fJGhCpLHyRFl/9PBk4o+tJD/1vJ/54yNjM=;20:svPcAh4oHAHSibp+9wMYztRdKrcYQOsoqgyUrpPlK6lKyCcS5nNjwseUSA/VVmaMDtj6WNFhG5Ju6F+O9HtTLwNjGg41JSBUbN1+gMYnqhN12u8BnZcqaGd6dWjireF/r9tT8WbpNuabpbY8wqIWtxn71LyeZ0wdBbuRhURko72yQPgET0c6cJf2VNbK2PkcD06uUC7lOsc0aVgkndb4vppVDPq3Ak3IfPNUOC9ubOKxyDFBTcz6mu/OPQ4tajp5rQSSqi6kJbX7J7A/kuBgqqPDQpFxQE5/Y3v058CitCR10BLLR+DqVDPLcmgT0wJS/OSOOGKmfv4RgWu0HhXN1KI4unVOFhtD6GpD+eViz9nlfPEJl//d6gW+RjIkA3Qs/ivpR0QLqrPGhnN0R0kGO7Ho2uLZXUd3puLcdrFfgj8/yMCxs6f+elxjtExEEZh1W06bFjZTSB7YvKHzUcPAPgSZg+FWD/DWGCgT7UCWMOY+JgnJ9GTR5yluRl/1bWhx
X-Microsoft-Antispam-PRVS: <BLUPR0201MB1490720A4C78BE5000793A4AC6E50@BLUPR0201MB1490.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(13015025)(13017025)(13023025)(13018025)(13024025)(5005006)(8121501046)(3002001)(10201501046)(6055026);SRVR:BLUPR0201MB1490;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1490;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1490;4://uMxM3acV3MJy+lwon7btLclvXthzoErZ5STFUpQkEvUfhsMGzV5LqmNxmCw2+LN1CylK18RT5irUK1oqOKILZESVbQMfwVtygNQwGkYEUY/y8K7MlFWUON7jS8FmhDQaHtaym+rdsvWBuiBqz2l8tDprI8jYvP3YKpUe6iNcmp7LwRAQRybKZXaSXBTrt//ggoPpVQcChPMlSeZP1JLVb0Zz3VcJHdcpaA6cxiX8Y01lkvc69jRHHStNpNi0l6EzxmCDok0+80X2emx82kpgzgqGXvws2Bt44qfXRLr6UmRMvCJg+bpusiOBaZh1BWBt7/XGDl67zPbAKx76xC5cdnD3Eru7mwqiMeNafiCRndVJeY8Dh7HwGh5RUY1FwX2rqxbWBPfSXnSqMywxphcdzlev/iCU7dloqC50pXUtMMh08L7FsV8oz1u187C/xzp70LOnX+IwwIcJxsER+8nj9Oufnr664iLVPnSoPxye79mbKSuh7tMQbyaHAc/nJX
X-Forefront-PRVS: 00531FAC2C
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BLUPR0201MB1490;23:QK9AW0t5HCHDATfbvkefCPajIUqU77uqpag?=
 =?Windows-1252?Q?ve0NRrO5Oxu5I6Z7NXFZm9qp9oAZKWxPneqyVU9fWol4YFVam/aAoSOs?=
 =?Windows-1252?Q?NNWHd7JmM+uEwAFin0FIAnuxJTUOd29p0pc7DtlzAvoHCeELMQzLgIch?=
 =?Windows-1252?Q?aItSFXNrq7Ud7Z5JaB/7ql3flItN0XkbzTRtiYgLSKQWI9eU8PkHTuYM?=
 =?Windows-1252?Q?6Yx/1/eZkYDGk0Hqs5UslNp5fAp/hvjns9C3cLW9pAKmE/H9TvbYvhSK?=
 =?Windows-1252?Q?ythnOC9EwFOj/Oppgl9h4o0vmXrPjX37zSYvzjOsSlmAbcMUlSQRFtkK?=
 =?Windows-1252?Q?qp2QAhArj5ixJVCLzlqmNjwNMmgsC7cx/x9bJFgrf0L/QQhFZAbFRVJv?=
 =?Windows-1252?Q?hfM2mvT+g00Ac1Lta5pK0ZOUyZABAroaJoupYkGMjY4hqSdYce8Xbsif?=
 =?Windows-1252?Q?Tyoqsr2wRHj6XgRdcPuMuBgZULspHFyw+47bPSoCOQN8icP57Ej+JbCA?=
 =?Windows-1252?Q?HrZDWw5gHXVhY/6h4ij+W3sRNPKBRA0j+gH1kZIE5gs6I9n5yL6g6Fg1?=
 =?Windows-1252?Q?b6ercDOCOHHRnj0y21w7fP6WYhldtjjSVkEMoxuoWVUuySfyQez11FzM?=
 =?Windows-1252?Q?FYDiUC0W9hBEUvDdcDMYdT03oPcDCxBdJSQeJi7YO8tzmz8GvbhajFWv?=
 =?Windows-1252?Q?EVRHYuRGd7KmtgSQ/tOwjSXZZiHUl1kv6+fMYCyIx1F9DHt4zCgsIa8X?=
 =?Windows-1252?Q?w6YGK4Oe0XGppc21Cv/UqDlDg4mhZIVA5rKHKUeclaEXN0h4CaABij/k?=
 =?Windows-1252?Q?WW1/geDpXFBSLYVYjcTljCNfE4h/VE5vqa8UBv3dNmhjvkVMh/RJ70/g?=
 =?Windows-1252?Q?qvf1yU79x5uz/di4vcQ+yGNKyKHJCbMh5o0HndO+awLP2bOeA8DvRbmx?=
 =?Windows-1252?Q?kT53Rkp5Zn+y9lbUCdz/JWOYfZPv4ANPeSUk+E31g2y0vxFSFesGdxJc?=
 =?Windows-1252?Q?JJRhkJSjZNPlEvW7xP7LSLvpuJ0dNZRUN9ZC05xhXR2ktJGX4dVYHAmr?=
 =?Windows-1252?Q?nnSwCaIaW7FH78ZhzCgxC0rYVrUp4WijiMdFsvjUVlX3J1fOtY+1IASe?=
 =?Windows-1252?Q?b7kp9szo6WudQwxtsvQKNvw8YU50G56K14/nraUB+/+rlJcyCoE+ebxl?=
 =?Windows-1252?Q?AZFwSYLnJbdekJG3lnHXy2osL0hIBdfDlub50I/36Wi9m/PH5zPRxcoL?=
 =?Windows-1252?Q?n57u3v8ZuPt/5JLlyv4MlR0McuWNssilFOqo3vUD/lqk5EgkZEWvoXfT?=
 =?Windows-1252?Q?9+wr9isA8LY6VAhNdCqRx/aC2N/LoF+KlT37ePrVcB/iuIjsy6alssbB?=
 =?Windows-1252?Q?tInLYypuOaVhQ?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0201MB1490;6:oMt71EqlTFUrfa+4mnrl97SNKhvpLFB5IqUq8t8ouHjRk1AiS3TukH+n0iuF/ExPyKQ8UuAKQoS5cv4WeLOSNmIciM5XtcvhK+DgT0Y+DB5zLEzNxq/Fi19q0Farra5iM1sZWJ2xvzI3U+YNKe/MIphs5aHZb4VBeDhXc9oHOWBJyh7xTkg98y+25s61MrNYQ08J3/+8/o0+u7JJeWOlyQkO9fILdUnMwxj9141iw7sRVyKCanb/JkuZhDgX87PdOGS+6yqvka6IOH/OzMwRlpJVTQxQfBeEEdXfTJbTQg2k3DnsOIv9A+NIAMNwgP1lSZHbx/Ey73L76CC4ay8j+w==;5:do58bXsZUP3dA7rfhl2MO+uuBCHCyMFvsE/VGrZ0WcPNq1PuMm8VR3Oy4/USgdrcBnTyTErotagOHfKg0+uia3iu49Kn+Ge/IEv0lq74szdHsewbVzcW+DCeHAbjrenICJ4EoXutJPxS/5SVVmCALw==;24:CwL4ltIxGeWDppCkrOTQxK3b6iq6dv277FVEsvPL7FUGKG5rI/WJcQNvoogbvLkTdIaSP5YvXIhjEZZ6txyaDW9gh1c4felR2y7yX+BuWPg=;7:4VshAEwm0XpPPw9boFziT/sAbYQhk4Ef4RnEN8O708unCZkyF+4OnyFnSb/erzORpW86J//pLeK1+YGZX39ott/qDrOVrRarmQONFaUIYWeHQaqVRhk4uvzuNq9Qj8XMN/0aVCaPbbw60NHNWp07yOIgdy2YO4UfaKaKfXb3VW1wpj2VUNdkAvMaP74KcB28gLM573rUtz8Rqvfnu54gMpZ5mXFDRA/6Pz0sebPvqx83nq7f7EkLpH+ENwBqTyGu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2016 07:05:24.9069
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1490
Return-Path: <michals@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54968
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

On 1.9.2016 18:50, Zubair Lutfullah Kakakhel wrote:
> IRQs from peripherals such as i2c/uart/ethernet come via
> the AXI Interrupt controller.
> 
> Select it in Kconfig for xilfpga and add the DT node
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> 
> ---
> V3 -> V4
> No change
> 
> V2 -> V3
> No change
> 
> V1 -> V2
> Renamed select XILINX_INTC to select XILINX_AXI_INTC
> ---
>  arch/mips/Kconfig                        |  1 +
>  arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 2638856..e8a7786 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -426,6 +426,7 @@ config MACH_XILFPGA
>  	select SYS_SUPPORTS_ZBOOT_UART16550
>  	select USE_OF
>  	select USE_GENERIC_EARLY_PRINTK_8250
> +	select XILINX_AXI_INTC
>  	help
>  	  This enables support for the IMG University Program MIPSfpga platform.
>  
> diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> index 48d2112..8db660b 100644
> --- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> +++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
> @@ -17,6 +17,18 @@
>  		compatible = "mti,cpu-interrupt-controller";
>  	};
>  
> +	axi_intc: interrupt-controller@10200000 {
> +		#interrupt-cells = <1>;
> +		compatible = "xlnx,xps-intc-1.00.a";
> +		interrupt-controller;
> +		reg = <0x10200000 0x10000>;
> +		xlnx,kind-of-intr = <0x0>;
> +		xlnx,num-intr-inputs = <0x6>;
> +
> +		interrupt-parent = <&cpuintc>;
> +		interrupts = <6>;

this is not the part of binding that's why you should remove it.
number of inputs is above that's why this is duplication.

Thanks,
Michal

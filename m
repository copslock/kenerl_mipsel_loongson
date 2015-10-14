Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 19:34:01 +0200 (CEST)
Received: from mail-by2on0078.outbound.protection.outlook.com ([207.46.100.78]:30579
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010417AbbJNRd7gKyH0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Oct 2015 19:33:59 +0200
Received: from BY2FFO11FD022.protection.gbl (10.1.14.34) by
 BY2FFO11HUB020.protection.gbl (10.1.14.140) with Microsoft SMTP Server (TLS)
 id 15.1.293.9; Wed, 14 Oct 2015 17:33:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BY2FFO11FD022.mail.protection.outlook.com (10.1.15.211) with Microsoft SMTP
 Server (TLS) id 15.1.293.9 via Frontend Transport; Wed, 14 Oct 2015 17:33:51
 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:60009 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1ZmPvy-00008U-SP; Wed, 14 Oct 2015 10:33:50 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1ZmPvy-0007hC-Ly; Wed, 14 Oct 2015 10:33:50 -0700
Received: from [172.19.74.49] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1ZmPvy-0007h9-DT; Wed, 14 Oct 2015 10:33:50 -0700
Date:   Wed, 14 Oct 2015 10:33:50 -0700
From:   =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <ralf@linux-mips.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <linux-mips@linux-mips.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] gpio/xilinx: enable for MIPS
Message-ID: <20151014173350.GV15287@xsjsorenbubuntu>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1444827117-10939-3-git-send-email-Zubair.Kakakhel@imgtec.com>
 <20151014151813.GL15287@xsjsorenbubuntu>
 <561E7B65.3090704@metafoo.de>
 <20151014165450.GS15287@xsjsorenbubuntu>
 <561E8FDF.9070500@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <561E8FDF.9070500@metafoo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-21878.004
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD022;1:HgAId8+/Zxd2GqEq+rc/28FGNMyuJ78H+ipVf/8aDL2xq5caAPQ6TrkAKt4jmbRfO59Jj4Dg/k6BgFwedqmgIBfTcb8zXLXZ3SZroB+sSBoDVHxYKcavHMWq1DapVYg3I92EvEgyIkvYOTLLgb5mAm3glykLNRNKIGjYW0IoXP5hTVso8zfwhykDgWPrjOaAc+sQfy0RR6FeSDoKgDW5haO4Ls5kb2PaX7Tsrd2ENuFZKDivZt+Ljzi/zFxu/29t3by2y7qKJCh98VlJHahzv62yk9HaSfdmJy01n2dYTn7Y7sQcOSoDKJt+xtdxQDl8VdjLN12rXGAIoQb8luFfxiEmG8aqS2Tkj/R+hwODFZbiOJ9KPpOR0ojlpS5vYRa2X6vfRuqUnMCzeHhz2a+TtQ==
X-Forefront-Antispam-Report: CIP:149.199.60.100;CTRY:US;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(2980300002)(438002)(479174004)(189002)(377424004)(24454002)(199003)(377454003)(64706001)(6806005)(85202003)(93886004)(16796002)(106466001)(2950100001)(4001450100002)(5001960100002)(110136002)(5008740100001)(5007970100001)(83506001)(92566002)(11100500001)(189998001)(46102003)(57986006)(50986999)(4001350100001)(81156007)(33716001)(23676002)(4001150100001)(47776003)(76506005)(19580395003)(63266004)(77096005)(33656002)(50466002)(76176999)(19580405001)(86362001)(85182001)(87936001)(54356999)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2FFO11HUB020;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11HUB020;2:ho55aDlllq9M5vGJoR8c7Dv7OiqP7CUxImDy3WMG6m7b9qGjk0G7NrBEqfaYU38jvYw2RdpiM9qG7JuYNxXJ9Gs4jqGYWOMVLmwknV9LEdDPPnN5hb5PyTiQJEY3JY8HtJcPYNKbSu7iEbCAKmR7RbJE+/3xije+XOqToxUg5Ls=;3:O1Acn6c2IHcFbgoFu6M4jf0Dl2UfT6llTFFjVudOA7mA8Mg2Zbb/shWjNOiDX579aTinyvkh+PXsUgNk05OmGAlwnah2QfThQrJNUvwwFrg3K8d09V4sk4TWBN5N8m3iKydGjGNiexWCZOjejEuQp1vKR1CiV09165VlSAg+dTIM2DUofRgOLvDK/qaGRn3TvbhjfYDhWGWoNzIk9162TOowDPmwfZfDaxO8N5+BFM+2iXQRh1IV8yLOUykmqrMs55TSZ7TkRg2MvsZyE2SCpQ==;25:thA9JfzDEfYO4HovKDlNsLF8TfBAnxERFRARFGvqjeiwkIXuwELFcSMVVHO4N6UEiCDzwi4Pc6ksXXly/3p+BIMGUG2+tIoVZqXyqHBWQNrMNITSlzK+HpCIKXH2tDVBfMfzX1X0flMOI0RchnMyLLH7YeA3WmpnBedDxQuYkXokcFbS4Bix831y7Mrr1JcMB7i2sUJ1u+ZwUTMSe5o+yws8o2HmsQVXbBmmTDIdaSj6ZCuLl8S7+LtaNeTn6qvFlHoFMaFoq7P1SFfX2wUNRw==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501001);SRVR:BY2FFO11HUB020;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11HUB020;20:PocdTgYNj1fuT3F8gzDiwZNVDLXIHEXZyOLIPNezoOZ8oStz/jfISXCJT/goTdiaPvwAhtoMI/ggyj87V3BBvlmIWIWpb1JhyY25eGylJ7cSlPtZ0gBLtOtVF67a9ZjmAcsVjh825FTfAb2co1TIpFW+3nr54ko875xZJIOsR3tH4KMm+anXT94FcGkg+0H/hUdB8xVL+X/DNrRFiZwGYhiMTW4IdL6YOC+tzok5YXYWHFVoYtTqhtgQ+xPTnjqnOm8lHcs4rI5wYXLba/wRFQkIEyQxk0p6sL0liHMiNnQwlGSOAiE363q/fXeLsHVGMq5QejaqwMCmusrQb1bdWCXvJ2ZmrQaXRbLBjPXY0ZbvmvdVHVx1F3OOHu4P5I/xBkhmIbtSGUtYHi9zo6zoAF8atSid6UuGakLWYI0GmyBONE8K5YnNDBwzRohVS9A74/rIjhYCu9pYXewNDwX4wZtMQcapVAZP4g1g5ed1xCLiPZHOkqhl5USKrLxGkCAl;4:0zFYMO3Fr9REM9xBmr6GvRBBijyFZ0AB1qEBsV4OiPpZ2PETvmxGSBABJij3krgDRvj1hUgnpkCwWFMVjRx06/GhkCvu5AX+zj7/RMwXfi5X3hcWD8FY3MqCb75ivzojBzrNCPZmuR6gn3R1WyKQQJtymH1uN6YcyjGg71HVVStiDE9z6Ur148nrGazue03SXDqFyggh4VEDMoJHNx+OsWTFu9VnIaFufJiwOWPANwPFHFylHOBQb4BAW5UQcdGbQbx/19PzLZ2tcNW64LJQGyay+g8t3j3c+XufPuyXcdajnkP7QsFq2MmO1WFPt+cQjXC+3i2J4JNzmPNm7gsSQJdbVj+YUqJVSbLssE79O/Rl2h7VzEeiEuIMycPvAhnr
X-Microsoft-Antispam-PRVS: <BY2FFO11HUB02090E834A1C0CFDD90A95A8C3F0@BY2FFO11HUB020.protection.gbl>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(520078)(5005006)(8121501046)(3002001)(10115024);SRVR:BY2FFO11HUB020;BCL:0;PCL:0;RULEID:;SRVR:BY2FFO11HUB020;
X-Forefront-PRVS: 0729050452
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJGRk8xMUhVQjAyMDsyMzpRLzV0Y01RQ0U0enhvMWM3bi9yWm81T2ox?=
 =?utf-8?B?UVF5SWppRm9lbFdOR285Z2dFWDNNY1FFTU00eVpGbWc3dFlHdTlXSzZkV3cv?=
 =?utf-8?B?YkF6T3YxdmRsb2swNGE4cytaNzlkZkVVUFVyKy9teGtSeUNGZlhJVEJJUHRK?=
 =?utf-8?B?eVBaUmYxeWJCOExLYUs0a0k0aUhUWitIUFRiSnExR3BkdlNOODc5enpjeGNJ?=
 =?utf-8?B?VHRwYnhUaUFMSVZiWkZLWGpGdDlkNkhOTGxrSk9TSGl1UFZMRXErQnc1UEMx?=
 =?utf-8?B?aFl2ZlJnMWwvUHF1NUxQRmQwUFVZZzlJNTNTK284WXdVN3ZKN203R0VxYnIw?=
 =?utf-8?B?enFrOGM1QmFrREZxNnUvZkY3S3FHZlc0MGpKWTVGRi9OWGdVVXFYRVRpQ25S?=
 =?utf-8?B?bENsQ0FBN21YL1JRcy9Cbm5EWk1jWEhrSGdCSkN4Z3I2MkFMUHowbkVRbW5q?=
 =?utf-8?B?RmN1Wm54ZGNVdkR4b3VHK3duOHp4YzA5N2tSR1diZDlzT25tTlBuMFBhZTND?=
 =?utf-8?B?Z0hjSUxQWlhwdXFsTXA5K2t4NVlWNDcrRHBwL29jTmJFdldvUW5wMVJUeTRI?=
 =?utf-8?B?bStFRGFoTmZqNzBVbDRoOHMxTlFPVVZzSWdSMWlWMnpzcXFqSlB1aVpVc3dI?=
 =?utf-8?B?TDFUQkVpTmdwSEVDZ1ZJUTNNNW9HQ0pxTkpwU05XMko1V3g1RWRyWitpUEw5?=
 =?utf-8?B?bmNNN2phQlRpc3Bta2RWRTFyUHRXelhxQmNNZTlYZmFqS1UxbnAzcmppOU5O?=
 =?utf-8?B?UDExL1k0enc0TmtOS1NobnRSVnhJaU9TSmQ1K3N6c3BKc1VpS0tCRHhBeUxH?=
 =?utf-8?B?Ung4aHZ2ZWxaVjd5djBHaytHYzNWVmJYTWlKSi9iaUo3eVB5QlRiV3YybVFL?=
 =?utf-8?B?bFBqbFFDWmw5WVZvNkRmVjVEZkFXZmEyYnJFaEx2L1NKdFg4WkJlemdMaUJ0?=
 =?utf-8?B?amZkcTNCQlYyQWdaMlBha0lrR0srcS9tVXZUZUdCS0lFNE13NDNqMzhvK09Q?=
 =?utf-8?B?NFQwS21NNjNLN0x6eHJrOE5kcWFJT3k4RzkrVVVRb1dqbUZ4eDdVblFSN2NY?=
 =?utf-8?B?V28zcXBlOXhza2laYW9IcjRrbVlWNnBsY3Npc2Y4YVZUcU1FNWZwTkJERzNm?=
 =?utf-8?B?RDlrd0xrYmpuc0J4MTJLamJoSEFYQUhxeGpvb1lsbUVmMFc5S0tyaTB2NWRF?=
 =?utf-8?B?U1FjVXF4MzlSa21QbktqOFNlajgvZmFtYXlMdXFrSEpBbVd5NS9ibWxFTXpK?=
 =?utf-8?B?clFRR3FyUHBuMUZKcW1YUGlLeXFna1RyZTJJeEc0andkZEJLTTJKelhueXIv?=
 =?utf-8?B?Q2RHTGE1eTFDL0l5NDhTdEJWUm1UYjJaR3FvcWxPQWg3a1FsVzR4WExFbVF5?=
 =?utf-8?B?K010ZTBXMjRRTzFEam9yVHVFdWpRYkxvcDBDelFaT1phTW9TcWV5cjIxUVhK?=
 =?utf-8?B?V2pYT2dBZG5QWFY5dzZCSC9idVhhR1lwTFZtUWlHRVE1bGw0TVFObUVlYi9Y?=
 =?utf-8?B?SVBObXZCaktkSElmNzZrUytpMzJzZm8zVXQ5MVR5cWg4QjNnNThHQmJqdHlq?=
 =?utf-8?B?RDlzb2lFNmJTRUxiTlByWGh0cmtaWTM0M0dtcktlU0RSb3ltWWF3VHlxZlRP?=
 =?utf-8?B?U0NHUkFpNnROMG9KcDVyZkxSMThhZXRSQXNxMjVCT2JuSzNiOUErKzhrWDlh?=
 =?utf-8?B?NlN4MDZuYzF3eXlCMndPdEFqQzdwdksvanhDeHA2U3RYY0ZFTVByMzVnelkv?=
 =?utf-8?B?MFFqdHo3d2U5aW9ON1MwOXc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11HUB020;5:3T64ZaLZ9q09fhr02smtXUeQczIp9pyXwxLOJ3mobZ99Yp5aKLMiRs53+L5xRwIG334DHcCroi53BUZZLMmFr+5YKvuKzZGHf55FAaQ/6F5OsSWImdSFgSHuGZPvUQzs0MJ7S9iZ0j6Rtbo1myqjKA==;24:invnj04ybVvM8a9sE56+knoQtOvZphAbsyLVVtQb0uSS1N796d7qTmwikbzCSAh2PX8Z9NreFhNYmNyZFEdZAx/pJ79loYS12obYunY2pfM=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2015 17:33:51.3246
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2FFO11HUB020
Return-Path: <soren.brinkmann@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: soren.brinkmann@xilinx.com
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

On Wed, 2015-10-14 at 07:24PM +0200, Lars-Peter Clausen wrote:
> On 10/14/2015 06:54 PM, Sören Brinkmann wrote:
> > On Wed, 2015-10-14 at 05:57PM +0200, Lars-Peter Clausen wrote:
> >> On 10/14/2015 05:18 PM, Sören Brinkmann wrote:
> >>> On Wed, 2015-10-14 at 01:51PM +0100, Zubair Lutfullah Kakakhel wrote:
> >>>> MIPSfpga uses the axi gpio controller. Enable the driver for MIPS.
> >>>>
> >>>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> >>>> ---
> >>>>  drivers/gpio/Kconfig | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> >>>> index 8949b3f..58e9afd 100644
> >>>> --- a/drivers/gpio/Kconfig
> >>>> +++ b/drivers/gpio/Kconfig
> >>>> @@ -508,7 +508,7 @@ config GPIO_XGENE_SB
> >>>>  
> >>>>  config GPIO_XILINX
> >>>>  	tristate "Xilinx GPIO support"
> >>>> -	depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86)
> >>>> +	depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86 || MIPS)
> >>>
> >>> Hmm, in general, this driver is hopefully generic enough that it doesn't
> >>> have any real architecture dependencies. And I suspect, we want to
> >>> enable this driver for ARM64 for ZynqMP soon too. Should we probably
> >>> drop these arch dependencies completely? It seems to become quite a long list.
> >>
> >> I've been thinking about this a while ago. This is certainly not the only
> >> driver affected by this problem. But the thing is people always complain if
> >> new symbols become visable in Kconfig that don't apply to their platform.
> >>
> >> Maybe we should introduce a HAS_REPROGRAMABLE_LOGIC (or similar) feature
> >> Kconfig symbol and let platforms which have a FPGA select it and let drivers
> >> for FPGA peripherals depend on it.
> > 
> > Sounds like a good idea to me. But, does that work for all use-cases.
> > E.g. if you plug some PCIe card with an FPGA into an x86(_64) machine.
> > That would allow you to use those drivers, but I'm not sure how that
> > could pull in the new config symbol.
> 
> Hm, right. We could also make it a user-selectable config symbol. In that
> case you only need to disable one symbol when you don't have FPGA support
> rather than one for each driver. Although I'm not quite sure where to put
> such a symbol.

Eventually, the FPGA manager subsystem could probably provide some high
level config symbols. Though, it is probably also not given that every
FPGA-enabled platform needs the FPGA manager.

	Sören

Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 17:18:24 +0200 (CEST)
Received: from mail-bn1bon0055.outbound.protection.outlook.com ([157.56.111.55]:33477
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010053AbbJNPSWHELbs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Oct 2015 17:18:22 +0200
Received: from BN1BFFO11FD006.protection.gbl (10.58.144.32) by
 BN1BFFO11HUB034.protection.gbl (10.58.144.181) with Microsoft SMTP Server
 (TLS) id 15.1.293.9; Wed, 14 Oct 2015 15:18:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; imgtec.com; dkim=none (message not signed)
 header.d=none;imgtec.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BN1BFFO11FD006.mail.protection.outlook.com (10.58.144.69) with Microsoft SMTP
 Server (TLS) id 15.1.293.9 via Frontend Transport; Wed, 14 Oct 2015 15:18:14
 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1ZmNoj-00013Y-Ul; Wed, 14 Oct 2015 08:18:13 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1ZmNoj-0003ZY-Qx; Wed, 14 Oct 2015 08:18:13 -0700
Received: from [172.19.74.49] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <soren.brinkmann@xilinx.com>)
        id 1ZmNoj-0003ZV-Eu; Wed, 14 Oct 2015 08:18:13 -0700
Date:   Wed, 14 Oct 2015 08:18:13 -0700
From:   =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
CC:     <ralf@linux-mips.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <linux-mips@linux-mips.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] gpio/xilinx: enable for MIPS
Message-ID: <20151014151813.GL15287@xsjsorenbubuntu>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1444827117-10939-3-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1444827117-10939-3-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.0.0.1202-21878.004
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD006;1:fcsCYATMOXSI/MGXSzupPPaHd87M6QKjB0sSO7tlBQGWK+xWl9Juy8Lo0OOphlRTvuIqtOdCAMd43kAq1gBKYRCf1GbpOXAIimdkKxHlT+Ehnje2cpHccO+6yzFJBz89adMVKajJhsBelIxC2jq59fh+nvW9LbU8gelQN7cTx1yig8NzMQDDEKYdlfkc5XDWCOL82qZKej9rkTJzzFp/31WBoH0e7SJ+ErwGzEjM+v332xgZ1eTyj7qwawmJpVPsuLzP1ylOu5s2UhqmFWDOBUAjKgnbq4dqS4e3gJ7dtsZCc2+7Z2IzBOHwYzyhJfj/bYX05DJnjzNcRp8cSpTTFYYqNjQa2AQPmZRdkYfupjY=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(10009020)(6009001)(2980300002)(438002)(189002)(199003)(377424004)(24454002)(54356999)(50466002)(23676002)(2950100001)(87936001)(5007970100001)(50986999)(83506001)(5008740100001)(46102003)(85202003)(110136002)(81156007)(106466001)(4001150100001)(85182001)(6806005)(4001350100001)(86362001)(57986006)(47776003)(92566002)(77096005)(76506005)(189998001)(33716001)(76176999)(63266004)(11100500001)(19580395003)(16796002)(33656002)(19580405001)(64706001)(5001960100002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1BFFO11HUB034;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;PTR:unknown-60-83.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11HUB034;2:+UqUD/j6Ys7mT2DfUVQiPIqVdxfPd8M7A/ND/51nAb2VfQIV6lHvR1C5LRNdj4qjQ56foA3vU0ADdAr6oGRPR1iQ3Rn6XwZ/0dt7T+pG49qaQwajc0WTMYaNqTImbcC03Bi0qk+kl16a4mHWnNCvJN5QJlS8pZZqEsoXU4LueEc=;3:zKbL03CRUrB6DoSgXOLLfTk3uoABBFvDlGkSgj5P4ngtCx8Nm42HqzBynvdLGzswJ0yZ049TpDj6NjICs89Aa0Fg56NM/v/5yYHOgsF0RuZTq2vzXeXLYyLJDoaFVq2odDj2TcBInoQY61WoTrA/DxWOdn4dzjxj7etveaazwJIleTnLlw2Ab0UvieTf8IDGnd7X3ihxzmuc3kstxicEu1FN5O7tke4Vf02tGSlOhZK6fQSY9md7pcADpaJJeNuHD1aaXufH2ArNI5hkwgyDBg==;25:VojWTCQgiE8M5/9rfkZZGqE5tMeXM6Pp2uWCHHF3redYJghmiruUcVDkaAqMkxRioR+5d9JtvM51dN8eF8nO6HmK5HGuDb2WV5s8PCPexf95gSdWw17gJEl5T1wftw2H7CVepxqvVy7KG6CCyIAIvFH/ZkxUVss6Hi1trkDzG63FHz+b0DpjTpMN9VmVJjL0oVZNS8Gz3uib0MIvtCvea4Ap7Gp60CU595tZ/aUoFqf3U6wL6F1daTE6AlUqfg2n
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(8251501001);SRVR:BN1BFFO11HUB034;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11HUB034;20:xJkVITIptvp0xOb5SIWdQQpenSFIuDFCAen1DgqA7OBMUJYapj19j8KJG6VsRBtwIr4JYyPeFkJaF1JRmCqd8HNzfcbVRevGaSVE5OvNvVWKxRWDTu01rqfnGduzGPATyQ/vUc/cp17PLzcKHqdzmY+WhcxjPNUB4ok8o2b4DNiiqxYYNgC6rBdE4RyWbI+YKpqWN/Od1SC7Uo3pgIAaYSpABI6mamV2BAy0JK1rS62jqn8MwPIFzXUbb46omJE3rEpeCH07IUR3C2yo1qkddq6hcY3B6wvQwdZIvhWeDhRQ2VPg+N5YJ/5yzXIutdaXBXu2sTCnWczAiBpR+RXK5sUCQkX8TLX77kbRWX0JI2iYkRTI7L8S2KbG9fiXD4tYoSxqFgkk0WzUet/uBMnMvDKB/ZuHFrdO4LFHGvcJZ2fdWel2zA9/LF1qvhS5Hxaz26rbIuLSHUoohyjAqMtziYgVvAttTI1mhRE9kfzHRCHFXr4807P3BkOZgj2SjPwy;4:A2UWgGmDWQQttxTWZrgfPYblpNL63F+Psz0SxQUSc2V2Rzb/Z/t0Ru+TuXxCb6Zv5ZWCp0JG4yCdopGY+/JSErA57Bns04o8T/NJkItT04mg9LtL7xsmJ8nBGgock2fzY07jc/pFF4klJ8ugvNhL63nyLeYlRSbwqM3zoOqPj/qXPpfajfvHp0nEcTaXOgBfkT8anV/y5RRUQaNtV5G72vVj5QUC2wXv0pIvI53JP9O6Zb/YAbej02nfzND8ss7M0Mv06mXhLMDG/DIhMdYbKYr3h/aZ+7+3nKXqZjwehEg0glD2NAncO+YYGMOOGoQaUSRotn/mquMo4crnfU1MK2Qa/7MueQgpycdYxs1+Fm6QB140kDNs9YiXokUjKKIn
X-Microsoft-Antispam-PRVS: <BN1BFFO11HUB0343084FC305B4E5FB338908C3F0@BN1BFFO11HUB034.protection.gbl>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(520078)(8121501046)(3002001)(10115024);SRVR:BN1BFFO11HUB034;BCL:0;PCL:0;RULEID:;SRVR:BN1BFFO11HUB034;
X-Forefront-PRVS: 0729050452
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjFCRkZPMTFIVUIwMzQ7MjM6UFFpUDB6QmlLNlJRYk40b1llZHdiZ2VD?=
 =?utf-8?B?THJCbGpObW5LN3h5R2JscFZ2MHJaS0k3YWdObmViUkZsQ0YxdkhjU1JQa09q?=
 =?utf-8?B?NURjbXhPVVF2LzF1WGNtbUV6QXY5d21YM2ZTTHlwRXQ0R3ZDaGZsVFNxaVQ4?=
 =?utf-8?B?eUFBRW5oVUVSV2l2S0tVenYwbzNZUlZZcHZxMUxGTENkaFVjclNVS1NMR1Jp?=
 =?utf-8?B?VGpOZGg1NlJ2N3VHVkpwcnl0c0lER0tpeWpZNDdPcmpDR3B2TVk4SUZGTHdl?=
 =?utf-8?B?NFVaM2VnU3RVdWw1blArTURIM0dVK2lNa3pxM2lYRnlsbE5oUXRaM1NYdUQ0?=
 =?utf-8?B?Q3dPTUJySERKb240bkZSbXRTUHo0b1pCU2RvZTdNNCtoUDUrcHVmN09nUzdU?=
 =?utf-8?B?VXZtd3V3NTNwWFRscXJKbjAvTGF4MDFwWHlObFp5c3pDVXhmRkdhSFZQa3Nh?=
 =?utf-8?B?Uk95WTJEUlpqUTE2M3AwalRtRzhBUG1hZGtWZGF1dXVxZnZhc2IxRXFLMlZB?=
 =?utf-8?B?QUVNTEU2VjIrZk5OSU1SOVFhQVpMQXZ0c0xhWU03NDdVYVdXc2g1R1g3Smoz?=
 =?utf-8?B?U1BSamtBdnRZUG9yZThBYjhQUzd4MzFUMmlYa0tzc3Fqa25PZitDbXhscDJZ?=
 =?utf-8?B?Nlk4TkdWMitmSUFBUjBGS1NRS1pZb0lIa1Z2ak1sRTRlMm5sMERMVzRSTDRh?=
 =?utf-8?B?MFZtQ0JzVHBlZlI3YkExY3hjTnJpdWg4NDU2UzhmZEVsTzdJMkZENU5NTGFp?=
 =?utf-8?B?aWZrOERQMWM2SWcrVDY4aXdqNFk0NS9lZnRPb2orc2llcGdRTjNmY3hMeWVH?=
 =?utf-8?B?WUViNXRsNlFSZFMxMVBBWk5sN2FRWGg4L1ZLWVlweTFlWkVyeWxkTCtETGtm?=
 =?utf-8?B?T1VmWmdXcmFEWWM1WC9rYVBqbzF0ajlnRUFjeWk4V04zdlV1U3dwb2lEWmkv?=
 =?utf-8?B?ZkpBUUZDYWY1QUVaQnMwUFZJTTJaanVmNkxRVmtEcG9PZTVCenljazNua2Rp?=
 =?utf-8?B?VmNBRmVGOXRQQWJtdDV6NWhuU0xLNlp6WUJvSXdJZ3UrU0hjODBxZHViUzlD?=
 =?utf-8?B?cmhxVkoxOUJnWHA2bndIVDQ2WjlWMCtaYVd4TVlnbzdKSFc5VVYzZW9RcWVE?=
 =?utf-8?B?a05ZWi9kUmc0d1hzT0F5aXlnejYya3dJWUF0SWFsNGFyWWV2Q2ZGa011WVRz?=
 =?utf-8?B?Y0dvYVZ6Q29XbG5aZnNHNUlrcUlRRWoxUndUSWUzcEh5eitublBKUExGTnVs?=
 =?utf-8?B?d1FKMlhKdWs0dG5NbWVud3pHSzhEVWdtTXhVRTM1eEFFektwZm9GdGk2ZjBQ?=
 =?utf-8?B?YzYrV1hYRzUwL2l0MitFN0FsWVRJa2pYTElHcUYza1ArNG5DTDV1eFZuTndN?=
 =?utf-8?B?TGg2bFNFTHZsZnpYZHVWYVJWUCt4bU5jZEE2RG5YTzQvOUdLNE0yclRHNkQx?=
 =?utf-8?B?UGNHR1NOVGU1THIxS2pWWk1Qbzg3MFkyLzB0aVU5cTFTdWEvQzgvTzltNTRB?=
 =?utf-8?B?Mk9pWGg0UktFcGNZeGlTK2hqNzJPaHBKYkdUSng0T0lPTVAyRFdxSlRaQVpM?=
 =?utf-8?B?WXAxNmpkVTNoZkFMWDhiNmFQR1ZKTVBNUT09?=
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11HUB034;5:pUlIqCBCfsmP0e0RQkN+ZhF3/Ae8die8Wg3ggYoeZL5fGJYCeddUuczXu8q81k37gCfUBRXqFpiWFqgm/nWgvhr8RxooZZSNWzByJI6au6CVUc7vKklqI/LXqE3O1uIGiqh3Wgm4pZDREgKHf388GQ==;24:4/uIoc8N0y+QNZDzuWxiiIoFycooLVQ//5a2FREG23lGlRRuEaglPb+AtY5O1gwDpMqasA6/WCQ3e7yG1m8273zNkBJKjfliIO8QelfJSBg=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2015 15:18:14.9969
 (UTC)
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1BFFO11HUB034
Return-Path: <soren.brinkmann@xilinx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49548
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

On Wed, 2015-10-14 at 01:51PM +0100, Zubair Lutfullah Kakakhel wrote:
> MIPSfpga uses the axi gpio controller. Enable the driver for MIPS.
> 
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 8949b3f..58e9afd 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -508,7 +508,7 @@ config GPIO_XGENE_SB
>  
>  config GPIO_XILINX
>  	tristate "Xilinx GPIO support"
> -	depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86)
> +	depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86 || MIPS)

Hmm, in general, this driver is hopefully generic enough that it doesn't
have any real architecture dependencies. And I suspect, we want to
enable this driver for ARM64 for ZynqMP soon too. Should we probably
drop these arch dependencies completely? It seems to become quite a long list.

	Sören

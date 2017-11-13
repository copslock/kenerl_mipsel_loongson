Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 18:49:02 +0100 (CET)
Received: from mail-bn3nam01on0066.outbound.protection.outlook.com ([104.47.33.66]:28519
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990431AbdKMRszMFaUR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Nov 2017 18:48:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BBu2asqtf+lTUXM/+DLDdVqQM6BYOZdIl9VRHvsgQBw=;
 b=jiedrna1KTRAiIgXd0jCFZjNTiQeJiDnGh2Y5A2KnieX7xl9Qi+3TGgc+E2FnryavfBKQoGBdw1+oZcHwNMLYaIPjw/bxuKQzoGT5qkw3k47w1kACnx6JYPRWYM31gO2dWmJy7TYG2EUUmia23MpMv30VTs49Rr93h9eZPkdITk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.218.12; Mon, 13 Nov 2017 17:48:42 +0000
Subject: Re: [PATCH RFC] EDAC: octeon: Fix uninitialized variable warning
To:     James Hogan <james.hogan@mips.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Daniel Walker <dwalker@fifo99.com>
Cc:     James Hogan <jhogan@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Steven J . Hill" <steven.hill@cavium.com>,
        linux-edac@vger.kernel.org, linux-mips@linux-mips.org,
        stable@vger.kernel.org
References: <20171113161206.20990-1-james.hogan@mips.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <8fd03118-4b0a-695f-1ce5-71079091e1e5@caviumnetworks.com>
Date:   Mon, 13 Nov 2017 09:48:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171113161206.20990-1-james.hogan@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0042.namprd07.prod.outlook.com (10.168.109.28) To
 MWHPR07MB3503.namprd07.prod.outlook.com (10.164.192.30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f9ee2ba-663f-4155-7129-08d52abec85e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603258);SRVR:MWHPR07MB3503;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;3:YKVJcmbm7+oNCLLPMc8NrfRszuZqcFvBPJhiZVxF08Xwl82JC8dO2TQVaLJClrkmUzCcRcW0A9z65NqUVBCkJCbzBzVNJNqccBqrjPl1BD6EdQ0XhSQjJk1DGpkh5b+rGZHoil9iSrbkSYOr3VU8njwUxpDp+MFytgs+lN0I36qMxY5eaCzuY0i3kQEWi6GgiOP4hzX8HjboGL/Pk6XOfRp7XVFqhVGoBIZi7tNIS/OPuWBzPDK/WTh9sbv94MhG;25:GjvHuxcpMvllyCJoCIdL7I0ZHqpkX5CQM1lQyhbJXLnrJvDU9P16l2f67cJvvuG9FWxcArC8LN+gRadia0bJid2ldRC2tcs/8fzccuM8/vohLv/dV5B8/VS9+jllQmmTjynoEaMDlRw+llntvkLed4IDZ0dnitJ5QdPZ63aHZGjVcydtTWABD0WncyQeWpzXQBzSG44Ken7nIwfPF10cjTjrdL/n9l7tXW44+o1BGNdyHkg5f07Wti9pmYkFABLOUW7wEePWSlz78iykzpTNQnmNDDFvypMGZQRzAwj2CwFHO+wuWc2LGjTlglHddWln1vVMSM2gF3TazQtmzpI9EA==;31:6D6ziPwdxjvnmC/vB7uR7brPk7kktREHqnOpNgASHDmMLIObWbC2amN2OSqpjsEzbPWQpkCqbwmZv7N8yMet39aZdETCmsb2RcZfq2gxp/e64+FztNK/kvlipam9/XXFOmrrWWGfis6MkQ2czRy0xOddEmh2o1eCSOcD+ypA9XXYMGgDhQygEtiW9ArExXp15o9DqmAr8eMbtx0zt3n7Sse5QTfDdcS3RbiGb5594fs=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3503:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;20:lJqoLsLqhJG+izBpjWkqEEB8H5SGEXBXLCetUlVk00r7+q8BfPKiLK5niwz/pBQBkoerYcui8GI11bzs2WgfRLmF5Q1kczy5LdPgQ0YwO+Mj/SpQLwBY7PTNQTbikv2WfKY53WUC1HxmSnFyrlfLXxUe4WjLygKwHhR5PJNPeCM8Bn4+EputnPXbQcGoi8S3Sjgha571G1JrPFflFqgVZciTkLUWkh/Jr+/xvmbiMjdqQFL52WJO+yFdC3KNN0J2WLK3qWj5wvuQVybTQhFWEqykzWy+3CA3khwy8p3ldP8dlU97u+rzG6h+/XS/MWozCcuL8Zwt/mFNDb2myqVfwZjO3qH8vZ+m70p8qJGV5VQlqYyR+A+WHzAxMK0we113miUQs3dcGAXmBgq883YcQh3DPHpDAwMi3SJaIflOyN7LfnTEnvRS5XL3EUqVS7YH9SgI2Il3StZPU7q4JHUarv6d1+WS0I601JEw+7gWnz5MoAbbXKC0HAdfXuFYwV8oV5P7UknqyTGUhpAcBZaW16YaTsx2YoiXeHyedOKtOoRrISeRHOo9w1GHkKYRw/7ZNBWXEeVOHpXwSoSNzgV1XyPh2we9MU31pWGz7IwlKeg=;4:HFGVNjHs2YHz51cj+BU1ZvSQnrCD8/sb+WvIOmGIAGkb9ztj8jcm2jpT62NvMV/LAYbKnOG2QgnAMIEM65L3aV+a+ij/zs+rEhFhHodL68tBwG/eWncIGeA+YWzNgU4C+eXxMRMD8ZwKeo2ehSqRdyqTFY0+y/9G9DyefdJGF9lOP0jSVLIzVGGkfAY2evbFn0nRTHNg4OQxiJsKNMw3z+EmgtuF3qqOGu3xJD+0q1Ht76B8sFne4TtP4g1TSwPMucBkaOAI/dG7g4x2b+Y9lXRW+U+gMCDU/4+xUiPtOkooMirHIxsBu2bA1blEzxap
X-Microsoft-Antispam-PRVS: <MWHPR07MB350317972F14FB5303F3E624972B0@MWHPR07MB3503.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(93006095)(10201501046)(3231022)(3002001)(6041248)(20161123564025)(20161123555025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR07MB3503;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR07MB3503;
X-Forefront-PRVS: 0490BBA1F0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(346002)(376002)(24454002)(189002)(199003)(25786009)(7736002)(69596002)(2950100002)(6486002)(42882006)(33646002)(6506006)(72206003)(305945005)(478600001)(65956001)(66066001)(53546010)(6666003)(229853002)(65806001)(5660300001)(6116002)(3846002)(68736007)(54356999)(76176999)(50986999)(65826007)(8676002)(8936002)(47776003)(81166006)(81156014)(189998001)(16526018)(2906002)(53936002)(31686004)(2870700001)(4326008)(6246003)(110136005)(101416001)(106356001)(83506002)(105586002)(316002)(53416004)(6512007)(54906003)(64126003)(97736004)(575784001)(67846002)(23676003)(50466002)(31696002)(58126008)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3503;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzNTAzOzIzOk5CMlJwUC9SamVMUE91bTZ5ZGJqVEtOZlYz?=
 =?utf-8?B?SDM4QUU1WFVOVEdwYmdxa0s4TVJ0MDBpVit5RnVNbUd5YmZJc2ZzbTBLWk00?=
 =?utf-8?B?Ym5JTElnQXdmTzFwN1krTXA3Qk9CdUw3ZGw1MTJXczRBNkY0eWJpOGlObzdw?=
 =?utf-8?B?Z0toaGJtT01XQ1BpdDhBT1BZb0c4allpRkNtRzNvOCs1TUJIcGFFdmhWRXRn?=
 =?utf-8?B?ZThuT1V2dkFjczZXVGtLcUZOWFNzeVo3aDY4SDhBcXNYY2o2VWFCL3Y3d1o0?=
 =?utf-8?B?ZFVRRXBmSHdidDZGdE9XQXlZdHRrelZ4OVRwd01KSG5mWTRxZSswSlNVMEpq?=
 =?utf-8?B?cFFVeGRKUFNHRG85Y01KRGVlVG5RdVg0NE9qNXl1bEVHRHlKOVRndVVXeC84?=
 =?utf-8?B?WFdRTytJN2pLRDIrOGtJdDYxK09mWElBV3dqMU5XR2taU3VIK2ozNXIrbFlC?=
 =?utf-8?B?YlN5MGJUblBuVlN1MlE0b1EzY0hPTmdXYU5XSVYrSDRQL2tERC9mRmdLMWVR?=
 =?utf-8?B?TnJCNHE0MlQ0enV2NWNrYk5WUitIdHgwNTFoT0dWTG1GdEJZWXNraDNLMU1O?=
 =?utf-8?B?bkd4dEhoMy9POUd6Q2s1ZFJCbFBtOGdjSXBKc1JsQXZlQ0c1OHUzYkx2MVlv?=
 =?utf-8?B?MGJYbWcxWEZDbEJDRVJWamZ0NW5WSXRQYzNpQXZ4bDhpT1dsTWpSTFRPM1A1?=
 =?utf-8?B?cTZEYnRhWEpROUdIZHBwRkFYdW8zYTVQaDFkTlBucm8xc3JjTHQyZ2Nhbmgz?=
 =?utf-8?B?bGU0QTB0UUxvc0ZHay9PSE44RjFKbHBBMnZmUG5Vc2RIbDJ6NkJsZHhwVnRr?=
 =?utf-8?B?aENDQmQ3OEZKdENFOW5mMnl5YnhYVXJ3S0NobFBnK2NNYTlFRm0wbWs4bit3?=
 =?utf-8?B?QXZRQzJNZnNUSHdiM1Bia2JoOGZHeXdLNHoycWR4YjZ5elpnZFExcm1TQ1lJ?=
 =?utf-8?B?RmF4L0xEUVN0NUZRMnZ6cmlZOUN0UzZqUXQweGttaXFONk1PcjRaNDkzNEZi?=
 =?utf-8?B?dVgrTXRRbzZxeHQ4ekp3Q1d2bzhIS2dLcjFMRkVLamFBcmV6eE5lNzVnc01B?=
 =?utf-8?B?S0h1Q2hvVjNQZGVENmdqRGVUVzZXNDFTREtzTXNBNTd3K0xtK2RxU3U4QlVS?=
 =?utf-8?B?d2JrWlZmWlZoSCszQTZaRmE4SEoyczFGN2ZGOEpQYVZTN3hHYW5lZWlCN090?=
 =?utf-8?B?Q082dkEvazh6NzBOb3I3d3ZSeEhYOU9NVTA5ODRCNUpSbmJWTTROLzZZYzcr?=
 =?utf-8?B?UHpxSDArWUEwdWFNZU5qSzJxSlhzMnVaNVBvckZmNlZBUHZGam5na3A5RUZO?=
 =?utf-8?B?aXR0SDVkUUJPSUxjVExwK2I4LzlORFVFZXNBM2dpN0Mwc1VZMjk4Ui9Qekty?=
 =?utf-8?B?ZnBkcDhiVVpicElIWlNOU2xhNWtsRW9GYUlpSktvMHEwZWdqajVVeUwzcm9l?=
 =?utf-8?B?bUZvc3VhRjI0SEMxQ3dtQ09lTHFWTis1OXV2dlAzY3VtN0xwWkEzWXIySFBW?=
 =?utf-8?B?UmM5UTJCcGhrRkNLOVA3R0xDMi9mdjNqUzdHK2tyd3R0NWQ2cUlBamU4bXg3?=
 =?utf-8?B?RDFST3E1ZFVWajdBZ1ViUkp1Rm5Rekw4UGlicDd2T2dPNC90WSttdktIblhM?=
 =?utf-8?B?cE9xbUxLV2g5eG03WldUbHhzd1NvOG1SUWN3blRVaTdqOVM2eDMxRjVRQ3E4?=
 =?utf-8?B?RFVDNUdDbngrZ2Vpa0tRQ3hCQTFvdFN1bWJXUFZucmhuNmRzeExudllObEll?=
 =?utf-8?B?MEs4ZTU3U0NWelQzYzJhQjBXKyttY1NZbkZ0Z0IvK2J3SmFKeGV3K3NsY21o?=
 =?utf-8?B?WUd0YVFLZ3RsTUdFWGJxKzVzaVRWR2t5eTcycEZrT3dNOGFHWXpOUi9JWFI1?=
 =?utf-8?B?b29TRnZrU2dXaHhkeUQwWDNNdXhBRVZyb2x4NDVrTGh2cTFtanU5ZjBHNG9u?=
 =?utf-8?B?VWNFM2tTWEVnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3503;6:SxVNpG4ZBmm2GSfA566E9O9ftVgWXvCBPxZiQ3Eq2xymSuGVizIJ/Q18jEtUEm7DHyhJcVVh1NnQ97uuLOOE7p4+JVWBV+LaNWE/EjVD/fDnSFOJhrVERNFjFuCO6gFgkG0TO8VUc52oBr7ec/TUe2H9SVGbuT6HwRZVIihp0Y8iNgLm9xFRFkejBA6dQaOWS8rgQcfSc9AoooPgXlAuj+np2+d7U3OixCVIEHaiwiwGEJ8fzZlSJzO/oL5LUDaTwn7MrSmHPwC2aFucFfvfIypspNasv6WyMo+dH+PjKGF5V6zLTpeootOWLxAXvStXiXnxCRr8ouFZnMGBtgI2Dy2NAzge9WoYEQvxarfLVBk=;5:TlB28Kik4kQazNP4yggYQ7S7AdEdcFXqJuRvSvN2XzY5jsgsdZtUP3o8Si50heWGZ0Nn0Ic4JkwOZwJMY9MT/gQhVOVh8auSB34pxBPPQ0NKp9Kw4CRwdjZh7Q759n9U2hGrX4mrAKMm9nn4gP8wD32Sv1im3EU9ZnbVi5s1Nj4=;24:aiSjxodB1f+3DbbD23pc1sD90+omnjQdE5ivoaYYTMY7yv1x8pgYkImL3pg8h7tmRfaNhU+ys7U4M7wTJ3Ob1OBDtIUVRrSdBSR4yfSFBtg=;7:BMHR1/xRFN/N8GMDpaa0KplnhY5nKFu6L9GQ8mNENvpfSiBS6GTZUdCmPTSY19VvV/xndCMCX/sHzyBjdnUM9NEev26kxiHvgD0h6B2xRkAQjhSuedvySGSELhwqo2491GJFGhbgtB37Z5bi+nyL0kTWEO5TcU86gbTV9x+01lMNwjTN6FcBX6/z6a4gwD2DKrHM+KPjEeXEZMck+YNM68OEGPkZQZOJBmrmQBc3DVhZCTpZAetrueYMcJuwsEXs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2017 17:48:42.5484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9ee2ba-663f-4155-7129-08d52abec85e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3503
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60883
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

On 11/13/2017 08:12 AM, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> Fix uninitialized variable warning in the Octeon EDAC driver, as seen in
> MIPS cavium_octeon_defconfig builds since v4.14 with Codescape GNU Tools
> 2016.05-03:
> 
> drivers/edac/octeon_edac-lmc.c In function ‘octeon_lmc_edac_poll_o2’:
> drivers/edac/octeon_edac-lmc.c:87:24: warning: ‘((long unsigned int*)&int_reg)[1]’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (int_reg.s.sec_err || int_reg.s.ded_err) {
>                          ^
> 
> This was introduced in commit 1bc021e81565 ("EDAC: Octeon: Add error
> injection support"), and is fixed by initialising the whole int_reg
> variable to zero before the conditional assignments in the error
> injection case.
> 
> Fixes: 1bc021e81565 ("EDAC: Octeon: Add error injection support")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Steven J. Hill <steven.hill@cavium.com>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 3.15+

Thanks, this looks correct,

Acked-by: David Daney <david.daney@cavium.com>


> ---
> Comments appreciated. Is this correct?
> 
> I've added the stable tag on the assumption that this might matter. If
> not it can be changed. It'd be nice to have it in 4.14 though to silence
> the warning since the driver was added to cavium_octeon_defconfig in
> commit f922bc0ad08b ("MIPS: Octeon: cavium_octeon_defconfig: Enable more
> drivers").
> ---
>   drivers/edac/octeon_edac-lmc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/octeon_edac-lmc.c b/drivers/edac/octeon_edac-lmc.c
> index 9c1ffe3e912b..aeb222ca3ed1 100644
> --- a/drivers/edac/octeon_edac-lmc.c
> +++ b/drivers/edac/octeon_edac-lmc.c
> @@ -78,6 +78,7 @@ static void octeon_lmc_edac_poll_o2(struct mem_ctl_info *mci)
>   	if (!pvt->inject)
>   		int_reg.u64 = cvmx_read_csr(CVMX_LMCX_INT(mci->mc_idx));
>   	else {
> +		int_reg.u64 = 0;
>   		if (pvt->error_type == 1)
>   			int_reg.s.sec_err = 1;
>   		if (pvt->error_type == 2)
> 

Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2018 01:06:18 +0200 (CEST)
Received: from mail-by2nam05on0719.outbound.protection.outlook.com ([IPv6:2a01:111:f400:fe52::719]:45287
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993057AbeF0XGLAVqha (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jun 2018 01:06:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=663yTIwCA8uILnX6VES9qca/8LEH2y2skii5hNeqxSI=;
 b=dqRFmPCzj+YlOwXzir+hqRm2hc2l5bufR2PhFFH8/7eiQs9/6fuzqRwFLMbeYDAR2FKRLsu5OKuI+Z+1Dl3UfS4blJH3PayPRL6VPZdssic+kxqeT+Gui/copM8peihumdR1GxUJSpwonPGZcfnIOCQqnjzPo/ZlTOAad/IVb+A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Wed, 27 Jun 2018 23:05:23 +0000
Date:   Wed, 27 Jun 2018 16:05:20 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     John Crispin <john@phrozen.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 05/25] MIPS: ath79: Avoid using unitialized 'reg' variable
Message-ID: <20180627230520.4nuefgld34ykomf5@pburton-laptop>
References: <20180625171549.4618-1-john@phrozen.org>
 <20180625171549.4618-6-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625171549.4618-6-john@phrozen.org>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR18CA0034.namprd18.prod.outlook.com
 (2603:10b6:320:31::20) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd8fbd1-ee9d-4cee-f049-08d5dc8276bd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:zwqqMZn3ocQfLYuDAVgyRuZLcbCvnwRK6GmYExomsYpq7oO5X2VmSnQMdqc2YaRpGF5bXSa7cQQOR+vjMdyV9jHvPz4Ilz6BPDhOAlwp1lyV05xEVxugRCgbwFJbWAxRD2zLZTkIhYqzLpxds0qMDqqGH94HkropH964TTy06CWG+gzR53vopOkNwKbMx5TTmlvpR20tPZu5cFAjyiLl0/eqfxtgKtMYuguqDecywuj9b7qQUZ98q+fwpJbTAmH9;25:RYHpmk8Dfp+0a0LFvfCRDDfVBBqPkgj6VcaaQvc7Sy3xkfp2Ao2otXffoTFCQJ+TGJQCYs+3Jk9SdlpxJvxDMSyueeu7ldccnSmM3YjPddKMNDeeAciArSN0eDzTiw/YDOSuCVwA8cHEQ/0L3bGPWtQgUPKIll1vZh4Yo5aBsOTuCnPp7Y9k4tTjzk715MPlKRKv+++rkJzHIrBs8ojKHK+EkIVqFCL1954xzTFZUG7fHgolRhfTsIstSuspXm8K9P4VwWbhHZdnPkhCChWiyW8Nr3iY3MztImULfW/dcfu+7ljtLcvzamxufsqzL0FPxS4MmSuzW5xgZbSHHyFkaA==;31:Ip1ABHQybyshp8HiHf/0ie13ayRbqEN9VIwSpZ4ea6zD/+wKJhkj4XGL1Iun+5K8iHQE1ptVWALY6tKraLM1LU7uSdeZnsK7FSDFvcaDfIxmeA5yNm66ne7RSL0VzVDEOCTHMlKt7n/2BTFJNI/rOWS6HtHna4p65xBGCKRTI+tfsjEEWtrLWXnJkRmx1d/O1n6+g79tFj7dkBohZoWn9tHSufECBnb6yAHmn2aJ4Ec=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:Smp1gTs5Rzw0CwZr3rBa25xnfNeLKA6ZWVqZ5slnnpFEpKyWWliniRLwxMg7xHJthn1EXMyMUKkkRFCtK3r6oJk34DpCzKTR6yCLVoiujElmXqceWeXs4iGJu34SHCcb7EZUAjvvnyLL921MfStFjSD5qXUK/gZVGLlNWoTkPGtL5m2/QSmMj3rmGe3xQnTpvvLq9+MODBeDXM3n7lvxd3S7E3jkwrz3zSxkRZiKDjJ+2PVNpPyuIeEelnekXYti;4:wWA0Io1Ckkqkau/CQCpX3DpBOSZ/wZvEvNg4rB4J/VJMpSK9j219Wwm2VxPgawkg4ANYKsypracbL5n2d9qhONs94cQBRZaD+7qaaFybvF1MsJK9RZKk/muUpeWkEphUkoO7tiAs8kTqvni/PVqC/xAT1k8p0W0wykpikb+gwR8Ph23Adk/Qab3boGkIZyvSRWTTXt1YlRcst+mGF+jng/zPjLISM67LgLNHfiY7V1NOX7cNnvMjShlnepP/mpGtAJG8BjdLN9ibRaL7qvoeqw==
X-Microsoft-Antispam-PRVS: <DM6PR08MB49397F966D74FD8385E9B2B9C1480@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(366004)(136003)(396003)(346002)(39840400004)(199004)(189003)(956004)(386003)(53936002)(5660300001)(44832011)(186003)(33716001)(486006)(16526019)(68736007)(42882007)(76506005)(26005)(66066001)(11346002)(229853002)(6486002)(6496006)(6916009)(446003)(47776003)(476003)(6246003)(4326008)(52116002)(33896004)(76176011)(8936002)(2906002)(54906003)(105586002)(50466002)(58126008)(8676002)(966005)(478600001)(316002)(25786009)(6306002)(7736002)(16586007)(6116002)(305945005)(81156014)(1076002)(3846002)(9686003)(81166006)(97736004)(106356001)(23726003)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:fcdEGNALt+j2KeV5qfUvJNhOKrYSQH5faZ//slWeQ?=
 =?us-ascii?Q?3YZmsSy+mU6XhYLnFj9G0bo1GK7dRgQ9opnGyiwL1pBDFZNbPNlcnEGr+Onc?=
 =?us-ascii?Q?RAwUWAjBG5ybhE+3fBbqtLjTydb4IQIsrIQFrrT9KroiurKpEhgT6u0IrMhs?=
 =?us-ascii?Q?RxreltHC5FLyWDQThOS9+RabfY4Ln1qY97RCZWq9g5HmXhziGYyFlTlh1jDT?=
 =?us-ascii?Q?OfRergKXLCV8nN21ZSbsU+RItR/NjEY2roBUatRd6zPTkYlN+RG1e1Ad65Po?=
 =?us-ascii?Q?fe0Lgkr9Hp63fxLjhD1jTCPDOOKwMte03pMdHPmPcUiGLsDgBxdfyoCicjhs?=
 =?us-ascii?Q?zqvQ5/q9xyYKF+jBvjphmRqw9uE6/goALDH0t/aXbo0ZBoP9iFgEFb+R87ef?=
 =?us-ascii?Q?b98KTB6YjHh48QZ/HJ9orhLWlG6l6Lg1J+4phuNRrMq4gnDnVR5va+NDKuF7?=
 =?us-ascii?Q?4jeENLrx0K3fLoJEr5GX4Cvpd8ZNxlDAM3aPqCsIyFbXsEiXIDKaeaK+k05p?=
 =?us-ascii?Q?elDfuqgBQMTWBGSlwgam3O2/EIsIuxVL/izg2g6NWtHXBMA8uMi02civeP05?=
 =?us-ascii?Q?YcZT6HtPtiGDumNIMgIl7dBuDL2SerI6MACMR6c0fDwtQNGwxJa8oop3HtVV?=
 =?us-ascii?Q?BOMbDchK3oKzz3zapLmoj6jPBuXglmNsKI7y1v6zR8uJsU7069dvdzsh1Etb?=
 =?us-ascii?Q?YsfvBEy6o5yqMuIeplHn6f5mxC0eO3If3JWic0EQai81KhpNjwsp4/eYpqbW?=
 =?us-ascii?Q?Iul75jt64MggjBSyaGW3mXMY61Qkqp2HEe1Hi4jayo+nzrT2hgbssnIQkuuO?=
 =?us-ascii?Q?Za7KIM4D/9Y3ycuNDKfZFg55+YtUuL1ZA1vlsoPB+Xop7MbqKrAXTZf3hqSK?=
 =?us-ascii?Q?+zTW3TnpkITtoPPUffS7f9HQqkmi9Fui6ypVUCpnmyCb99ZKi7Jn0teeNAj9?=
 =?us-ascii?Q?yUfrp76tc3A6GdVm9DenqUBfixF0H/m5Sl6g7VeuoCYwXiBxx10SA6To5dE4?=
 =?us-ascii?Q?fDgU5BveytYTSa+yTFrbjUgSgoBI9/q/BG5VmSrzIijHd5G0V6a9wlvgsEN7?=
 =?us-ascii?Q?BzNjSIqRRNtsEow0iZK7cw99PgT+Kn7KHMj34IHlO9lB2PFG4f0euNWkx+LZ?=
 =?us-ascii?Q?2ChhuWFhAyFtSXswRWFTiWeVbcbnJYRTYRGXVRcuJDDkBkLP/ZTYCBGLhfaf?=
 =?us-ascii?Q?tmFkq0h6Dnnp5ZmUQJcO+9msj7hs/LQSWL3ccNlSQJfDw3RXsz01UknVBQY9?=
 =?us-ascii?Q?V6K+FlC/bot6qLCmRDmOI4f3tUni3zMdk50kpfFacLrT5E0iwK60GfObpZJ1?=
 =?us-ascii?Q?bBDew0/lLjtdl6TMXultySkrEi+Ghwgn3Ba6EJt7sBU?=
X-Microsoft-Antispam-Message-Info: xs5swIYW3uKeNg3OBAv5Xqe9ma9zLOPbtRo/Rj27+xCEnzNmb4vpJdV+YIpwtyBejcui/ua9KlevrGogBzSsN2Kj5qC2UrnptHPXJM5HiO/g0N3c9yqXeedTHRJbu6IsEmGJ8s0toTK6r/AcjXa+bkSvOBvFiaz0ZPTycWdjAIE3ztuDCKI2o3SyrA+VtPOq2Pb/KCNXTJgs5LtywxnGVOa+XtMZMj+FSY7fKKyQlBjOs8jwS+NfpqPy0PFPrCBLdDp0GhzucDN2CcM7wCtQIhCw8UPWDwNZiFXe9hhppiPLoS01IjzcO8E1uZrO3J1u/d/3AoXJHiK81nHUtX5kc2UalibYI830zZ6EPkaMF94=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:B2XkZE8wszLeKJQVIct6zIQXd+C875TxpipGpdHRfdkt1BBmezQAwndj+vFoLrgyWS+w3sigDtj5MEv6CA8pquybovjdgSTugdKd5Xg5MyiUZRCgFV0+La2gqkCT/cTiSUbE1xOfsszUwFT9xJjsS8Vm83JH+3+5qL2mJD+s8jRjw/tMFAmEXbgvm9pabZxPEUoHctRPB+p+GQj3ZgIEcge/mOAEWBllkI/NueroHDVRpoRPY4K3WYADELW0Y2n37EubGJR/Yn7lNVMaBHeGjoSNkhq2IOeC9R5XUDHdy1RaCJ7PzighxYoFi3OcEPx9sn3ai6Ety7aBV6UWcKLzTLduI/uVi+48l1IkkReHUlX/pKWmkrLP7rItWHj+CcJqSwzDG8YhVzSYEEOBSorZyYWZT4ImmqIbyaXJV1jzyLsJGhBhmsFoJYMHPiwKmplfV5bmsZWq2gvYgbP2GJeUFA==;5:Ah29E2x7aZm2Gt3czl4j0z6urIqwfKlQie4QR3Yn+TM8yoWoT1JnbtMLqWUdkfjKgadiFbu1y92mozKZoxiAv5ye2+dZUhacfsbyzGZrgWxnTR5vtVUvLFwz0CeDHh2Yrpoj+Dx9nkIMqPinIQ3RCklcwLDybU26uCAZWG9FsfA=;24:7cG7Ur1DAHLoHHRmjJ3bzOQcp9xsfzEx69SWPfTXzVAtrXmV0m4Oljkb4NC3wkMks90+j5kY2b83LmJOcV6Jvbx4sRZnYevfb5CbOzxmaBk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;7:LoB37th9LHS+eN/Y6kQIM+F/Rbc1v7z/8Z9mB2jo1jeme9k9ElfVKnax/g6u7ZpYcDEJltaxbrutGU864ilNIb9cp6EWQ7WQx6oLyvXZEYxt3cTI3h02XPUzeSuuh6KIyifzuOGtV8dwLErP+9xvU1O1Gpr3ibTakfhS63v2jw4oNAydpDT9+F/duwcOdfS5NoWTC1k2FQNd2g9HEmwGX+nBesBgc692VftLkC1kke7+aUW0UIF+rbKSPp8fSVRB
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 23:05:23.6936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd8fbd1-ee9d-4cee-f049-08d5dc8276bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Return-Path: <pburton@wavecomp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi John,

On Mon, Jun 25, 2018 at 07:15:29PM +0200, John Crispin wrote:
> diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
> index cd6055f9e7a0..fc3438150b3e 100644
> --- a/arch/mips/ath79/common.c
> +++ b/arch/mips/ath79/common.c
> @@ -110,7 +110,7 @@ void ath79_device_reset_set(u32 mask)
>  	else if (soc_is_qca956x() || soc_is_tp9343())
>  		reg = QCA956X_RESET_REG_RESET_MODULE;
>  	else
> -		BUG();
> +		panic("Reset register not defined for this SOC");
>  
>  	spin_lock_irqsave(&ath79_device_reset_lock, flags);
>  	t = ath79_reset_rr(reg);
> @@ -142,7 +142,7 @@ void ath79_device_reset_clear(u32 mask)
>  	else if (soc_is_qca956x() || soc_is_tp9343())
>  		reg = QCA956X_RESET_REG_RESET_MODULE;
>  	else
> -		BUG();
> +		panic("Reset register not defined for this SOC");
>  
>  	spin_lock_irqsave(&ath79_device_reset_lock, flags);
>  	t = ath79_reset_rr(reg);

This was rejected when first submitted nearly back in 2013:

    https://patchwork.linux-mips.org/patch/5742/

...and indeed I agree with Ralf's message from back then that it seems
odd for GCC to now be recognizing that code beyond a BUG() is
unreachable.

Could you specify which version(s) of GCC are problematic?

Thanks,
    Paul
